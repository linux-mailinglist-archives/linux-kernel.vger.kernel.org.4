Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4360E067
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiJZMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiJZMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0204A1262C;
        Wed, 26 Oct 2022 05:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E4B7B82218;
        Wed, 26 Oct 2022 12:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041D9C433D7;
        Wed, 26 Oct 2022 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666786190;
        bh=T5gZRpFWlBKDyv8ncqwaYHbkyfyyv8ZVB76OXMJ34S0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u4tN0LWTm2VPhCTcWVfR+Pkydn/KMw6wZxRbyLsGmYsK9RaaHVmQQfWa9lxv2kjP6
         N3v0TxM5njD2xKWj+IBbVwYWjQfcm53fDPUsqPjwCkc+tHnV7VqNH+jLMccg+USVGJ
         IgIiwrX5DP0s6ILM+BsDvAbDBc4SQTN1ClQpoGzZeFYMLxI/jdQtdx4DCThIukvM7Y
         cssd+aH8W65WyCV+6pLxhoq+ZGxqcnnbyRQVmUeMjtRZVXLSAd/86WBmh7LHZDdrY2
         4S6L3IZPJMWAEsvOzQ3FPKttUajPQqBavEuuncb6zp/JB+VAwCja6T7CNBL52q/gw2
         QHKh+7KDyacbg==
Received: by mail-ed1-f53.google.com with SMTP id t15so6393274edd.4;
        Wed, 26 Oct 2022 05:09:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf14KRd8LRBgtWMpUyyig7D6/T5J/Q/5nawJdiDT0D8PcUo16fcU
        CErDjO/3UwdmcgE6YqNdf1yp/R129YUjH4yNs4s=
X-Google-Smtp-Source: AMsMyM4sPyDY8U/rtsq3yTTTm7yKZdA9k4J4EICbmaM9P/ePohFg70owW/p6wVK/5MQnbtYOemYhQ7TL2gBPSuOHskc=
X-Received: by 2002:a05:6402:34cd:b0:462:5382:c3a9 with SMTP id
 w13-20020a05640234cd00b004625382c3a9mr4033445edc.298.1666786188210; Wed, 26
 Oct 2022 05:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221026035752.32681-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221026035752.32681-1-zhuyinbo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 26 Oct 2022 20:09:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4dfz1iCOyxZbBPsH+V5n8iUXc70G_yeB5BYtOxd9PFoQ@mail.gmail.com>
Message-ID: <CAAhV-H4dfz1iCOyxZbBPsH+V5n8iUXc70G_yeB5BYtOxd9PFoQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] clocksource: loongson2_hpet: add hpet driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yinbo,

On Wed, Oct 26, 2022 at 11:58 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
>
> The loongson2 HPET module includes a main count and three comparators
The naming issue, which has been pointed out in another thread.

> , all of which are 32 bits wide. Among the three comparators, only
> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v4:
>                 1. Use common clock framework ops to gain apb clock.
>                 2. This patch need rely on clock patch, which patchwork
>                    link was "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".
>
>  MAINTAINERS                          |   6 +
>  arch/loongarch/kernel/time.c         |   4 +-
>  drivers/clocksource/Kconfig          |   9 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/loongson2_hpet.c | 335 +++++++++++++++++++++++++++
>  5 files changed, 354 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clocksource/loongson2_hpet.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61a431ad8ca..db29c1dc2d89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11915,6 +11915,12 @@ F:     Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>  F:     drivers/clk/clk-loongson2.c
>  F:     include/dt-bindings/clock/loongson,ls2k-clk.h
>
> +LOONGSON2 SOC SERIES HPET DRIVER
> +M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:     linux-kernel@vger.kernel.org
> +S:     Maintained
> +F:     drivers/clocksource/loongson2_hpet.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>  M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index 09f20bc81798..0d8b37763086 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -216,7 +216,9 @@ int __init constant_clocksource_init(void)
>  void __init time_init(void)
>  {
>         of_clk_init(NULL);
> -
> +#ifdef CONFIG_TIMER_PROBE
> +       timer_probe();
> +#endif
>         if (!cpu_has_cpucfg)
>                 const_clock_freq = cpu_clock_freq;
>         else
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 4f2bb7315b67..1c7ab3541d81 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,13 @@ config GOLDFISH_TIMER
>         help
>           Support for the timer/counter of goldfish-rtc
>
> +config LOONGSON2_HPET
> +       bool "Loongson2 High Precision Event Timer (HPET)"
> +       select TIMER_PROBE
> +       select TIMER_OF
> +       help
> +         This option enables Loongson2 High Precision Event Timer
> +         (HPET) module driver. It supports the oneshot, the periodic
> +         modes and high resolution. It is used as a clocksource and
> +         a clockevent.
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 64ab547de97b..1a3abb770f11 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)                += timer-microchip-pit64b.o
>  obj-$(CONFIG_MSC313E_TIMER)            += timer-msc313e.o
>  obj-$(CONFIG_GOLDFISH_TIMER)           += timer-goldfish.o
>  obj-$(CONFIG_GXP_TIMER)                        += timer-gxp.o
> +obj-$(CONFIG_LOONGSON2_HPET)           += loongson2_hpet.o
> diff --git a/drivers/clocksource/loongson2_hpet.c b/drivers/clocksource/loongson2_hpet.c
> new file mode 100644
> index 000000000000..fbcf69f0204f
> --- /dev/null
> +++ b/drivers/clocksource/loongson2_hpet.c
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <asm/time.h>
Please include asm headers after all linux headers.

Huacai
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/clk.h>
> +
> +/* HPET regs */
> +#define HPET_CFG                0x010
> +#define HPET_STATUS             0x020
> +#define HPET_COUNTER            0x0f0
> +#define HPET_T0_IRS             0x001
> +#define HPET_T0_CFG             0x100
> +#define HPET_T0_CMP             0x108
> +#define HPET_CFG_ENABLE         0x001
> +#define HPET_TN_LEVEL           0x0002
> +#define HPET_TN_ENABLE          0x0004
> +#define HPET_TN_PERIODIC        0x0008
> +#define HPET_TN_SETVAL          0x0040
> +#define HPET_TN_32BIT           0x0100
> +
> +#define HPET_MIN_CYCLES                16
> +#define HPET_MIN_PROG_DELTA    (HPET_MIN_CYCLES * 12)
> +#define HPET_COMPARE_VAL       ((hpet_freq + HZ / 2) / HZ)
> +
> +void __iomem                   *hpet_mmio_base;
> +unsigned int                   hpet_freq;
> +unsigned int                   hpet_t0_irq;
> +unsigned int                   hpet_irq_flags;
> +unsigned int                   hpet_t0_cfg;
> +
> +static DEFINE_SPINLOCK(hpet_lock);
> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
> +
> +static int hpet_read(int offset)
> +{
> +       return readl(hpet_mmio_base + offset);
> +}
> +
> +static void hpet_write(int offset, int data)
> +{
> +       writel(data, hpet_mmio_base + offset);
> +}
> +
> +static void hpet_start_counter(void)
> +{
> +       unsigned int cfg = hpet_read(HPET_CFG);
> +
> +       cfg |= HPET_CFG_ENABLE;
> +       hpet_write(HPET_CFG, cfg);
> +}
> +
> +static void hpet_stop_counter(void)
> +{
> +       unsigned int cfg = hpet_read(HPET_CFG);
> +
> +       cfg &= ~HPET_CFG_ENABLE;
> +       hpet_write(HPET_CFG, cfg);
> +}
> +
> +static void hpet_reset_counter(void)
> +{
> +       hpet_write(HPET_COUNTER, 0);
> +       hpet_write(HPET_COUNTER + 4, 0);
> +}
> +
> +static void hpet_restart_counter(void)
> +{
> +       hpet_stop_counter();
> +       hpet_reset_counter();
> +       hpet_start_counter();
> +}
> +
> +static void hpet_enable_legacy_int(void)
> +{
> +       /* Do nothing on Loongson2 */
> +}
> +
> +static int hpet_set_state_periodic(struct clock_event_device *evt)
> +{
> +       int cfg;
> +
> +       spin_lock(&hpet_lock);
> +
> +       pr_info("set clock event to periodic mode!\n");
> +       /* stop counter */
> +       hpet_stop_counter();
> +       hpet_reset_counter();
> +       hpet_write(HPET_T0_CMP, 0);
> +
> +       /* enables the timer0 to generate a periodic interrupt */
> +       cfg = hpet_read(HPET_T0_CFG);
> +       cfg &= ~HPET_TN_LEVEL;
> +       cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
> +               HPET_TN_32BIT | hpet_irq_flags;
> +       hpet_write(HPET_T0_CFG, cfg);
> +
> +       /* set the comparator */
> +       hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
> +       udelay(1);
> +       hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
> +
> +       /* start counter */
> +       hpet_start_counter();
> +
> +       spin_unlock(&hpet_lock);
> +       return 0;
> +}
> +
> +static int hpet_set_state_shutdown(struct clock_event_device *evt)
> +{
> +       int cfg;
> +
> +       spin_lock(&hpet_lock);
> +
> +       cfg = hpet_read(HPET_T0_CFG);
> +       cfg &= ~HPET_TN_ENABLE;
> +       hpet_write(HPET_T0_CFG, cfg);
> +
> +       spin_unlock(&hpet_lock);
> +       return 0;
> +}
> +
> +static int hpet_set_state_oneshot(struct clock_event_device *evt)
> +{
> +       int cfg;
> +
> +       spin_lock(&hpet_lock);
> +
> +       pr_info("set clock event to one shot mode!\n");
> +       cfg = hpet_read(HPET_T0_CFG);
> +       /*
> +        * set timer0 type
> +        * 1 : periodic interrupt
> +        * 0 : non-periodic(oneshot) interrupt
> +        */
> +       cfg &= ~HPET_TN_PERIODIC;
> +       cfg |= HPET_TN_ENABLE | HPET_TN_32BIT |
> +               hpet_irq_flags;
> +       hpet_write(HPET_T0_CFG, cfg);
> +
> +       /* start counter */
> +       hpet_start_counter();
> +
> +       spin_unlock(&hpet_lock);
> +       return 0;
> +}
> +
> +static int hpet_tick_resume(struct clock_event_device *evt)
> +{
> +       spin_lock(&hpet_lock);
> +       hpet_enable_legacy_int();
> +       spin_unlock(&hpet_lock);
> +
> +       return 0;
> +}
> +
> +static int hpet_next_event(unsigned long delta,
> +               struct clock_event_device *evt)
> +{
> +       u32 cnt;
> +       s32 res;
> +
> +       cnt = hpet_read(HPET_COUNTER);
> +       cnt += (u32) delta;
> +       hpet_write(HPET_T0_CMP, cnt);
> +
> +       res = (s32)(cnt - hpet_read(HPET_COUNTER));
> +
> +       return res < HPET_MIN_CYCLES ? -ETIME : 0;
> +}
> +
> +static irqreturn_t hpet_irq_handler(int irq, void *data)
> +{
> +       int is_irq;
> +       struct clock_event_device *cd;
> +       unsigned int cpu = smp_processor_id();
> +
> +       is_irq = hpet_read(HPET_STATUS);
> +       if (is_irq & HPET_T0_IRS) {
> +               /* clear the TIMER0 irq status register */
> +               hpet_write(HPET_STATUS, HPET_T0_IRS);
> +               cd = &per_cpu(hpet_clockevent_device, cpu);
> +               cd->event_handler(cd);
> +               return IRQ_HANDLED;
> +       }
> +       return IRQ_NONE;
> +}
> +
> +static struct irqaction hpet_irq_str = {
> +       .handler = hpet_irq_handler,
> +       .flags = IRQD_NO_BALANCING | IRQF_TIMER,
> +       .name = "hpet",
> +};
> +
> +/*
> + * HPET address assignation and irq setting should be done in bios.
> + * But, sometimes bios don't do this, we just setup here directly.
> + */
> +static void hpet_setup(void)
> +{
> +       hpet_enable_legacy_int();
> +}
> +
> +static int hpet_setup_irq(struct clock_event_device *cd)
> +{
> +       setup_irq(cd->irq, &hpet_irq_str);
> +
> +       disable_irq(cd->irq);
> +       irq_set_affinity(cd->irq, cd->cpumask);
> +       enable_irq(cd->irq);
> +
> +       return 0;
> +}
> +
> +static int __init loongson2_hpet_clockevent_init(void)
> +{
> +       unsigned int cpu = smp_processor_id();
> +       struct clock_event_device *cd;
> +
> +       hpet_setup();
> +
> +       cd = &per_cpu(hpet_clockevent_device, cpu);
> +       cd->name = "hpet";
> +       cd->rating = 300;
> +       cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> +       cd->set_state_shutdown = hpet_set_state_shutdown;
> +       cd->set_state_periodic = hpet_set_state_periodic;
> +       cd->set_state_oneshot = hpet_set_state_oneshot;
> +       cd->tick_resume = hpet_tick_resume;
> +       cd->set_next_event = hpet_next_event;
> +       cd->irq = hpet_t0_irq;
> +       cd->cpumask = cpumask_of(cpu);
> +       clockevent_set_clock(cd, hpet_freq);
> +       cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
> +       cd->max_delta_ticks = 0x7fffffff;
> +       cd->min_delta_ns = clockevent_delta2ns(HPET_MIN_PROG_DELTA, cd);
> +       cd->min_delta_ticks = HPET_MIN_PROG_DELTA;
> +
> +       clockevents_register_device(cd);
> +       hpet_setup_irq(cd);
> +
> +       pr_info("hpet clock event device register\n");
> +
> +       return 0;
> +}
> +
> +static u64 hpet_read_counter(struct clocksource *cs)
> +{
> +       return (u64)hpet_read(HPET_COUNTER);
> +}
> +
> +static void hpet_suspend(struct clocksource *cs)
> +{
> +       hpet_t0_cfg = hpet_read(HPET_T0_CFG);
> +}
> +
> +static void hpet_resume(struct clocksource *cs)
> +{
> +       hpet_write(HPET_T0_CFG, hpet_t0_cfg);
> +       hpet_setup();
> +       hpet_restart_counter();
> +}
> +
> +struct clocksource csrc_hpet = {
> +       .name = "hpet",
> +       .rating = 300,
> +       .read = hpet_read_counter,
> +       .mask = CLOCKSOURCE_MASK(32),
> +       /* oneshot mode work normal with this flag */
> +       .flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +       .suspend = hpet_suspend,
> +       .resume = hpet_resume,
> +       .mult = 0,
> +       .shift = 10,
> +};
> +
> +static int __init loongson2_hpet_clocksource_init(void)
> +{
> +       csrc_hpet.mult = clocksource_hz2mult(hpet_freq, csrc_hpet.shift);
> +
> +       /* start counter */
> +       hpet_start_counter();
> +
> +       return clocksource_register_hz(&csrc_hpet, hpet_freq);
> +}
> +
> +static int __init loongson2_hpet_init(struct device_node *np)
> +{
> +       int ret;
> +       struct clk *clk;
> +
> +       hpet_mmio_base = of_iomap(np, 0);
> +       if (!hpet_mmio_base) {
> +               pr_err("hpet: unable to map loongson2 hpet registers\n");
> +               goto err;
> +       }
> +
> +       ret = -EINVAL;
> +       hpet_t0_irq = irq_of_parse_and_map(np, 0);
> +       if (hpet_t0_irq <= 0) {
> +               pr_err("hpet: unable to get IRQ from DT, %d\n", hpet_t0_irq);
> +               goto err;
> +       }
> +
> +       clk = of_clk_get(np, 0);
> +       if (!IS_ERR(clk)) {
> +               hpet_freq = clk_get_rate(clk);
> +               clk_put(clk);
> +       } else
> +               goto err;
> +
> +       hpet_irq_flags = HPET_TN_LEVEL;
> +
> +       loongson2_hpet_clocksource_init();
> +
> +       loongson2_hpet_clockevent_init();
> +
> +       return 0;
> +
> +err:
> +       iounmap(hpet_mmio_base);
> +       return ret;
> +}
> +
> +TIMER_OF_DECLARE(loongson2_hpet, "loongson,ls2k-hpet", loongson2_hpet_init);
> --
> 2.31.1
>
