Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D16A1771
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBXHmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBXHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:42:53 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A91E30CF;
        Thu, 23 Feb 2023 23:42:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7033724E278;
        Fri, 24 Feb 2023 15:42:33 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 15:42:33 +0800
Received: from [192.168.125.128] (113.72.147.165) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 15:42:32 +0800
Message-ID: <8ba002ea-299c-2eaf-b1a7-d7d38a540152@starfivetech.com>
Date:   Fri, 24 Feb 2023 15:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <20230223182341.GA200380@roeck-us.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230223182341.GA200380@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/24 2:23, Guenter Roeck wrote:
> On Mon, Feb 20, 2023 at 04:19:26PM +0800, Xingyu Wu wrote:
>> Add watchdog driver for the StarFive JH7110 SoC.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  MAINTAINERS                     |   7 +
>>  drivers/watchdog/Kconfig        |   9 +
>>  drivers/watchdog/Makefile       |   2 +
>>  drivers/watchdog/starfive-wdt.c | 651 ++++++++++++++++++++++++++++++++
>>  4 files changed, 669 insertions(+)
>>  create mode 100644 drivers/watchdog/starfive-wdt.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 135d93368d36..6cbcf08fa76a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19933,6 +19933,13 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>>  F:	drivers/reset/reset-starfive-jh7100.c
>>  F:	include/dt-bindings/reset/starfive-jh7100.h
>>  
>> +STARFIVE JH7110 WATCHDOG DRIVER
>> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>
>> +M:	Samin Guo <samin.guo@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/watchdog/starfive*
>> +F:	drivers/watchdog/starfive-wdt.c
>> +
>>  STATIC BRANCH/CALL
>>  M:	Peter Zijlstra <peterz@infradead.org>
>>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0bc40b763b06..4608eb5c9501 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -2089,6 +2089,15 @@ config UML_WATCHDOG
>>  	tristate "UML watchdog"
>>  	depends on UML || COMPILE_TEST
>>  
>> +config STARFIVE_WATCHDOG
>> +	tristate "StarFive Watchdog support"
>> +	depends on RISCV
>> +	select WATCHDOG_CORE
>> +	default SOC_STARFIVE
>> +	help
>> +	  Say Y here to support the watchdog of StarFive JH7110 SoC.
>> +	  This driver can also be built as a module if choose M.
>> +
>>  #
>>  # ISA-based Watchdog Cards
>>  #
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 9cbf6580f16c..4c0bd377e92a 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -211,6 +211,8 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
>>  # Xen
>>  obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>>  
>> +obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
>> +
>>  # Architecture Independent
>>  obj-$(CONFIG_BD957XMUF_WATCHDOG) += bd9576_wdt.o
>>  obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
>> new file mode 100644
>> index 000000000000..dfbb80406076
>> --- /dev/null
>> +++ b/drivers/watchdog/starfive-wdt.c
>> @@ -0,0 +1,651 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Starfive Watchdog driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>> +#include <linux/watchdog.h>
>> +
>> +/* JH7110 WatchDog register define */
>> +#define STARFIVE_WDT_JH7110_LOAD	0x000	/* RW: Watchdog load register */
>> +#define STARFIVE_WDT_JH7110_VALUE	0x004	/* RO: The current value for the watchdog counter */
>> +#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
>> +						 * RW:
>> +						 * [0]: reset enable;
>> +						 * [1]: int enable/wdt enable/reload counter;
>> +						 * [31:2]: reserve.
> 
> reserved

Will fix.

> 
>> +						 */
>> +#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* WO: clear intterupt && reload the counter */
>> +#define STARFIVE_WDT_JH7110_RIS		0x010	/* RO: Raw interrupt status from the counter */
>> +#define STARFIVE_WDT_JH7110_IMS		0x014	/* RO: Enabled interrupt status from the counter */
>> +#define STARFIVE_WDT_JH7110_LOCK	0xc00	/*
>> +						 * RO: Enable write access to all other registers
>> +						 * by writing 0x1ACCE551.
>> +						 */
> 
> "RO" contradicts itself against the rest of the comment. The register is
> written to, so it can't bew RO.

Change to 'RW'.

> 
>> +
>> +/* WDOGCONTROL */
>> +#define STARFIVE_WDT_ENABLE			0x1
>> +#define STARFIVE_WDT_JH7110_EN_SHIFT		0
>> +#define STARFIVE_WDT_RESET_EN			0x1
>> +#define STARFIVE_WDT_JH7110_RESEN_SHIFT		1
>> +
>> +/* WDOGLOCK */
>> +#define STARFIVE_WDT_LOCKED			BIT(0)
>> +#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
>> +
>> +/* WDOGINTCLR */
>> +#define STARFIVE_WDT_INTCLR			0x1
>> +
>> +#define STARFIVE_WDT_MAXCNT			0xffffffff
>> +#define STARFIVE_WDT_DEFAULT_TIME		(15)
>> +#define STARFIVE_WDT_DELAY_US			0
>> +#define STARFIVE_WDT_TIMEOUT_US			10000
>> +
>> +/* module parameter */
>> +#define STARFIVE_WDT_EARLY_ENA			0
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +static int heartbeat;
>> +static int early_enable = STARFIVE_WDT_EARLY_ENA;
>> +
>> +module_param(heartbeat, int, 0);
>> +module_param(early_enable, int, 0);
>> +module_param(nowayout, bool, 0);
>> +
>> +MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds. (default="
>> +		 __MODULE_STRING(STARFIVE_WDT_DEFAULT_TIME) ")");
>> +MODULE_PARM_DESC(early_enable,
>> +		 "Watchdog is started at boot time if set to 1, default="
>> +		 __MODULE_STRING(STARFIVE_WDT_EARLY_ENA));
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +struct starfive_wdt_variant {
>> +	u32 control;
>> +	u32 load;
>> +	u32 enable;
>> +	u32 value;
>> +	u32 int_clr;
>> +	u32 unlock;
>> +	u32 unlock_key;
>> +	u32 irq_is_raise;
>> +	u8 enrst_shift;
>> +	u8 en_shift;
>> +};
>> +
>> +struct starfive_wdt {
>> +	unsigned long freq;
>> +	struct device *dev;
>> +	struct watchdog_device wdt_device;
>> +	struct clk *core_clk;
>> +	struct clk *apb_clk;
>> +	struct reset_control *rsts;
>> +	const struct starfive_wdt_variant *drv_data;
>> +	u32 count;	/*count of timeout*/
>> +	u32 reload;	/*restore the count*/
>> +	void __iomem *base;
>> +	spinlock_t lock;	/* spinlock for register handling */
>> +};
>> +
>> +/* Register bias in JH7110 */
>> +static const struct starfive_wdt_variant drv_data_jh7110 = {
>> +	.control = STARFIVE_WDT_JH7110_CONTROL,
>> +	.load = STARFIVE_WDT_JH7110_LOAD,
>> +	.enable = STARFIVE_WDT_JH7110_CONTROL,
>> +	.value = STARFIVE_WDT_JH7110_VALUE,
>> +	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
>> +	.unlock = STARFIVE_WDT_JH7110_LOCK,
>> +	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
>> +	.irq_is_raise = STARFIVE_WDT_JH7110_IMS,
>> +	.enrst_shift = STARFIVE_WDT_JH7110_RESEN_SHIFT,
>> +	.en_shift = STARFIVE_WDT_JH7110_EN_SHIFT,
>> +};
>> +
>> +static const struct of_device_id starfive_wdt_match[] = {
>> +	{ .compatible = "starfive,jh7110-wdt", .data = &drv_data_jh7110 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, starfive_wdt_match);
>> +
>> +static const struct platform_device_id starfive_wdt_ids[] = {
>> +	{
>> +		.name = "starfive-jh7110-wdt",
>> +		.driver_data = (unsigned long)&drv_data_jh7110,
>> +	},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(platform, starfive_wdt_ids);
>> +
>> +static int starfive_wdt_get_clock_rate(struct starfive_wdt *wdt)
>> +{
>> +	wdt->freq = clk_get_rate(wdt->core_clk);
>> +	/* The clock rate should not be 0.*/
> 
> This is obvious and not worth a comment.

Will drop.

> 
>> +	if (wdt->freq)
>> +		return 0;
>> +
>> +	dev_err(wdt->dev, "get clock rate failed.\n");
>> +	return -ENOENT;
> 
> Error handling should come first
> 
> 	if (!wdt->freq) {
> 		dev_err(wdt->dev, "get clock rate failed.\n");
> 		return -EINVAL;
> 	}
> 	return 0;
> 
> This is not "No such file or directory" (yes, I see that other drivers
> do that, but that doesn't make it better). Use -EINVAL instead.

Will fix.

> 
>> +}
>> +
>> +static int starfive_wdt_get_clock(struct starfive_wdt *wdt)
>> +{
>> +	wdt->apb_clk = devm_clk_get(wdt->dev, "apb");
>> +	if (IS_ERR(wdt->apb_clk)) {
>> +		dev_err(wdt->dev, "failed to get apb clock.\n");
>> +		return PTR_ERR(wdt->apb_clk);
>> +	}
>> +
>> +	wdt->core_clk = devm_clk_get(wdt->dev, "core");
>> +	if (IS_ERR(wdt->core_clk)) {
>> +		dev_err(wdt->dev, "failed to get core clock.\n");
>> +		return PTR_ERR(wdt->core_clk);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_wdt_reset_init(struct starfive_wdt *wdt)
>> +{
>> +	int ret = 0;
>> +
>> +	wdt->rsts = devm_reset_control_array_get_exclusive(wdt->dev);
>> +	if (IS_ERR(wdt->rsts)) {
>> +		dev_err(wdt->dev, "failed to get rsts error.\n");
> 
> I don't think this message is understandable. "failed to get reset
> control", maybe. Also, the call may return -EPROBE_DEFER,
> which should not generate an error message. Either drop the message
> or use dev_err_probe().

Thanks you for reminding me. I will drop this.
So is the devm_clk_get() and also drop the error message?

> 
>> +		ret = PTR_ERR(wdt->rsts);
>> +	} else {
>> +		ret = reset_control_deassert(wdt->rsts);
>> +		if (ret)
>> +			dev_err(wdt->dev, "failed to deassert rsts.\n");
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static u32 starfive_wdt_ticks_to_sec(struct starfive_wdt *wdt, u32 ticks)
>> +{
>> +	return DIV_ROUND_CLOSEST(ticks, wdt->freq);
>> +}
>> +
>> +/*
>> + * Write unlock-key to unlock. Write other value to lock. When lock bit is 1,
>> + * external accesses to other watchdog registers are ignored.
>> + */
>> +static bool starfive_wdt_is_locked(struct starfive_wdt *wdt)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(wdt->base + wdt->drv_data->unlock);
>> +	return !!(val & STARFIVE_WDT_LOCKED);
>> +}
>> +
>> +static void starfive_wdt_unlock(struct starfive_wdt *wdt)
>> +{
>> +	if (starfive_wdt_is_locked(wdt))
>> +		writel(wdt->drv_data->unlock_key,
>> +		       wdt->base + wdt->drv_data->unlock);
>> +}
>> +
>> +static void starfive_wdt_lock(struct starfive_wdt *wdt)
>> +{
>> +	if (!starfive_wdt_is_locked(wdt))
>> +		writel(~wdt->drv_data->unlock_key,
>> +		       wdt->base + wdt->drv_data->unlock);
>> +}
>> +
>> +/* enable watchdog interrupt to reset/reboot */
>> +static void starfive_wdt_enable_reset(struct starfive_wdt *wdt)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(wdt->base + wdt->drv_data->control);
>> +	val |= STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift;
>> +	writel(val, wdt->base + wdt->drv_data->control);
>> +}
>> +
>> +/* disable watchdog interrupt to reset/reboot */
>> +static void starfive_wdt_disable_reset(struct starfive_wdt *wdt)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(wdt->base + wdt->drv_data->control);
>> +	val &= ~(STARFIVE_WDT_RESET_EN << wdt->drv_data->enrst_shift);
>> +	writel(val, wdt->base + wdt->drv_data->control);
>> +}
>> +
>> +/* interrupt status whether has been raised from the counter */
>> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
>> +{
>> +	return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
>> +}
>> +
>> +/* clear interrupt signal before initialization or reload */
>> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
>> +{
>> +	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
>> +}
>> +
>> +static inline void starfive_wdt_set_count(struct starfive_wdt *wdt, u32 val)
>> +{
>> +	writel(val, wdt->base + wdt->drv_data->load);
>> +}
>> +
>> +static inline u32 starfive_wdt_get_count(struct starfive_wdt *wdt)
>> +{
>> +	return readl(wdt->base + wdt->drv_data->value);
>> +}
>> +
>> +/* enable watchdog */
>> +static inline void starfive_wdt_enable(struct starfive_wdt *wdt)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(wdt->base + wdt->drv_data->enable);
>> +	val |= STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift;
>> +	writel(val, wdt->base + wdt->drv_data->enable);
>> +}
>> +
>> +/* disable watchdog */
>> +static inline void starfive_wdt_disable(struct starfive_wdt *wdt)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(wdt->base + wdt->drv_data->enable);
>> +	val &= ~(STARFIVE_WDT_ENABLE << wdt->drv_data->en_shift);
>> +	writel(val, wdt->base + wdt->drv_data->enable);
>> +}
>> +
>> +static inline void starfive_wdt_set_reload_count(struct starfive_wdt *wdt, u32 count)
>> +{
>> +	starfive_wdt_set_count(wdt, count);
>> +	/* need enable controller to reload counter */
>> +	starfive_wdt_enable(wdt);
>> +}
>> +
>> +static unsigned int starfive_wdt_max_timeout(struct starfive_wdt *wdt)
>> +{
>> +	return DIV_ROUND_UP(STARFIVE_WDT_MAXCNT, (wdt->freq / 2)) - 1;
>> +}
>> +
>> +static unsigned int starfive_wdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	u32 count;
>> +
>> +	starfive_wdt_unlock(wdt);
>> +	/*
>> +	 * Because set half count value,
>> +	 * timeleft value should add the count value before first timeout.
>> +	 */
>> +	count = starfive_wdt_get_count(wdt);
>> +	if (!starfive_wdt_raise_irq_status(wdt))
>> +		count += wdt->count;
>> +
>> +	starfive_wdt_lock(wdt);
>> +
>> +	return starfive_wdt_ticks_to_sec(wdt, count);
>> +}
>> +
>> +static int starfive_wdt_keepalive(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	spin_lock(&wdt->lock);
>> +
>> +	starfive_wdt_unlock(wdt);
>> +	starfive_wdt_int_clr(wdt);
>> +	starfive_wdt_set_reload_count(wdt, wdt->count);
>> +	starfive_wdt_lock(wdt);
>> +
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_wdt_stop(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	spin_lock(&wdt->lock);
>> +
>> +	starfive_wdt_unlock(wdt);
>> +	starfive_wdt_disable_reset(wdt);
> 
> Is that necessary ? The watchdog is going to be stopped, after all.

It doesn't seem necessary. Drop this. And drop this entire function
because no one use it. 

> 
>> +	starfive_wdt_int_clr(wdt);
>> +	starfive_wdt_disable(wdt);
>> +	starfive_wdt_lock(wdt);
>> +
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	starfive_wdt_stop(wdd);
>> +	pm_runtime_put_sync(wdt->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_wdt_start(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	spin_lock(&wdt->lock);
>> +	starfive_wdt_unlock(wdt);
>> +	/* disable watchdog, to be safe */
>> +	starfive_wdt_disable(wdt);
>> +
>> +	starfive_wdt_enable_reset(wdt);
>> +	starfive_wdt_int_clr(wdt);
>> +	starfive_wdt_set_count(wdt, wdt->count);
>> +	starfive_wdt_enable(wdt);
>> +
>> +	starfive_wdt_lock(wdt);
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +
>> +	pm_runtime_get_sync(wdt->dev);
>> +
>> +	return starfive_wdt_start(wdd);
>> +}
>> +
>> +static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
>> +				    unsigned int timeout)
>> +{
>> +	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
>> +	unsigned long freq = wdt->freq;
>> +
>> +	spin_lock(&wdt->lock);
>> +
>> +	/*
>> +	 * This watchdog takes twice timeouts to reset.
>> +	 * In order to reduce time to reset, should set half count value.
>> +	 */
>> +	wdt->count = timeout * freq / 2;
>> +	wdd->timeout = timeout;
>> +
>> +	starfive_wdt_unlock(wdt);
>> +	starfive_wdt_disable(wdt);
>> +	starfive_wdt_set_reload_count(wdt, wdt->count);
>> +	starfive_wdt_enable(wdt);
>> +	starfive_wdt_lock(wdt);
>> +
>> +	spin_unlock(&wdt->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +#define OPTIONS (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
>> +
>> +static const struct watchdog_info starfive_wdt_ident = {
>> +	.options = OPTIONS,
>> +	.identity = "StarFive Watchdog",
>> +};
>> +
>> +static const struct watchdog_ops starfive_wdt_ops = {
>> +	.owner = THIS_MODULE,
>> +	.start = starfive_wdt_pm_start,
>> +	.stop = starfive_wdt_pm_stop,
>> +	.ping = starfive_wdt_keepalive,
>> +	.set_timeout = starfive_wdt_set_timeout,
>> +	.get_timeleft = starfive_wdt_get_timeleft,
>> +};
>> +
>> +static const struct watchdog_device starfive_wdd = {
>> +	.info = &starfive_wdt_ident,
>> +	.ops = &starfive_wdt_ops,
>> +	.timeout = STARFIVE_WDT_DEFAULT_TIME,
>> +};
>> +
>> +static inline const struct starfive_wdt_variant *
>> +starfive_wdt_get_drv_data(struct platform_device *pdev)
>> +{
>> +	const struct starfive_wdt_variant *variant;
>> +
>> +	variant = of_device_get_match_data(&pdev->dev);
>> +	if (!variant) {
>> +		/* Device matched by platform_device_id */
>> +		variant = (struct starfive_wdt_variant *)
>> +			   platform_get_device_id(pdev)->driver_data;
>> +	}
>> +
>> +	return variant;
>> +}
>> +
>> +static int starfive_wdt_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct starfive_wdt *wdt;
>> +	int ret;
>> +
>> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> +	if (!wdt)
>> +		return -ENOMEM;
>> +
>> +	wdt->dev = dev;
>> +	spin_lock_init(&wdt->lock);
>> +	wdt->wdt_device = starfive_wdd;
>> +
>> +	wdt->drv_data = starfive_wdt_get_drv_data(pdev);
>> +
>> +	/* get the memory region for the watchdog timer */
>> +	wdt->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(wdt->base)) {
>> +		ret = PTR_ERR(wdt->base);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, wdt);
>> +	pm_runtime_enable(wdt->dev);
>> +
>> +	ret = starfive_wdt_get_clock(wdt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (pm_runtime_enabled(wdt->dev)) {
>> +		ret = pm_runtime_get_sync(wdt->dev);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		/* runtime PM is disabled but clocks need to be enabled */
>> +		ret = clk_prepare_enable(wdt->apb_clk);
>> +		if (ret) {
>> +			dev_err(wdt->dev, "failed to enable apb_clk.\n");
>> +			return ret;
>> +		}
>> +		ret = clk_prepare_enable(wdt->core_clk);
>> +		if (ret) {
>> +			dev_err(wdt->dev, "failed to enable core_clk.\n");
>> +			goto err_apb_clk_disable;
>> +		}
>> +	}
>> +
>> +	ret = starfive_wdt_get_clock_rate(wdt);
>> +	if (ret)
>> +		goto err_clk_disable;
>> +
>> +	ret = starfive_wdt_reset_init(wdt);
>> +	if (ret)
>> +		goto err_clk_disable;
>> +
>> +	wdt->wdt_device.min_timeout = 1;
>> +	wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
> 
> 	wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> 
> should be set here. Otherwise the warning below would always be seen
> if the module parameter is not set.
> 
>> +
>> +	watchdog_set_drvdata(&wdt->wdt_device, wdt);
>> +
>> +	/*
>> +	 * see if we can actually set the requested heartbeat,
>> +	 * and if not, try the default value.
>> +	 */
>> +	watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>> +	if (wdt->wdt_device.timeout == 0 ||
> 
> If wdt->wdt_device.timeout is pre-initialized, it will never be 0 here.
> 
>> +	    wdt->wdt_device.timeout > wdt->wdt_device.max_timeout) {
> 
> That won't happen because watchdog_init_timeout() validates it and does
> not update the value if it is out of range.
> 
>> +		dev_warn(dev, "heartbeat value out of range, default %d used\n",
>> +			 STARFIVE_WDT_DEFAULT_TIME);
>> +		wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> 
> And this is then unnecessary. wdt->wdt_device.timeout will always be
> valid if it was pre-initialized.

It is changed to be this at beginning of the driver:

static int heartbeat = STARFIVE_WDT_DEFAULT_TIME;

and it is changed to be this here:

ret = watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
if (ret)
	return ret;

Would that be better?

> 
>> +	}
>> +	starfive_wdt_set_timeout(&wdt->wdt_device, wdt->wdt_device.timeout);
>> +
>> +	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
>> +	watchdog_stop_on_reboot(&wdt->wdt_device);
>> +	watchdog_stop_on_unregister(&wdt->wdt_device);
>> +
>> +	wdt->wdt_device.parent = dev;
>> +
>> +	ret = watchdog_register_device(&wdt->wdt_device);
>> +	if (ret)
>> +		goto err_clk_disable;
>> +
>> +	if (early_enable) {
>> +		starfive_wdt_start(&wdt->wdt_device);
>> +		set_bit(WDOG_HW_RUNNING, &wdt->wdt_device.status);
> 
> Is it correct to call pm_runtime_put_sync() below if the watchdog
> is running ? Doesn't that stop the clock ?

Add a check of 'early_enable' to pm_runtime_put_sync() or
move it after starfive_wdt_stop() immediately.

> 
>> +	} else {
>> +		starfive_wdt_stop(&wdt->wdt_device);
>> +	}
> 
> Wrong order. This has to be done _before_ the watchdog device is registered
> to make sure that the watchdog core knows about WDOG_HW_RUNNING.

So move this before watchdog_register_device().

Best regards,
Xingyu Wu
