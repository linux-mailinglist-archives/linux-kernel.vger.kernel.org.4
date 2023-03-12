Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6C6B68DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCLRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:41:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F287827996;
        Sun, 12 Mar 2023 10:41:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso5604229otf.2;
        Sun, 12 Mar 2023 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678642901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OPe+hKS1Y2/EkSSm93WmjLychI3l8gkOtiq8RUcW+w=;
        b=N2mtc53F5N4ecgdTxhrXMwvmbbJXUMeemib6F7odrbvWRQGmsre2RTpSO8yYIah597
         cgvXLAeFpNq4uHtyh32FvSGNi7uSGh7HO4+xkvgDmRsZ53dowEv8wHIUcW9WuSNfdYGB
         DYoSSz9AnyVuPM3TABHR7KxGteDEujUcfIRQOiwabZ/8raH4veCiI6yG0KtcCTm6jEcs
         gYmYeOhuzGl26vBVvXdsKLEwTgufoRgJ45sG8aZojOO0tT8JdDfBan+tFrHA58aGQSGu
         HRPirn6f17neKRh/KP8yM8dPmwEKO8OfOZIDZCw4XDC52bArosv11+tdlGzl2qDOmd3Q
         MOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OPe+hKS1Y2/EkSSm93WmjLychI3l8gkOtiq8RUcW+w=;
        b=Yf8y+1+98UTwgiW8X5Iv1r9kzEIr1jOTbOMp+8IqiChWUYNBR9SkVkBPEjR8uMYbF9
         TGNOs3l2nXVK48O7k/S+5wgBuCeJ8rvZBBnz8IpNQfhwU21E+In7vtYzyTWFdxn0d9W0
         RDNNJp528zNuJjOJM5FaDeDu7d2GGArM5KMEycTu21CNT/1AZuv1xkgF2GxkZiR8O2vS
         QwztYSPuSc7gPwkh1K9sN92EudwCNf6jC7IS6hDEbKrzLNQgHwTSPhwDLps4gYglI2Nd
         kAYVBOi3LxdRoQ11PLYFJZarYLc/HSmE1CZXiypXYPvsy5JiznJI2x6Ts+g2GIr6c2Cl
         Y2gw==
X-Gm-Message-State: AO0yUKXMt3qz3mLzWVomBiDJnuKwzP3b+DS0Ihr+DcV4hY+NUYPpNo0B
        0cAIRQaPSAjqCb3SEwBzh9s=
X-Google-Smtp-Source: AK7set+9tM0uAtRw21QnC9kZAHr5vy4WmqxoF/4Gum7zuKRaAEVDgXdllDyGU0v0aaRQwN/IjvpPxg==
X-Received: by 2002:a9d:610:0:b0:694:359e:b9c8 with SMTP id 16-20020a9d0610000000b00694359eb9c8mr16190522otn.22.1678642901228;
        Sun, 12 Mar 2023 10:41:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020a9d6e95000000b0068bb73bd95esm2322426otr.58.2023.03.12.10.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:41:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:41:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] hwmon: (aquacomputer_d5next) Support one byte
 control values
Message-ID: <e460edb5-813b-4d37-867b-3d383c84a1c6@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-2-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-2-leonard.anderweit@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:02:16PM +0100, Leonard Anderweit wrote:
> Add support for one byte control values. This extends aqc_set_ctrl_val() and
> aqc_get_ctrl_val() with a type. Currently supported types are AQC_8 (one byte)
> and AQC_BE16 (two bytes big endian). More types will be added in the future.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Applied. In the future, please make sure that the line length in the
description has no more than 75 columns.

Thanks,
Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 48 +++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 12682a610ce7..babfd998e70c 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -70,6 +70,10 @@ static u8 secondary_ctrl_report[] = {
>  /* Report IDs for legacy devices */
>  #define POWERADJUST3_STATUS_REPORT_ID	0x03
>  
> +/* Data types for reading and writing control reports */
> +#define AQC_8		0
> +#define AQC_BE16	1
> +
>  /* Info, sensor sizes and offsets for most Aquacomputer devices */
>  #define AQC_SERIAL_START		0x3
>  #define AQC_FIRMWARE_VERSION		0xD
> @@ -544,7 +548,7 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>  }
>  
>  /* Refreshes the control buffer and stores value at offset in val */
> -static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
> +static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val, int type)
>  {
>  	int ret;
>  
> @@ -554,14 +558,23 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
>  	if (ret < 0)
>  		goto unlock_and_return;
>  
> -	*val = (s16)get_unaligned_be16(priv->buffer + offset);
> +	switch (type) {
> +	case AQC_BE16:
> +		*val = (s16)get_unaligned_be16(priv->buffer + offset);
> +		break;
> +	case AQC_8:
> +		*val = priv->buffer[offset];
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
>  
>  unlock_and_return:
>  	mutex_unlock(&priv->mutex);
>  	return ret;
>  }
>  
> -static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
> +static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
>  {
>  	int ret;
>  
> @@ -571,7 +584,19 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
>  	if (ret < 0)
>  		goto unlock_and_return;
>  
> -	put_unaligned_be16((s16)val, priv->buffer + offset);
> +	switch (type) {
> +	case AQC_BE16:
> +		put_unaligned_be16((s16)val, priv->buffer + offset);
> +		break;
> +	case AQC_8:
> +		priv->buffer[offset] = (u8)val;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		goto unlock_and_return;
>  
>  	ret = aqc_send_ctrl_data(priv);
>  
> @@ -775,7 +800,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		case hwmon_temp_offset:
>  			ret =
>  			    aqc_get_ctrl_val(priv, priv->temp_ctrl_offset +
> -					     channel * AQC_SENSOR_SIZE, val);
> +					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  
> @@ -791,7 +816,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  			*val = priv->speed_input[channel];
>  			break;
>  		case hwmon_fan_pulses:
> -			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
> +			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
> +					       val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -804,7 +830,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		break;
>  	case hwmon_pwm:
>  		if (priv->fan_ctrl_offsets) {
> -			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
> +			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
> +					       val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  
> @@ -877,7 +904,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  			val = clamp_val(val, -15000, 15000) / 10;
>  			ret =
>  			    aqc_set_ctrl_val(priv, priv->temp_ctrl_offset +
> -					     channel * AQC_SENSOR_SIZE, val);
> +					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -889,7 +916,8 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  		switch (attr) {
>  		case hwmon_fan_pulses:
>  			val = clamp_val(val, 10, 1000);
> -			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
> +			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
> +					       val, AQC_BE16);
>  			if (ret < 0)
>  				return ret;
>  			break;
> @@ -906,7 +934,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  					return pwm_value;
>  
>  				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
> -						       pwm_value);
> +						       pwm_value, AQC_BE16);
>  				if (ret < 0)
>  					return ret;
>  			}
