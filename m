Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8F6A0846
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjBWMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjBWMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:11:40 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314B55C14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:11:12 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id f5so2213271qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MF+iCYk9E2xvgTpRosXWJJIelTC2CmQvceltIoI8jo=;
        b=D2Pt2FuY1P/8hN2vO0Dnq+TGWzgYu9f4osLNYGUVJ/ByTmO61Inxak8geOGRyuNT+V
         CZ7rKK4kblmhxS38TuwTlX11aLL3SxlHRbefv8XRfxywiiQt38sbC+/5Ph1oB4io84RF
         5G6bbql1G+TqtSgA3Ov49X9NTN7nFyhVK8jxvlpOmUtjsqnZIXclzLkU0XwTlMvZ/rc7
         Ns/LMr94h6ERXv4hjFRe2uU+OZf1+HnHS1muAPO+J8T9uUllI9I8o9STXgYV5o3bWC87
         TfuG1L+zx7Q2Qc4raJAnxOdlAb37cxHBCxQw4svmZPSZylsfshUukU4vaXcAbeILjuGd
         IDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MF+iCYk9E2xvgTpRosXWJJIelTC2CmQvceltIoI8jo=;
        b=siTVB4xonFgvugj+9ywQoLb5R4hLs6oHnluVBUJpVjcrk5DDA5zYFwVHyIXcO+vf80
         MCUn+djCAdnq1mmanndIhkOhyOaMevISxcbxHOmoo4MUFVxDS90CV7I4esav1HDJS4vJ
         5RJSdVXCSkbdi/Fp7ZoQnH5pa0RdO8+Q6qLc99CIjDV9U4S1qNNC8dwGmgFNBs+/nfyC
         FvYX8xJcoJYfjZIV6w7sGoEfHb+qm1KLZQnfnEgOgukrjDN5lTcx779BHpR29Z76SBwy
         UU/50qFjHKmlS201ck4JwSTv0I2IRdupbJNnKvMTfximoC8s05Hso1qi9g2r1l8RrkRp
         6RjQ==
X-Gm-Message-State: AO0yUKVBXNtSE3EAIbsI7gQ/2SRBXmc211/YZz21nVwc6S/zIhBZUzvl
        biUUAUuJ7jo8lFIfEDEs/3gKng57plMvtfkQEw==
X-Google-Smtp-Source: AK7set+qPcAVNNLRj6bvPRns1V8BVa5HeXqW3evusgtX7vxwvku5mHfee3mLLlm50KBeUulaj+Ew+tK0+D9LhPk1nDE=
X-Received: by 2002:a05:620a:318c:b0:72b:25b4:565f with SMTP id
 bi12-20020a05620a318c00b0072b25b4565fmr2648836qkb.5.1677154245461; Thu, 23
 Feb 2023 04:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20230222221301.245890-1-brgerst@gmail.com> <20230222221301.245890-5-brgerst@gmail.com>
 <47E3748A-47CB-4F83-9125-2570968C3280@zytor.com>
In-Reply-To: <47E3748A-47CB-4F83-9125-2570968C3280@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 23 Feb 2023 07:10:33 -0500
Message-ID: <CAMzpN2js6Lugxd_QbFgx3Hw_8dEBJz4zxWFW=gjJkjoKjLQHzg@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86/smpbppt: Remove early_gdt_descr on 64-bit
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 1:50 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On February 22, 2023 2:12:59 PM PST, Brian Gerst <brgerst@gmail.com> wrote:
> >Build the GDT descriptor on the stack instead.
> >
> >Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >---
> > arch/x86/kernel/acpi/sleep.c |  2 --
> > arch/x86/kernel/head_64.S    | 19 +++++++------------
> > 2 files changed, 7 insertions(+), 14 deletions(-)
> >
> >diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> >index 008fda8b1982..6538ddb55f28 100644
> >--- a/arch/x86/kernel/acpi/sleep.c
> >+++ b/arch/x86/kernel/acpi/sleep.c
> >@@ -114,8 +114,6 @@ int x86_acpi_suspend_lowlevel(void)
> > #else /* CONFIG_64BIT */
> > #ifdef CONFIG_SMP
> >       current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
> >-      early_gdt_descr.address =
> >-                      (unsigned long)get_cpu_gdt_rw(smp_processor_id());
> >       initial_gs = per_cpu_offset(smp_processor_id());
> >       /* Force the startup into boot mode */
> >       saved_smpboot_ctrl = xchg(&smpboot_control, 0);
> >diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> >index f7905ba4b992..0dd57d573a0e 100644
> >--- a/arch/x86/kernel/head_64.S
> >+++ b/arch/x86/kernel/head_64.S
> >@@ -245,7 +245,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
> > #ifdef CONFIG_SMP
> >       /*
> >        * Is this the boot CPU coming up? If so everything is available
> >-       * in initial_gs and early_gdt_descr.
> >+       * in initial_gs.
> >        */
> >       movl    smpboot_control(%rip), %edx
> >       testl   $STARTUP_SECONDARY, %edx
> >@@ -313,11 +313,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
> >       /* Save it for GS BASE setup */
> >       movq    %rbx, initial_gs(%rip)
> >
> >-      /* Calculate the GDT address */
> >-      movq    $gdt_page, %rcx
> >-      addq    %rbx, %rcx
> >-      movq    %rcx, early_gdt_descr_base(%rip)
> >-
> >       movq    %rbx, %rdx
> > #else
> >       xorl    %edx, %edx
> >@@ -339,7 +334,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
> >        * addresses where we're currently running on. We have to do that here
> >        * because in 32bit we couldn't load a 64bit linear address.
> >        */
> >-      lgdt    early_gdt_descr(%rip)
> >+      subq    $16, %rsp
> >+      movw    $(GDT_SIZE-1), (%rsp)
> >+      leaq    gdt_page(%rdx), %rax
> >+      movq    %rax, 2(%rsp)
> >+      lgdt    (%rsp)
> >+      addq    $16, %rsp
> >
> >       /* set up data segments */
> >       xorl %eax,%eax
> >@@ -754,11 +754,6 @@ SYM_DATA_END(level1_fixmap_pgt)
> >
> >       .data
> >       .align 16
> >-
> >-SYM_DATA(early_gdt_descr,             .word GDT_ENTRIES*8-1)
> >-SYM_DATA_LOCAL(early_gdt_descr_base,  .quad INIT_PER_CPU_VAR(gdt_page))
> >-
> >-      .align 16
> > SYM_DATA(smpboot_control,             .long 0)
> >
> >       .align 16
>
> This is known to break at least some hypervisors, probably old by now, but...

I remember some ancient versions of Xen stored the address of the
descriptor, instead of the contents.  But looking at load_direct_gdt()
and load_fixmap_gdt() which both load a descriptor on the stack, I
don't think that is still a concern.

--
Brian Gerst
