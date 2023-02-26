Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DBB6A2D16
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBZCIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZCIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:08:50 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEA11157;
        Sat, 25 Feb 2023 18:08:48 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id bf15so1208886iob.7;
        Sat, 25 Feb 2023 18:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrjdtBILIDq+NV0DYk67jfytffL1y4tAnBSHMKXYiGE=;
        b=d6kmUKplnpCinpxYtGel4x9i/A3TT7tllyN6U5q2EzObKlKOA5nH9Qdfh06S1n97Wf
         9DhUo3Z6z8rUs3JeEPKZu/HgGpbfyjvGaZFVvOIlRsvJN2S5iD+OgucMIpNfmT42qKWd
         TRRdiRtMbiYa9n0jPyWtjuIIbtylvj4+OPFIVqF7tuIxVXhme9aNB83Isx23zzxJQ0KM
         7TXEMWEyrnaC/gIHaQw2DTqNdAaT73GpsMGwhe95HgYWL96WFv35ixpNANQqpdY0iuu5
         Ksx+l/3n4RHXw8IOXDbgYvXUH6beOE3+s9vOawQKWGBH1W27ArPfPBcFAWbxoFwLPvve
         CQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrjdtBILIDq+NV0DYk67jfytffL1y4tAnBSHMKXYiGE=;
        b=x3Y2zzIvTHjO54qV84Do3ml1N1TrChw0bzTbUL1u3/WMC3xWizz6GX7nlLwpa0Rn6z
         /sJ1uIsPqI38GO+/oZk2uHxzaSsjYPtdpq4ny9HgL82ypUf1HrAzk5tD5XTdOsXXUoXi
         6IuFpp6yaKayeWVEFfCmfHGFD+4J81Wunlgk0XUl2Xje3DkIfMigywYD5BddKmxlUZNL
         bh1D+yT3aEmXEpoXNmTQqqaCinOEU4yZWr8d9mJj3Aek177IUTnyDANx2NeruhcCinqT
         gZc4fEkIgQdM4gZAI9tkoGAve3YSMOOSabCckS3gkMNWVy1Y+CgvJyuOPQUzJbVK4k7J
         NrfQ==
X-Gm-Message-State: AO0yUKXst7/5DJigZMbq+LJCVFFqHl31durquFPjSXugnipElm9Ro3FI
        ZwePT4vaiXYIkHSNe1S77JGB1zG3BEO/2J9rkoM=
X-Google-Smtp-Source: AK7set8NXG7XzplL6Lbk5ufmQAIWK7F8jnvQJX+YRsxLo9IaAZhKMPpj3Z6d4ohfmTGPflB99o9bRDch5WRUc4qPkF8=
X-Received: by 2002:a05:6602:2d89:b0:74c:a82e:eed1 with SMTP id
 k9-20020a0566022d8900b0074ca82eeed1mr2999725iow.0.1677377328284; Sat, 25 Feb
 2023 18:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20220224060558.1856804-1-keescook@chromium.org>
In-Reply-To: <20220224060558.1856804-1-keescook@chromium.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:08:37 -0500
Message-ID: <CAEdQ38Fg=Au5=BbyTHiEO+GaivheCe6hPBjcZhjgALxn4503Mg@mail.gmail.com>
Subject: Re: [PATCH] alpha: Implement "current_stack_pointer"
To:     Kees Cook <keescook@chromium.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
>
> To follow the existing per-arch conventions replace open-coded use
> of asm "$30" as "current_stack_pointer". This will let it be used in
> non-arch places (like HARDENED_USERCOPY).
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/alpha/Kconfig                   | 1 +
>  arch/alpha/include/asm/thread_info.h | 2 ++
>  arch/alpha/lib/stacktrace.c          | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 4e87783c90ad..31f3dbcdc28c 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -3,6 +3,7 @@ config ALPHA
>         bool
>         default y
>         select ARCH_32BIT_USTAT_F_TINODE
> +       select ARCH_HAS_CURRENT_STACK_POINTER
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
> diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
> index 2592356e3215..28214db31053 100644
> --- a/arch/alpha/include/asm/thread_info.h
> +++ b/arch/alpha/include/asm/thread_info.h
> @@ -43,6 +43,8 @@ struct thread_info {
>  register struct thread_info *__current_thread_info __asm__("$8");
>  #define current_thread_info()  __current_thread_info
>
> +register unsigned long *current_stack_pointer __asm__ ("$30");
> +
>  #endif /* __ASSEMBLY__ */
>
>  /* Thread information allocation.  */
> diff --git a/arch/alpha/lib/stacktrace.c b/arch/alpha/lib/stacktrace.c
> index 62454a7810e2..2b1176dd5174 100644
> --- a/arch/alpha/lib/stacktrace.c
> +++ b/arch/alpha/lib/stacktrace.c
> @@ -92,7 +92,7 @@ stacktrace(void)
>  {
>         instr * ret_pc;
>         instr * prologue = (instr *)stacktrace;
> -       register unsigned char * sp __asm__ ("$30");
> +       unsigned char *sp = (unsigned char *)current_stack_pointer;
>
>         printk("\tstack trace:\n");
>         do {
> --
> 2.30.2
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
