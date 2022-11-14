Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C08628BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiKNWSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiKNWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:17:48 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5491AF04;
        Mon, 14 Nov 2022 14:17:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C80B5FF804;
        Mon, 14 Nov 2022 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668464251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8a4wPtjVzOGoyWFiu/TeCUBsfxb3YVZS/qU+8AaCrn4=;
        b=lXmgqsxzL2Jf3LaI2strgXSfattQSrNEl2EC6lXwkk1Crw/W98if+31YNObTan4Oh/Mz8X
        wKpiYntr/9uwelnH6a+vuC7rECgqrkn8nLIhtWIjW9o33oE+FOUG+8rt5TxUm8qjiOiRvs
        zZkE53bYCj24/MmZ5PPupbgRtd+mB89DoENVUvnmzj0VxJwjbEP8W4IDpnSpbLPXxL5v8p
        emX8mj+i3N0jM3zX7viqdCT1sqkrlvrzJGdfAozanZ30OcxXtA6irhwoRMnSxfC+ZN3l1b
        HUMV4o7calKrRg+xU5VJvXmSaV9CpdANhnkOQu0FMxQWVqr3d33L03BsEtGlhA==
Date:   Mon, 14 Nov 2022 23:17:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     glasveze@delta.nl
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        a.zummo@towertech.it, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] rtc: ds1307: Add support for Epson RX8111
Message-ID: <Y3K+ehjZAA4AIXie@mail.local>
References: <20221028144041.11067-1-glasveze@delta.nl>
 <20221028144041.11067-2-glasveze@delta.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028144041.11067-2-glasveze@delta.nl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/10/2022 16:40:41+0200, glasveze@delta.nl wrote:
> +static u8 do_trickle_setup_rx8111(struct ds1307 *ds1307, u32 ohms, bool diode)
> +{
> +	/* make sure that the backup battery is enabled */
> +	u8 setup = RX8111_PSC_SMP_INIEN;

You can't do that, else it will never be possible to remove that without
breaking existing users. Instead, you should use
RTC_PARAM_BACKUP_SWITCH_MODE. Honestly, I would really like stopping
adding support for more RTCs in this driver and instead split them all
out.

> +
> +	if (diode)
> +		setup |= RX8111_PSC_SMP_CHGEN;
> +
> +	return setup;
> +}
> +
>  static u8 do_trickle_setup_rx8130(struct ds1307 *ds1307, u32 ohms, bool diode)
>  {
>  	/* make sure that the backup battery is enabled */
> @@ -1012,6 +1078,16 @@ static const struct chip_desc chips[last_ds_type] = {
>  		.century_bit	= DS1337_BIT_CENTURY,
>  		.bbsqi_bit	= DS3231_BIT_BBSQW,
>  	},
> +	[rx_8111] = {
> +		.alarm		= 1,
> +		.nvram_offset	= 0x40,
> +		.nvram_size	= 0x40,	/* 0x40 .. 0x7F is user RAM */
> +		.offset		= 0x10,
> +		.irq_handler = rx8130_irq,
> +		.rtc_ops = &rx8130_rtc_ops,
> +		.trickle_charger_reg = RX8111_PWR_SWITCH_CTRL,
> +		.do_trickle_setup = &do_trickle_setup_rx8111,
> +	},
>  	[rx_8130] = {
>  		.alarm		= 1,
>  		/* this is battery backed SRAM */
> @@ -1063,6 +1139,7 @@ static const struct i2c_device_id ds1307_id[] = {
>  	{ "pt7c4338", ds_1307 },
>  	{ "rx8025", rx_8025 },
>  	{ "isl12057", ds_1337 },
> +	{ "rx8111", rx_8111 },
>  	{ "rx8130", rx_8130 },
>  	{ }
>  };
> @@ -1137,6 +1214,10 @@ static const struct of_device_id ds1307_of_match[] = {
>  		.compatible = "isil,isl12057",
>  		.data = (void *)ds_1337
>  	},
> +	{
> +		.compatible = "epson,rx8111",
> +		.data = (void *)rx_8111
> +	},
>  	{
>  		.compatible = "epson,rx8130",
>  		.data = (void *)rx_8130
> @@ -1880,6 +1961,10 @@ static int ds1307_probe(struct i2c_client *client,
>  				     DS1307_REG_HOUR << 4 | 0x08, hour);
>  		}
>  		break;
> +	case rx_8111:
> +		/* Use memory as user RAM */
> +		regmap_write(ds1307->regmap, RX8111_TIME_STAMP_BUF_CTRL, 0);
> +		break;
>  	case ds_1388:
>  		err = regmap_read(ds1307->regmap, DS1388_REG_CONTROL, &tmp);
>  		if (err) {
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
