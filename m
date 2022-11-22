Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A8633FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiKVO7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiKVO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:59:08 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6043AE6;
        Tue, 22 Nov 2022 06:57:47 -0800 (PST)
Received: from [192.168.10.46] (unknown [130.180.211.218])
        (Authenticated sender: daniel.lezcano@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 9578EB00535;
        Tue, 22 Nov 2022 15:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1669129065;
        bh=B7HUiAPO+9HzwwBVHzf2LAUEewOOfyCp9QGvnFZZBRQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TTcnBD4jzu7Dgg5B7PCE9UWE2GQjqzV0XlqQoqMb8ApUDKCShYCQvjzx2c9tBE6fV
         svlmzm+aY/oN24AMqMOLnZ62rbRIrN0J1oMgZE9XBuktzxE6IEIv7RwZFjIOXnc06D
         VqtAT0yggyU0CwAJYp81Z1/30GSamPE8J39+R3Zp94WQ2sSO6xw+Y8O5cdtlcsBOm/
         VAYLRKoJ3vZ4RtQOUz6t5mJQG0d9s5OLfXnSKXYgxocpg/UPOw94iBC2hORFK/OM2a
         ufoGPSt7U1Dlhf5SysKLO/fEb+1YNt2oJUaxQtgGDz9hIgjcq9mp3tRuvLhB0LAVVn
         CnTcfashtg30g==
Message-ID: <7586968e-eb25-56c4-19ce-be10216b0b28@free.fr>
Date:   Tue, 22 Nov 2022 15:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] clocksource: loongson2_hpet: add hpet driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
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
From:   Daniel Lezcano <daniel.lezcano@free.fr>
In-Reply-To: <20221103131202.12481-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 14:12, Yinbo Zhu wrote:
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
> 
> The Loongson-2 HPET module includes a main count and three comparators,
> all of which are 32 bits wide. Among the three comparators, only
> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.

What is the difference with arch/mips/loongson64/hpet.c ?

> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v10:
> 		1. Replace "goto err" with "return -ENOMEM" if of_iomap fail.
>                  2. This patch need rely on clock patch, which patchwork
> 		   link was "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
> Change in v9:
> 		1. Replace string "register" with "request" in hpet_request_irq.
> 		2. Move the varible "ret" to the begining position in
> 		   loongson2_hpet_init and initialized it.
> 		3. Adjust if judgement in clk_get_rate context, there was less
> 		   less indentation in the normal path.
>                  4. This patch need rely on clock patch, which patchwork
> 		   link was "https://patchwork.kernel.org/project/linux-clk/list/?series=691497".
> Change in v8:
> 		1. Add all history change log information.
> Change in v7:
> 		1. Replace setup_irq with request_irq.
> Change in v6:
> 		1. Move comma to the end of the previous line if that comma at
> 		   the beginning of the line.
> Change in v5:
> 		1. Replace string loongson2 with Loongson-2 in commit message
> 		   and Kconfig file.
> 		2. Replace string LOONGSON2 with LOONGSON-2 in MAINTAINERS.
> 		3. Make include asm headers after all linux headers.
> 		4. Add blank place before comma if comma when the comma is at
> 		   the beginning of the line.
> Change in v4:
>                  1. Use common clock framework ops to gain apb clock.
>                  2. This patch need rely on clock patch, which patchwork
>                     link was "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".
> Change in v3:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes
> Change in v2:
> 		1. NO change, but other patch in this series of patches set
> 		   has changes
> 
>   MAINTAINERS                          |   6 +
>   arch/loongarch/kernel/time.c         |   4 +-
>   drivers/clocksource/Kconfig          |   9 +
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/loongson2_hpet.c | 334 +++++++++++++++++++++++++++
>   5 files changed, 353 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clocksource/loongson2_hpet.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7afaf6d72800..52519695a458 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12026,6 +12026,12 @@ F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
>   F:	drivers/clk/clk-loongson2.c
>   F:	include/dt-bindings/clock/loongson,ls2k-clk.h
>   
> +LOONGSON-2 SOC SERIES HPET DRIVER
> +M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/clocksource/loongson2_hpet.c
> +
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>   M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index 09f20bc81798..0d8b37763086 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -216,7 +216,9 @@ int __init constant_clocksource_init(void)
>   void __init time_init(void)
>   {
>   	of_clk_init(NULL);
> -
> +#ifdef CONFIG_TIMER_PROBE
> +	timer_probe();
> +#endif

This change should go in another patch.

#ifdef is not needed

>   	if (!cpu_has_cpucfg)
>   		const_clock_freq = cpu_clock_freq;
>   	else
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 4469e7f555e9..f114ee47e6f7 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,13 @@ config GOLDFISH_TIMER
>   	help
>   	  Support for the timer/counter of goldfish-rtc
>   
> +config LOONGSON2_HPET
> +	bool "Loongson-2 High Precision Event Timer (HPET)"
> +	select TIMER_PROBE

TIMER_OF selects TIMER_PROBE

> +	select TIMER_OF
> +	help
> +	  This option enables Loongson-2 High Precision Event Timer
> +	  (HPET) module driver. It supports the oneshot, the periodic
> +	  modes and high resolution. It is used as a clocksource and
> +	  a clockevent.
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 64ab547de97b..1a3abb770f11 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
>   obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
>   obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
>   obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
> +obj-$(CONFIG_LOONGSON2_HPET)		+= loongson2_hpet.o

Please rename to timer-loongson.c

> diff --git a/drivers/clocksource/loongson2_hpet.c b/drivers/clocksource/loongson2_hpet.c
> new file mode 100644
> index 000000000000..9b828f9728ca
> --- /dev/null
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
> +
> +#define HPET_MIN_CYCLES		16
> +#define HPET_MIN_PROG_DELTA	(HPET_MIN_CYCLES * 12)
> +#define HPET_COMPARE_VAL	((hpet_freq + HZ / 2) / HZ)
> +
> +void __iomem			*hpet_mmio_base;
> +unsigned int			hpet_freq;
> +unsigned int			hpet_t0_irq;
> +unsigned int			hpet_irq_flags;
> +unsigned int			hpet_t0_cfg;
> +
> +static DEFINE_SPINLOCK(hpet_lock);
> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
> +
> +static int hpet_read(int offset)

Please replace hpet by loogson as the former is already in the mips 
namespace.


