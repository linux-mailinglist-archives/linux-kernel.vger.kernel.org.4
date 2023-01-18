Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB7671EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjAROIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAROHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:07:35 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946ACA732C;
        Wed, 18 Jan 2023 05:43:42 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p185so7526700oif.2;
        Wed, 18 Jan 2023 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I17OzmZtLqMo8ET5jlEammDd0U/M5km1yFXfGeGmi8I=;
        b=q7tGkRH5NIVOqqCXE+btX6WNLgFmVxuQJf/djr2FjaUVrqMYrmH2uwbF/r/5X+Iq8p
         Pdci3xkbi9IOnkt1CJL7HLvNgIK7U7xBjYEDwv0uWeCvJxsdKeY3t8BmhJMwk1f73++X
         6lqCJRbCVQnCYzkWrpHYw6OXcP87aIS3Q5T8ARZ+jciZd+X83v4A4cnRiaIiy9Vc7MAg
         OEZgQTtMFlCAG7zO+npybi+sZdIqB+rKisouOAKTIAFo+g1/wlBqCS4lFO2iQpQkcwSF
         zo80a37qk5ncQpg78AgEA+HUp91hn7mdRM9slWrX+6Xw6XEtr51TS1v2r/v9nu8vSj5K
         rXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I17OzmZtLqMo8ET5jlEammDd0U/M5km1yFXfGeGmi8I=;
        b=h8yzT/sG2/k5bv8vzyGSlpa73ETPKU9QjtlX5EQXEF+aYCmrQyOFYO+B1Up93VLgxC
         Y6NGBj62Bv2h0KoLE2Dt1fymnD6NYu63lilhpAKsiZUq6GkKxOiUXuJ2Va7G5fQ8xBin
         zw5pdMXMGEAied7oGk9HLtA8Zzis3GnOor9SIXbNsOXT4r/T89PYFpY4EO00/4RNATF8
         OA5yhGnJdzCBVneC01+kaoOjMg9xLVwvPrOxzMIBHQ1GHjAEVLxdMVS3+tkiruLa0Nwp
         sNGOHPh1T67JYCH7DILhmUU62E9jyy/z/RiJhJuYVRiUSS1wYm20T4EQ5/eYhXtDOKE7
         HZyw==
X-Gm-Message-State: AFqh2kqVIoayxxtlsGRESGBN73/AXWlY6jrVeOglvwZ4pEZEiqywhEa1
        DGhu9iJapwv9TRwyDDLEH+4CP5zcRG8=
X-Google-Smtp-Source: AMrXdXsiex4vRLUCJZaTwr5Ec7Cgd9e/38R7LfMnAyunSDDfqlUcLrTrkD2j6Q9LeW/wLG9QeiRtEA==
X-Received: by 2002:aca:191a:0:b0:368:7897:cbd0 with SMTP id l26-20020aca191a000000b003687897cbd0mr2839334oii.12.1674049421823;
        Wed, 18 Jan 2023 05:43:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c38-20020a05683034a600b00684b8ddde9asm11116790otu.18.2023.01.18.05.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:43:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f9a47a1a-dcce-87e1-be4e-4f62f8e60c78@roeck-us.net>
Date:   Wed, 18 Jan 2023 05:43:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] hwmon: (pmbus/core): Generalize pmbus status flag map
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118111536.3276540-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230118111536.3276540-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 03:15, Naresh Solanki wrote:
> Move the PMBus status flag map (pmbus_regulator_status_flag_map)
> outside of the regulator #if block and update the associated
> variable/struct name to reflect a generic PMBus status. Also retain
> the regulator error flag for use in determining regulator specific error.
> 
> This will make the PMBus status flag map more versatile and easier to
> incorporate into different contexts and functions.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Sorry, I don't see the point of moving a structure including
regulator error codes outside regulator code.

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 94 ++++++++++++++++----------------
>   1 file changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..1b70cf3be313 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2692,6 +2692,49 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	return 0;
>   }
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
>   #if IS_ENABLED(CONFIG_REGULATOR)
>   static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>   {
> @@ -2738,54 +2781,11 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>   	return _pmbus_regulator_on_off(rdev, 0);
>   }
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
>   static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>   {
>   	int i, status;
> -	const struct pmbus_regulator_status_category *cat;
> -	const struct pmbus_regulator_status_assoc *bit;
> +	const struct pmbus_status_category *cat;
> +	const struct pmbus_status_assoc *bit;
>   	struct device *dev = rdev_get_dev(rdev);
>   	struct i2c_client *client = to_i2c_client(dev->parent);
>   	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2796,8 +2796,8 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>   
>   	mutex_lock(&data->update_lock);
>   
> -	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
> -		cat = &pmbus_regulator_flag_map[i];
> +	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
> +		cat = &pmbus_status_flag_map[i];
>   		if (!(func & cat->func))
>   			continue;
>   
> 
> base-commit: 774dccfe77dcd8cf1d82df1f61fe95a720dc76e4

