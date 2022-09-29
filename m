Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6251E5EF4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiI2L7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2L7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CB382602
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:59:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17501A9A;
        Thu, 29 Sep 2022 04:59:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11E33F73B;
        Thu, 29 Sep 2022 04:59:19 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:59:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Julia.Lawall@inria.fr, akpm@linux-foundation.org,
        andreyknvl@gmail.com, elver@google.com, wangkefeng.wang@huawei.com,
        zhouchengming@bytedance.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: module/ftrace: Fix mcount-based ftrace
 initialization failure
Message-ID: <YzWIlcM249P+ZzVs@FVFF77S0Q05N>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
 <20220929094134.99512-4-lihuafei1@huawei.com>
 <YzWA/GCdcLX31+rI@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWA/GCdcLX31+rI@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:26:52PM +0100, Mark Rutland wrote:
> On Thu, Sep 29, 2022 at 05:41:34PM +0800, Li Huafei wrote:
> > The commit a6253579977e ("arm64: ftrace: consistently handle PLTs.")
> > makes ftrace_make_nop() always validate the 'old' instruction that will
> > be replaced. However, in the mcount-based implementation,
> > ftrace_init_nop() also calls ftrace_make_nop() to do the initialization,
> > and the 'old' target address is MCOUNT_ADDR at this time. with
> > CONFIG_MODULE_PLT support, the distance between MCOUNT_ADDR and callsite
> > may exceed 128M, at which point ftrace_find_callable_addr() will fail
> > because it cannot find an available PLT.
> 
> Ah, sorry about this.
> 
> > We can reproduce this problem by forcing the module to alloc memory away
> > from the kernel:
> > 
> >   ftrace_test: loading out-of-tree module taints kernel.
> >   ftrace: no module PLT for _mcount
> >   ------------[ ftrace bug ]------------
> >   ftrace failed to modify
> >   [<ffff800029180014>] 0xffff800029180014
> >    actual:   44:00:00:94
> >   Initializing ftrace call sites
> >   ftrace record flags: 2000000
> >    (0)
> >    expected tramp: ffff80000802eb3c
> >   ------------[ cut here ]------------
> >   WARNING: CPU: 3 PID: 157 at kernel/trace/ftrace.c:2120 ftrace_bug+0x94/0x270
> >   Modules linked in:
> >   CPU: 3 PID: 157 Comm: insmod Tainted: G           O       6.0.0-rc6-00151-gcd722513a189-dirty #22
> >   Hardware name: linux,dummy-virt (DT)
> >   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc : ftrace_bug+0x94/0x270
> >   lr : ftrace_bug+0x21c/0x270
> >   sp : ffff80000b2bbaf0
> >   x29: ffff80000b2bbaf0 x28: 0000000000000000 x27: ffff0000c4d38000
> >   x26: 0000000000000001 x25: ffff800009d7e000 x24: ffff0000c4d86e00
> >   x23: 0000000002000000 x22: ffff80000a62b000 x21: ffff8000098ebea8
> >   x20: ffff0000c4d38000 x19: ffff80000aa24158 x18: ffffffffffffffff
> >   x17: 0000000000000000 x16: 0a0d2d2d2d2d2d2d x15: ffff800009aa9118
> >   x14: 0000000000000000 x13: 6333626532303830 x12: 3030303866666666
> >   x11: 203a706d61727420 x10: 6465746365707865 x9 : 3362653230383030
> >   x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : 000000000000bff4
> >   x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000001
> >   x2 : ad2cb14bb5438900 x1 : 0000000000000000 x0 : 0000000000000022
> >   Call trace:
> >    ftrace_bug+0x94/0x270
> >    ftrace_process_locs+0x308/0x430
> >    ftrace_module_init+0x44/0x60
> >    load_module+0x15b4/0x1ce8
> >    __do_sys_init_module+0x1ec/0x238
> >    __arm64_sys_init_module+0x24/0x30
> >    invoke_syscall+0x54/0x118
> >    el0_svc_common.constprop.4+0x84/0x100
> >    do_el0_svc+0x3c/0xd0
> >    el0_svc+0x1c/0x50
> >    el0t_64_sync_handler+0x90/0xb8
> >    el0t_64_sync+0x15c/0x160
> >   ---[ end trace 0000000000000000 ]---
> >   ---------test_init-----------
> > 
> > In fact, in .init.plt or .plt or both of them, we have the mcount PLT.
> > If we save the mcount PLT entry address, we can determine what the 'old'
> > instruction should be when initializing the nop instruction.
> >
> > Fixes: a6253579977e ("arm64: ftrace: consistently handle PLTs.")
> > Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> > ---
> >  arch/arm64/include/asm/module.h |  7 +++++++
> >  arch/arm64/kernel/ftrace.c      | 29 ++++++++++++++++++++++++++++-
> >  arch/arm64/kernel/module-plts.c | 16 ++++++++++++++++
> >  arch/arm64/kernel/module.c      | 11 +++++++++++
> >  4 files changed, 62 insertions(+), 1 deletion(-)
> 
> Since this only matters for the initalization of a module callsite, I'd rather
> we simply didn't check in this case, so that we don't have to go scanning for
> the PLTs and keep that information around forever.
> 
> To be honest, I'd rather we simply didn't check when initializing an mcount
> call-site for a module, as we used to do prior to commit a6253579977e.
> 
> Does the below work for you?

Thinking some more, that's probably going to warn in the insn code when
unconditionally generating the 'old' branch; I'll spin a new version after some
testing.

Thanks,
Mark.

> 
> Thanks,
> Mark.
> 
> ---->8----
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index ea5dc7c90f46..ba9b76ea5e68 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -216,6 +216,17 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  {
>  	unsigned long pc = rec->ip;
>  	u32 old = 0, new;
> +	bool validate = true;
> +
> +	/*
> +	 * When using mcount, calls can be indirected via a PLT generated by
> +	 * the toolchain. Ignore this when initializing the callsite.
> +	 *
> +	 * Note: `mod` is only set at module load time.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) &&
> +	    IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) && mod)
> +		validate = false;
>  
>  	if (!ftrace_find_callable_addr(rec, mod, &addr))
>  		return -EINVAL;
> @@ -223,7 +234,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  	old = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
>  	new = aarch64_insn_gen_nop();
>  
> -	return ftrace_modify_code(pc, old, new, true);
> +	return ftrace_modify_code(pc, old, new, validate);
>  }
>  
>  void arch_ftrace_update_code(int command)
