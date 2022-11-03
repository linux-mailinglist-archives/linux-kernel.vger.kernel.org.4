Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9527617706
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCG7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCG7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:59:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6013F10B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:59:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so501069otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jU3NGxO1EUwTyTXWWYBu4YHjvr1DaVewYJ8W5p2q9KU=;
        b=NuVeukR3guNMcd8fqb8zusPXO3pX292A2paPMT1Fw2JCW6ScnhB6S2pNYAiISOj1OE
         epquGbWXm0CIoSC/uYtqFgwiQ9xTvq+bfivcNbTl3kI21lSwBxX6dVSnO5kjb6wESKI+
         RYdfA169166lqCqhSf1WYLooQ3G15KIdpA9R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jU3NGxO1EUwTyTXWWYBu4YHjvr1DaVewYJ8W5p2q9KU=;
        b=tPxPAFOVuVN+Lliu2xzHs5pRRPUrWKITcBdkCP+6u6gaiOMVc+xgCSMvkKopwMoXuF
         J5ax9wQQWe7HsY5BZEU0tq9fafseRh2RTlAq7fzpfOQF/2T0gVTgFqe3tNKx6in7yroq
         zTY2F+4DlpdVCYawJ3ORFUw4NC2tSsPwZt6dAB4+cB5vc3BshBWHge8n4zTqULrvTkCF
         OwRCIN3Me/j8rMmIDhZCSBu/B+gxbDx9k36XZNqYT725LGLr/BKRDhyuofZ0IgGWq+RL
         9SXO+AwNgZAGgzSYwRtg/byp+kcILomfdC2tXRPKpSKAYMW0rAPDS+b6KuwbxByWpPnf
         CbqA==
X-Gm-Message-State: ACrzQf0wR3gsg8/QT8PwGcCqCpkDVOPPvFzTx49z8v0JNQhx3KY0pS8K
        RAjhtUMLN3Qyh2E9cG3z6n6fhmX+q9SHv4ei9f6p
X-Google-Smtp-Source: AMsMyM7cWIKI4geOTz1CbFifK42quVigOSL6ijHJuUGmO2itd5TIzSD3coAj+1RA3oI6VXAJNoy9RJRUEFc+QLk0sqI=
X-Received: by 2002:a05:6830:6611:b0:662:2725:d309 with SMTP id
 cp17-20020a056830661100b006622725d309mr13453334otb.293.1667458777704; Wed, 02
 Nov 2022 23:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221101143400.690000-1-apatel@ventanamicro.com> <20221101143400.690000-6-apatel@ventanamicro.com>
In-Reply-To: <20221101143400.690000-6-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 2 Nov 2022 23:59:25 -0700
Message-ID: <CAOnJCUKqRzNU0oCRMTm+XApMm_ys6hjgFbJDhQs0=nnR1s+MJw@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:34 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> To do remote FENCEs (i.e. remote TLB flushes) using IPI calls on the
> RISC-V kernel, we need hardware mechanism to directly inject IPI from
> the supervisor mode (i.e. RISC-V kernel) instead of using SBI calls.
>
> The upcoming AIA IMSIC devices allow direct IPI injection from the
> supervisor mode (i.e. RISC-V kernel). To support this, we extend the
> riscv_ipi_set_virq_range() function so that IPI provider (i.e. irqchip
> drivers can mark IPIs as suitable for remote FENCEs.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/smp.h      | 18 ++++++++++++++++--
>  arch/riscv/kernel/sbi-ipi.c       |  2 +-
>  arch/riscv/kernel/smp.c           | 11 ++++++++++-
>  drivers/clocksource/timer-clint.c |  2 +-
>  4 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 79ed0b73cd4e..56976e41a21e 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -16,6 +16,9 @@ struct seq_file;
>  extern unsigned long boot_cpu_hartid;
>
>  #ifdef CONFIG_SMP
> +
> +#include <linux/jump_label.h>
> +
>  /*
>   * Mapping between linux logical cpu index and hartid.
>   */
> @@ -46,7 +49,12 @@ void riscv_ipi_disable(void);
>  bool riscv_ipi_have_virq_range(void);
>
>  /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
> -void riscv_ipi_set_virq_range(int virq, int nr);
> +void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
> +
> +/* Check if we can use IPIs for remote FENCEs */
> +DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> +#define riscv_use_ipi_for_rfence() \
> +       static_branch_unlikely(&riscv_ipi_for_rfence)
>
>  /* Secondary hart entry */
>  asmlinkage void smp_callin(void);
> @@ -93,10 +101,16 @@ static inline bool riscv_ipi_have_virq_range(void)
>         return false;
>  }
>
> -static inline void riscv_ipi_set_virq_range(int virq, int nr)
> +static inline void riscv_ipi_set_virq_range(int virq, int nr,
> +                                           bool use_for_rfence)
>  {
>  }
>
> +static inline bool riscv_use_ipi_for_rfence(void)
> +{
> +       return false;
> +}
> +
>  #endif /* CONFIG_SMP */
>
>  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index f0a78420b127..ee8620104bd8 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -75,6 +75,6 @@ void __init sbi_ipi_init(void)
>                           "irqchip/sbi-ipi:starting",
>                           sbi_ipi_starting_cpu, sbi_ipi_dying_cpu);
>
> -       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> +       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
>         pr_info("providing IPIs using SBI IPI extension\n");
>  }
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index e8a20454d65b..74b8cb1a89ab 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -145,7 +145,10 @@ bool riscv_ipi_have_virq_range(void)
>         return (ipi_virq_base) ? true : false;
>  }
>
> -void riscv_ipi_set_virq_range(int virq, int nr)
> +DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> +EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
> +
> +void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
>  {
>         int i, err;
>
> @@ -168,6 +171,12 @@ void riscv_ipi_set_virq_range(int virq, int nr)
>
>         /* Enabled IPIs for boot CPU immediately */
>         riscv_ipi_enable();
> +
> +       /* Update RFENCE static key */
> +       if (use_for_rfence)
> +               static_branch_enable(&riscv_ipi_for_rfence);
> +       else
> +               static_branch_disable(&riscv_ipi_for_rfence);
>  }
>  EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
>
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index f9dd746a72c5..658049a5440b 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -249,7 +249,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
>                 goto fail_free_irq;
>         }
>
> -       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
> +       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, true);
>         clint_clear_ipi(clint_ipi_irq, NULL);
>
>         return 0;
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
