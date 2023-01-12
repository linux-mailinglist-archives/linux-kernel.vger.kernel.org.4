Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A46677E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbjALOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbjALOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:49:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C14811801;
        Thu, 12 Jan 2023 06:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDDDF62026;
        Thu, 12 Jan 2023 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A8C433D2;
        Thu, 12 Jan 2023 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673534193;
        bh=9nDQCiy4ZhBYJG7V8fAABcpXbz/cL2INS6RnNTWpn5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lIZz+Qk2uhEmNImMBalk6jfCkyNFYOU2j7KgJZiyd7J4KZdb8Q6kep+cMExbNqLBS
         WzD41YJiJE0EwV8JTbfn1OvywR7eYFmvVN2Y6HHX4L+JFnhmXQyodBTI0xn2mZc1Fa
         89ZkX0W8VnZ7ccWoRv1VkOauwq1UT25Zbi28lMNhaX40Zt32KTZz/VA7DoTXuFuM/G
         VyZFrylrtkkYkrbyue6jV9N3smPm4POG7PePSVsMS+/8izNdhpWz+Vw75WRd8t2KA6
         PnN565yEY+H6dySMGTQtQMc8j05MSwWlr/UwuWhxYEn6Lm4Qt5YTI7iJb8HID3c5jV
         yFXK44DuowCPA==
Date:   Thu, 12 Jan 2023 23:36:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel hangs when kprobe memcpy
Message-Id: <20230112233629.fafdbbe07dddf364f8078df6@kernel.org>
In-Reply-To: <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
References: <d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn>
        <19666c03-4bf6-7aac-3f1d-cd31ab7de2d5@loongson.cn>
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

On Thu, 12 Jan 2023 21:32:51 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> 
> 
> On 01/11/2023 07:38 PM, Tiezhu Yang wrote:
> > Hi all,
> >
> > (1) I have the following test environment, kernel hangs when kprobe memcpy:
> >
> > system: x86_64 fedora 36
> > kernel version: Linux 5.7 (compile and update)
> > test case: modprobe kprobe_example symbol="memcpy"
> > (CONFIG_SAMPLE_KPROBES=m)
> >
> > In order to fix build errors, it needs to unset CONFIG_NFP and do the
> > following changes:
> > commit 52a9dab6d892 ("libsubcmd: Fix use-after-free for realloc(..., 0)")
> > commit de979c83574a ("x86/entry: Build thunk_$(BITS) only if
> > CONFIG_PREEMPTION=y")
> >
> > (2) Using the latest upstream mainline kernel, no hang problem due to the
> > commit e3a9e681adb7 ("x86/entry: Fixup bad_iret vs noinstr") to prohibit
> > probing memcpy which is put into the .noinstr.text section.
> >
> >   # modprobe kprobe_example symbol="memcpy"
> >   modprobe: ERROR: could not insert 'kprobe_example': Invalid argument
> >
> > In my opinion, according to the commit message, the above commit is not
> > intended to fix the memcpy hang problem, the problem was fixed by accident.
> >
> > (3) If make handler_pre() and handler_post() as empty functions in the 5.7
> > kernel code, the above hang problem does not exist.


> >
> > diff --git a/samples/kprobes/kprobe_example.c
> > b/samples/kprobes/kprobe_example.c
> > index fd346f58ddba..c194171d8a46 100644
> > --- a/samples/kprobes/kprobe_example.c
> > +++ b/samples/kprobes/kprobe_example.c
> > @@ -28,8 +28,6 @@ static struct kprobe kp = {
> >  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
> >  {
> >  #ifdef CONFIG_X86
> > -    pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
> > -        p->symbol_name, p->addr, regs->ip, regs->flags);
> >  #endif
> >  #ifdef CONFIG_PPC
> >      pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
> > @@ -65,8 +63,6 @@ static void __kprobes handler_post(struct kprobe *p,
> > struct pt_regs *regs,
> >                  unsigned long flags)
> >  {
> >  #ifdef CONFIG_X86
> > -    pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
> > -        p->symbol_name, p->addr, regs->flags);
> >  #endif
> >  #ifdef CONFIG_PPC
> >      pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
> >
> > I want to know what is the real reason of the hang problem when kprobe
> > memcpy,
> > I guess it may be kprobe recursion, what do you think? Thank you.
> >
> > By the way, kprobe memset has no problem whether or not handler_pre() and
> > handler_post() are empty functions.
> >
> > Thanks,
> > Tiezhu
> 
> I find out the following call trace:
> 
> handler_pre()
>    pr_info()
>      printk()
>        _printk()
>          vprintk()
>            vprintk_store()
>              memcpy()
> 
> I think it may cause recursive exceptions, so we should
> mark memcpy as non-kprobe-able, right?

Yes, and the .noinstr.text (noinstr function attribute) is including
non-kprobe-able (nokprobe function attribute). I a function is nokprobe
and notrace, it should be noinstr. "NOKPROBE_SYMBOL" is used for the
symbol which is called in the kprobe processing path (e.g. x86 int3
handler etc.).

BTW, that the bug you reported is interesting. Even if another kprobe
is called inside kprobe pre/post handler, it must be skipped.
If you can share your kconfig, I can try to reproduce it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
