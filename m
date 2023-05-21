Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D370AE95
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjEUPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEUPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB91BD;
        Sun, 21 May 2023 08:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12FE61528;
        Sun, 21 May 2023 15:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F3C433B4;
        Sun, 21 May 2023 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684683017;
        bh=YPMM/8GlJbBOcfom5pOdN7LyjQ75t5SA5nQ04f6GwkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mO11FJAL4r8D0kMZRd46uYx1Xli83ofHh+hlst3r2IWQiSr2efthW0UDDilhWb5J4
         TBufuNw+KMqv+QWOWzbJ91HqLYirOZNhOeziKTs6mFvsBzbq4/Rh9998v7waFBKXQ/
         LDbk8HCtZOCsm/0PLSC18CBVktLPbOVh97m5WGcA5U+rrFUILIedpBrHl5BiesvRc4
         ILxWiKbrjOJ7k8qAHBkc0SyHuC7VcH23et+XIbb64kZ4A7dnDSFTgtwAkYOKmMPhv2
         QZMGqUwsHNKxGVkiOZnxlSKNECbnQHk1HX/NCka1LKBxNnv49Q4LcGZR5nawIL91Yt
         /lL358K44LExQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-510ede0f20aso5371329a12.3;
        Sun, 21 May 2023 08:30:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDx4R9dgPEceHo7udNLdC4tYnrO+BRH3QCRQfShbs7C70+NF83LX
        qvz71hw2VS6Vx/9AGxBPdG3oURW8AGMpsPQrPLY=
X-Google-Smtp-Source: ACHHUZ7fC7VoTCmxVvgnj+XprmdOzTdADfx+p51AfUU2RX+IjuemmurGhjjXvb4ZOHMk5eyEyL8M50rHqnEzEEon25w=
X-Received: by 2002:a17:907:8a20:b0:96a:861:a2ac with SMTP id
 sc32-20020a1709078a2000b0096a0861a2acmr8333246ejc.0.1684683014948; Sun, 21
 May 2023 08:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230516200341.553413-1-arnd@kernel.org>
In-Reply-To: <20230516200341.553413-1-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 May 2023 23:30:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTqoE=Hty7q__m_4zvTOpC8cDpnK1ghEuFVZ+KrA7xmfA@mail.gmail.com>
Message-ID: <CAJF2gTTqoE=Hty7q__m_4zvTOpC8cDpnK1ghEuFVZ+KrA7xmfA@mail.gmail.com>
Subject: Re: [PATCH] irq_work: consolidate arch_irq_work_raise prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 4:03=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The prototype was hidden on x86, which causes a warning:
>
> kernel/irq_work.c:72:13: error: no previous prototype for 'arch_irq_work_=
raise' [-Werror=3Dmissing-prototypes]
>
> Fix this by providing it in only one place that is always visible.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/irq_work.h     | 2 --
>  arch/arm64/include/asm/irq_work.h   | 2 --
>  arch/csky/include/asm/irq_work.h    | 2 +-
>  arch/powerpc/include/asm/irq_work.h | 1 -
>  arch/riscv/include/asm/irq_work.h   | 2 +-
>  arch/s390/include/asm/irq_work.h    | 2 --
>  arch/x86/include/asm/irq_work.h     | 1 -
>  include/linux/irq_work.h            | 3 +++
>  8 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_w=
ork.h
> index 3149e4dc1b54..8895999834cc 100644
> --- a/arch/arm/include/asm/irq_work.h
> +++ b/arch/arm/include/asm/irq_work.h
> @@ -9,6 +9,4 @@ static inline bool arch_irq_work_has_interrupt(void)
>         return is_smp();
>  }
>
> -extern void arch_irq_work_raise(void);
> -
>  #endif /* _ASM_ARM_IRQ_WORK_H */
> diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/i=
rq_work.h
> index 81bbfa3a035b..a1020285ea75 100644
> --- a/arch/arm64/include/asm/irq_work.h
> +++ b/arch/arm64/include/asm/irq_work.h
> @@ -2,8 +2,6 @@
>  #ifndef __ASM_IRQ_WORK_H
>  #define __ASM_IRQ_WORK_H
>
> -extern void arch_irq_work_raise(void);
> -
>  static inline bool arch_irq_work_has_interrupt(void)
>  {
>         return true;
> diff --git a/arch/csky/include/asm/irq_work.h b/arch/csky/include/asm/irq=
_work.h
> index 33aaf39d6f94..d39fcc1f5395 100644
> --- a/arch/csky/include/asm/irq_work.h
> +++ b/arch/csky/include/asm/irq_work.h
> @@ -7,5 +7,5 @@ static inline bool arch_irq_work_has_interrupt(void)
>  {
>         return true;
>  }
> -extern void arch_irq_work_raise(void);
> +
Acked-by: Guo Ren <guoren@kernel.org>

>  #endif /* __ASM_CSKY_IRQ_WORK_H */
> diff --git a/arch/powerpc/include/asm/irq_work.h b/arch/powerpc/include/a=
sm/irq_work.h
> index b8b0be8f1a07..c6d3078bd8c3 100644
> --- a/arch/powerpc/include/asm/irq_work.h
> +++ b/arch/powerpc/include/asm/irq_work.h
> @@ -6,6 +6,5 @@ static inline bool arch_irq_work_has_interrupt(void)
>  {
>         return true;
>  }
> -extern void arch_irq_work_raise(void);
>
>  #endif /* _ASM_POWERPC_IRQ_WORK_H */
> diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/i=
rq_work.h
> index b53891964ae0..b27a4d64fc6a 100644
> --- a/arch/riscv/include/asm/irq_work.h
> +++ b/arch/riscv/include/asm/irq_work.h
> @@ -6,5 +6,5 @@ static inline bool arch_irq_work_has_interrupt(void)
>  {
>         return IS_ENABLED(CONFIG_SMP);
>  }
> -extern void arch_irq_work_raise(void);
> +
>  #endif /* _ASM_RISCV_IRQ_WORK_H */
> diff --git a/arch/s390/include/asm/irq_work.h b/arch/s390/include/asm/irq=
_work.h
> index 603783766d0a..f00c9f610d5a 100644
> --- a/arch/s390/include/asm/irq_work.h
> +++ b/arch/s390/include/asm/irq_work.h
> @@ -7,6 +7,4 @@ static inline bool arch_irq_work_has_interrupt(void)
>         return true;
>  }
>
> -void arch_irq_work_raise(void);
> -
>  #endif /* _ASM_S390_IRQ_WORK_H */
> diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_w=
ork.h
> index 800ffce0db29..6b4d36c95165 100644
> --- a/arch/x86/include/asm/irq_work.h
> +++ b/arch/x86/include/asm/irq_work.h
> @@ -9,7 +9,6 @@ static inline bool arch_irq_work_has_interrupt(void)
>  {
>         return boot_cpu_has(X86_FEATURE_APIC);
>  }
> -extern void arch_irq_work_raise(void);
>  #else
>  static inline bool arch_irq_work_has_interrupt(void)
>  {
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 8cd11a223260..136f2980cba3 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -66,6 +66,9 @@ void irq_work_sync(struct irq_work *work);
>  void irq_work_run(void);
>  bool irq_work_needs_cpu(void);
>  void irq_work_single(void *arg);
> +
> +void arch_irq_work_raise(void);
> +
>  #else
>  static inline bool irq_work_needs_cpu(void) { return false; }
>  static inline void irq_work_run(void) { }
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren
