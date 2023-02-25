Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BB6A2AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBYRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:07:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471710ABA;
        Sat, 25 Feb 2023 09:07:12 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bi17so2020492oib.3;
        Sat, 25 Feb 2023 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnB5gujaVnqBoC9xX9EZBRVvHCjUNdsJN9CYSYynhMU=;
        b=SDMyW4qDukwZFMcU5CQNRAdfiXi0lbT7F4EhbSZMS9xvHQc76yxbx7UZp+hUgE/0IX
         e21i5b7yCa+nwA+ShZPj/fFsFG3Ig2uJyuWubrkRWxmZ05GHhzlRfqKgAdfFYmLSgps6
         t4eiwRl2vtvX5PLCYydUDmxmlkWcNltTVM9IsXh/7BQONvqQkn7Gfle9iADCmxodnTW9
         bbIO+oDQC+wAG5wEUQSUhP+cmvm6qvxSAxDUpuJCDdUGWcaK8+fQG8xmdneI1jNadhs7
         f+LsbAjYsFTs5slCQjT3lI2dKBR5oLY1ddkwGO2viE4FvHMBS7e0sLvXPFSrldHQiyCk
         V6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnB5gujaVnqBoC9xX9EZBRVvHCjUNdsJN9CYSYynhMU=;
        b=1Ql0vSjwlncOb2848GZ34JADvdxDcB5OYv9zbxKb2sRjDOXJDqjvg7q2hVmMrLhG3b
         px0J1JLgLd+IdkvdB9OP9jEScO+LgDzb7BDWNAsS8EDqxFwKdVNpZIc/l5ZIR67ruQDE
         1v3tHRv3tZBcveroBpWLrsmR7hAV0ge4TqJnmndAB8kOdh0MKIqHWbCwbY3M0+tG82Qk
         rUbnkOobbIKQ206Z8ll/kXLxX98wIpELqk4KCnkca8dLNy484dmHg0hB/jQwZpyaKfjt
         Hv4Dba1Ok7FNMxbT/GSgDellLWQ58RUzB8DNxiscpul9LJ/oVVecQKZEiYcuC/iU04hc
         jCpw==
X-Gm-Message-State: AO0yUKVHjU86SsI7YslDzIGnOz0/WGq8akZaByiJyL07lVrGMZZwMinu
        zseBOCJ3mTKIf5svhXZotbM=
X-Google-Smtp-Source: AK7set+82KW0G5rNagd+LFTsfSeMjj+S09cUq48u546rV0mTqnu8fBLCeWkKeWhUiceVxjxA5aabJA==
X-Received: by 2002:a05:6808:319:b0:37f:83cb:8e92 with SMTP id i25-20020a056808031900b0037f83cb8e92mr8702983oie.57.1677344830443;
        Sat, 25 Feb 2023 09:07:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12-20020a9d038c000000b0068bd3001922sm788156otf.45.2023.02.25.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 09:07:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 09:07:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] hwmon: (pmbus/core) Generalise pmbus get status
Message-ID: <20230225170708.GA3995447@roeck-us.net>
References: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
 <20230217083631.657430-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217083631.657430-2-Naresh.Solanki@9elements.com>
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

On Fri, Feb 17, 2023 at 09:36:29AM +0100, Naresh Solanki wrote:
> Add function pmbus get status that can be used to get both pmbus
> specific status & regulator status
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ...
> Changes in V3:
> - Add pmbus_is_enabled function
> Changes in V2:
> - Add __maybe attribute for pmbus_get_status function
> - Remove unrelated changes
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 98 ++++++++++++++++++++------------
>  1 file changed, 62 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 1b70cf3be313..f8ac9016ea0e 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2735,18 +2735,12 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>  	},
>  };
>  
> -#if IS_ENABLED(CONFIG_REGULATOR)
> -static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
> +static int _pmbus_is_enabled(struct device *dev, u8 page)
>  {
> -	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
>  	int ret;
>  
> -	mutex_lock(&data->update_lock);
>  	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> -	mutex_unlock(&data->update_lock);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -2754,58 +2748,38 @@ static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>  	return !!(ret & PB_OPERATION_CONTROL_ON);
>  }
>  
> -static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
> +static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
>  {
> -	struct device *dev = rdev_get_dev(rdev);
>  	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
>  	int ret;
>  
>  	mutex_lock(&data->update_lock);
> -	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
> -				     PB_OPERATION_CONTROL_ON,
> -				     enable ? PB_OPERATION_CONTROL_ON : 0);
> +	ret = _pmbus_is_enabled(dev, page);
>  	mutex_unlock(&data->update_lock);
>  
> -	return ret;
> -}
> -
> -static int pmbus_regulator_enable(struct regulator_dev *rdev)
> -{
> -	return _pmbus_regulator_on_off(rdev, 1);
> -}
> -
> -static int pmbus_regulator_disable(struct regulator_dev *rdev)
> -{
> -	return _pmbus_regulator_on_off(rdev, 0);
> +	return !!(ret & PB_OPERATION_CONTROL_ON);
>  }
>  
> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
>  {
>  	int i, status;
>  	const struct pmbus_status_category *cat;
>  	const struct pmbus_status_assoc *bit;
> -	struct device *dev = rdev_get_dev(rdev);
> -	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
> +	struct device *dev = data->dev;
> +	struct i2c_client *client = to_i2c_client(dev);
>  	int func = data->info->func[page];
>  
>  	*flags = 0;
>  
> -	mutex_lock(&data->update_lock);
> -
>  	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
>  		cat = &pmbus_status_flag_map[i];
>  		if (!(func & cat->func))
>  			continue;
>  
>  		status = _pmbus_read_byte_data(client, page, cat->reg);
> -		if (status < 0) {
> -			mutex_unlock(&data->update_lock);
> +		if (status < 0)
>  			return status;
> -		}
>  
>  		for (bit = cat->bits; bit->pflag; bit++) {
>  			if (status & bit->pflag)
> @@ -2823,11 +2797,10 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	 * REGULATOR_ERROR_<foo>_WARN.
>  	 */
>  	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> -	mutex_unlock(&data->update_lock);
>  	if (status < 0)
>  		return status;
>  
> -	if (pmbus_regulator_is_enabled(rdev)) {
> +	if (_pmbus_is_enabled(dev, page)) {
>  		if (status & PB_STATUS_OFF)
>  			*flags |= REGULATOR_ERROR_FAIL;
>  
> @@ -2855,6 +2828,59 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->update_lock);
> +	ret = _pmbus_get_flags(data, page, flags);
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_REGULATOR)
> +static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	return pmbus_is_enabled(rdev_get_dev(rdev), rdev_get_id(rdev));
> +}
> +
> +static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int ret;
> +
> +	mutex_lock(&data->update_lock);
> +	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
> +				     PB_OPERATION_CONTROL_ON,
> +				     enable ? PB_OPERATION_CONTROL_ON : 0);
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +static int pmbus_regulator_enable(struct regulator_dev *rdev)
> +{
> +	return _pmbus_regulator_on_off(rdev, 1);
> +}
> +
> +static int pmbus_regulator_disable(struct regulator_dev *rdev)
> +{
> +	return _pmbus_regulator_on_off(rdev, 0);
> +}
> +
> +static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +
> +	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
> +}
> +
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>  {
>  	struct device *dev = rdev_get_dev(rdev);
