Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0A70C566
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjEVSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjEVSkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:40:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416EAB7;
        Mon, 22 May 2023 11:40:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae85b71141so32261435ad.0;
        Mon, 22 May 2023 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684780821; x=1687372821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+EAmn2tpz4/xDoyuHIGsW4CA87YG1swsk2hGj8vxAxo=;
        b=MbKTglxDb9NdIFUgKl7mLyMgI6Q6JspOvGrE1ReThikIzQhX/V/DewAqnEXAj6ggn5
         KRsIos/VjlBmFWYLEqlGhFWCt2TEe6coXefFKScWAvCWemk4JzasEx0J35JWutmChJR4
         EmxhmT5CdqlCFru/NitkyzchacbB7UrB78TdvtkxhFLwoOr/C0DrFZ54oXn+Dg4eLFCH
         RrMDrLqI0nT5qvkXM2fCztoXM1I/itgUD7evoqzejL40mqbw5L2oAefCVtjmxGR7MXNx
         pTeF4uTwHaNYYUptDqKbDZbUOG/u9D5nNua57mAg8RefBI3AexGCsa7Npf+d5bGjCE95
         wc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780821; x=1687372821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EAmn2tpz4/xDoyuHIGsW4CA87YG1swsk2hGj8vxAxo=;
        b=lqAAlOjZ9yqnDi56eEwrspXIWm2kOV9qNv0pe/EdkgHKFlpenJe+B29MGF9leZunkK
         QJBzUqlpSpvqlqkhmWFr6ZsHskW/3+8rHzdt38Vp+wISspdUZ3rgSgbF4ZJh7xysPeMH
         39zWWD+lMUvNH0EYFxYEMxP9y13AcRyA8AV5VOQlZnoNoSw1tYtJUWM64Vmiuotmmxa5
         8oIqq+AzVEcM+m/YNJ3WrTnS0gJq5aRhKB4iE2Ve5XPQr+e/wJVx/pRptpVJhl8JPLnl
         BlMYy7cdx/MNdMG1aTz+3Tgfvs9eQBuO+lRQMG+jkw07f87clnNWsAXqNrKHbLPAmFHA
         Nu9g==
X-Gm-Message-State: AC+VfDzESKvf6+4EvbStpOZ+tugxs7WdsPUc01u0YQH6mnrUHN4Q+FI9
        rrNjoIgsSzv5m4+9wTK+G/VHWCo3+5EjiK/LXJ6fIka+
X-Google-Smtp-Source: ACHHUZ6ysvT/o4Zz1Xie2WnFX+T6TrOs1L5dvv3KhLHRnDFaIsSxg1PtNiD0topJLdi7Bp0qwodWyVpnm6nI534Po6g=
X-Received: by 2002:a17:902:ef82:b0:1a5:3319:12f7 with SMTP id
 iz2-20020a170902ef8200b001a5331912f7mr11626862plb.50.1684780821596; Mon, 22
 May 2023 11:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com> <20230519164753.72065-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230519164753.72065-2-jiaxun.yang@flygoat.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 22 May 2023 20:40:10 +0200
Message-ID: <CAOiHx==iku+duvBnAfu_3AXgNmY9aK+uO+t9Enzdf6qQN5m+iw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 May 2023 at 18:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> WAR_4KC_LLSC is used to control workaround of 4KC LLSC issue
> that affects 4Kc up to version 0.9.
>
> Early ath25 chips are known to be affected.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/Kconfig                                        | 6 ++++++
>  arch/mips/include/asm/cpu.h                              | 1 +
>  arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h | 2 +-
>  arch/mips/kernel/cpu-probe.c                             | 7 +++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 30e90a2d53f4..354d033364ad 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -230,6 +230,7 @@ config ATH25
>         select SYS_SUPPORTS_BIG_ENDIAN
>         select SYS_SUPPORTS_32BIT_KERNEL
>         select SYS_HAS_EARLY_PRINTK
> +       select WAR_4KC_LLSC if !SOC_AR5312

Shouldn't this be "if SOC_AR5312"?

Though since you are adding runtime detection/correction below, I
wonder if this would be really needed as an extra symbol, and rather
use the later introduced (CPU_MAY_HAVE_LLSC) directly.

Or rather have select "CPU_HAS_LLSC if !SOC_AR5312" in that case.

>         help
>           Support for Atheros AR231x and Atheros AR531x based boards
>
> @@ -2544,6 +2545,11 @@ config WAR_ICACHE_REFILLS
>  config WAR_R10000_LLSC
>         bool
>
> +# On 4Kc up to version 0.9 (PRID_REV < 1) there is a bug that may cause llsc
> +# sequences to deadlock.
> +config WAR_4KC_LLSC
> +       bool
> +
>  # 34K core erratum: "Problems Executing the TLBR Instruction"
>  config WAR_MIPS34K_MISSED_ITLB
>         bool
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index ecb9854cb432..84bb1931a8b4 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -247,6 +247,7 @@
>  #define PRID_REV_VR4122                        0x0070
>  #define PRID_REV_VR4181A               0x0070  /* Same as VR4122 */
>  #define PRID_REV_VR4130                        0x0080
> +#define PRID_REV_4KC_V1_0              0x0001
>  #define PRID_REV_34K_V1_0_2            0x0022
>  #define PRID_REV_LOONGSON1B            0x0020
>  #define PRID_REV_LOONGSON1C            0x0020  /* Same as Loongson-1B */
> diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> index ec3604c44ef2..5df292b1ff04 100644
> --- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> @@ -24,7 +24,7 @@
>  #define cpu_has_counter                        1
>  #define cpu_has_ejtag                  1
>
> -#if !defined(CONFIG_SOC_AR5312)
> +#if !defined(WAR_4KC_LLSC)
>  #  define cpu_has_llsc                 1

since the #else path defines cpu_has_llsc as 0, it means that kernels
targeting both SoCs would force llsc to be unavailable (not introduced
by you).

So this probably should be rather this:

#if !defined(CONFIG_SOC_AR5312)
#define cpu_has_llsc 1
#else if !defined(CONFIG_SOC_AR5312)
#define cpu_has_llsc 0
#endif

(so if only one is enabled, set it accordingly, else let runtime
detection handle it).

>  #else
>  /*
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 6d15a398d389..fd452e68cd90 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -152,6 +152,13 @@ static inline void check_errata(void)
>         struct cpuinfo_mips *c = &current_cpu_data;
>
>         switch (current_cpu_type()) {
> +       case CPU_4KC:
> +               if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
> +                       c->options &= ~MIPS_CPU_LLSC;
> +                       if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
> +                               pr_err("CPU have LLSC errata, please enable CONFIG_WAR_4K_LLSC");
> +               }

And then you don't need this error message at all, since then
cpu_has_llsc is 0 or follows MIPS_CPU_LLSC, unless you disabled
support for the relevant SoC, and then you'll have bigger problems
anyway.

Regards,
Jonas
