Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C469E7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBUSlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBUSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:41:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081930282;
        Tue, 21 Feb 2023 10:41:35 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c23so1178851pjo.4;
        Tue, 21 Feb 2023 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVehFQdVGJrMqMTa40u/3esY8x1eGiBhNFRgFgu1gT0=;
        b=VeCbtMXTBLi3rfPegHSsToMWXrB0ha+ZadIsZuM5awOB0FejJlJg2luB49095xGC7A
         zaqHdyOAr8mfOBsjSRQ/NV4tIwXEJW8kEDinjeLxJ3vcH470avDlLY0rjnnABEGUiIPQ
         OVNhWEgbpTS6zUhITxLKFhmuPGKZ//Dx8bHp91yrqXKwUuOcrygOs1GutaJX0Lpzz7nB
         Y67V4yXk3cS/pZ1effVlCmCg1zsj94aDKIJqKRryVp6kka3s6owDtcKmRJKgMJRXCuPe
         QPLzud/YkGTRT8arVRUMNYGWAJXoeXjLVfvrVM6uSWCggv85cCrSOuqzdN6p3rUoqpF/
         FnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVehFQdVGJrMqMTa40u/3esY8x1eGiBhNFRgFgu1gT0=;
        b=vqZWDJNnmUJoNDizy1c29uMCcdOFEePEI9oovpvILNtpN7gtEkpQHqA9TzFYnoIkcf
         sE3IPQKLKAOZb1jtu8VksAfXOUZ5Q0dvRxNO4ITdVBQ6duOOeZ5yXUcDlTKmkrxLjgTq
         u5lsJcym8PXPjBU4oCrlcVEwg1eu+AxVOt5CNvIJj72TpVe3knaiUiKIqMEG/MQ3mJxE
         T4blmuINwjip8NRa0ZAxwlvjcf2+udMuHKTsgbbF29AptUB/UmekyWm7TBqCNqqGoIvA
         Pa/ZKMtNgML00G9pffm6v8bYwlrDjBNxoo2/VroQ+rb/DdLf7rAgq8QxeieLzZ6fDpt5
         cFzA==
X-Gm-Message-State: AO0yUKUjUeqQcx1Zgd7T2AAnLTlfztRSiI5x8WZ8ROtrTVAVs7AvKRyT
        MaqZpMaQCByeHCoghSndSt0=
X-Google-Smtp-Source: AK7set/J+D0m43p+fEQA2RrEHmqQYCaRXTzyT8E1jNvkeze10AzS/rnFLCbb9SfffmoTwlEK20YcBA==
X-Received: by 2002:a17:90a:ff15:b0:233:ee50:d291 with SMTP id ce21-20020a17090aff1500b00233ee50d291mr5791003pjb.22.1677004894875;
        Tue, 21 Feb 2023 10:41:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:30ba:90e9:a2f2:4b50])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090b018500b0023530b1e4a0sm3211354pjs.2.2023.02.21.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:41:34 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:41:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, ulf.hansson@linaro.org,
        hari.prasathge@microchip.com
Subject: Re: [PATCH v4 1/2] mmc: atmel-mci: Convert to gpio descriptors
Message-ID: <Y/UQW0f9m3gqBnJ8@google.com>
References: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com>
 <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balamanikandan,

On Tue, Feb 21, 2023 at 03:12:06PM +0530, Balamanikandan Gunasundar wrote:
> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 77 +++++++++++++++++-------------------
>  include/linux/atmel-mci.h    |  4 +-
>  2 files changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index dd18440a90c5..ddad5a929634 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -11,7 +11,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -19,7 +18,8 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
> @@ -388,8 +388,8 @@ struct atmel_mci_slot {
>  #define ATMCI_CARD_NEED_INIT	1
>  #define ATMCI_SHUTDOWN		2
>  
> -	int			detect_pin;
> -	int			wp_pin;
> +	struct gpio_desc        *detect_pin;
> +	struct gpio_desc	*wp_pin;
>  	bool			detect_is_active_high;
>  
>  	struct timer_list	detect_timer;
> @@ -637,7 +637,10 @@ atmci_of_init(struct platform_device *pdev)
>  			pdata->slot[slot_id].bus_width = 1;
>  
>  		pdata->slot[slot_id].detect_pin =
> -			of_get_named_gpio(cnp, "cd-gpios", 0);
> +			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
> +					      "cd", GPIOD_IN, "cd-gpios");
> +		if (IS_ERR(pdata->slot[slot_id].detect_pin))
> +			pdata->slot[slot_id].detect_pin = NULL;

Since we are doing the conversion, may I suggest:

		error = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
		if (error) {
			if (error != -ENOENT)
				retrun ERR_PTR(error);
			pdata->slot[slot_id].detect_pin = NULL;
		}

so that we do not ignore valid errors, and handle deferrals.

I also wonde if it would not be better to move this (acquiring GPIOs)
out of the OF case and into the main probe.

>  
>  		pdata->slot[slot_id].detect_is_active_high =
>  			of_property_read_bool(cnp, "cd-inverted");

I believe it would be better to have this quirk be handled in
gpiolib-of.c where you would set up polarity of gpiod properly, and then
in this driver you would not need to bother with using raw API and
handle polarity yourself.

> @@ -646,7 +649,10 @@ atmci_of_init(struct platform_device *pdev)
>  			of_property_read_bool(cnp, "non-removable");
>  
>  		pdata->slot[slot_id].wp_pin =
> -			of_get_named_gpio(cnp, "wp-gpios", 0);
> +			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
> +					      "wp", GPIOD_IN, "wp-gpios");
> +		if (IS_ERR(pdata->slot[slot_id].wp_pin))
> +			pdata->slot[slot_id].wp_pin = NULL;
>  	}
>  
>  	return pdata;
> @@ -1509,8 +1515,8 @@ static int atmci_get_ro(struct mmc_host *mmc)
>  	int			read_only = -ENOSYS;
>  	struct atmel_mci_slot	*slot = mmc_priv(mmc);
>  
> -	if (gpio_is_valid(slot->wp_pin)) {
> -		read_only = gpio_get_value(slot->wp_pin);
> +	if (slot->wp_pin) {
> +		read_only = gpiod_get_value(slot->wp_pin);
>  		dev_dbg(&mmc->class_dev, "card is %s\n",
>  				read_only ? "read-only" : "read-write");
>  	}
> @@ -1523,8 +1529,8 @@ static int atmci_get_cd(struct mmc_host *mmc)
>  	int			present = -ENOSYS;
>  	struct atmel_mci_slot	*slot = mmc_priv(mmc);
>  
> -	if (gpio_is_valid(slot->detect_pin)) {
> -		present = !(gpio_get_value(slot->detect_pin) ^
> +	if (slot->detect_pin) {
> +		present = !(gpiod_get_raw_value(slot->detect_pin) ^
>  			    slot->detect_is_active_high);
>  		dev_dbg(&mmc->class_dev, "card is %spresent\n",
>  				present ? "" : "not ");
> @@ -1637,8 +1643,8 @@ static void atmci_detect_change(struct timer_list *t)
>  	if (test_bit(ATMCI_SHUTDOWN, &slot->flags))
>  		return;
>  
> -	enable_irq(gpio_to_irq(slot->detect_pin));
> -	present = !(gpio_get_value(slot->detect_pin) ^
> +	enable_irq(gpiod_to_irq(slot->detect_pin));
> +	present = !(gpiod_get_raw_value(slot->detect_pin) ^
>  		    slot->detect_is_active_high);
>  	present_old = test_bit(ATMCI_CARD_PRESENT, &slot->flags);
>  
> @@ -2237,9 +2243,9 @@ static int atmci_init_slot(struct atmel_mci *host,
>  	dev_dbg(&mmc->class_dev,
>  	        "slot[%u]: bus_width=%u, detect_pin=%d, "
>  		"detect_is_active_high=%s, wp_pin=%d\n",
> -		id, slot_data->bus_width, slot_data->detect_pin,
> +		id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
>  		slot_data->detect_is_active_high ? "true" : "false",
> -		slot_data->wp_pin);
> +		desc_to_gpio(slot_data->wp_pin));
>  
>  	mmc->ops = &atmci_ops;
>  	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
> @@ -2275,31 +2281,24 @@ static int atmci_init_slot(struct atmel_mci *host,
>  
>  	/* Assume card is present initially */
>  	set_bit(ATMCI_CARD_PRESENT, &slot->flags);
> -	if (gpio_is_valid(slot->detect_pin)) {
> -		if (devm_gpio_request(&host->pdev->dev, slot->detect_pin,
> -				      "mmc_detect")) {
> -			dev_dbg(&mmc->class_dev, "no detect pin available\n");
> -			slot->detect_pin = -EBUSY;
> -		} else if (gpio_get_value(slot->detect_pin) ^
> -				slot->detect_is_active_high) {
> +	if (slot->detect_pin) {
> +		if (gpiod_get_raw_value(slot->detect_pin) ^
> +		    slot->detect_is_active_high) {
>  			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
>  		}
> +	} else {
> +		dev_dbg(&mmc->class_dev, "no detect pin available\n");
>  	}
>  
> -	if (!gpio_is_valid(slot->detect_pin)) {
> +	if (!slot->detect_pin) {
>  		if (slot_data->non_removable)
>  			mmc->caps |= MMC_CAP_NONREMOVABLE;
>  		else
>  			mmc->caps |= MMC_CAP_NEEDS_POLL;
>  	}
>  
> -	if (gpio_is_valid(slot->wp_pin)) {
> -		if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
> -				      "mmc_wp")) {
> -			dev_dbg(&mmc->class_dev, "no WP pin available\n");
> -			slot->wp_pin = -EBUSY;
> -		}
> -	}
> +	if (!slot->wp_pin)
> +		dev_dbg(&mmc->class_dev, "no WP pin available\n");
>  
>  	host->slot[id] = slot;
>  	mmc_regulator_get_supply(mmc);
> @@ -2309,18 +2308,18 @@ static int atmci_init_slot(struct atmel_mci *host,
>  		return ret;
>  	}
>  
> -	if (gpio_is_valid(slot->detect_pin)) {
> +	if (slot->detect_pin) {
>  		timer_setup(&slot->detect_timer, atmci_detect_change, 0);
>  
> -		ret = request_irq(gpio_to_irq(slot->detect_pin),
> -				atmci_detect_interrupt,
> -				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> -				"mmc-detect", slot);
> +		ret = request_irq(gpiod_to_irq(slot->detect_pin),
> +				  atmci_detect_interrupt,
> +				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +				  "mmc-detect", slot);
>  		if (ret) {
>  			dev_dbg(&mmc->class_dev,
>  				"could not request IRQ %d for detect pin\n",
> -				gpio_to_irq(slot->detect_pin));
> -			slot->detect_pin = -EBUSY;
> +				gpiod_to_irq(slot->detect_pin));
> +			slot->detect_pin = NULL;
>  		}
>  	}
>  
> @@ -2339,10 +2338,8 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>  
>  	mmc_remove_host(slot->mmc);
>  
> -	if (gpio_is_valid(slot->detect_pin)) {
> -		int pin = slot->detect_pin;
> -
> -		free_irq(gpio_to_irq(pin), slot);
> +	if (slot->detect_pin) {
> +		free_irq(gpiod_to_irq(slot->detect_pin), slot);
>  		del_timer_sync(&slot->detect_timer);
>  	}
>  
> diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
> index 1491af38cc6e..017e7d8f6126 100644
> --- a/include/linux/atmel-mci.h
> +++ b/include/linux/atmel-mci.h
> @@ -26,8 +26,8 @@
>   */
>  struct mci_slot_pdata {
>  	unsigned int		bus_width;
> -	int			detect_pin;
> -	int			wp_pin;
> +	struct gpio_desc        *detect_pin;
> +	struct gpio_desc	*wp_pin;
>  	bool			detect_is_active_high;
>  	bool			non_removable;
>  };
> -- 
> 2.25.1
> 

Additionally, I think you can remove handling of the static platform
data as I do not believe anyone is using it in the mainline, as well as
switch to generic device properties instead of using of_*() APIs.

Thanks.

-- 
Dmitry
