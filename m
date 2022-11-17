Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320462D4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiKQIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:08:18 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34CC9716F5;
        Thu, 17 Nov 2022 00:08:15 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxPLbu63Vj2jcIAA--.11590S3;
        Thu, 17 Nov 2022 16:08:14 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHuLp63Vjvs8VAA--.57710S2;
        Thu, 17 Nov 2022 16:08:11 +0800 (CST)
Subject: Re: [PATCH v10 1/2] clocksource: loongson2_hpet: add hpet driver
 support
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20221103131202.12481-1-zhuyinbo@loongson.cn>
 <4d194eb7-2de9-38d1-1c87-ee107d973b3c@loongson.cn>
Message-ID: <41bcd616-3cda-5480-27d6-a0b42037ab03@loongson.cn>
Date:   Thu, 17 Nov 2022 16:08:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4d194eb7-2de9-38d1-1c87-ee107d973b3c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHuLp63Vjvs8VAA--.57710S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3tF4fZr18CFWrXr4DWFyUWrg_yoW8ArW7to
        Wjkr1Sqr1rJr1jgryUJw1Utr1aqF1kGr9Fyr1UG343Jr10yF1UG3y7JrW5t3yUJF1rGr1D
        A3W7JrW0yFWjy3Wrn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4
        kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY
        6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0FtC7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates?

在 2022/11/9 下午5:48, Yinbo Zhu 写道:
> Hi maintainer,
> 
> I don't find clocksoure/timer tree so I verified it in mainline 6.1-rc3.
> if no other issue, please help me merge it to upstream.
> 
> In addition, this patch need rely on 
> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497"
> 
> Thanks,
> Yinbo.
> 
> 在 2022/11/3 下午9:12, Yinbo Zhu 写道:
>> HPET (High Precision Event Timer) defines a new set of timers, which
>> are used by the operating system to schedule threads, interrupt the
>> kernel and interrupt the multimedia timer server. The operating
>> system can assign different timers to different applications. By
>> configuration, each timer can generate interrupt independently.
>>
>> The Loongson-2 HPET module includes a main count and three comparators,
>> all of which are 32 bits wide. Among the three comparators, only
>> one comparator supports periodic interrupt, all three comparators
>> support non periodic interrupts.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v10:
>>         1. Replace "goto err" with "return -ENOMEM" if of_iomap fail.
>>                  2. This patch need rely on clock patch, which patchwork
>>            link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
>> Change in v9:
>>         1. Replace string "register" with "request" in hpet_request_irq.
>>         2. Move the varible "ret" to the begining position in
>>            loongson2_hpet_init and initialized it.
>>         3. Adjust if judgement in clk_get_rate context, there was less
>>            less indentation in the normal path.
>>                  4. This patch need rely on clock patch, which patchwork
>>            link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
>> Change in v8:
>>         1. Add all history change log information.
>> Change in v7:
>>         1. Replace setup_irq with request_irq.
>> Change in v6:
>>         1. Move comma to the end of the previous line if that comma at
>>            the beginning of the line.
>> Change in v5:
>>         1. Replace string loongson2 with Loongson-2 in commit message
>>            and Kconfig file.
>>         2. Replace string LOONGSON2 with LOONGSON-2 in MAINTAINERS.
>>         3. Make include asm headers after all linux headers.
>>         4. Add blank place before comma if comma when the comma is at
>>            the beginning of the line.
>> Change in v4:
>>                  1. Use common clock framework ops to gain apb clock.
>>                  2. This patch need rely on clock patch, which patchwork
>>                     link was 
>> "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".
>> Change in v3:
>>         1. NO change, but other patch in this series of patches set
>>            has changes
>> Change in v2:
>>         1. NO change, but other patch in this series of patches set
>>            has changes
>>
>>   MAINTAINERS                          |   6 +
>>   arch/loongarch/kernel/time.c         |   4 +-
>>   drivers/clocksource/Kconfig          |   9 +
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/loongson2_hpet.c | 334 +++++++++++++++++++++++++++
>>   5 files changed, 353 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clocksource/loongson2_hpet.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7afaf6d72800..52519695a458 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12026,6 +12026,12 @@ F:    
>> Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>>   F:    drivers/clk/clk-loongson2.c
>>   F:    include/dt-bindings/clock/loongson,ls2k-clk.h
>> +LOONGSON-2 SOC SERIES HPET DRIVER
>> +M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>> +L:    linux-kernel@vger.kernel.org
>> +S:    Maintained
>> +F:    drivers/clocksource/loongson2_hpet.c
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:    Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:    Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
>> index 09f20bc81798..0d8b37763086 100644
>> --- a/arch/loongarch/kernel/time.c
>> +++ b/arch/loongarch/kernel/time.c
>> @@ -216,7 +216,9 @@ int __init constant_clocksource_init(void)
>>   void __init time_init(void)
>>   {
>>       of_clk_init(NULL);
>> -
>> +#ifdef CONFIG_TIMER_PROBE
>> +    timer_probe();
>> +#endif
>>       if (!cpu_has_cpucfg)
>>           const_clock_freq = cpu_clock_freq;
>>       else
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 4469e7f555e9..f114ee47e6f7 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -721,4 +721,13 @@ config GOLDFISH_TIMER
>>       help
>>         Support for the timer/counter of goldfish-rtc
>> +config LOONGSON2_HPET
>> +    bool "Loongson-2 High Precision Event Timer (HPET)"
>> +    select TIMER_PROBE
>> +    select TIMER_OF
>> +    help
>> +      This option enables Loongson-2 High Precision Event Timer
>> +      (HPET) module driver. It supports the oneshot, the periodic
>> +      modes and high resolution. It is used as a clocksource and
>> +      a clockevent.
>>   endmenu
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 64ab547de97b..1a3abb770f11 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -88,3 +88,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)        += 
>> timer-microchip-pit64b.o
>>   obj-$(CONFIG_MSC313E_TIMER)        += timer-msc313e.o
>>   obj-$(CONFIG_GOLDFISH_TIMER)        += timer-goldfish.o
>>   obj-$(CONFIG_GXP_TIMER)            += timer-gxp.o
>> +obj-$(CONFIG_LOONGSON2_HPET)        += loongson2_hpet.o
>> diff --git a/drivers/clocksource/loongson2_hpet.c 
>> b/drivers/clocksource/loongson2_hpet.c
>> new file mode 100644
>> index 000000000000..9b828f9728ca
>> --- /dev/null
>> +++ b/drivers/clocksource/loongson2_hpet.c
>> @@ -0,0 +1,334 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/percpu.h>
>> +#include <linux/delay.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_address.h>
>> +#include <linux/clk.h>
>> +#include <asm/time.h>
>> +
>> +/* HPET regs */
>> +#define HPET_CFG                0x010
>> +#define HPET_STATUS             0x020
>> +#define HPET_COUNTER            0x0f0
>> +#define HPET_T0_IRS             0x001
>> +#define HPET_T0_CFG             0x100
>> +#define HPET_T0_CMP             0x108
>> +#define HPET_CFG_ENABLE         0x001
>> +#define HPET_TN_LEVEL           0x0002
>> +#define HPET_TN_ENABLE          0x0004
>> +#define HPET_TN_PERIODIC        0x0008
>> +#define HPET_TN_SETVAL          0x0040
>> +#define HPET_TN_32BIT           0x0100
>> +
>> +#define HPET_MIN_CYCLES        16
>> +#define HPET_MIN_PROG_DELTA    (HPET_MIN_CYCLES * 12)
>> +#define HPET_COMPARE_VAL    ((hpet_freq + HZ / 2) / HZ)
>> +
>> +void __iomem            *hpet_mmio_base;
>> +unsigned int            hpet_freq;
>> +unsigned int            hpet_t0_irq;
>> +unsigned int            hpet_irq_flags;
>> +unsigned int            hpet_t0_cfg;
>> +
>> +static DEFINE_SPINLOCK(hpet_lock);
>> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
>> +
>> +static int hpet_read(int offset)
>> +{
>> +    return readl(hpet_mmio_base + offset);
>> +}
>> +
>> +static void hpet_write(int offset, int data)
>> +{
>> +    writel(data, hpet_mmio_base + offset);
>> +}
>> +
>> +static void hpet_start_counter(void)
>> +{
>> +    unsigned int cfg = hpet_read(HPET_CFG);
>> +
>> +    cfg |= HPET_CFG_ENABLE;
>> +    hpet_write(HPET_CFG, cfg);
>> +}
>> +
>> +static void hpet_stop_counter(void)
>> +{
>> +    unsigned int cfg = hpet_read(HPET_CFG);
>> +
>> +    cfg &= ~HPET_CFG_ENABLE;
>> +    hpet_write(HPET_CFG, cfg);
>> +}
>> +
>> +static void hpet_reset_counter(void)
>> +{
>> +    hpet_write(HPET_COUNTER, 0);
>> +    hpet_write(HPET_COUNTER + 4, 0);
>> +}
>> +
>> +static void hpet_restart_counter(void)
>> +{
>> +    hpet_stop_counter();
>> +    hpet_reset_counter();
>> +    hpet_start_counter();
>> +}
>> +
>> +static void hpet_enable_legacy_int(void)
>> +{
>> +    /* Do nothing on Loongson2 */
>> +}
>> +
>> +static int hpet_set_state_periodic(struct clock_event_device *evt)
>> +{
>> +    int cfg;
>> +
>> +    spin_lock(&hpet_lock);
>> +
>> +    pr_info("set clock event to periodic mode!\n");
>> +    /* stop counter */
>> +    hpet_stop_counter();
>> +    hpet_reset_counter();
>> +    hpet_write(HPET_T0_CMP, 0);
>> +
>> +    /* enables the timer0 to generate a periodic interrupt */
>> +    cfg = hpet_read(HPET_T0_CFG);
>> +    cfg &= ~HPET_TN_LEVEL;
>> +    cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
>> +        HPET_TN_32BIT | hpet_irq_flags;
>> +    hpet_write(HPET_T0_CFG, cfg);
>> +
>> +    /* set the comparator */
>> +    hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
>> +    udelay(1);
>> +    hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
>> +
>> +    /* start counter */
>> +    hpet_start_counter();
>> +
>> +    spin_unlock(&hpet_lock);
>> +    return 0;
>> +}
>> +
>> +static int hpet_set_state_shutdown(struct clock_event_device *evt)
>> +{
>> +    int cfg;
>> +
>> +    spin_lock(&hpet_lock);
>> +
>> +    cfg = hpet_read(HPET_T0_CFG);
>> +    cfg &= ~HPET_TN_ENABLE;
>> +    hpet_write(HPET_T0_CFG, cfg);
>> +
>> +    spin_unlock(&hpet_lock);
>> +    return 0;
>> +}
>> +
>> +static int hpet_set_state_oneshot(struct clock_event_device *evt)
>> +{
>> +    int cfg;
>> +
>> +    spin_lock(&hpet_lock);
>> +
>> +    pr_info("set clock event to one shot mode!\n");
>> +    cfg = hpet_read(HPET_T0_CFG);
>> +    /*
>> +     * set timer0 type
>> +     * 1 : periodic interrupt
>> +     * 0 : non-periodic(oneshot) interrupt
>> +     */
>> +    cfg &= ~HPET_TN_PERIODIC;
>> +    cfg |= HPET_TN_ENABLE | HPET_TN_32BIT |
>> +        hpet_irq_flags;
>> +    hpet_write(HPET_T0_CFG, cfg);
>> +
>> +    /* start counter */
>> +    hpet_start_counter();
>> +
>> +    spin_unlock(&hpet_lock);
>> +    return 0;
>> +}
>> +
>> +static int hpet_tick_resume(struct clock_event_device *evt)
>> +{
>> +    spin_lock(&hpet_lock);
>> +    hpet_enable_legacy_int();
>> +    spin_unlock(&hpet_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int hpet_next_event(unsigned long delta,
>> +        struct clock_event_device *evt)
>> +{
>> +    u32 cnt;
>> +    s32 res;
>> +
>> +    cnt = hpet_read(HPET_COUNTER);
>> +    cnt += (u32) delta;
>> +    hpet_write(HPET_T0_CMP, cnt);
>> +
>> +    res = (s32)(cnt - hpet_read(HPET_COUNTER));
>> +
>> +    return res < HPET_MIN_CYCLES ? -ETIME : 0;
>> +}
>> +
>> +static irqreturn_t hpet_irq_handler(int irq, void *data)
>> +{
>> +    int is_irq;
>> +    struct clock_event_device *cd;
>> +    unsigned int cpu = smp_processor_id();
>> +
>> +    is_irq = hpet_read(HPET_STATUS);
>> +    if (is_irq & HPET_T0_IRS) {
>> +        /* clear the TIMER0 irq status register */
>> +        hpet_write(HPET_STATUS, HPET_T0_IRS);
>> +        cd = &per_cpu(hpet_clockevent_device, cpu);
>> +        cd->event_handler(cd);
>> +        return IRQ_HANDLED;
>> +    }
>> +    return IRQ_NONE;
>> +}
>> +
>> +/*
>> + * HPET address assignation and irq setting should be done in bios.
>> + * But, sometimes bios don't do this, we just setup here directly.
>> + */
>> +static void hpet_setup(void)
>> +{
>> +    hpet_enable_legacy_int();
>> +}
>> +
>> +static int hpet_request_irq(struct clock_event_device *cd)
>> +{
>> +    unsigned long flags = IRQD_NO_BALANCING | IRQF_TIMER;
>> +
>> +    if (request_irq(cd->irq, hpet_irq_handler, flags, "hpet", NULL)) {
>> +        pr_err("Failed to request hpet interrupt\n");
>> +        return -1;
>> +    }
>> +
>> +    disable_irq(cd->irq);
>> +    irq_set_affinity(cd->irq, cd->cpumask);
>> +    enable_irq(cd->irq);
>> +
>> +    return 0;
>> +}
>> +
>> +static int __init loongson2_hpet_clockevent_init(void)
>> +{
>> +    unsigned int cpu = smp_processor_id();
>> +    struct clock_event_device *cd;
>> +
>> +    hpet_setup();
>> +
>> +    cd = &per_cpu(hpet_clockevent_device, cpu);
>> +    cd->name = "hpet";
>> +    cd->rating = 300;
>> +    cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>> +    cd->set_state_shutdown = hpet_set_state_shutdown;
>> +    cd->set_state_periodic = hpet_set_state_periodic;
>> +    cd->set_state_oneshot = hpet_set_state_oneshot;
>> +    cd->tick_resume = hpet_tick_resume;
>> +    cd->set_next_event = hpet_next_event;
>> +    cd->irq = hpet_t0_irq;
>> +    cd->cpumask = cpumask_of(cpu);
>> +    clockevent_set_clock(cd, hpet_freq);
>> +    cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
>> +    cd->max_delta_ticks = 0x7fffffff;
>> +    cd->min_delta_ns = clockevent_delta2ns(HPET_MIN_PROG_DELTA, cd);
>> +    cd->min_delta_ticks = HPET_MIN_PROG_DELTA;
>> +
>> +    clockevents_register_device(cd);
>> +    if (hpet_request_irq(cd))
>> +        return -1;
>> +
>> +    pr_info("hpet clock event device register\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static u64 hpet_read_counter(struct clocksource *cs)
>> +{
>> +    return (u64)hpet_read(HPET_COUNTER);
>> +}
>> +
>> +static void hpet_suspend(struct clocksource *cs)
>> +{
>> +    hpet_t0_cfg = hpet_read(HPET_T0_CFG);
>> +}
>> +
>> +static void hpet_resume(struct clocksource *cs)
>> +{
>> +    hpet_write(HPET_T0_CFG, hpet_t0_cfg);
>> +    hpet_setup();
>> +    hpet_restart_counter();
>> +}
>> +
>> +struct clocksource csrc_hpet = {
>> +    .name = "hpet",
>> +    .rating = 300,
>> +    .read = hpet_read_counter,
>> +    .mask = CLOCKSOURCE_MASK(32),
>> +    /* oneshot mode work normal with this flag */
>> +    .flags = CLOCK_SOURCE_IS_CONTINUOUS,
>> +    .suspend = hpet_suspend,
>> +    .resume = hpet_resume,
>> +    .mult = 0,
>> +    .shift = 10,
>> +};
>> +
>> +static int __init loongson2_hpet_clocksource_init(void)
>> +{
>> +    csrc_hpet.mult = clocksource_hz2mult(hpet_freq, csrc_hpet.shift);
>> +
>> +    /* start counter */
>> +    hpet_start_counter();
>> +
>> +    return clocksource_register_hz(&csrc_hpet, hpet_freq);
>> +}
>> +
>> +static int __init loongson2_hpet_init(struct device_node *np)
>> +{
>> +    struct clk *clk;
>> +    int ret = -EINVAL;
>> +
>> +    hpet_mmio_base = of_iomap(np, 0);
>> +    if (!hpet_mmio_base) {
>> +        pr_err("hpet: unable to map loongson2 hpet registers\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    hpet_t0_irq = irq_of_parse_and_map(np, 0);
>> +    if (hpet_t0_irq <= 0) {
>> +        pr_err("hpet: unable to get IRQ from DT, %d\n", hpet_t0_irq);
>> +        goto err;
>> +    }
>> +
>> +    clk = of_clk_get(np, 0);
>> +    if (IS_ERR(clk))
>> +        goto err;
>> +
>> +    hpet_freq = clk_get_rate(clk);
>> +    clk_put(clk);
>> +
>> +    hpet_irq_flags = HPET_TN_LEVEL;
>> +
>> +    loongson2_hpet_clocksource_init();
>> +
>> +    loongson2_hpet_clockevent_init();
>> +
>> +    return 0;
>> +
>> +err:
>> +    iounmap(hpet_mmio_base);
>> +    return ret;
>> +}
>> +
>> +TIMER_OF_DECLARE(loongson2_hpet, "loongson,ls2k-hpet", 
>> loongson2_hpet_init);
>>

