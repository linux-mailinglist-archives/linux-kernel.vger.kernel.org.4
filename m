Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B5B680ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbjA3KZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3KZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:25:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 634A216310;
        Mon, 30 Jan 2023 02:25:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276CEFEC;
        Mon, 30 Jan 2023 02:26:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3103F71E;
        Mon, 30 Jan 2023 02:25:40 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:25:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org,
        "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v3 1/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y9ebIY/pWz0Ms9S6@FVFF77S0Q05N>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
 <20230123134603.1064407-2-mark.rutland@arm.com>
 <f2f5dfc6-3deb-9fce-a9be-9386e844a9cf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2f5dfc6-3deb-9fce-a9be-9386e844a9cf@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:46:48PM +0800, Wangshaobo (bobo) wrote:
> 锟斤拷 2023/1/23 21:45, Mark Rutland 写锟斤拷:
> > +config DYNAMIC_FTRACE_WITH_CALL_OPS
> > +	def_bool y
> > +	depends on HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> > +
> Hi Mark,

Hi,

> I have test your patches and it looks fine with my sample module, 

Thanks for testing!

> but here setting DYNAMIC_FTRACE_WITH_CALL_OPS to y immutably may increase the
> .text section size by 5% or more, how about making this to optional^^

We could consider making this optional. I had not made this optional so far as
in the future I'd like to make this the only implementation of ftrace on arm64
(once we can drop the old mcount version, and once we've sorted out the
incompatibility with CFI). In the mean time, it probably makes sense to have
the option at least to enable testing of each of the two forms.

Is your concern that the overall kernel image size is larger, or do you care
specifically about the size of the .text section for some reason?

Thanks,
Mark.

> 
> -- Wang ShaoBo
> >   config DYNAMIC_FTRACE_WITH_ARGS
> >   	def_bool y
> >   	depends on DYNAMIC_FTRACE
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 442438b93fe9..e634b80f49d1 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -125,6 +125,33 @@ struct ftrace_ops global_ops;
> >   void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >   			  struct ftrace_ops *op, struct ftrace_regs *fregs);
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> > +/*
> > + * Stub used to invoke the list ops without requiring a separate trampoline.
> > + */
> > +const struct ftrace_ops ftrace_list_ops = {
> > +	.func	= ftrace_ops_list_func,
> > +	.flags	= FTRACE_OPS_FL_STUB,
> > +};
> > +
> > +static void ftrace_ops_nop_func(unsigned long ip, unsigned long parent_ip,
> > +				struct ftrace_ops *op,
> > +				struct ftrace_regs *fregs)
> > +{
> > +	/* do nothing */
> > +}
> > +
> > +/*
> > + * Stub used when a call site is disabled. May be called transiently by threads
> > + * which have made it into ftrace_caller but haven't yet recovered the ops at
> > + * the point the call site is disabled.
> > + */
> > +const struct ftrace_ops ftrace_nop_ops = {
> > +	.func	= ftrace_ops_nop_func,
> > +	.flags  = FTRACE_OPS_FL_STUB,
> > +};
> > +#endif
> > +
> >   static inline void ftrace_ops_init(struct ftrace_ops *ops)
> >   {
> >   #ifdef CONFIG_DYNAMIC_FTRACE
> > @@ -1814,6 +1841,18 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
> >   			 * if rec count is zero.
> >   			 */
> >   		}
> > +
> > +		/*
> > +		 * If the rec has a single associated ops, and ops->func can be
> > +		 * called directly, allow the call site to call via the ops.
> > +		 */
> > +		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) &&
> > +		    ftrace_rec_count(rec) == 1 &&
> > +		    ftrace_ops_get_func(ops) == ops->func)
> > +			rec->flags |= FTRACE_FL_CALL_OPS;
> > +		else
> > +			rec->flags &= ~FTRACE_FL_CALL_OPS;
> > +
> >   		count++;
> >   		/* Must match FTRACE_UPDATE_CALLS in ftrace_modify_all_code() */
> > @@ -2108,8 +2147,9 @@ void ftrace_bug(int failed, struct dyn_ftrace *rec)
> >   		struct ftrace_ops *ops = NULL;
> >   		pr_info("ftrace record flags: %lx\n", rec->flags);
> > -		pr_cont(" (%ld)%s", ftrace_rec_count(rec),
> > -			rec->flags & FTRACE_FL_REGS ? " R" : "  ");
> > +		pr_cont(" (%ld)%s%s", ftrace_rec_count(rec),
> > +			rec->flags & FTRACE_FL_REGS ? " R" : "  ",
> > +			rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ");
> >   		if (rec->flags & FTRACE_FL_TRAMP_EN) {
> >   			ops = ftrace_find_tramp_ops_any(rec);
> >   			if (ops) {
> > @@ -2177,6 +2217,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
> >   		 * want the direct enabled (it will be done via the
> >   		 * direct helper). But if DIRECT_EN is set, and
> >   		 * the count is not one, we need to clear it.
> > +		 *
> >   		 */
> >   		if (ftrace_rec_count(rec) == 1) {
> >   			if (!(rec->flags & FTRACE_FL_DIRECT) !=
> > @@ -2185,6 +2226,19 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
> >   		} else if (rec->flags & FTRACE_FL_DIRECT_EN) {
> >   			flag |= FTRACE_FL_DIRECT;
> >   		}
> > +
> > +		/*
> > +		 * Ops calls are special, as count matters.
> > +		 * As with direct calls, they must only be enabled when count
> > +		 * is one, otherwise they'll be handled via the list ops.
> > +		 */
> > +		if (ftrace_rec_count(rec) == 1) {
> > +			if (!(rec->flags & FTRACE_FL_CALL_OPS) !=
> > +			    !(rec->flags & FTRACE_FL_CALL_OPS_EN))
> > +				flag |= FTRACE_FL_CALL_OPS;
> > +		} else if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> > +			flag |= FTRACE_FL_CALL_OPS;
> > +		}
> >   	}
> >   	/* If the state of this record hasn't changed, then do nothing */
> > @@ -2229,6 +2283,21 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
> >   					rec->flags &= ~FTRACE_FL_DIRECT_EN;
> >   				}
> >   			}
> > +
> > +			if (flag & FTRACE_FL_CALL_OPS) {
> > +				if (ftrace_rec_count(rec) == 1) {
> > +					if (rec->flags & FTRACE_FL_CALL_OPS)
> > +						rec->flags |= FTRACE_FL_CALL_OPS_EN;
> > +					else
> > +						rec->flags &= ~FTRACE_FL_CALL_OPS_EN;
> > +				} else {
> > +					/*
> > +					 * Can only call directly if there's
> > +					 * only one set of associated ops.
> > +					 */
> > +					rec->flags &= ~FTRACE_FL_CALL_OPS_EN;
> > +				}
> > +			}
> >   		}
> >   		/*
> > @@ -2258,7 +2327,8 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
> >   			 * and REGS states. The _EN flags must be disabled though.
> >   			 */
> >   			rec->flags &= ~(FTRACE_FL_ENABLED | FTRACE_FL_TRAMP_EN |
> > -					FTRACE_FL_REGS_EN | FTRACE_FL_DIRECT_EN);
> > +					FTRACE_FL_REGS_EN | FTRACE_FL_DIRECT_EN |
> > +					FTRACE_FL_CALL_OPS_EN);
> >   	}
> >   	ftrace_bug_type = FTRACE_BUG_NOP;
> > @@ -2431,6 +2501,25 @@ ftrace_find_tramp_ops_new(struct dyn_ftrace *rec)
> >   	return NULL;
> >   }
> > +struct ftrace_ops *
> > +ftrace_find_unique_ops(struct dyn_ftrace *rec)
> > +{
> > +	struct ftrace_ops *op, *found = NULL;
> > +	unsigned long ip = rec->ip;
> > +
> > +	do_for_each_ftrace_op(op, ftrace_ops_list) {
> > +
> > +		if (hash_contains_ip(ip, op->func_hash)) {
> > +			if (found)
> > +				return NULL;
> > +			found = op;
> > +		}
> > +
> > +	} while_for_each_ftrace_op(op);
> > +
> > +	return found;
> > +}
> > +
> >   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >   /* Protected by rcu_tasks for reading, and direct_mutex for writing */
> >   static struct ftrace_hash *direct_functions = EMPTY_HASH;
> > @@ -3780,11 +3869,12 @@ static int t_show(struct seq_file *m, void *v)
> >   	if (iter->flags & FTRACE_ITER_ENABLED) {
> >   		struct ftrace_ops *ops;
> > -		seq_printf(m, " (%ld)%s%s%s",
> > +		seq_printf(m, " (%ld)%s%s%s%s",
> >   			   ftrace_rec_count(rec),
> >   			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
> >   			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ",
> > -			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ");
> > +			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ",
> > +			   rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ");
> >   		if (rec->flags & FTRACE_FL_TRAMP_EN) {
> >   			ops = ftrace_find_tramp_ops_any(rec);
> >   			if (ops) {
> > @@ -3800,6 +3890,15 @@ static int t_show(struct seq_file *m, void *v)
> >   		} else {
> >   			add_trampoline_func(m, NULL, rec);
> >   		}
> > +		if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> > +			ops = ftrace_find_unique_ops(rec);
> > +			if (ops) {
> > +				seq_printf(m, "\tops: %pS (%pS)",
> > +					   ops, ops->func);
> > +			} else {
> > +				seq_puts(m, "\tops: ERROR!");
> > +			}
> > +		}
> >   		if (rec->flags & FTRACE_FL_DIRECT) {
> >   			unsigned long direct;
> > 
