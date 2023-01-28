Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D353C67F676
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjA1IrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjA1IrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:47:03 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19C2B0AF;
        Sat, 28 Jan 2023 00:46:58 -0800 (PST)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P3p0p39ccz16NQw;
        Sat, 28 Jan 2023 16:44:58 +0800 (CST)
Received: from [10.174.177.133] (10.174.177.133) by
 dggpemm500015.china.huawei.com (7.185.36.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 16:46:54 +0800
Subject: Re: [PATCH v3 1/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
To:     Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhiramat@kernel.org>, <ndesaulniers@google.com>,
        <ojeda@kernel.org>, <peterz@infradead.org>,
        <rafael.j.wysocki@intel.com>, <revest@chromium.org>,
        <robert.moore@intel.com>, <rostedt@goodmis.org>, <will@kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
 <20230123134603.1064407-2-mark.rutland@arm.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <f2f5dfc6-3deb-9fce-a9be-9386e844a9cf@huawei.com>
Date:   Sat, 28 Jan 2023 16:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20230123134603.1064407-2-mark.rutland@arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.133]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/1/23 21:45, Mark Rutland Ð´µÀ:
> Architectures without dynamic ftrace trampolines incur an overhead when
> multiple ftrace_ops are enabled with distinct filters. in these cases,
> each call site calls a common trampoline which uses
> ftrace_ops_list_func() to iterate over all enabled ftrace functions, and
> so incurs an overhead relative to the size of this list (including RCU
> protection overhead).
> 
> Architectures with dynamic ftrace trampolines avoid this overhead for
> call sites which have a single associated ftrace_ops. In these cases,
> the dynamic trampoline is customized to branch directly to the relevant
> ftrace function, avoiding the list overhead.
> 
> On some architectures it's impractical and/or undesirable to implement
> dynamic ftrace trampolines. For example, arm64 has limited branch ranges
> and cannot always directly branch from a call site to an arbitrary
> address (e.g. from a kernel text address to an arbitrary module
> address). Calls from modules to core kernel text can be indirected via
> PLTs (allocated at module load time) to address this, but the same is
> not possible from calls from core kernel text.
> 
> Using an indirect branch from a call site to an arbitrary trampoline is
> possible, but requires several more instructions in the function
> prologue (or immediately before it), and/or comes with far more complex
> requirements for patching.
> 
> Instead, this patch adds a new option, where an architecture can
> associate each call site with a pointer to an ftrace_ops, placed at a
> fixed offset from the call site. A shared trampoline can recover this
> pointer and call ftrace_ops::func() without needing to go via
> ftrace_ops_list_func(), avoiding the associated overhead.
> 
> This avoids issues with branch range limitations, and avoids the need to
> allocate and manipulate dynamic trampolines, making it far simpler to
> implement and maintain, while having similar performance
> characteristics.
> 
> Note that this allows for dynamic ftrace_ops to be invoked directly from
> an architecture's ftrace_caller trampoline, whereas existing code forces
> the use of ftrace_ops_get_list_func(), which is in part necessary to
> permit the ftrace_ops to be freed once unregistered *and* to avoid
> branch/address-generation range limitation on some architectures (e.g.
> where ops->func is a module address, and may be outside of the direct
> branch range for callsites within the main kernel image).
> 
> The CALL_OPS approach avoids this problems and is safe as:
> 
> * The existing synchronization in ftrace_shutdown() using
>    ftrace_shutdown() using synchronize_rcu_tasks_rude() (and
>    synchronize_rcu_tasks()) ensures that no tasks hold a stale reference
>    to an ftrace_ops (e.g. in the middle of the ftrace_caller trampoline,
>    or while invoking ftrace_ops::func), when that ftrace_ops is
>    unregistered.
> 
>    Arguably this could also be relied upon for the existing scheme,
>    permitting dynamic ftrace_ops to be invoked directly when ops->func is
>    in range, but this will require additional logic to handle branch
>    range limitations, and is not handled by this patch.
> 
> * Each callsite's ftrace_ops pointer literal can hold any valid kernel
>    address, and is updated atomically. As an architecture's ftrace_caller
>    trampoline will atomically load the ops pointer then dereference
>    ops->func, there is no risk of invoking ops->func with a mismatches
>    ops pointer, and updates to the ops pointer do not require special
>    care.
> 
> A subsequent patch will implement architectures support for arm64. There
> should be no functional change as a result of this patch alone.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florent Revest <revest@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>   include/linux/ftrace.h |  18 +++++--
>   kernel/trace/Kconfig   |   7 +++
>   kernel/trace/ftrace.c  | 109 +++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 99f1146614c0..366c730beaa3 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -39,6 +39,7 @@ static inline void ftrace_boot_snapshot(void) { }
>   
>   struct ftrace_ops;
>   struct ftrace_regs;
> +struct dyn_ftrace;
>   
>   #ifdef CONFIG_FUNCTION_TRACER
>   /*
> @@ -57,6 +58,9 @@ void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
>   void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>   			       struct ftrace_ops *op, struct ftrace_regs *fregs);
>   #endif
> +extern const struct ftrace_ops ftrace_nop_ops;
> +extern const struct ftrace_ops ftrace_list_ops;
> +struct ftrace_ops *ftrace_find_unique_ops(struct dyn_ftrace *rec);
>   #endif /* CONFIG_FUNCTION_TRACER */
>   
>   /* Main tracing buffer and events set up */
> @@ -391,8 +395,6 @@ struct ftrace_func_entry {
>   	unsigned long direct; /* for direct lookup only */
>   };
>   
> -struct dyn_ftrace;
> -
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   extern int ftrace_direct_func_count;
>   int register_ftrace_direct(unsigned long ip, unsigned long addr);
> @@ -563,6 +565,8 @@ bool is_ftrace_trampoline(unsigned long addr);
>    *  IPMODIFY - the record allows for the IP address to be changed.
>    *  DISABLED - the record is not ready to be touched yet
>    *  DIRECT   - there is a direct function to call
> + *  CALL_OPS - the record can use callsite-specific ops
> + *  CALL_OPS_EN - the function is set up to use callsite-specific ops
>    *
>    * When a new ftrace_ops is registered and wants a function to save
>    * pt_regs, the rec->flags REGS is set. When the function has been
> @@ -580,9 +584,11 @@ enum {
>   	FTRACE_FL_DISABLED	= (1UL << 25),
>   	FTRACE_FL_DIRECT	= (1UL << 24),
>   	FTRACE_FL_DIRECT_EN	= (1UL << 23),
> +	FTRACE_FL_CALL_OPS	= (1UL << 22),
> +	FTRACE_FL_CALL_OPS_EN	= (1UL << 21),
>   };
>   
> -#define FTRACE_REF_MAX_SHIFT	23
> +#define FTRACE_REF_MAX_SHIFT	21
>   #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
>   
>   #define ftrace_rec_count(rec)	((rec)->flags & FTRACE_REF_MAX)
> @@ -820,7 +826,8 @@ static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>    */
>   extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
>   
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) || \
> +	defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS)
>   /**
>    * ftrace_modify_call - convert from one addr to another (no nop)
>    * @rec: the call site record (e.g. mcount/fentry)
> @@ -833,6 +840,9 @@ extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
>    * what we expect it to be, and then on success of the compare,
>    * it should write to the location.
>    *
> + * When using call ops, this is called when the associated ops change, even
> + * when (addr == old_addr).
> + *
>    * The code segment at @rec->ip should be a caller to @old_addr
>    *
>    * Return must be:
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 197545241ab8..5df427a2321d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -42,6 +42,9 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
>   config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   	bool
>   
> +config HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> +	bool
> +
>   config HAVE_DYNAMIC_FTRACE_WITH_ARGS
>   	bool
>   	help
> @@ -257,6 +260,10 @@ config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   	depends on DYNAMIC_FTRACE_WITH_REGS
>   	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   
> +config DYNAMIC_FTRACE_WITH_CALL_OPS
> +	def_bool y
> +	depends on HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> +
Hi Mark,
I have test your patches and it looks fine with my sample module, but 
here setting DYNAMIC_FTRACE_WITH_CALL_OPS to y immutably may increase 
the .text section size by 5% or more, how about making this to optional^^

-- Wang ShaoBo
>   config DYNAMIC_FTRACE_WITH_ARGS
>   	def_bool y
>   	depends on DYNAMIC_FTRACE
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 442438b93fe9..e634b80f49d1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -125,6 +125,33 @@ struct ftrace_ops global_ops;
>   void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>   			  struct ftrace_ops *op, struct ftrace_regs *fregs);
>   
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +/*
> + * Stub used to invoke the list ops without requiring a separate trampoline.
> + */
> +const struct ftrace_ops ftrace_list_ops = {
> +	.func	= ftrace_ops_list_func,
> +	.flags	= FTRACE_OPS_FL_STUB,
> +};
> +
> +static void ftrace_ops_nop_func(unsigned long ip, unsigned long parent_ip,
> +				struct ftrace_ops *op,
> +				struct ftrace_regs *fregs)
> +{
> +	/* do nothing */
> +}
> +
> +/*
> + * Stub used when a call site is disabled. May be called transiently by threads
> + * which have made it into ftrace_caller but haven't yet recovered the ops at
> + * the point the call site is disabled.
> + */
> +const struct ftrace_ops ftrace_nop_ops = {
> +	.func	= ftrace_ops_nop_func,
> +	.flags  = FTRACE_OPS_FL_STUB,
> +};
> +#endif
> +
>   static inline void ftrace_ops_init(struct ftrace_ops *ops)
>   {
>   #ifdef CONFIG_DYNAMIC_FTRACE
> @@ -1814,6 +1841,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
>   			 * if rec count is zero.
>   			 */
>   		}
> +
> +		/*
> +		 * If the rec has a single associated ops, and ops->func can be
> +		 * called directly, allow the call site to call via the ops.
> +		 */
> +		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) &&
> +		    ftrace_rec_count(rec) == 1 &&
> +		    ftrace_ops_get_func(ops) == ops->func)
> +			rec->flags |= FTRACE_FL_CALL_OPS;
> +		else
> +			rec->flags &= ~FTRACE_FL_CALL_OPS;
> +
>   		count++;
>   
>   		/* Must match FTRACE_UPDATE_CALLS in ftrace_modify_all_code() */
> @@ -2108,8 +2147,9 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
>   		struct ftrace_ops *ops = NULL;
>   
>   		pr_info("ftrace record flags: %lx\n", rec->flags);
> -		pr_cont(" (%ld)%s", ftrace_rec_count(rec),
> -			rec->flags & FTRACE_FL_REGS ? " R" : "  ");
> +		pr_cont(" (%ld)%s%s", ftrace_rec_count(rec),
> +			rec->flags & FTRACE_FL_REGS ? " R" : "  ",
> +			rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ");
>   		if (rec->flags & FTRACE_FL_TRAMP_EN) {
>   			ops = ftrace_find_tramp_ops_any(rec);
>   			if (ops) {
> @@ -2177,6 +2217,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
>   		 * want the direct enabled (it will be done via the
>   		 * direct helper). But if DIRECT_EN is set, and
>   		 * the count is not one, we need to clear it.
> +		 *
>   		 */
>   		if (ftrace_rec_count(rec) == 1) {
>   			if (!(rec->flags & FTRACE_FL_DIRECT) !=
> @@ -2185,6 +2226,19 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
>   		} else if (rec->flags & FTRACE_FL_DIRECT_EN) {
>   			flag |= FTRACE_FL_DIRECT;
>   		}
> +
> +		/*
> +		 * Ops calls are special, as count matters.
> +		 * As with direct calls, they must only be enabled when count
> +		 * is one, otherwise they'll be handled via the list ops.
> +		 */
> +		if (ftrace_rec_count(rec) == 1) {
> +			if (!(rec->flags & FTRACE_FL_CALL_OPS) !=
> +			    !(rec->flags & FTRACE_FL_CALL_OPS_EN))
> +				flag |= FTRACE_FL_CALL_OPS;
> +		} else if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> +			flag |= FTRACE_FL_CALL_OPS;
> +		}
>   	}
>   
>   	/* If the state of this record hasn't changed, then do nothing */
> @@ -2229,6 +2283,21 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
>   					rec->flags &= ~FTRACE_FL_DIRECT_EN;
>   				}
>   			}
> +
> +			if (flag & FTRACE_FL_CALL_OPS) {
> +				if (ftrace_rec_count(rec) == 1) {
> +					if (rec->flags & FTRACE_FL_CALL_OPS)
> +						rec->flags |= FTRACE_FL_CALL_OPS_EN;
> +					else
> +						rec->flags &= ~FTRACE_FL_CALL_OPS_EN;
> +				} else {
> +					/*
> +					 * Can only call directly if there's
> +					 * only one set of associated ops.
> +					 */
> +					rec->flags &= ~FTRACE_FL_CALL_OPS_EN;
> +				}
> +			}
>   		}
>   
>   		/*
> @@ -2258,7 +2327,8 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
>   			 * and REGS states. The _EN flags must be disabled though.
>   			 */
>   			rec->flags &= ~(FTRACE_FL_ENABLED | FTRACE_FL_TRAMP_EN |
> -					FTRACE_FL_REGS_EN | FTRACE_FL_DIRECT_EN);
> +					FTRACE_FL_REGS_EN | FTRACE_FL_DIRECT_EN |
> +					FTRACE_FL_CALL_OPS_EN);
>   	}
>   
>   	ftrace_bug_type = FTRACE_BUG_NOP;
> @@ -2431,6 +2501,25 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
>   	return NULL;
>   }
>   
> +struct ftrace_ops *
> +ftrace_find_unique_ops(struct dyn_ftrace *rec)
> +{
> +	struct ftrace_ops *op, *found = NULL;
> +	unsigned long ip = rec->ip;
> +
> +	do_for_each_ftrace_op(op, ftrace_ops_list) {
> +
> +		if (hash_contains_ip(ip, op->func_hash)) {
> +			if (found)
> +				return NULL;
> +			found = op;
> +		}
> +
> +	} while_for_each_ftrace_op(op);
> +
> +	return found;
> +}
> +
>   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   /* Protected by rcu_tasks for reading, and direct_mutex for writing */
>   static struct ftrace_hash *direct_functions = EMPTY_HASH;
> @@ -3780,11 +3869,12 @@ static int t_show(struct seq_file *m, void *v)
>   	if (iter->flags & FTRACE_ITER_ENABLED) {
>   		struct ftrace_ops *ops;
>   
> -		seq_printf(m, " (%ld)%s%s%s",
> +		seq_printf(m, " (%ld)%s%s%s%s",
>   			   ftrace_rec_count(rec),
>   			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
>   			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ",
> -			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ");
> +			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ",
> +			   rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ");
>   		if (rec->flags & FTRACE_FL_TRAMP_EN) {
>   			ops = ftrace_find_tramp_ops_any(rec);
>   			if (ops) {
> @@ -3800,6 +3890,15 @@ static int t_show(struct seq_file *m, void *v)
>   		} else {
>   			add_trampoline_func(m, NULL, rec);
>   		}
> +		if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> +			ops = ftrace_find_unique_ops(rec);
> +			if (ops) {
> +				seq_printf(m, "\tops: %pS (%pS)",
> +					   ops, ops->func);
> +			} else {
> +				seq_puts(m, "\tops: ERROR!");
> +			}
> +		}
>   		if (rec->flags & FTRACE_FL_DIRECT) {
>   			unsigned long direct;
>   
> 
