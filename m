Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A344658DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiL2O0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiL2O0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:26:10 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3976E0A8;
        Thu, 29 Dec 2022 06:26:07 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id j130so11619243oif.4;
        Thu, 29 Dec 2022 06:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu2i+yqAuTpsosJSjE8BjQ/j8yCFJ6AF+GvsZ04xxRY=;
        b=WZ/aiULlHgKhCNIC2gvA+k7OyG1HotluR0o3Ig1QNlRPvj74h7umpuZPUhvcZCs9cp
         jrBpgHKYcwGgdNLUi30Sq0BcTN6O4sltMtRrqJVyXY/DHiCnlhov+WdTpHm6kq+922fM
         zPWcUUjsluax0vcbNREv68sbMrGD74zwPVrNM5YIJblQqA0z9BG0PvV3kvTUoirMrFck
         f9Obx4fn4wKSDqi08eiqEtyOGV47h0773mjcTyFDldRZoD2n+hzmwYMrxhdSsXI3cxI2
         pDDESHTalyUTYosGGIES+O36PgeYzhWb0OkMsgKlUvVf9UQml5xcBQVHIfQYCMJPoXdQ
         1d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu2i+yqAuTpsosJSjE8BjQ/j8yCFJ6AF+GvsZ04xxRY=;
        b=lG0PZyg7FsDrXJz6nCVKnx9Tb+kKxiC9kQkSxobYrwZ3svZzm6LLXisv5rqNBT8SL6
         9NstkhzMOvMZTYl+w8oyUFE3NWDZZhEqa/pbAYysI2q6PtqsEv/lmZ8T/0nYbF9NqXga
         uX3ug8nY+MVS8aCeSfdt8vWxGyiNmDAvDobaX6/DbiNsSzkArdXy1zwMVCA7nLpFjC37
         HzEVn12a1+oiqsDwShu+00BMIUOMZcXvpnj68NAU5KsKxl69G79/bYDkdksy9aTzjBdn
         wyCwh01gS5+Ql5jyYh/bhz971Yu/GeUHjorp1ixdmVzFSJ2E4AzyZXbOanVtphBAXwmq
         gIfA==
X-Gm-Message-State: AFqh2krpi+hBPl610dKNWwxyKaDIGD+kRoDgdY0kIl2jBdZ13CCNGAPv
        GAiLR79PcJufclHEYfuEUjI5dryUKtM=
X-Google-Smtp-Source: AMrXdXul0FfiL51kGC1BF3UBOu+y2T89lKbLnMENTSBBRzlZ2FXOTvjmcCVTs6rs+znhrUrOdca5cw==
X-Received: by 2002:a05:6808:3af:b0:360:ea74:b6b9 with SMTP id n15-20020a05680803af00b00360ea74b6b9mr12937155oie.37.1672323967066;
        Thu, 29 Dec 2022 06:26:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be15-20020a056808218f00b0035e7c48d08esm8148585oib.15.2022.12.29.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:26:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:26:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (ftsteutates) Fix scaling of measurements
Message-ID: <20221229142605.GA20427@roeck-us.net>
References: <20221224041855.83981-1-W_Armin@gmx.de>
 <20221224041855.83981-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224041855.83981-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 05:18:53AM +0100, Armin Wolf wrote:
> A user complained that the ftsteutates driver was displaying
> bogus values since its introduction. This happens because the
> sensor measurements need to be scaled in order to produce
> meaningful results:
> - the fan speed needs to be multiplied by 60 since its in RPS
> - the temperature is in degrees celsius and needs an offset of 64
> - the voltage is in 1/256 of 3.3V
> 
> The offical datasheet says the voltage needs to be divided by 256,
> but this is likely an off-by-one-error, since even the BIOS
> devides by 255 (otherwise 3.3V could not be measured).
> 
> The voltage channels additionally need a board-specific multiplier,
> however this can be done by the driver since its board-specific.
> 
> The reason the missing scaling of measurements is the way Fujitsu
> used this driver when it was still out-of-tree. Back then, all
> scaling was done in userspace by libsensors, even the generic one.
> 
> Tested on a Fujitsu DS3401-B1.
> 
> Fixes: 08426eda58e0 ("hwmon: Add driver for FTS BMC chip "Teutates"")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/ftsteutates.rst |  4 ++++
>  drivers/hwmon/ftsteutates.c         | 19 +++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/ftsteutates.rst
> index 58a2483d8d0d..198fa8e2819d 100644
> --- a/Documentation/hwmon/ftsteutates.rst
> +++ b/Documentation/hwmon/ftsteutates.rst
> @@ -22,6 +22,10 @@ enhancements. It can monitor up to 4 voltages, 16 temperatures and
>  8 fans. It also contains an integrated watchdog which is currently
>  implemented in this driver.
> 
> +The 4 voltages require a board-specific multiplier, since the BMC can
> +only measure voltages up to 3.3V and thus relies on voltage dividers.
> +Consult your motherboard manual for details.
> +
>  To clear a temperature or fan alarm, execute the following command with the
>  correct path to the alarm file::
> 
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index f5b8e724a8ca..ffa0bb364877 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -12,6 +12,7 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> @@ -347,13 +348,15 @@ static ssize_t in_value_show(struct device *dev,
>  {
>  	struct fts_data *data = dev_get_drvdata(dev);
>  	int index = to_sensor_dev_attr(devattr)->index;
> -	int err;
> +	int value, err;
> 
>  	err = fts_update_device(data);
>  	if (err < 0)
>  		return err;
> 
> -	return sprintf(buf, "%u\n", data->volt[index]);
> +	value = DIV_ROUND_CLOSEST(data->volt[index] * 3300, 255);
> +
> +	return sprintf(buf, "%d\n", value);
>  }
> 
>  static ssize_t temp_value_show(struct device *dev,
> @@ -361,13 +364,15 @@ static ssize_t temp_value_show(struct device *dev,
>  {
>  	struct fts_data *data = dev_get_drvdata(dev);
>  	int index = to_sensor_dev_attr(devattr)->index;
> -	int err;
> +	int value, err;
> 
>  	err = fts_update_device(data);
>  	if (err < 0)
>  		return err;
> 
> -	return sprintf(buf, "%u\n", data->temp_input[index]);
> +	value = (data->temp_input[index] - 64) * 1000;
> +
> +	return sprintf(buf, "%d\n", value);
>  }
> 
>  static ssize_t temp_fault_show(struct device *dev,
> @@ -436,13 +441,15 @@ static ssize_t fan_value_show(struct device *dev,
>  {
>  	struct fts_data *data = dev_get_drvdata(dev);
>  	int index = to_sensor_dev_attr(devattr)->index;
> -	int err;
> +	int value, err;
> 
>  	err = fts_update_device(data);
>  	if (err < 0)
>  		return err;
> 
> -	return sprintf(buf, "%u\n", data->fan_input[index]);
> +	value = data->fan_input[index] * 60;
> +
> +	return sprintf(buf, "%d\n", value);
>  }
> 
>  static ssize_t fan_source_show(struct device *dev,
