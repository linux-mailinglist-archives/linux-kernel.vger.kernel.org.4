Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF8662C66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjAIRNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjAIRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:12:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97958829
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37054B80E76
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCE3C433D2;
        Mon,  9 Jan 2023 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673284316;
        bh=sOKBXH00f4x9Idnwc6yY00btcdQhBdQ61HUjUHD4HCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMY1mzh0TPROyPBXs/bwOIm6VLSKyEi5kAMHsyHNQW4XK+6mSaW85K6w6bCgGMYSV
         Ss9Mfg4diy8lB3uh3V7W4TDlReOXayfe017efcSs3Gr5C0ccGTl+CNtGq2B+9adNyJ
         CBK/Dw1Qzqc3J/vGai1tWFR7vVck8RfGbuoimczcnt5I8zvi0jpDk+GsoWwnbfe9/a
         6K44hwxOIAL3PV7zjxhP17wy8o+Q4tQlAqq2nT/x1Lp0s7lXKXuogqT6c9RkAYj48h
         VEB2C/YAzelA2xnYGYCaidK01LS3BjkQumwae1bR4T64cDlpHxMHw9XhY/rZBOAnyA
         zHv4J56k7sZJg==
Date:   Mon, 9 Jan 2023 17:11:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Switch to the sys-off handler API
Message-ID: <Y7xK2AkHlr7hIzwC@google.com>
References: <20221228162752.14204-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228162752.14204-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022, Samuel Holland wrote:

> This removes a layer of indirection through pm_power_off() and allows
> the PMIC handler to be used as a fallback when firmware power off fails.
> This happens on boards like the Clockwork DevTerm R-01 where OpenSBI
> does not know how to use the PMIC to power off the board.
> 
> Move the check for AXP288 to avoid registering a dummy handler.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> Note: this patch depends on updating the PSCI driver first[1] to keep
> the existing callback priority.
> 
> [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/
> 
>  drivers/mfd/axp20x.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 47fd700f284f..58f82f1f4b43 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -23,7 +23,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -825,17 +825,17 @@ static const struct mfd_cell axp813_cells[] = {
>  	},
>  };
>  
> -static struct axp20x_dev *axp20x_pm_power_off;
> -static void axp20x_power_off(void)
> +static int axp20x_power_off(struct sys_off_data *data)
>  {
> -	if (axp20x_pm_power_off->variant == AXP288_ID)
> -		return;
> +	struct axp20x_dev *axp20x = data->cb_data;
>  
> -	regmap_write(axp20x_pm_power_off->regmap, AXP20X_OFF_CTRL,
> +	regmap_write(axp20x->regmap, AXP20X_OFF_CTRL,
>  		     AXP20X_OFF);

Nit: Can you pop this on the line above now, thanks.

In fact, forget it, I'll do it.

>  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
>  	mdelay(500);
> +
> +	return NOTIFY_DONE;
>  }
>  
>  int axp20x_match_device(struct axp20x_dev *axp20x)
> @@ -1002,10 +1002,11 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>  		return ret;
>  	}
>  
> -	if (!pm_power_off) {
> -		axp20x_pm_power_off = axp20x;
> -		pm_power_off = axp20x_power_off;
> -	}
> +	if (axp20x->variant != AXP288_ID)
> +		devm_register_sys_off_handler(axp20x->dev,
> +					      SYS_OFF_MODE_POWER_OFF,
> +					      SYS_OFF_PRIO_DEFAULT,
> +					      axp20x_power_off, axp20x);
>  
>  	dev_info(axp20x->dev, "AXP20X driver loaded\n");
>  
> @@ -1015,11 +1016,6 @@ EXPORT_SYMBOL(axp20x_device_probe);
>  
>  void axp20x_device_remove(struct axp20x_dev *axp20x)
>  {
> -	if (axp20x == axp20x_pm_power_off) {
> -		axp20x_pm_power_off = NULL;
> -		pm_power_off = NULL;
> -	}
> -
>  	mfd_remove_devices(axp20x->dev);
>  	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
>  }

Applied, thanks

-- 
Lee Jones [李琼斯]
