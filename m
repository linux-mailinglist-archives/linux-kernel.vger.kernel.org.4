Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2996E714A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjE2Ni1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjE2NiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:38:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BBFCF;
        Mon, 29 May 2023 06:38:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso3942439b3a.0;
        Mon, 29 May 2023 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685367502; x=1687959502;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Wz1iKEYkaJwrBK5fzZBFhYmG1xumF7J7SB6Or0Q1f4=;
        b=fhIXuGg5vHxdfBqBvQhYdbRXMJbHF2551fB5vbqfCKqPweWwV2CpxwIc94kKWFL4CI
         7UReQo+g8hjpFFi/0AwrU96mfAftVX41ai2RGhgfy3RivlqLcy9rdK1m2/vfKCOS23rN
         0fn4DuXfhJE2x2b3gmKvW5Ze1/cqyJI30Yn/TNrRRHhsnPoUi7Gr4O4lw4cuC6BOGHrG
         /WTzOoP1ZauWGJ+j/8wxVALwGd9pAfNMyy3yadwHnQh9rwT9arrklLWdotzhjwlxMntr
         Slzg7zAwYoJH3z1sPlBc7D/2sIex59lm74GJ3goaZJQzjoD36ZO0kFI4ue0L3q3tA2dy
         CY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367502; x=1687959502;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wz1iKEYkaJwrBK5fzZBFhYmG1xumF7J7SB6Or0Q1f4=;
        b=Vx8mRA76HAijQIDtpLk0jPuIZhZcH/PngnC/5Jn+kwTeW8+xLEUw/jvQw1lDa8XAUT
         IHvTpurRTQuAMkd8hpMrfpuQ7u3oGWuyk+RBnOSdMD/CwbUT6vyDZ39zydGAM1BsfYmx
         rzlGHeb5EcGYTMHO6ke0GC3uiFAQ9FhEh/u9M97dJ+f20a0rl2/6iNsgBq7STDKr70PW
         +jkNHggN8RlV2q6FWMXdg0GILiGJfdV6llJv52w7vMuz/wm3iBsX6tsnNUCakqyk+48V
         7mFR+Eq6l/wOQShtp8S2lq3qeaNs0G+TwphjGwKvEW1LFELoSqZRKz0hWFoau2MRXmZ8
         0J0g==
X-Gm-Message-State: AC+VfDwyLgU5YW8OmS4jFU5IvtD3qvOabNwy4hb2iJi8wRxNr+0lNw0o
        746lQbjWvoLNIoQBwvZkpU4=
X-Google-Smtp-Source: ACHHUZ5RVT3C34ovjV2v3LSw3G/oqyYka+FLhLY7Xfemsbj3HfGUGcMHuXA8HMQczdwp2wMLONtQew==
X-Received: by 2002:a17:902:c94a:b0:1a0:7156:f8d1 with SMTP id i10-20020a170902c94a00b001a07156f8d1mr15701286pla.19.1685367501990;
        Mon, 29 May 2023 06:38:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902760800b001acad86ebc5sm8269811pll.33.2023.05.29.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:38:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <059bfc62-c2a5-df57-dceb-669585fad4d5@roeck-us.net>
Date:   Mon, 29 May 2023 06:38:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20230526062626.1180-1-bbhushan2@marvell.com>
 <20230526062626.1180-2-bbhushan2@marvell.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2 v8] Watchdog: Add marvell GTI watchdog driver
In-Reply-To: <20230526062626.1180-2-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 23:26, Bharat Bhushan wrote:
> This patch add support for Marvell GTI watchdog.  Global timer
> unit (GTI) support hardware watchdog timer. Software programs
> watchdog timer to generate interrupt on first timeout, second
> timeout is configured to be ignored and system reboots on
> third timeout.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v8:
>    - Compatible names as per soc names
>    - This driver run on ARM64 based architecture, Added 64BIT config
>      dependency to avoid compilation error related to readq/writeq on
>      32 as platform (Hexagon)
>   

In the future, please provide complete change logs.

>   drivers/watchdog/Kconfig           |  13 ++
>   drivers/watchdog/Makefile          |   1 +
>   drivers/watchdog/marvell_gti_wdt.c | 346 +++++++++++++++++++++++++++++
>   3 files changed, 360 insertions(+)
>   create mode 100644 drivers/watchdog/marvell_gti_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f22138709bf5..bbdc20f33dbf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1779,6 +1779,19 @@ config OCTEON_WDT
>   	  from the first interrupt, it is then only poked when the
>   	  device is written.
>   
> +config MARVELL_GTI_WDT
> +	tristate "Marvell GTI Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> +	default y

Does this watchdog exist on all Thunder processors ?
If not please drop.

> +	select WATCHDOG_CORE
> +	help
> +	 Marvell GTI hardware supports watchdog timer. First timeout
> +	 works as watchdog pretimeout and installed interrupt handler
> +	 will be called on first timeout. Hardware can generate interrupt
> +	 to SCP on second timeout but it is not enabled, So second
> +	 timeout is ignored. If device poke does not happen then system
> +	 will reboot on third timeout.
> +
>   config BCM2835_WDT
>   	tristate "Broadcom BCM2835 hardware watchdog"
>   	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index b4c4ccf2d703..a164cd161ef3 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>   obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>   obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
>   obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
> +obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
>   
>   # X86 (i386 + ia64 + x86_64) Architecture
>   obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> new file mode 100644
> index 000000000000..976bb9306115
> --- /dev/null
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell GTI Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/clk.h>
> +
Alphabetic order, please. Also, include io.h since
you are using io functions (writeq).

> +/*
> + * Hardware supports following mode of operation:
> + * 1) Interrupt Only:
> + *    This will generate the interrupt to arm core whenever timeout happens.
> + *
> + * 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    This will generate interrupt to SCP processor on 2nd timeout happens
> + *
> + * 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
> + *    This will generate interrupt to arm core on 1st timeout happens
> + *    Will generate interrupt to SCP processor on 2nd timeout happens,
> + *    if interrupt is configured.
> + *    Reboot on 3rd timeout.
> + *
> + * Driver will use hardware in mode-3 above so that system can reboot in case
> + * a hardware hang. Also h/w is configured not to generate SCP interrupt, so
> + * effectively 2nd timeout is ignored within hardware.
> + *
> + * First timeout is effectively watchdog pretimeout.
> + */
> +
> +/* GTI CWD Watchdog (GTI_CWD_WDOG) Register */
> +#define GTI_CWD_WDOG(reg_offset)	(0x8 * reg_offset)

reg_offset in ()

> +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> +#define GTI_CWD_WDOG_MODE_MASK		GENMASK_ULL(1, 0)
> +#define GTI_CWD_WDOG_LEN_SHIFT		4
> +#define GTI_CWD_WDOG_LEN_MASK		GENMASK_ULL(19, 4)
> +#define GTI_CWD_WDOG_CNT_SHIFT		20
> +#define GTI_CWD_WDOG_CNT_MASK		GENMASK_ULL(43, 20)
> +
> +/* GTI CWD Watchdog Interrupt (GTI_CWD_INT) Register */
> +#define GTI_CWD_INT			0x200
> +#define GTI_CWD_INT_PENDING_STATUS(bit)	(1 << bit)
> +
> +/* GTI CWD Watchdog Interrupt Enable Clear (GTI_CWD_INT_ENA_CLR) Register */
> +#define GTI_CWD_INT_ENA_CLR		0x210
> +#define GTI_CWD_INT_ENA_CLR_VAL(bit)	(1 << bit)

Please use BIT().

> +
> +/* GTI CWD Watchdog Interrupt Enable Set (GTI_CWD_INT_ENA_SET) Register */
> +#define GTI_CWD_INT_ENA_SET		0x218
> +#define GTI_CWD_INT_ENA_SET_VAL(bit)	(1 << bit)
> +
> +/* GTI CWD Watchdog Poke (GTI_CWD_POKE) Registers */
> +#define GTI_CWD_POKE(reg_offset)	(0x10000 + 0x8 * reg_offset)
> +#define GTI_CWD_POKE_VAL		1
> +
> +struct gti_match_data {
> +	u32 gti_num_timers;
> +};
> +
> +static const struct gti_match_data match_data_octeontx2 = {

The driver depends on ARCH_THUNDER but not ARCH_THUNDER2.

> +	.gti_num_timers = 54,
> +};
> +
> +static const struct gti_match_data match_data_cn10k = {
> +	.gti_num_timers = 64,
> +};
> +
> +struct gti_wdt_priv {
> +	struct watchdog_device wdev;
> +	void __iomem *base;
> +	u32 clock_freq;
> +	struct clk *sclk;
> +	/* wdt_timer_idx used for timer to be used for system watchdog */
> +	u32 wdt_timer_idx;
> +	const struct gti_match_data *data;
> +};
> +
> +static irqreturn_t gti_wdt_interrupt(int irq, void *data)
> +{
> +	struct watchdog_device *wdev = data;
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	/* Clear Interrupt Pending Status */
> +	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT);
> +
> +	watchdog_notify_pretimeout(wdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gti_wdt_ping(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
> +	writeq(GTI_CWD_POKE_VAL,
> +	       priv->base + GTI_CWD_POKE(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_start(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	if (!wdev->pretimeout)
> +		return -EINVAL;
> +
> +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> +
> +	/* Clear any pending interrupt */
> +	writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT);
> +
> +	/* Enable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_SET_VAL(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT_ENA_SET);
> +
> +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_stop(struct watchdog_device *wdev)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 regval;
> +
> +	/* Disable Interrupt */
> +	writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
> +	       priv->base + GTI_CWD_INT_ENA_CLR);
> +
> +	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval &= ~GTI_CWD_WDOG_MODE_MASK;
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_settimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	u64 timeout_wdog, regval;
> +
> +	/* Update new timeout */
> +	wdev->timeout = timeout;
> +
> +	/* Pretimeout is 1/3 of timeout */
> +	wdev->pretimeout = timeout / 3;
> +
> +	/* Get clock cycles from pretimeout */
> +	timeout_wdog = (u64)priv->clock_freq * wdev->pretimeout;
> +
> +	/* Watchdog counts in 1024 cycle steps */
> +	timeout_wdog = timeout_wdog >> 10;
> +
> +	/* GTI_CWD_WDOG.CNT: reload counter is 16-bit */
> +	timeout_wdog = (timeout_wdog + 0xff) >> 8;
> +	if (timeout_wdog >= 0x10000)
> +		timeout_wdog = 0xffff;
> +
> +	/*
> +	 * GTI_CWD_WDOG.LEN is 24bit, lower 8-bits should be zero and
> +	 * upper 16-bits are same as GTI_CWD_WDOG.CNT
> +	 */
> +	regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +	regval &= GTI_CWD_WDOG_MODE_MASK;
> +	regval |= (timeout_wdog << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> +	writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
> +
> +	return 0;
> +}
> +
> +static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
> +					unsigned int timeout)
> +{
> +	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	struct watchdog_device *wdog_dev = &priv->wdev;
> +
> +	/* pretimeout should 1/3 of max_timeout */
> +	if (timeout * 3 <= wdog_dev->max_timeout)
> +		return gti_wdt_settimeout(wdev, timeout * 3);
> +
> +	return -EINVAL;
> +}
> +
> +static void gti_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static int gti_wdt_get_cntfrq(struct platform_device *pdev,
> +			      struct gti_wdt_priv *priv)
> +{
> +	int err;
> +
> +	priv->sclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->sclk))
> +		return PTR_ERR(priv->sclk);
> +
> +	err = clk_prepare_enable(priv->sclk);
> +	if (err)
> +		return err;
> +

Any reason for not using devm_clk_get_enabled() ?

> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       gti_clk_disable_unprepare, priv->sclk);
> +	if (err)
> +		return err;
> +
> +	priv->clock_freq = clk_get_rate(priv->sclk);
> +	if (!priv->clock_freq)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_info gti_wdt_ident = {
> +	.identity = "Marvell GTI watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT | WDIOF_KEEPALIVEPING |
> +		   WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> +};
> +
> +static const struct watchdog_ops gti_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = gti_wdt_start,
> +	.stop = gti_wdt_stop,
> +	.ping = gti_wdt_ping,
> +	.set_timeout = gti_wdt_settimeout,
> +	.set_pretimeout = gti_wdt_set_pretimeout,
> +};
> +
> +static int gti_wdt_probe(struct platform_device *pdev)
> +{
> +	struct gti_wdt_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdog_dev;
> +	u64 max_pretimeout;
> +	u32 wdt_idx;
> +	int irq;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> +			      "reg property not valid/found\n");
> +
> +	err = gti_wdt_get_cntfrq(pdev, priv);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "GTI clock frequency not valid/found");
> +
> +	priv->data = of_device_get_match_data(dev);
> +
> +	/* default use last timer for watchdog */
> +	priv->wdt_timer_idx = priv->data->gti_num_timers - 1;
> +
> +	err = of_property_read_u32(dev->of_node, "marvell,wdt-timer-index",
> +				   &wdt_idx);
> +	if (!err) {
> +		if (wdt_idx >= priv->data->gti_num_timers)
> +			return dev_err_probe(&pdev->dev, err,
> +				"GTI wdog timer index not valid");
> +
> +		priv->wdt_timer_idx = wdt_idx;
> +	}
> +
> +	wdog_dev = &priv->wdev;
> +	wdog_dev->info = &gti_wdt_ident,
> +	wdog_dev->ops = &gti_wdt_ops,
> +	wdog_dev->parent = dev;
> +	/*
> +	 * Watchdog counter is 24 bit where lower 8 bits are zeros
> +	 * This counter decrements every 1024 clock cycles.
> +	 */
> +	max_pretimeout = (GTI_CWD_WDOG_CNT_MASK >> GTI_CWD_WDOG_CNT_SHIFT);
> +	max_pretimeout &= ~0xFFUL;
> +	max_pretimeout = (max_pretimeout * 1024) / priv->clock_freq;
> +	wdog_dev->pretimeout = max_pretimeout;
> +
> +	/* Maximum timeout is 3 times the pretimeout */
> +	wdog_dev->max_timeout = max_pretimeout * 3;
> +	/* Minimum first timeout (pretimeout) is 1, so min_timeout as 3 */
> +	wdog_dev->min_timeout = 3;
> +	wdog_dev->timeout = wdog_dev->pretimeout;
> +
> +	watchdog_set_drvdata(wdog_dev, priv);
> +	platform_set_drvdata(pdev, priv);
> +	gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> +	watchdog_stop_on_reboot(wdog_dev);
> +	watchdog_stop_on_unregister(wdog_dev);
> +
> +	err = devm_watchdog_register_device(dev, wdog_dev);
> +	if (err)
> +		return err;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(&pdev->dev, irq, "IRQ resource not found\n");
> +
> +	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
> +			       pdev->name, &priv->wdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
> +
> +	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
> +	return 0;
> +}
> +
> +static const struct of_device_id gti_wdt_of_match[] = {
> +	{ .compatible = "marvell,cn9670-wdt", .data = &match_data_octeontx2},
> +	{ .compatible = "marvell,cn9880-wdt", .data = &match_data_octeontx2},
> +	{ .compatible = "marvell,cnf9535-wdt", .data = &match_data_octeontx2},
> +	{ .compatible = "marvell,cn10624-wdt", .data = &match_data_cn10k},
> +	{ .compatible = "marvell,cn10308-wdt", .data = &match_data_cn10k},
> +	{ .compatible = "marvell,cnf10518-wdt", .data = &match_data_cn10k},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, gti_wdt_of_match);
> +
> +static struct platform_driver gti_wdt_driver = {
> +	.driver = {
> +		.name = "gti-wdt",
> +		.of_match_table = gti_wdt_of_match,
> +	},
> +	.probe = gti_wdt_probe,
> +};
> +module_platform_driver(gti_wdt_driver);
> +
> +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> +MODULE_DESCRIPTION("Marvell GTI watchdog driver");

