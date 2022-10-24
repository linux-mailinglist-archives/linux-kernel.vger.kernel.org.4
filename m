Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061CE609794
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 02:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJXAre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 20:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJXArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 20:47:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40EE550B5;
        Sun, 23 Oct 2022 17:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74B29B80DB5;
        Mon, 24 Oct 2022 00:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B2BC4314E;
        Mon, 24 Oct 2022 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666572448;
        bh=eKfyQ9JvQkHMYp0oSdnbc/60KLnQGcBug839FEafCbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kLNzVcQ4PvZK/n2eKxCsv9SmiN3hvk/qXV8+h3Et67GpL7L7QR2vaacx2Z0M3d/gM
         LXr4Fc7qoGPJ11FvSm3Q1HFTq/U6vk7OD6MnKZuUvAGrVukd7E1Lj0K4NYoh52XTjg
         eLRKdczXSykrYQeYbMDir7gDudt4BdiF/QGJFB3wmcpQjC72X/2m7uWyMOyLsCE+VZ
         U7TTQzR3igVSuy2knX9hOXZ6alJe4GAUcJLR952m0Ad15MT+vXJkP51zaN04Bi+XgD
         vmvQy31+JlNm/TFTHEguhVIIQa5qUIFv2V1Q7sXz5L2RTilKP954MdsvZiuBcN31VZ
         ijoSZBaAGgHRw==
Received: by mail-oi1-f182.google.com with SMTP id r204so6652242oie.5;
        Sun, 23 Oct 2022 17:47:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf0aKyt1VoluUcHTypKDx3mDvDRr0h/uadJME+dZOKFuku4jQB1f
        kMCxXdWpr21AvOsGTyP5h2vRON77OjqFORRjdDo=
X-Google-Smtp-Source: AMsMyM7009U9fo6Wj1OBVCOrzgnAnnM4a9IV75Exy9bv6NK9Bj31r01l0ngnnVp614GR5Po40WpMPngCeLU7/ER3RuU=
X-Received: by 2002:a05:6871:b0d:b0:13b:b91:dc94 with SMTP id
 fq13-20020a0568710b0d00b0013b0b91dc94mr11308877oab.112.1666572436415; Sun, 23
 Oct 2022 17:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221023203208.118919-1-Jason@zx2c4.com> <20221023203208.118919-3-Jason@zx2c4.com>
In-Reply-To: <20221023203208.118919-3-Jason@zx2c4.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Oct 2022 08:47:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS5rgm8mZ1RPWm8dA36hY6CRkg4GF=JV1bbbMOJy1fDZg@mail.gmail.com>
Message-ID: <CAJF2gTS5rgm8mZ1RPWm8dA36hY6CRkg4GF=JV1bbbMOJy1fDZg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] stackprotector: actually use get_random_canary()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:32 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The RNG always mixes in the Linux version extremely early in boot. It
> also always includes a cycle counter, not only during early boot, but
> each and every time it is invoked prior to being fully initialized.
> Together, this means that the use of additional xors inside of the
> various stackprotector.h files is superfluous and over-complicated.
> Instead, we can get exactly the same thing, but better, by just calling
> `get_random_canary()`.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm/include/asm/stackprotector.h     |  9 +--------
>  arch/arm64/include/asm/stackprotector.h   |  9 +--------
>  arch/csky/include/asm/stackprotector.h    | 10 +---------
>  arch/mips/include/asm/stackprotector.h    |  9 +--------
>  arch/powerpc/include/asm/stackprotector.h | 10 +---------
>  arch/riscv/include/asm/stackprotector.h   | 10 +---------
>  arch/sh/include/asm/stackprotector.h      | 10 +---------
>  arch/x86/include/asm/stackprotector.h     | 14 +-------------
>  arch/xtensa/include/asm/stackprotector.h  |  7 +------
>  9 files changed, 9 insertions(+), 79 deletions(-)
>
> diff --git a/arch/arm/include/asm/stackprotector.h b/arch/arm/include/asm/stackprotector.h
> index 088d03161be5..0bd4979759f1 100644
> --- a/arch/arm/include/asm/stackprotector.h
> +++ b/arch/arm/include/asm/stackprotector.h
> @@ -15,9 +15,6 @@
>  #ifndef _ASM_STACKPROTECTOR_H
>  #define _ASM_STACKPROTECTOR_H 1
>
> -#include <linux/random.h>
> -#include <linux/version.h>
> -
>  #include <asm/thread_info.h>
>
>  extern unsigned long __stack_chk_guard;
> @@ -30,11 +27,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>  #ifndef CONFIG_STACKPROTECTOR_PER_TASK
> diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
> index 33f1bb453150..ae3ad80f51fe 100644
> --- a/arch/arm64/include/asm/stackprotector.h
> +++ b/arch/arm64/include/asm/stackprotector.h
> @@ -13,8 +13,6 @@
>  #ifndef __ASM_STACKPROTECTOR_H
>  #define __ASM_STACKPROTECTOR_H
>
> -#include <linux/random.h>
> -#include <linux/version.h>
>  #include <asm/pointer_auth.h>
>
>  extern unsigned long __stack_chk_guard;
> @@ -28,12 +26,7 @@ extern unsigned long __stack_chk_guard;
>  static __always_inline void boot_init_stack_canary(void)
>  {
>  #if defined(CONFIG_STACKPROTECTOR)
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> -       canary &= CANARY_MASK;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>         if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
> index d7cd4e51edd9..d23747447166 100644
> --- a/arch/csky/include/asm/stackprotector.h
> +++ b/arch/csky/include/asm/stackprotector.h
> @@ -2,9 +2,6 @@
>  #ifndef _ASM_STACKPROTECTOR_H
>  #define _ASM_STACKPROTECTOR_H 1
>
> -#include <linux/random.h>
> -#include <linux/version.h>
> -
>  extern unsigned long __stack_chk_guard;
>
>  /*
> @@ -15,12 +12,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> -       canary &= CANARY_MASK;
> +       unsigned long canary = get_random_canary();
Acked-by: Guo Ren <guoren@kernel.org> #csky part

>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
> diff --git a/arch/mips/include/asm/stackprotector.h b/arch/mips/include/asm/stackprotector.h
> index 68d4be9e1254..518c192ad982 100644
> --- a/arch/mips/include/asm/stackprotector.h
> +++ b/arch/mips/include/asm/stackprotector.h
> @@ -15,9 +15,6 @@
>  #ifndef _ASM_STACKPROTECTOR_H
>  #define _ASM_STACKPROTECTOR_H 1
>
> -#include <linux/random.h>
> -#include <linux/version.h>
> -
>  extern unsigned long __stack_chk_guard;
>
>  /*
> @@ -28,11 +25,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
> diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
> index 1c8460e23583..283c34647856 100644
> --- a/arch/powerpc/include/asm/stackprotector.h
> +++ b/arch/powerpc/include/asm/stackprotector.h
> @@ -7,8 +7,6 @@
>  #ifndef _ASM_STACKPROTECTOR_H
>  #define _ASM_STACKPROTECTOR_H
>
> -#include <linux/random.h>
> -#include <linux/version.h>
>  #include <asm/reg.h>
>  #include <asm/current.h>
>  #include <asm/paca.h>
> @@ -21,13 +19,7 @@
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       canary = get_random_canary();
> -       canary ^= mftb();
> -       canary ^= LINUX_VERSION_CODE;
> -       canary &= CANARY_MASK;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>  #ifdef CONFIG_PPC64
> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
> index 09093af46565..43895b90fe3f 100644
> --- a/arch/riscv/include/asm/stackprotector.h
> +++ b/arch/riscv/include/asm/stackprotector.h
> @@ -3,9 +3,6 @@
>  #ifndef _ASM_RISCV_STACKPROTECTOR_H
>  #define _ASM_RISCV_STACKPROTECTOR_H
>
> -#include <linux/random.h>
> -#include <linux/version.h>
> -
>  extern unsigned long __stack_chk_guard;
>
>  /*
> @@ -16,12 +13,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> -       canary &= CANARY_MASK;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>         if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> diff --git a/arch/sh/include/asm/stackprotector.h b/arch/sh/include/asm/stackprotector.h
> index 35616841d0a1..665dafac376f 100644
> --- a/arch/sh/include/asm/stackprotector.h
> +++ b/arch/sh/include/asm/stackprotector.h
> @@ -2,9 +2,6 @@
>  #ifndef __ASM_SH_STACKPROTECTOR_H
>  #define __ASM_SH_STACKPROTECTOR_H
>
> -#include <linux/random.h>
> -#include <linux/version.h>
> -
>  extern unsigned long __stack_chk_guard;
>
>  /*
> @@ -15,12 +12,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> -       canary &= CANARY_MASK;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
> index 24a8d6c4fb18..00473a650f51 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -34,7 +34,6 @@
>  #include <asm/percpu.h>
>  #include <asm/desc.h>
>
> -#include <linux/random.h>
>  #include <linux/sched.h>
>
>  /*
> @@ -50,22 +49,11 @@
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       u64 canary;
> -       u64 tsc;
> +       unsigned long canary = get_random_canary();
>
>  #ifdef CONFIG_X86_64
>         BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
>  #endif
> -       /*
> -        * We both use the random pool and the current TSC as a source
> -        * of randomness. The TSC only matters for very early init,
> -        * there it already has some randomness on most systems. Later
> -        * on during the bootup the random pool has true entropy too.
> -        */
> -       get_random_bytes(&canary, sizeof(canary));
> -       tsc = rdtsc();
> -       canary += tsc + (tsc << 32UL);
> -       canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
>  #ifdef CONFIG_X86_64
> diff --git a/arch/xtensa/include/asm/stackprotector.h b/arch/xtensa/include/asm/stackprotector.h
> index e368f94fd2af..e1e318a0c98a 100644
> --- a/arch/xtensa/include/asm/stackprotector.h
> +++ b/arch/xtensa/include/asm/stackprotector.h
> @@ -14,7 +14,6 @@
>  #ifndef _ASM_STACKPROTECTOR_H
>  #define _ASM_STACKPROTECTOR_H 1
>
> -#include <linux/random.h>
>  #include <linux/version.h>
>
>  extern unsigned long __stack_chk_guard;
> @@ -27,11 +26,7 @@ extern unsigned long __stack_chk_guard;
>   */
>  static __always_inline void boot_init_stack_canary(void)
>  {
> -       unsigned long canary;
> -
> -       /* Try to get a semi random initial value. */
> -       get_random_bytes(&canary, sizeof(canary));
> -       canary ^= LINUX_VERSION_CODE;
> +       unsigned long canary = get_random_canary();
>
>         current->stack_canary = canary;
>         __stack_chk_guard = current->stack_canary;
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
