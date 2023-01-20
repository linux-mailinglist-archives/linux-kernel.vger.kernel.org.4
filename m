Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916CC675D33
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjATS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:57:13 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574D564BD;
        Fri, 20 Jan 2023 10:57:10 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9D1361C0002;
        Fri, 20 Jan 2023 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674241029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XT7VlRCFpLsl/BJ9dql5jQ1wL2D/AfrEjza1AGq4vg4=;
        b=GAi7Dxr05BGKSylSlDEt1u/vjh5WR7PZSaQzqllmk42o/jXkP+yn3e2Zq7KVlqIzpgR75o
        su23IAKfa5jN3dbKtjmr3iDMX5AaA+M+SCWF0OO/dEcSHmhrVLDmgSYumUpyW8sjthU/f5
        gOgaqufU+rI0x59ObHRF+9gQgemf69qcJ1rfnE7ZTK6wCusnNXOFOpoWKJcsm1sz1wWUcw
        9sd+rVDRyfiNUC92sqii2UluK/8bsd46LUyZN5WGRL6J8UCV47ce+b59H+LE4HzvC3k07q
        J5iLIVjBX9Fco/Ig51vijhpO5t72wF/fDeP0XYGk5CKwoUz4Ho0cFbvbZnl6vg==
Date:   Fri, 20 Jan 2023 19:57:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 07/14] rtc: pcf2127: add support for PCF2131 RTC
Message-ID: <Y8rkA/N6RqSzgXpt@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-8-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-8-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 10:02:08-0500, Hugo Villeneuve wrote:
>  	  PCF2127 has an additional feature of 512 bytes battery backed
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 3265878edc48..4148e135f935 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -1,16 +1,26 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * An I2C and SPI driver for the NXP PCF2127/29 RTC
> + * An I2C and SPI driver for the NXP PCF2127/29/31 RTC
>   * Copyright 2013 Til-Technologies
> + * Copyright 2021 DimOnOff

For the record, I don't really like that because git will be the
authoritative source for the copyright. This will only end up being
outdated info (as it is already)

>   *
>   * Author: Renaud Cerrato <r.cerrato@til-technologies.fr>
>   *
>   * Watchdog and tamper functions
>   * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
>   *
> + * PCF2131 support
> + * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> + *
>   * based on the other drivers in this same directory.
>   *
> - * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF2127.pdf
> + * Datasheets: https://www.nxp.com/docs/en/data-sheet/PCF2127.pdf
> + *             https://www.nxp.com/docs/en/data-sheet/PCF2131DS.pdf
> + */
> +
> +/*
> + * The following features are not yet implemented for the PCF2131:
> + *   - support for 1/100th seconds

This will never be added so I would remove that comment

>   */
>  
>  #include <linux/i2c.h>
> @@ -43,8 +53,30 @@
>  #define PCF2127_BIT_CTRL3_BLF			BIT(2)
>  #define PCF2127_BIT_CTRL3_BF			BIT(3)
>  #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
> +/* Control register 4 */
> +#define PCF2131_REG_CTRL4		0x03
> +#define PCF2131_BIT_CTRL4_TSF4			BIT(4)
> +#define PCF2131_BIT_CTRL4_TSF3			BIT(5)
> +#define PCF2131_BIT_CTRL4_TSF2			BIT(6)
> +#define PCF2131_BIT_CTRL4_TSF1			BIT(7)
> +/* Control register 5 */
> +#define PCF2131_REG_CTRL5		0x04
> +#define PCF2131_BIT_CTRL5_TSIE4			BIT(4)
> +#define PCF2131_BIT_CTRL5_TSIE3			BIT(5)
> +#define PCF2131_BIT_CTRL5_TSIE2			BIT(6)
> +#define PCF2131_BIT_CTRL5_TSIE1			BIT(7)
> +/* Software reset register */
> +#define PCF2131_REG_SR_RESET		0x05
> +#define PCF2131_SR_RESET_READ_PATTERN	0b00100100 /* Fixed pattern. */
> +#define PCF2131_SR_RESET_RESET_CMD	0x2C /* SR is bit 3. */
>  /* Time and date registers */
>  #define PCF2127_REG_TIME_DATE_BASE	0x03
> +#define PCF2131_REG_TIME_DATE_BASE	0x07 /* Register 0x06 is 100th seconds,
> +					      * but we do not support it. By
> +					      * using offset 0x07, we can be
> +					      * compatible with existing
> +					      * time/date functions.
> +					      */

Because we will never support 100th of seconds, this comment is not
useful

>  /* Time and date registers offsets (starting from base register) */
>  #define PCF2127_OFFSET_TD_SC		0
>  #define PCF2127_OFFSET_TD_MN		1
> @@ -57,6 +89,7 @@
>  #define PCF2127_BIT_SC_OSF			BIT(7)
>  /* Alarm registers */
>  #define PCF2127_REG_ALARM_BASE		0x0A
> +#define PCF2131_REG_ALARM_BASE		0x0E

I'd keep the defines ordered by address, so you could move all the
PCF2131 defines after the PCF2127 ones

>  /* Alarm registers offsets (starting from base register) */
>  #define PCF2127_OFFSET_ALARM_SC		0
>  #define PCF2127_OFFSET_ALARM_MN		1
> @@ -67,16 +100,26 @@
>  #define PCF2127_BIT_ALARM_AE			BIT(7)
>  /* CLKOUT control register */
>  #define PCF2127_REG_CLKOUT		0x0f
> +#define PCF2131_REG_CLKOUT		0x13
>  #define PCF2127_BIT_CLKOUT_OTPR			BIT(5)
>  /* Watchdog registers */
>  #define PCF2127_REG_WD_CTL		0x10
> +#define PCF2131_REG_WD_CTL		0x35
>  #define PCF2127_BIT_WD_CTL_TF0			BIT(0)
>  #define PCF2127_BIT_WD_CTL_TF1			BIT(1)
>  #define PCF2127_BIT_WD_CTL_CD0			BIT(6)
>  #define PCF2127_BIT_WD_CTL_CD1			BIT(7)
>  #define PCF2127_REG_WD_VAL		0x11
> +#define PCF2131_REG_WD_VAL		0x36
>  /* Tamper timestamp1 registers */
>  #define PCF2127_REG_TS1_BASE		0x12
> +#define PCF2131_REG_TS1_BASE		0x14
> +/* Tamper timestamp2 registers */
> +#define PCF2131_REG_TS2_BASE		0x1B
> +/* Tamper timestamp3 registers */
> +#define PCF2131_REG_TS3_BASE		0x22
> +/* Tamper timestamp4 registers */
> +#define PCF2131_REG_TS4_BASE		0x29
>  /* Tamper timestamp registers common offsets (starting from base register) */
>  #define PCF2127_OFFSET_TS_CTL		0
>  #define PCF2127_OFFSET_TS_SC		1
> @@ -92,11 +135,22 @@
>   * RAM registers
>   * PCF2127 has 512 bytes general-purpose static RAM (SRAM) that is
>   * battery backed and can survive a power outage.
> - * PCF2129 doesn't have this feature.
> + * PCF2129/31 doesn't have this feature.
>   */
>  #define PCF2127_REG_RAM_ADDR_MSB	0x1A
>  #define PCF2127_REG_RAM_WRT_CMD		0x1C
>  #define PCF2127_REG_RAM_RD_CMD		0x1D
> +/* Interrupt mask registers */
> +#define PCF2131_REG_INT_A_MASK1		0x31
> +#define PCF2131_REG_INT_A_MASK2		0x32
> +#define PCF2131_REG_INT_B_MASK1		0x33
> +#define PCF2131_REG_INT_B_MASK2		0x34
> +#define PCF2131_BIT_INT_BLIE		BIT(0)
> +#define PCF2131_BIT_INT_BIE		BIT(1)
> +#define PCF2131_BIT_INT_AIE		BIT(2)
> +#define PCF2131_BIT_INT_WD_CD		BIT(3)
> +#define PCF2131_BIT_INT_SI		BIT(4)
> +#define PCF2131_BIT_INT_MI		BIT(5)
>  
>  /* Watchdog timer value constants */
>  #define PCF2127_WD_VAL_STOP		0
> @@ -110,6 +164,14 @@
>  		PCF2127_BIT_CTRL2_AF | \
>  		PCF2127_BIT_CTRL2_WDTF | \
>  		PCF2127_BIT_CTRL2_TSF2)
> +#define PCF2131_CTRL2_IRQ_MASK ( \
> +		PCF2127_BIT_CTRL2_AF | \
> +		PCF2127_BIT_CTRL2_WDTF)
> +#define PCF2131_CTRL4_IRQ_MASK ( \
> +		PCF2131_BIT_CTRL4_TSF4 | \
> +		PCF2131_BIT_CTRL4_TSF3 | \
> +		PCF2131_BIT_CTRL4_TSF2 | \
> +		PCF2131_BIT_CTRL4_TSF1)
>  
>  struct pcf21xx_ts_config {
>  	u8 regs_base; /* Base register to read timestamp values. */
> @@ -370,7 +432,7 @@ static int pcf2127_wdt_set_timeout(struct watchdog_device *wdd,
>  }
>  
>  static const struct watchdog_info pcf2127_wdt_info = {
> -	.identity = "NXP PCF2127/PCF2129 Watchdog",
> +	.identity = "NXP PCF2127/29/31 Watchdog",

This change may break userspace tools as this is exposed to userspace


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
