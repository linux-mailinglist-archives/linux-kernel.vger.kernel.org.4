Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335EB6F16CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjD1LdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjD1LdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:33:08 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01DD2D5B;
        Fri, 28 Apr 2023 04:33:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-505050c7217so2303886a12.0;
        Fri, 28 Apr 2023 04:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682681586; x=1685273586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qiK+2Kef1Kx6h4Hgf1UOALX5Oe6r2KFCk8XCh0+Srw=;
        b=QAiKimGW7TUHci8v1rAi081krLoNzy9DR3de89EuFqbKslwbLCu5aLhpQvNf7M5QNI
         QUzd6OiK8FbI5opc3xTxLmmBNIGvEKNpJmDBF5ey8bu6FM2SZGoE8Akqa3biQ7hiuVJq
         Ck1Rwgz+4WZ+3jDt+SO3Lw1H8uI6D3smH/jEheRVM8AFwejRkBjInZsKLPV4/337uW+E
         bRP76wmtUp/vvsNAlzWCfoVdsCEJjUXzXCEQRyLH9a7J67pRHnbMlR0i4rpA0WMuMWaL
         mgwts79zFDCIHpS3+XDiyyIhTKjFYX4rYrxDEeE2ZVFgjU5wdU4yNXg8Zse95W0LwYGi
         +NHQ==
X-Gm-Message-State: AC+VfDy6c7ljWOhuUkyDR9Oo37ClNbnEP2teXPQ+jCuWTNU5qEuZdHi9
        O5GJY8Zo1YF5UsC2DhdhfSA5nxineU2o8uEezwo=
X-Google-Smtp-Source: ACHHUZ4N1EiiMKI1qx4JfSPfZXQQ2xHApLzR4SKlxtAOHfQYgP0iGWdaQ8AIYNoTuoYy4pajn+iSB7na14Vf4shwqQY=
X-Received: by 2002:a05:6402:26c5:b0:509:c551:c024 with SMTP id
 x5-20020a05640226c500b00509c551c024mr4944858edd.1.1682681585788; Fri, 28 Apr
 2023 04:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com> <8b90798cb41604b2e2d47c8fcbb67913daafd85d.1682673543.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <8b90798cb41604b2e2d47c8fcbb67913daafd85d.1682673543.git.houwenlong.hwl@antgroup.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Apr 2023 13:32:53 +0200
Message-ID: <CAJZ5v0iWUV=V5zqUp7DdJhR2FZiSOpbUUg7nuRg7N_xt4e0ETQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/43] x86/acpi: Adapt assembly for PIE support
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:52 AM Hou Wenlong
<houwenlong.hwl@antgroup.com> wrote:
>
> From: Thomas Garnier <thgarnie@chromium.org>
>
> From: Thomas Garnier <thgarnie@chromium.org>
>
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
>
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index d5d8a352eafa..fe688bd87d72 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -17,7 +17,7 @@
>          * Hooray, we are in Long 64-bit mode (but still running in low memory)
>          */
>  SYM_FUNC_START(wakeup_long64)
> -       movq    saved_magic, %rax
> +       movq    saved_magic(%rip), %rax
>         movq    $0x123456789abcdef0, %rdx
>         cmpq    %rdx, %rax
>         je      2f
> @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
>         movw    %ax, %es
>         movw    %ax, %fs
>         movw    %ax, %gs
> -       movq    saved_rsp, %rsp
> +       movq    saved_rsp(%rip), %rsp
>
> -       movq    saved_rbx, %rbx
> -       movq    saved_rdi, %rdi
> -       movq    saved_rsi, %rsi
> -       movq    saved_rbp, %rbp
> +       movq    saved_rbx(%rip), %rbx
> +       movq    saved_rdi(%rip), %rdi
> +       movq    saved_rsi(%rip), %rsi
> +       movq    saved_rbp(%rip), %rbp
>
> -       movq    saved_rip, %rax
> +       movq    saved_rip(%rip), %rax
>         ANNOTATE_RETPOLINE_SAFE
>         jmp     *%rax
>  SYM_FUNC_END(wakeup_long64)
> @@ -51,7 +51,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>         xorl    %eax, %eax
>         call    save_processor_state
>
> -       movq    $saved_context, %rax
> +       leaq    saved_context(%rip), %rax
>         movq    %rsp, pt_regs_sp(%rax)
>         movq    %rbp, pt_regs_bp(%rax)
>         movq    %rsi, pt_regs_si(%rax)
> @@ -70,13 +70,14 @@ SYM_FUNC_START(do_suspend_lowlevel)
>         pushfq
>         popq    pt_regs_flags(%rax)
>
> -       movq    $.Lresume_point, saved_rip(%rip)
> +       leaq    .Lresume_point(%rip), %rax
> +       movq    %rax, saved_rip(%rip)
>
> -       movq    %rsp, saved_rsp
> -       movq    %rbp, saved_rbp
> -       movq    %rbx, saved_rbx
> -       movq    %rdi, saved_rdi
> -       movq    %rsi, saved_rsi
> +       movq    %rsp, saved_rsp(%rip)
> +       movq    %rbp, saved_rbp(%rip)
> +       movq    %rbx, saved_rbx(%rip)
> +       movq    %rdi, saved_rdi(%rip)
> +       movq    %rsi, saved_rsi(%rip)
>
>         addq    $8, %rsp
>         movl    $3, %edi
> @@ -88,7 +89,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>         .align 4
>  .Lresume_point:
>         /* We don't restore %rax, it must be 0 anyway */
> -       movq    $saved_context, %rax
> +       leaq    saved_context(%rip), %rax
>         movq    saved_context_cr4(%rax), %rbx
>         movq    %rbx, %cr4
>         movq    saved_context_cr3(%rax), %rbx
> --
> 2.31.1
>
