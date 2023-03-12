Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD46B68FB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCLRwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCLRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:52:36 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517A38012;
        Sun, 12 Mar 2023 10:52:35 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id o19-20020a056820041300b005259de79accso1523197oou.9;
        Sun, 12 Mar 2023 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9nRYGv4tBorP/efj26VPKlVruGkODO+tjVZuK8Uvw4=;
        b=ppHcF0j7NfL/G+3NO7W3rS+Ir5pKCS9+c+AKOi55t1L5iCG4J9uvp9x77pg9VShXaR
         0I9fQInLwGbkQFlir6RHMp5oqivbQv+uZyn3+8BKhZJ2Gih5gfrwZLxvLbLpRa2s3p10
         TbgTD9juIz2/SpunOgbTfM9m8n5qFK4aZH+C4BTo+6BKTHX8SDBD03iTnNwjqoFCLP1T
         T6Z7wc26KiyyOgOXrpyRDgojXM1cGav5GjF5+1C+U3+0Y4BYuVDD5B8rux0xqqo3FpdK
         62UgNvUnWNzG9Wku56i0f4HGKNs/1zGfgFb0C/P1fevCbT1SOMCgjdDtZ7bPESQzMiXj
         hw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9nRYGv4tBorP/efj26VPKlVruGkODO+tjVZuK8Uvw4=;
        b=1UAEOqSf4EBUB2MwcnIQSGHYEjcjAW9QRoNgU78iluMUDro1QQJdFKWlp/NJtX8mhC
         Lt9XkUkqDqpcKbqB14lO2zEf4UlQ3WF+UbxF91vucBvqNuWdcYZg1HoSGheFI1ZYLOyF
         PiRpGIC7yrI2RyNMzbVgvRKfmuuAiQih/I89exiNLoC0Uetu46YbA59dVDfVlupWBawC
         JjhyviFT0/Z5ypef3BCAPgcBe/gr9skOi4T0EWEWx6LaEWdleGz2Wzwfqbf1qhAVqEqW
         Shz4NbPHHUjn/ayOFIMKjEOHeEswdI+qqwYz8sbHGUsut3sd+DUYgkImzleAOX5ANvSf
         /mMA==
X-Gm-Message-State: AO0yUKVJ5wROnoRYm+nJB4T9DewXicZKSUGcwb0VxhYS2ilba66jvcxh
        UcsLWf65hFlsDO+HS1kTipE=
X-Google-Smtp-Source: AK7set9gjryrb+sQR894eTTfoJw2z/9R0XfafIS/6OehwKjSuYjEHfvqfiRqoXkye0VBIhGcV1OUeQ==
X-Received: by 2002:a4a:df0c:0:b0:51a:a89a:4be3 with SMTP id i12-20020a4adf0c000000b0051aa89a4be3mr12692558oou.9.1678643554737;
        Sun, 12 Mar 2023 10:52:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5-20020a4ab605000000b005253a5cc3cfsm2297511oon.29.2023.03.12.10.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:52:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:52:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] hwmon: (pmbus/core): Generalize pmbus status flag
 map
Message-ID: <c6906217-805f-46a1-8c59-f985ed137e26@roeck-us.net>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
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

On Wed, Mar 01, 2023 at 05:44:31PM +0100, Naresh Solanki wrote:
> The PMBus status flag map(pmbus_regulator_status_flag_map) is moved
> outside of the regulator #if block and the associated variable/struct
> name updated to reflect as generic PMBus status.
> 
> This will make the PMBus status flag map more versatile and easier to
> incorporate into different contexts and functions.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Note: checkpatch complains:

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Naresh Solanki <naresh.solanki@9elements.com>' != 'Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>'

Nitpicky, but please fix that for future patches.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 94 ++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 58326709e8f8122df46d29981eb39896d600c7c4
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..1b70cf3be313 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2692,6 +2692,49 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>  	return 0;
>  }
>  
> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> +struct pmbus_status_assoc {
> +	int pflag, rflag;
> +};
> +
> +/* PMBus->regulator bit mappings for a PMBus status register */
> +struct pmbus_status_category {
> +	int func;
> +	int reg;
> +	const struct pmbus_status_assoc *bits; /* zero-terminated */
> +};
> +
> +static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[] = {
> +	{
> +		.func = PMBUS_HAVE_STATUS_VOUT,
> +		.reg = PMBUS_STATUS_VOUT,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_IOUT,
> +		.reg = PMBUS_STATUS_IOUT,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> +			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> +			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> +			{ },
> +		},
> +	}, {
> +		.func = PMBUS_HAVE_STATUS_TEMP,
> +		.reg = PMBUS_STATUS_TEMPERATURE,
> +		.bits = (const struct pmbus_status_assoc[]) {
> +			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> +			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> +			{ },
> +		},
> +	},
> +};
> +
>  #if IS_ENABLED(CONFIG_REGULATOR)
>  static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>  {
> @@ -2738,54 +2781,11 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>  	return _pmbus_regulator_on_off(rdev, 0);
>  }
>  
> -/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
> -struct pmbus_regulator_status_assoc {
> -	int pflag, rflag;
> -};
> -
> -/* PMBus->regulator bit mappings for a PMBus status register */
> -struct pmbus_regulator_status_category {
> -	int func;
> -	int reg;
> -	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
> -};
> -
> -static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> -	{
> -		.func = PMBUS_HAVE_STATUS_VOUT,
> -		.reg = PMBUS_STATUS_VOUT,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
> -			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
> -			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
> -			{ },
> -		},
> -	}, {
> -		.func = PMBUS_HAVE_STATUS_IOUT,
> -		.reg = PMBUS_STATUS_IOUT,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> -			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> -			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> -			{ },
> -		},
> -	}, {
> -		.func = PMBUS_HAVE_STATUS_TEMP,
> -		.reg = PMBUS_STATUS_TEMPERATURE,
> -		.bits = (const struct pmbus_regulator_status_assoc[]) {
> -			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
> -			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
> -			{ },
> -		},
> -	},
> -};
> -
>  static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>  {
>  	int i, status;
> -	const struct pmbus_regulator_status_category *cat;
> -	const struct pmbus_regulator_status_assoc *bit;
> +	const struct pmbus_status_category *cat;
> +	const struct pmbus_status_assoc *bit;
>  	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2796,8 +2796,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  
>  	mutex_lock(&data->update_lock);
>  
> -	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
> -		cat = &pmbus_regulator_flag_map[i];
> +	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
> +		cat = &pmbus_status_flag_map[i];
>  		if (!(func & cat->func))
>  			continue;
>  
