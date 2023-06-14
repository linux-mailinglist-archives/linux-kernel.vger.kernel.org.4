Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEE72FF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbjFNNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjFNNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:04:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6786A1BC3;
        Wed, 14 Jun 2023 06:04:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66577752f05so2657962b3a.0;
        Wed, 14 Jun 2023 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686747857; x=1689339857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sw1gB+vCV+Osid5cBqyQVazdg28STr+FplDdL8t5QI=;
        b=efChFDGVrkrkAf8nrrUyDUFwfpKZVgwX4p7wfS2WFgAEee/AA1ZgbWvvxXVZQvMq+y
         koHDVZ+Y2ZPakxbS8v2RoBE44fcYCO+IW1y1y5C4Ph7iwyIQzp7oRa/Xhu7f8Pg96pua
         azQkK75cKB/lQB1I+ExajBBlsopLPPRyXLMGVRqwzDg65yECUwRnZgF68K70uAGi+l5a
         ZoFsZtB6P8iuIkRtHrY6xdLH1Ehwp9Y5wVbu5gY/vAgmN4NwJ1IyQiovZ6muSUbVCggK
         Zr12bGFMafMF0lj/91KueJocOPtqnu7uoUB17YZb1HO+Y1abnxy/HQxeQukd6l+f+DyB
         lm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747857; x=1689339857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Sw1gB+vCV+Osid5cBqyQVazdg28STr+FplDdL8t5QI=;
        b=OhCvZohWtKm/u0mIihtV4mwmvfmkFIPRyJZ7AP3VpVP2syXtMpoLPDtUugBdIB6Ds6
         i4uM2P0sH4r/0o1ughdUYfPLMBzBDEdYSAo572xo+RP/GSaAHR2w4Msc73KQrRvKkBjY
         P7+23pVJBdbMCVkT7CnNU4wFCR44jEe7srEQgHOKc/ikUOQc5U9z6Cps7dFd/Hw99kpN
         9aENIa6ImV2ZtBFMqK/ZvwssAkdKCqBXryqp2MC6pvxoDzMAl6Yl8CFMRtar57nV8wmw
         u/afw6bdxx/7a7prPxdj3zb8eVCReXXz1wp1lduMdUzaqMoNw6jwvyWVdGickOtM0AdB
         HDcw==
X-Gm-Message-State: AC+VfDwWQ68T6XAcgZVdeeBaQ4YxsajouujplvxITjasN6y24vfPEXkh
        gAmTiDqJBaNgpjMNK3SZK0AMP8+bDuw=
X-Google-Smtp-Source: ACHHUZ4T9N2RvYxZvTlMDI4bVpDD81pW5pNqQGYji3xmazcmDcuqMFG00xknptCDkzeAkUV+6wHNPw==
X-Received: by 2002:a05:6a21:789a:b0:114:c11c:7ad5 with SMTP id bf26-20020a056a21789a00b00114c11c7ad5mr2157252pzc.52.1686747856126;
        Wed, 14 Jun 2023 06:04:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2-20020a056a00270200b005d22639b577sm2128723pfv.165.2023.06.14.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:04:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7594a5cd-9ef1-4093-20e3-b824cb91194d@roeck-us.net>
Date:   Wed, 14 Jun 2023 06:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] hwmon: (sht3x)add new non-stardard sysfs interface
Content-Language: en-US
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DB4PR10MB6261C3FAA8B183F94B007163925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <DB4PR10MB6261C3FAA8B183F94B007163925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On 6/13/23 23:28, JuenKit Yip wrote:
> add "repeatability" interface to sysfs, it could be
> read or written to control the sensor.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>   Documentation/hwmon/sht3x.rst |  7 +++++++
>   drivers/hwmon/sht3x.c         | 29 +++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index 2c87c8f58..3dc4b9c14 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -83,4 +83,11 @@ heater_enable:      heater enable, heating element removes excess humidity from
>   update_interval:    update interval, 0 for single shot, interval in msec
>   		    for periodic measurement. If the interval is not supported
>   		    by the sensor, the next faster interval is chosen
> +repeatability:      write or read repeatability, the higher repeatability means
> +                    the longer measurement duration, the lower noise level and
> +                    the larger energy consumption:

s/the//g

> +
> +                        - 0: low repeatability
> +                        - 1: medium repeatability
> +                        - 2: high repeatability
>   =================== ============================================================
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index eb968b9d3..209090a48 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -642,6 +642,33 @@ static ssize_t update_interval_store(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t repeatability_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct sht3x_data *data = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", data->repeatability);
> +}
> +
> +static ssize_t repeatability_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t count)
> +{
> +	u8 val;
> +	struct sht3x_data *data = dev_get_drvdata(dev);
> +
> +	val = kstrtou8(buf, 0, &val);
> +	if (val)
> +		return val;

You need a separate ret variable with type int.

> +
> +	val = clamp_val(val, low_repeatability, high_repeatability);

This should not be clamped; the accepted values are well defined,
and this is not a range.

> +	data->repeatability = val;
> +
> +	return count;
> +}
> +
>   static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
>   static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
>   static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
> @@ -658,6 +685,7 @@ static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
>   static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
>   static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
>   static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
> +static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
>   
>   static struct attribute *sht3x_attrs[] = {
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
> @@ -674,6 +702,7 @@ static struct attribute *sht3x_attrs[] = {
>   	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
>   	&sensor_dev_attr_heater_enable.dev_attr.attr,
>   	&sensor_dev_attr_update_interval.dev_attr.attr,
> +	&sensor_dev_attr_repeatability.dev_attr.attr,
>   	NULL
>   };
>   

