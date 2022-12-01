Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079563EF77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLAL3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLAL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:29:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A352148;
        Thu,  1 Dec 2022 03:29:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669894152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDYHcKJNIl+bFBsPJ9EKGMSmWfe/8gI4HDrW58IPop0=;
        b=o8IsKqMxg5Xkgxlv83mVHjmHCrw88/1n8GQWsRih1pewbVOeJyEY9TFGg1nPjoeJtVOHWR
        9+qhCIParsQuUdzuD/Qf/QbU6MIqTThKNCDKkTORdbPxLSJ9GLyXMuUs2opHR7xOaCh9um
        LHOVcyHL4K0RvjNgf79BcMKr+DRgcQ39V8Lv2y5EnJF6uqpXtqeWhSxiD9CamqQ3l51Y0D
        wrX8pqk7knVKZyvnI7LaRKrhIpM17v5HyWHAeR1j42SnpLKr3JQlWGHpxB7vUkPELTCYAr
        ArcU1+H8N1nYX0wXOhIwkVoysCFpcSlqezu4gdK4j2P0TAuF/0vFd8qIO2a8cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669894152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDYHcKJNIl+bFBsPJ9EKGMSmWfe/8gI4HDrW58IPop0=;
        b=NVjcGjbsY+ymyeBytgfnNhP/VQjQSsGfl0G38KK1qXT3nvEO7RAfQ3LDnNPDOF/2LiyC1S
        MUuww9PZ0hNXi1Bw==
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v11 1/3] clocksource: loongson2_hpet: add hpet driver
 support
In-Reply-To: <20221129030925.14074-1-zhuyinbo@loongson.cn>
References: <20221129030925.14074-1-zhuyinbo@loongson.cn>
Date:   Thu, 01 Dec 2022 12:29:12 +0100
Message-ID: <87k03bs6pj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 11:09, Yinbo Zhu wrote:
> HPET (High Precision Event Timer) defines a new set of timers, which

It's not really new. The HPET specification is 20 years old :)

> +++ b/drivers/clocksource/loongson2_hpet.c
> @@ -0,0 +1,334 @@
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
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/clk.h>
> +#include <asm/time.h>
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

So this is another copy of the defines which are already available in
x86 and mips. Seriously?

> +static DEFINE_SPINLOCK(hpet_lock);

This wants to be a raw spinlock if at all. But first you have to explain
the purpose of this lock.

> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);

Why needs this to be global and why is it needed at all?

This code does support exactly _ONE_ clock event device.

> +static int hpet_read(int offset)
> +{
> +	return readl(hpet_mmio_base + offset);
> +}
> +
> +static void hpet_write(int offset, int data)
> +{
> +	writel(data, hpet_mmio_base + offset);
> +}
> +
> +static void hpet_start_counter(void)
> +{
> +	unsigned int cfg = hpet_read(HPET_CFG);
> +
> +	cfg |= HPET_CFG_ENABLE;
> +	hpet_write(HPET_CFG, cfg);
> +}
> +
> +static void hpet_stop_counter(void)
> +{
> +	unsigned int cfg = hpet_read(HPET_CFG);
> +
> +	cfg &= ~HPET_CFG_ENABLE;
> +	hpet_write(HPET_CFG, cfg);
> +}
> +
> +static void hpet_reset_counter(void)
> +{
> +	hpet_write(HPET_COUNTER, 0);
> +	hpet_write(HPET_COUNTER + 4, 0);
> +}
> +
> +static void hpet_restart_counter(void)
> +{
> +	hpet_stop_counter();
> +	hpet_reset_counter();
> +	hpet_start_counter();
> +}

This is also a copy of the x86 HPET code....

> +static void hpet_enable_legacy_int(void)
> +{
> +	/* Do nothing on Loongson2 */
> +}
> +
> +static int hpet_set_state_periodic(struct clock_event_device *evt)
> +{
> +	int cfg;
> +
> +	spin_lock(&hpet_lock);

What's the purpose of this lock ?

> +	pr_info("set clock event to periodic mode!\n");
> +
> +	/* stop counter */
> +	hpet_stop_counter();
> +	hpet_reset_counter();
> +	hpet_write(HPET_T0_CMP, 0);
> +
> +	/* enables the timer0 to generate a periodic interrupt */
> +	cfg = hpet_read(HPET_T0_CFG);
> +	cfg &= ~HPET_TN_LEVEL;
> +	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
> +		HPET_TN_32BIT | hpet_irq_flags;
> +	hpet_write(HPET_T0_CFG, cfg);
> +
> +	/* set the comparator */
> +	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
> +	udelay(1);
> +	hpet_write(HPET_T0_CMP, HPET_COMPARE_VAL);
> +
> +	/* start counter */
> +	hpet_start_counter();

Pretty much the same code as hpet_clkevt_set_state_periodic()

> +	spin_unlock(&hpet_lock);
> +	return 0;
> +}
> +
> +static int hpet_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	int cfg;
> +
> +	spin_lock(&hpet_lock);
> +
> +	cfg = hpet_read(HPET_T0_CFG);
> +	cfg &= ~HPET_TN_ENABLE;
> +	hpet_write(HPET_T0_CFG, cfg);
> +
> +	spin_unlock(&hpet_lock);

Another slightly different copy of the x86 code

> +	return 0;
> +}
> +
> +static int hpet_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	int cfg;
> +
> +	spin_lock(&hpet_lock);
> +
> +	pr_info("set clock event to one shot mode!\n");
> +	cfg = hpet_read(HPET_T0_CFG);
> +	/*
> +	 * set timer0 type
> +	 * 1 : periodic interrupt
> +	 * 0 : non-periodic(oneshot) interrupt
> +	 */
> +	cfg &= ~HPET_TN_PERIODIC;
> +	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT |
> +		hpet_irq_flags;
> +	hpet_write(HPET_T0_CFG, cfg);

Yet another copy.

> +	/* start counter */
> +	hpet_start_counter();

Why doe you need an explicit start here?

> +	spin_unlock(&hpet_lock);
> +	return 0;
> +}
> +
> +static int hpet_tick_resume(struct clock_event_device *evt)
> +{
> +	spin_lock(&hpet_lock);
> +	hpet_enable_legacy_int();
> +	spin_unlock(&hpet_lock);

More copy and paste just to slap a spinlock on to it which has zero
value AFAICT.

> +	return 0;
> +}
> +
> +static int hpet_next_event(unsigned long delta,
> +		struct clock_event_device *evt)
> +{
> +	u32 cnt;
> +	s32 res;
> +
> +	cnt = hpet_read(HPET_COUNTER);
> +	cnt += (u32) delta;
> +	hpet_write(HPET_T0_CMP, cnt);
> +
> +	res = (s32)(cnt - hpet_read(HPET_COUNTER));
> +
> +	return res < HPET_MIN_CYCLES ? -ETIME : 0;

Another copy of the x86 code except for omitting the big comment which
explains the logic.

Seriously, this is not how it works. Instead of copy & paste, we create
shared infrastructure and just keep the real architecture specific
pieces separate.

Thanks,

        tglx
