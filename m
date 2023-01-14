Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398366ABBF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjANNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjANNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:46:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F383F9;
        Sat, 14 Jan 2023 05:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1494A60B43;
        Sat, 14 Jan 2023 13:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C60EC433EF;
        Sat, 14 Jan 2023 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673703961;
        bh=FBTqS5C0vpzX8K3CrTPD4Sh29BdTUohvKieosm8VPHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2VpF+UcL1UcKZEl3Ka9iPE7fHWM/Q1QOEe3DgbhZml4p42ix5eV7W5xxZr5k3t32
         7Gbt1OXZGTmtHn4iBCdV6O7BJvxnioriYX8661/+FEIlV68/frlQ5ZCiy1CDvJAU3t
         huQIAjGk2drEHwEDOTH+GNRIgNQHVkYt3wRaZQ9h95nAEnfTSevhJXVBcuDdEStG04
         1BQC6WEWlIqWxOaVzLhf0SooYJQYW3x4urYuKC4+ErigaTfhHysz3+Tl+YdMaeuB14
         XUFKOMCkp0CSUAne2BQVdqjrF6haJj2omJ2rXA+gxPr5oJZ1aTCfeP3F2Fo8Y/QJJc
         fNm1HKIDnGgfw==
Date:   Sat, 14 Jan 2023 22:45:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel hangs when kprobe memcpy
Message-Id: <20230114224558.63bc010f06f67e2e534db9fe@kernel.org>
In-Reply-To: <b20cfc27-0e46-7e3b-e4f1-2e185ea516ab@loongson.cn>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
        <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
        <20230112233629.fafdbbe07dddf364f8078df6@kernel.org>
        <d0484b6e-c8a3-65c8-2157-0da95c17b061@loongson.cn>
        <20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org>
        <b20cfc27-0e46-7e3b-e4f1-2e185ea516ab@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 14:53:21 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> 
> 
> On 01/14/2023 01:38 PM, Masami Hiramatsu (Google) wrote:
> > Hi Tiezhu,
> >
> > On Fri, 13 Jan 2023 14:26:52 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >>
> >>
> >> On 01/12/2023 10:36 PM, Masami Hiramatsu (Google) wrote:
> >>> Hi Tiezhu,
> >>>
> >>> On Thu, 12 Jan 2023 21:32:51 +0800
> >>> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>>
> >>>>
> >>>>
> >>>> On 01/11/2023 07:38 PM, Tiezhu Yang wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> (1) I have the following test environment, kernel hangs when kprobe memcpy:
> >>>>>
> >>>>> system: x86_64 fedora 36
> >>>>> kernel version: Linux 5.7 (compile and update)
> >>>>> test case: modprobe kprobe_example symbol="memcpy"
> >>>>> (CONFIG_SAMPLE_KPROBES=m)
> >>>>>
> >>>>> In order to fix build errors, it needs to unset CONFIG_NFP and do the
> >>>>> following changes:
> >>>>> commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
> >>>>> commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if
> >>>>> CONFIG_PREEMPTION=y")
> >>>>>
> >>>>> (2) Using the latest upstream mainline kernel, no hang problem due to the
> >>>>> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
> >>>>> probing memcpy which is put into the .noinstr.text section.
> >>>>>
> >>>>>   # modprobe kprobe_example symbol="memcpy"
> >>>>>   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument
> >>>>>
> >>>>> In my opinion, according to the commit message, the above commit is not
> >>>>> intended to fix the memcpy hang problem, the problem was fixed by accident.
> >>>>>
> >>>>> (3) If make handler_pre() and handler_post() as empty functions in the 5.7
> >>>>> kernel code, the above hang problem does not exist.
> >>>
> >>>
> >>>>>
> >>>>> diff --git a/samples/kprobes/kprobe_example.c
> >>>>> b/samples/kprobes/kprobe_example.c
> >>>>> index fd346f58ddba..c194171d8a46 100644
> >>>>> --- a/samples/kprobes/kprobe_example.c
> >>>>> +++ b/samples/kprobes/kprobe_example.c
> >>>>> @@ -28,8 +28,6 @@ static struct kprobe kp = {
> >>>>>  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
> >>>>>  {
> >>>>>  #ifdef CONFIG_X86
> >>>>> -    pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
> >>>>> -        p->symbol_name, p->addr, regs->ip, regs->flags);
> >>>>>  #endif
> >>>>>  #ifdef CONFIG_PPC
> >>>>>      pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
> >>>>> @@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p,
> >>>>> struct pt_regs *regs,
> >>>>>                  unsigned long flags)
> >>>>>  {
> >>>>>  #ifdef CONFIG_X86
> >>>>> -    pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
> >>>>> -        p->symbol_name, p->addr, regs->flags);
> >>>>>  #endif
> >>>>>  #ifdef CONFIG_PPC
> >>>>>      pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
> >>>>>
> >>>>> I want to know what is the real reason of the hang problem when kprobe
> >>>>> memcpy,
> >>>>> I guess it may be kprobe recursion, what do you think? Thank you.
> >>>>>
> >>>>> By the way, kprobe memset has no problem whether or not handler_pre() and
> >>>>> handler_post() are empty functions.
> >>>>>
> >>>>> Thanks,
> >>>>> Tiezhu
> >>>>
> >>>> I find out the following call trace:
> >>>>
> >>>> handler_pre()
> >>>>    pr_info()
> >>>>      printk()
> >>>>        _printk()
> >>>>          vprintk()
> >>>>            vprintk_store()
> >>>>              memcpy()
> >>>>
> >>>> I think it may cause recursive exceptions, so we should
> >>>> mark memcpy as non-kprobe-able, right?
> >>>
> >>> Yes, and the .noinstr.text (noinstr function attribute) is including
> >>> non-kprobe-able (nokprobe function attribute). I a function is nokprobe
> >>> and notrace, it should be noinstr. "NOKPROBE_SYMBOL" is used for the
> >>> symbol which is called in the kprobe processing path (e.g. x86 int3
> >>> handler etc.).
> >>>
> >>> BTW, that the bug you reported is interesting. Even if another kprobe
> >>> is called inside kprobe pre/post handler, it must be skipped.
> >>> If you can share your kconfig, I can try to reproduce it.
> >>>
> >>> Thank you,
> >>>
> >>
> >> Hi Masami,
> >>
> >> Thank you very much for your reply.
> >>
> >> Please use the attached config and diff file, here are the steps
> >> to reproduce kernel hangs when kprobe memcpy on x86_64 fedora 36:
> >>
> >> (1) kernel 5.7
> >> $ wget --no-check-certificate
> >> https://git.kernel.org/torvalds/t/linux-5.7.tar.gz
> >> $ ls
> >> 5.7.config  5.7.diff  linux-5.7.tar.gz
> >> $ tar xf linux-5.7.tar.gz
> >> $ cd linux-5.7/
> >> $ patch -p1 < ../5.7.diff
> >> $ cp ../5.7.config .config
> >> $ make -j8
> >> # make modules_install -j8
> >> # make install
> >> # set the default kernel and reboot
> >> # modprobe kprobe_example symbol="memcpy"
> >>
> >> (2) kernel 6.2-rc1
> >> $ wget --no-check-certificate
> >> https://git.kernel.org/torvalds/t/linux-6.2-rc1.tar.gz
> >> $ ls
> >> 6.2-rc1.config  6.2-rc1.diff  linux-6.2-rc1.tar.gz
> >> $ tar xf linux-6.2-rc1.tar.gz
> >> $ cd linux-6.2-rc1/
> >> $ patch -p1 < ../6.2-rc1.diff
> >> $ cp ../6.2-rc1.config .config
> >> $ make -j8
> >> # make modules_install -j8
> >> # make install
> >> # set the default kernel and reboot
> >> # modprobe kprobe_example symbol="memcpy"
> >>
> >> By the way, I am developing and testing kprobe on LoongArch, I met the
> >> same hang problems when probe some symbols, such as (1) handle_syscall,
> >> like entry_SYSCALL_64 in arch/x86/entry/entry_64.S, used as syscall
> >> exception handler, (2) memcpy, it may cause recursive exceptions like
> >> x86.
> >
> > If you saw that without any change, please report it. At least
> > memcpy is already marked as noinstr.
> 
> The current upstream mainline kernel has no problem, because it includes
> commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr"), memcpy is
> already marked as noinstr. But for the kernel without the above commit,
> like kernel 5.7, it has problem.

Hmm, indeed. At least that should be backported to the stable kernels.
If we can reproduce it on 5.4 or older stable kernel, we have to backport
it or mark memcpy at least nokprobe.

Thank you,

> 
> >
> >>
> >> I do the following changes on LoongArch, could you please take a look
> >> whether the code itself and the commit message are proper? Thank you.
> >
> > Yeah, this direction is good to me.
> >
> 
> Thank you very much.
> 
> >>
> >> LoongArch: Mark some assembler symbols as non-kprobe-able
> >>
> >> Some assembler symbols are not kprobe safe, such as handle_syscall
> >> (used as syscall exception handler), *memcpy* (may cause recursive
> >> exceptions), they can not be instrumented, just blacklist them for
> >> kprobing.
> >>
> >> diff --git a/arch/loongarch/include/asm/asm.h
> >> b/arch/loongarch/include/asm/asm.h
> >> index 40eea6aa469e..c51a0914fc99 100644
> >> --- a/arch/loongarch/include/asm/asm.h
> >> +++ b/arch/loongarch/include/asm/asm.h
> >> @@ -188,4 +188,14 @@
> >>   #define PTRLOG		3
> >>   #endif
> >>
> >> +/* Annotate a function as being unsuitable for kprobes. */
> >> +#ifdef CONFIG_KPROBES
> >> +#define ASM_NOKPROBE(name)				\
> >
> > As same as other archs, can you rename it _ASM_NOKPROBE()?
> 
> OK, will modify it in the normal patch.
> 
> >
> > Others look good to me.
> 
> Thanks,
> Tiezhu
> 
> >
> > Thanks!
> >
> >> +	.pushsection "_kprobe_blacklist", "aw";		\
> >> +	.quad	name;					\
> >> +	.popsection;
> >> +#else
> >> +#define ASM_NOKPROBE(name)
> >> +#endif
> >> +
> >>   #endif /* __ASM_ASM_H */
> >> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> >> index d53b631c9022..05696bf7b69d 100644
> >> --- a/arch/loongarch/kernel/entry.S
> >> +++ b/arch/loongarch/kernel/entry.S
> >> @@ -67,6 +67,7 @@ SYM_FUNC_START(handle_syscall)
> >>
> >>   	RESTORE_ALL_AND_RET
> >>   SYM_FUNC_END(handle_syscall)
> >> +ASM_NOKPROBE(handle_syscall)
> >>
> >>   SYM_CODE_START(ret_from_fork)
> >>   	bl	schedule_tail		# a0 = struct task_struct *prev
> >> diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
> >> index 7c07d595ee89..b32dd25ce3a4 100644
> >> --- a/arch/loongarch/lib/memcpy.S
> >> +++ b/arch/loongarch/lib/memcpy.S
> >> @@ -17,6 +17,7 @@ SYM_FUNC_START(memcpy)
> >>   	ALTERNATIVE	"b __memcpy_generic", \
> >>   			"b __memcpy_fast", CPU_FEATURE_UAL
> >>   SYM_FUNC_END(memcpy)
> >> +ASM_NOKPROBE(memcpy)
> >>
> >>   EXPORT_SYMBOL(memcpy)
> >>
> >> @@ -41,6 +42,7 @@ SYM_FUNC_START(__memcpy_generic)
> >>   2:	move	a0, a3
> >>   	jr	ra
> >>   SYM_FUNC_END(__memcpy_generic)
> >> +ASM_NOKPROBE(__memcpy_generic)
> >>
> >>   /*
> >>    * void *__memcpy_fast(void *dst, const void *src, size_t n)
> >> @@ -93,3 +95,4 @@ SYM_FUNC_START(__memcpy_fast)
> >>   3:	move	a0, a3
> >>   	jr	ra
> >>   SYM_FUNC_END(__memcpy_fast)
> >> +ASM_NOKPROBE(__memcpy_fast)
> >>
> >> Thanks,
> >> Tiezhu
> >
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
