Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC662FCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiKRScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiKRScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:32:10 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636E10ED
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:32:08 -0800 (PST)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A88C3F222
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668796327;
        bh=Djv3x6aUPv9PyyjT1iixDxyaYlLmiEBl3/NbYjudgXA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=n1qNvLZC0TwV9yiXYqXOA7zDS9EpEIlVbjtEnWk2c+PbivNvVj3oVHPAOvzNvERgE
         8rCELrzouQI8vrmUAG/uqu8/F2mku1zzZqmo7rPkRt4V1ixSELhf5N+CJkYLdsOcNC
         AIZBzGbPo3xMr+x+9KLtytJ7nDMNpxPrIVpzheb7zRy5iZA0vcAkoI3NpY2TEtcZIn
         X8OL2UB5iuV0Twiv9HlxyNZtC5WkP2pcNjTzRFLZqkiD2mTmTH6TzCKWFTACLeLFyG
         OQY6zqlpWiwXHRcloWFM/x301JcTXuC6d69SsdrEZuvpGQv8mQkSD6tCbsRoYAHV29
         3a7sMM17ffd9Q==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-391bd92f931so47698087b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Djv3x6aUPv9PyyjT1iixDxyaYlLmiEBl3/NbYjudgXA=;
        b=kmYZcI15pq4xEifTQugxT7F9bGdKFUfdaMxBPObM24t8Z+9RHKE8Hj19rcUUuRwBFh
         O1TKg0Syux8X6eyspUU0vt+atf8zLn0YfeNbag8l32jkkkBdsNvz3aFlDmjdGzgFb+Sj
         nmLsGtV3OjzGzqel6uDeh+QkTR94qRn/+O/s5yfkAec4hHsKgt3kYIq7N8xpHCfMPMtl
         6gWfCEzgWWG8sj6bEfE36AotHp21xJPyrFEhmXD6GdSay0aiNaQ/QkMAHa4i/h0LXInr
         SIMDQXBjmdRRh9O9YBrO5IGdMCYuwEnNTTAniZ4kmO/yAvRMmMeZrhXA+XefQ69tU8cA
         p/VA==
X-Gm-Message-State: ANoB5pllOpSzbT6jxaYEWr0oRJ4HZnVFuzHrtdSV8PtRYEThGB/PxGxM
        YTBqTJ9MTWVchktSpHyryREVgNfLWCq2stkm27xRBCcq+6x8wtcfpx3C2UJM2BgFeuarjG4WESG
        Uwj+GBhfs7geC1kYFqrl9GQqrua42muMJE8DR7WK4cBGNvFqIzP50kZyo+w==
X-Received: by 2002:a81:f805:0:b0:378:5e3a:8fad with SMTP id z5-20020a81f805000000b003785e3a8fadmr7655976ywm.78.1668796324638;
        Fri, 18 Nov 2022 10:32:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XdIk5stDOfOFkR1tIl/cDaTWOTLW+0rpbUH31BIkAMdlgi7U1KbO8hjd4o6yHDyjGGNFzy/lAfdlxiS47ZOg=
X-Received: by 2002:a81:f805:0:b0:378:5e3a:8fad with SMTP id
 z5-20020a81f805000000b003785e3a8fadmr7655950ywm.78.1668796324303; Fri, 18 Nov
 2022 10:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20221118133216.17037-1-walker.chen@starfivetech.com> <20221118133216.17037-4-walker.chen@starfivetech.com>
In-Reply-To: <20221118133216.17037-4-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 19:31:47 +0100
Message-ID: <CAJM55Z9jfpOW49Z5cdR18T0w4Ae6CQAYF-AsCD8eOcPczwgoZA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> Add generic power domain driver for the StarFive JH71XX SoC.

SoCs

> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  MAINTAINERS                       |   8 +
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/starfive/Kconfig      |   9 +
>  drivers/soc/starfive/Makefile     |   3 +
>  drivers/soc/starfive/jh71xx_pmu.c | 380 ++++++++++++++++++++++++++++++
>  include/soc/starfive/pm_domains.h |  15 ++
>  7 files changed, 417 insertions(+)
>  create mode 100644 drivers/soc/starfive/Kconfig
>  create mode 100644 drivers/soc/starfive/Makefile
>  create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
>  create mode 100644 include/soc/starfive/pm_domains.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70c1d0f303e..112f1e698723 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19623,6 +19623,14 @@ F:     Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:     drivers/reset/starfive/
>  F:     include/dt-bindings/reset/starfive*

checkpatch.pl complains about not sorting these lines alphabetically.

> +STARFIVE JH71XX PMU CONTROLLER DRIVER
> +M:     Walker Chen <walker.chen@starfivetech.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/power/starfive*
> +F:     drivers/soc/starfive/jh71xx_pmu.c
> +F:     include/soc/starfive/pm_domains.h
> +F:     include/dt-bindings/power/jh7110-power.h
> +
>  STATIC BRANCH/CALL
>  M:     Peter Zijlstra <peterz@infradead.org>
>  M:     Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index e461c071189b..628fda4d5ed9 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -21,6 +21,7 @@ source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
>  source "drivers/soc/sifive/Kconfig"
> +source "drivers/soc/starfive/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 534669840858..cbe076f42068 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -27,6 +27,7 @@ obj-y                         += renesas/
>  obj-y                          += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
>  obj-y                          += sifive/
> +obj-y                          += starfive/
>  obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-y                          += ti/
> diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
> new file mode 100644
> index 000000000000..2bbcc1397b15
> --- /dev/null
> +++ b/drivers/soc/starfive/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config JH71XX_PMU
> +       bool "Support PMU for StarFive JH71XX Soc"
> +       depends on PM && (SOC_STARFIVE || COMPILE_TEST)
> +       select PM_GENERIC_DOMAINS
> +       help
> +         Say y here to enable power domain support.

Please expand this help text. Even checkpatch.pl complains about it.

> +
> diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
> new file mode 100644
> index 000000000000..13b589d6b5f3
> --- /dev/null
> +++ b/drivers/soc/starfive/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_JH71XX_PMU)       += jh71xx_pmu.o
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
> new file mode 100644
> index 000000000000..e6c0083d166e
> --- /dev/null
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * StarFive JH71XX Power Domain Controller Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <dt-bindings/power/jh7110-power.h>
> +
> +/* register offset */
> +#define HW_EVENT_TURN_ON_MASK          0x04
> +#define HW_EVENT_TURN_OFF_MASK         0x08
> +#define SW_TURN_ON_POWER_MODE          0x0C
> +#define SW_TURN_OFF_POWER_MODE         0x10
> +#define SW_ENCOURAGE                   0x44
> +#define PMU_INT_MASK                   0x48
> +#define PCH_BYPASS                     0x4C
> +#define PCH_PSTATE                     0x50
> +#define PCH_TIMEOUT                    0x54
> +#define LP_TIMEOUT                     0x58
> +#define HW_TURN_ON_MODE                        0x5C
> +#define CURR_POWER_MODE                        0x80
> +#define PMU_EVENT_STATUS               0x88
> +#define PMU_INT_STATUS                 0x8C
> +
> +/* sw encourage cfg */
> +#define SW_MODE_ENCOURAGE_EN_LO                0x05
> +#define SW_MODE_ENCOURAGE_EN_HI                0x50
> +#define SW_MODE_ENCOURAGE_DIS_LO       0x0A
> +#define SW_MODE_ENCOURAGE_DIS_HI       0xA0
> +#define SW_MODE_ENCOURAGE_ON           0xFF
> +
> +/* pmu int status */
> +#define PMU_INT_SEQ_DONE               BIT(0)
> +#define PMU_INT_HW_REQ                 BIT(1)
> +#define PMU_INT_SW_FAIL                        GENMASK(3, 2)
> +#define PMU_INT_HW_FAIL                        GENMASK(5, 4)
> +#define PMU_INT_PCH_FAIL               GENMASK(8, 6)
> +#define PMU_INT_FAIL_MASK              (PMU_INT_SW_FAIL | \
> +                                       PMU_INT_HW_FAIL | \
> +                                       PMU_INT_PCH_FAIL)
> +#define PMU_INT_ALL_MASK               (PMU_INT_SEQ_DONE | \
> +                                       PMU_INT_HW_REQ | \
> +                                       PMU_INT_FAIL_MASK)
> +
> +#define DELAY_US                       10
> +#define TIMEOUT_US                     100000

Please add a JH71XX_PMU_ prefix to these definitions to avoid
accidentally clashing with a definition added to a generic header.

> +
> +struct starfive_power_dev {
> +       struct generic_pm_domain genpd;
> +       struct starfive_pmu *power;
> +       uint32_t mask;

u32

> +};
> +
> +struct starfive_pmu {
> +       void __iomem *base;
> +       spinlock_t lock;
> +       int irq;
> +       struct device *pdev;
> +       struct starfive_power_dev *dev;
> +       struct genpd_onecell_data genpd_data;
> +       struct generic_pm_domain **genpd;
> +};
> +
> +struct starfive_pmu_data {
> +       const char * const name;
> +       uint8_t bit;

u8

> +       unsigned int flags;
> +};
> +
> +static void __iomem *pmu_base;
> +
> +static inline void pmu_writel(u32 val, u32 offset)
> +{
> +       writel(val, pmu_base + offset);
> +}
> +
> +void starfive_pmu_hw_event_turn_on(u32 mask)
> +{
> +       pmu_writel(mask, HW_EVENT_TURN_ON_MASK);
> +}
> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_on);
> +
> +void starfive_pmu_hw_event_turn_off(u32 mask)
> +{
> +       pmu_writel(mask, HW_EVENT_TURN_OFF_MASK);
> +}
> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_off);
> +
> +static int starfive_pmu_get_state(struct starfive_power_dev *pmd, bool *is_on)
> +{
> +       struct starfive_pmu *pmu = pmd->power;
> +
> +       if (!pmd->mask) {
> +               *is_on = false;
> +               return -EINVAL;
> +       }
> +
> +       *is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
> +
> +       return 0;
> +}

Maybe just return an int where 0 = off, 1 = on and negative is an error.

> +
> +static int starfive_pmu_set_state(struct starfive_power_dev *pmd, bool on)
> +{
> +       struct starfive_pmu *pmu = pmd->power;
> +       unsigned long flags;
> +       uint32_t val;
> +       uint32_t mode;
> +       uint32_t encourage_lo;
> +       uint32_t encourage_hi;

u32

> +       bool is_on;
> +       int ret;
> +
> +       if (!pmd->mask)
> +               return -EINVAL;
> +
> +       if (is_on == on) {
> +               dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
> +                               pmd->genpd.name, on ? "en" : "dis");
> +               return 0;
> +       }
> +
> +       spin_lock_irqsave(&pmu->lock, flags);
> +
> +       if (on) {
> +               mode = SW_TURN_ON_POWER_MODE;
> +               encourage_lo = SW_MODE_ENCOURAGE_EN_LO;
> +               encourage_hi = SW_MODE_ENCOURAGE_EN_HI;
> +       } else {
> +               mode = SW_TURN_OFF_POWER_MODE;
> +               encourage_lo = SW_MODE_ENCOURAGE_DIS_LO;
> +               encourage_hi = SW_MODE_ENCOURAGE_DIS_HI;
> +       }
> +
> +       __raw_writel(pmd->mask, pmu->base + mode);
> +
> +       /* write SW_ENCOURAGE to make the configuration take effect */
> +       __raw_writel(SW_MODE_ENCOURAGE_ON, pmu->base + SW_ENCOURAGE);
> +       __raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
> +       __raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);
> +
> +       spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +       if (on) {
> +               ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> +                                               val & pmd->mask, DELAY_US,
> +                                               TIMEOUT_US);
> +               if (ret) {
> +                       dev_err(pmu->pdev, "%s: failed to power on\n", pmd->genpd.name);
> +                       return -ETIMEDOUT;
> +               }
> +       } else {
> +               ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> +                                               !(val & pmd->mask), DELAY_US,
> +                                               TIMEOUT_US);
> +               if (ret) {
> +                       dev_err(pmu->pdev, "%s: failed to power off\n", pmd->genpd.name);
> +                       return -ETIMEDOUT;
> +               }
> +       }

You can move the dev_err out. Eg. dev_err(pmu->pdev, "%s: failed to
power %s\n", pmd->genpd.name, on ? "on" : "off")

> +       return 0;
> +}
> +
> +static int starfive_pmu_on(struct generic_pm_domain *genpd)
> +{
> +       struct starfive_power_dev *pmd = container_of(genpd,
> +               struct starfive_power_dev, genpd);

checkpatch.pl --strict complains that arguments doesn't match the open
parenthesis

> +
> +       return starfive_pmu_set_state(pmd, true);
> +}
> +
> +static int starfive_pmu_off(struct generic_pm_domain *genpd)
> +{
> +       struct starfive_power_dev *pmd = container_of(genpd,
> +               struct starfive_power_dev, genpd);
> +
> +       return starfive_pmu_set_state(pmd, false);
> +}
> +
> +static void starfive_pmu_int_enable(struct starfive_pmu *pmu, u32 mask, bool enable)
> +{
> +       u32 val = __raw_readl(pmu->base + PMU_INT_MASK);
> +
> +       if (enable)
> +               val &= ~mask;
> +       else
> +               val |= mask;
> +
> +       __raw_writel(val, pmu->base + PMU_INT_MASK);
> +}

Consider adding comments to functions that need a lock to be held to
be used safely.

> +
> +static irqreturn_t starfive_pmu_interrupt(int irq, void *data)
> +{
> +       struct starfive_pmu *pmu = data;
> +       unsigned long flags;
> +       u32 val;
> +
> +       spin_lock_irqsave(&pmu->lock, flags);
> +       val = __raw_readl(pmu->base + PMU_INT_STATUS);
> +
> +       if (val & PMU_INT_SEQ_DONE)
> +               dev_dbg(pmu->pdev, "sequence done.\n");
> +       if (val & PMU_INT_HW_REQ)
> +               dev_dbg(pmu->pdev, "hardware encourage requestion.\n");
> +       if (val & PMU_INT_SW_FAIL)
> +               dev_err(pmu->pdev, "software encourage fail.\n");
> +       if (val & PMU_INT_HW_FAIL)
> +               dev_err(pmu->pdev, "hardware encourage fail.\n");
> +       if (val & PMU_INT_PCH_FAIL)
> +               dev_err(pmu->pdev, "p-channel fail event.\n");
> +
> +       /* clear interrupts */
> +       __raw_writel(val, pmu->base + PMU_INT_STATUS);
> +       __raw_writel(val, pmu->base + PMU_EVENT_STATUS);
> +
> +       spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int starfive_pmu_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       const struct starfive_pmu_data *entry, *table;
> +       struct starfive_pmu *pmu;
> +       unsigned int i;
> +       uint8_t max_bit = 0;
> +       int ret;
> +
> +       pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +       if (!pmu)
> +               return -ENOMEM;
> +
> +       pmu_base = pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(pmu->base))
> +               return PTR_ERR(pmu->base);
> +
> +       /* initialize pmu interrupt  */
> +       pmu->irq = platform_get_irq(pdev, 0);
> +       if (pmu->irq < 0)
> +               return pmu->irq;
> +
> +       ret = devm_request_irq(dev, pmu->irq, starfive_pmu_interrupt,
> +                              0, pdev->name, pmu);
> +       if (ret)
> +               dev_err(dev, "request irq failed.\n");
> +
> +       table = of_device_get_match_data(dev);
> +       if (!table)
> +               return -EINVAL;
> +
> +       pmu->pdev = dev;
> +       pmu->genpd_data.num_domains = 0;
> +       i = 0;
> +       for (entry = table; entry->name; entry++) {
> +               max_bit = max(max_bit, entry->bit);
> +               i++;
> +       }
> +
> +       if (!i)
> +               return -ENODEV;
> +
> +       pmu->genpd_data.num_domains = max_bit + 1;
> +
> +       pmu->dev = devm_kcalloc(dev, pmu->genpd_data.num_domains,
> +                                 sizeof(struct starfive_power_dev),
> +                                 GFP_KERNEL);
> +       if (!pmu->dev)
> +               return -ENOMEM;
> +
> +       pmu->genpd = devm_kcalloc(dev, pmu->genpd_data.num_domains,
> +                                   sizeof(struct generic_pm_domain *),
> +                                   GFP_KERNEL);
> +       if (!pmu->genpd)
> +               return -ENOMEM;
> +
> +       pmu->genpd_data.domains = pmu->genpd;
> +
> +       i = 0;
> +       for (entry = table; entry->name; entry++) {
> +               struct starfive_power_dev *pmd = &pmu->dev[i];
> +               bool is_on;
> +
> +               pmd->power = pmu;
> +               pmd->mask = BIT(entry->bit);
> +               pmd->genpd.name = entry->name;
> +               pmd->genpd.flags = entry->flags;
> +
> +               ret = starfive_pmu_get_state(pmd, &is_on);
> +               if (ret)
> +                       dev_warn(dev, "unable to get current state for %s\n",
> +                                pmd->genpd.name);
> +
> +               pmd->genpd.power_on = starfive_pmu_on;
> +               pmd->genpd.power_off = starfive_pmu_off;
> +
> +               pm_genpd_init(&pmd->genpd, NULL, !is_on);
> +               pmu->genpd[entry->bit] = &pmd->genpd;
> +
> +               i++;
> +       }
> +
> +       spin_lock_init(&pmu->lock);
> +       starfive_pmu_int_enable(pmu, PMU_INT_ALL_MASK & ~PMU_INT_PCH_FAIL, true);
> +
> +       ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
> +       if (ret) {
> +               dev_err(dev, "failed to register genpd driver: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dev_info(dev, "registered %u power domains\n", i);
> +
> +       return 0;
> +}
> +
> +static const struct starfive_pmu_data jh7110_power_domains[] = {
> +       {
> +               .name = "SYSTOP",
> +               .bit = JH7110_PD_SYSTOP,
> +               .flags = GENPD_FLAG_ALWAYS_ON,
> +       }, {
> +               .name = "CPU",
> +               .bit = JH7110_PD_CPU,
> +               .flags = GENPD_FLAG_ALWAYS_ON,
> +       }, {
> +               .name = "GPUA",
> +               .bit = JH7110_PD_GPUA,
> +       }, {
> +               .name = "VDEC",
> +               .bit = JH7110_PD_VDEC,
> +       }, {
> +               .name = "VOUT",
> +               .bit = JH7110_PD_VOUT,
> +       }, {
> +               .name = "ISP",
> +               .bit = JH7110_PD_ISP,
> +       }, {
> +               .name = "VENC",
> +               .bit = JH7110_PD_VENC,
> +       }, {
> +               .name = "GPUB",
> +               .bit = JH7110_PD_GPUB,
> +       }, {
> +               /* sentinel */
> +       },
> +};
> +
> +static const struct of_device_id starfive_pmu_of_match[] = {
> +       {
> +               .compatible = "starfive,jh7110-pmu",
> +               .data = &jh7110_power_domains,
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +
> +static struct platform_driver jh71xx_pmu_driver = {
> +       .driver = {
> +               .name = "jh71xx-pmu",
> +               .of_match_table = starfive_pmu_of_match,
> +       },
> +       .probe  = starfive_pmu_probe,
> +};
> +builtin_platform_driver(jh71xx_pmu_driver);

You're using a mix of starfive_, starfive_pmu_ and jh71xx_pmu_
prefixes. Please choose one, preferably jh71xx_pmu_ since that's what
you call the driver.

> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/starfive/pm_domains.h b/include/soc/starfive/pm_domains.h
> new file mode 100644
> index 000000000000..a20e28e9baf3
> --- /dev/null
> +++ b/include/soc/starfive/pm_domains.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Author: Walker Chen <walker.chen@starfivetech.com>
> + */
> +
> +#ifndef __SOC_STARFIVE_PMDOMAINS_H__
> +#define __SOC_STARFIVE_PMDOMAINS_H__
> +
> +#include <linux/types.h>
> +
> +void starfive_pmu_hw_event_turn_on(u32 mask);
> +void starfive_pmu_hw_event_turn_off(u32 mask);
> +
> +#endif /* __SOC_STARFIVE_PMDOMAINS_H__ */

The header and functions within are named very generic, but
implemented by the jh71xx-specific driver.

Also who should use this header? These functions are never called by
anything in this series.

> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
