Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDA66B78C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAPGle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjAPGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:41:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D0283D6;
        Sun, 15 Jan 2023 22:41:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67EAEB80D0B;
        Mon, 16 Jan 2023 06:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939FDC433D2;
        Mon, 16 Jan 2023 06:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673851288;
        bh=vxB4hgvvq627D1GhOvSCHeoYC0e4WMhyfKKnraRhV4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZ56rODpD4CgQ/qC/beZ23LRaanSycqHyi/na0VCHVyCUbp2JrX1Tnk9adi7mYKXl
         Xjx7lzX1xFRLmY+7SwK4oxJnHbFOdXYMKNINTudQ1+V3CIfyXwLS0A9ReANwuH1T6p
         hsMoQ4I8aOZkUVkBW2vv/auxqH0nL+R5mu6nSd34XUInZ8OkxSTMvWFDbF/4TfIjQl
         G2EXxpxH5jr7o/nf9O9CVXcQbzCPkg0rofgVmW862DV4zQAixYucladTlKPmBCAF1c
         0BncvOX3fCapcCavMmv0ePE8Y3EHyu2tKY9JZlioghZTbziyn3fL9suNzNlY6GMGxD
         kSZty1rCtEMpA==
Date:   Mon, 16 Jan 2023 15:41:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel hangs when kprobe memcpy
Message-Id: <20230116154123.a0ff8d6deaff3fe87b48461b@kernel.org>
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

Hi Tiezhu,

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

I've confirmed that kernel 5.4.228 (the latest stable tree) did not have
this issue (it already rejects the memcpy). Since 5.7 is not a stable
(maintained) tree, we can not send a patch to it.
Anyway, it is better to add a test case for the recursed probe function.
I made a patch below. Can your loongarch port pass this test case?

Thank you, 

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 16 Jan 2023 15:19:52 +0900
Subject: [PATCH] test_kprobes: Add recursed kprobe test case

Add a recursed kprobe test case to the KUnit test module for kprobes.
This will probe a function which is called from the pre_handler and
post_handler itself. If the kprobe is correctly implemented, the recursed
kprobe handlers will be skipped and the number of skipped kprobe will
be counted on kprobe::nmissed.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/test_kprobes.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
index 1c95e5719802..0648f7154f5c 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -14,6 +14,7 @@
 
 static u32 rand1, preh_val, posth_val;
 static u32 (*target)(u32 value);
+static u32 (*recursed_target)(u32 value);
 static u32 (*target2)(u32 value);
 static struct kunit *current_test;
 
@@ -27,18 +28,27 @@ static noinline u32 kprobe_target(u32 value)
 	return (value / div_factor);
 }
 
+static noinline u32 kprobe_recursed_target(u32 value)
+{
+	return (value / div_factor);
+}
+
 static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	preh_val = (rand1 / div_factor);
+
+	preh_val = recursed_target(rand1);
 	return 0;
 }
 
 static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
 		unsigned long flags)
 {
+	u32 expval = recursed_target(rand1);
+
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
-	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
+	KUNIT_EXPECT_EQ(current_test, preh_val, expval);
+
 	posth_val = preh_val + div_factor;
 }
 
@@ -136,6 +146,29 @@ static void test_kprobes(struct kunit *test)
 	unregister_kprobes(kps, 2);
 }
 
+static struct kprobe kp_missed = {
+	.symbol_name = "kprobe_recursed_target",
+	.pre_handler = kp_pre_handler,
+	.post_handler = kp_post_handler,
+};
+
+static void test_kprobe_missed(struct kunit *test)
+{
+	current_test = test;
+	preh_val = 0;
+	posth_val = 0;
+
+	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp_missed));
+
+	recursed_target(rand1);
+
+	KUNIT_EXPECT_EQ(test, 2, kp_missed.nmissed);
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
+
+	unregister_kprobe(&kp_missed);
+}
+
 #ifdef CONFIG_KRETPROBES
 static u32 krph_val;
 
@@ -336,6 +369,7 @@ static int kprobes_test_init(struct kunit *test)
 {
 	target = kprobe_target;
 	target2 = kprobe_target2;
+	recursed_target = kprobe_recursed_target;
 	stacktrace_target = kprobe_stacktrace_target;
 	internal_target = kprobe_stacktrace_internal_target;
 	stacktrace_driver = kprobe_stacktrace_driver;
@@ -346,6 +380,7 @@ static int kprobes_test_init(struct kunit *test)
 static struct kunit_case kprobes_testcases[] = {
 	KUNIT_CASE(test_kprobe),
 	KUNIT_CASE(test_kprobes),
+	KUNIT_CASE(test_kprobe_missed),
 #ifdef CONFIG_KRETPROBES
 	KUNIT_CASE(test_kretprobe),
 	KUNIT_CASE(test_kretprobes),
-- 
2.39.0.246.g2a6d74b583-goog


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
