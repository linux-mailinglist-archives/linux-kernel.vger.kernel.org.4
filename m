Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D86B68FD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCLRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCLRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:53:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AA34C22;
        Sun, 12 Mar 2023 10:53:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso5614576otr.5;
        Sun, 12 Mar 2023 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1KN410i4kPlnbAcLyJZqfc7GoJgxyUkm6SsvxRM8Ec=;
        b=i4yTkrMd5seKVEB4qbKHuGeak4H3SgQrKNdRdyO8GRZvmoHnkWzGnM7rGLBcYKkY/l
         BJRm3UCZBej7f9oNjDYCpgT7HIxoQlO31nKH/KHZmAqModoLeOvTYv6Zzl+FVzCIjZEm
         lIthnTHRVgEvUUM/mwLK0zyyriopRQ4mZtG1cOFRzHPGl+FLJZVO0GX8hcdCqbDYFL5w
         WcgidX5buVElN5yTACQFz7Z/oBrvRKvSuXgAZwXKHPBALyeet7pfVkFxllbI63WJHrRm
         u2hfd/bwRiRYkTMl0KaCz/DeRMMlLrhtDRTKGXX4VE9RjNAq2eYrA04C/fexGHPvb7aB
         0VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1KN410i4kPlnbAcLyJZqfc7GoJgxyUkm6SsvxRM8Ec=;
        b=oBIqnKwMxQOuKJTSMLOc8K5YCSNJ4yu09VYV12J+QcZQpT/R9uTbc7zW2rCIt4aBFd
         j5Wskjun7ys4iQl6Tt4sN5YKtcRYJuDxeMZFS81qL5roowz1v84yzwB80ciDjeheUQkh
         Eo5Z8nhbsd0qNxkKm/4cnROLh11S+Y9cvSuOp6MS/ewuin7MmJ7jNgi3ClPR9qb8Pl15
         RoGG+Juoig1i5TT+qizPPq3PkI17NqCMCQUVwLS/TkZIVT5f99mh9rvHFQYotNYpusEB
         HmbN6ScbGWg32xtZgbsfcm/8n54VAN++N+n25CGBxDt7xFKwnAjOT9g72m0ZNUE4Paf1
         mnVQ==
X-Gm-Message-State: AO0yUKXgInWVsgUG/jlynuU8NYKzvE3BrLwqpMlHMg/CtaKKUFu/fopC
        mBs4Iqy0t13JBsd3fa3071GDRlvPf9Y=
X-Google-Smtp-Source: AK7set+d/c/T/d4dlNACBRMdfqXNbe5e0nXjEnOGQMxLan3AeEPNWSU7eKgJ23uH64mxjWwXnVa6wQ==
X-Received: by 2002:a05:6830:716:b0:694:419f:4b2f with SMTP id y22-20020a056830071600b00694419f4b2fmr15088347ots.23.1678643632009;
        Sun, 12 Mar 2023 10:53:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k30-20020a9d4b9e000000b00690dd5e7345sm2378657otf.26.2023.03.12.10.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:53:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:53:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] hwmon: (pmbus/core) Generalise pmbus get status
Message-ID: <1bee51aa-e3f3-4089-9e31-26dcf82771ea@roeck-us.net>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
 <20230301164434.1928237-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301164434.1928237-2-Naresh.Solanki@9elements.com>
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

On Wed, Mar 01, 2023 at 05:44:32PM +0100, Naresh Solanki wrote:
> Add function pmbus get status that can be used to get both pmbus
> specific status & regulator status
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ...
> Change in V4
> - None
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
