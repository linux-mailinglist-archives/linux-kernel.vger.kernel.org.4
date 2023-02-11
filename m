Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F526931E5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBKPHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:07:54 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1025E08;
        Sat, 11 Feb 2023 07:07:52 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15f97c478a8so10228135fac.13;
        Sat, 11 Feb 2023 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oc8Oeui3K1tb0XrrtmwUkZ3knxpX/4Xz8AB8zRYwT74=;
        b=Ou+rBGt9DmvBAtwRnHGA4UyxE59kurGI2AULIOanzbE8AHzxg+UVbwaG6C5MY9VD89
         RqoNMQzAR8i0zblJsqL9boxtp2ZWefM5SNBInQIouoSSpqSOD4cYecqQyR6r0J7UHOhb
         kqfCARNLiWLg+ogqemIVOB5VlOE4Q10Pceqr/9kyLH3U4nVDiLA9s1xrcqkv3Ro2VVxx
         Tz4al1YgxAIyoJlIClLU3FfReX2v8IeoAMTkjtf70fyB3iXQjq5pkTzmbQQgN6mVswTv
         4wyfzLGS5zt6zSbnLaiE8sd7lFDS8vctrhR/ZEkD9K0Q77+rqRFfRN0EV1YEuFcWQOIz
         VOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc8Oeui3K1tb0XrrtmwUkZ3knxpX/4Xz8AB8zRYwT74=;
        b=rAqU7+sjLxRJ/X6xorYUAXNDZFQzGlD1kF1aNfhvb+BERA8/4lWcb8u9goWRlK3VhM
         XJ+5HTLI4cRAxKHsFEpLcL6Mr+aE/tVQ5XrKZn67hSyYQ/vNKIxAv9B1ySJ7krRyR1zv
         qfZOglFwxlgX1Rpz1HFk3//ohIQMcgkamnWsXKobaM7B5rhrYIWO0cYBU/R4bdEpOKb7
         20Z0wCaXYyEl3Fa22IV5/w8WDf0l0jbDqrSPYM2dep+6JywCtbDN+rZ/vSZk9+36QdIC
         F1/rCLptA7RVVsX+6CwdGINTf949flHY4+Bf1B9iXxlYz7b3cTJZakNqtqweJkbxQJkW
         44wA==
X-Gm-Message-State: AO0yUKWaeELwewA8mvSssvgjNedG7EzeEn14O1HTWOWQmZti1c5wUsGF
        6H1lEaoNV+mGlqUiB3CsjVavEKG9gU4=
X-Google-Smtp-Source: AK7set9lPcNP1UJwURIVHWLaCLdQnl44lpVSdejqmRef1HE6YFydIX2QQmnMfDNYoTKZeq2YewpEsw==
X-Received: by 2002:a05:6870:1607:b0:16a:a8c2:c0a6 with SMTP id b7-20020a056870160700b0016aa8c2c0a6mr7925563oae.17.1676128071972;
        Sat, 11 Feb 2023 07:07:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o191-20020a4a2cc8000000b0050dc3c2f77asm3105378ooo.8.2023.02.11.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:07:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Feb 2023 07:07:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] hwmon: (pmbus/core) Generalise pmbus get status
Message-ID: <20230211150749.GA202703@roeck-us.net>
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
 <20230207120241.2800662-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207120241.2800662-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:02:39PM +0100, Naresh Solanki wrote:
> Add function pmbus get status that can be used to get both pmbus
> specific status & regulator status
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Changes in V2:
> - Add __maybe_unused attribute for pmbus_get_status function
> - Remove unrelated changes
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 118 +++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 1b70cf3be313..5ccae8126a56 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2735,61 +2735,14 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>  	},
>  };
>  
> -#if IS_ENABLED(CONFIG_REGULATOR)
> -static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
> -{
> -	struct device *dev = rdev_get_dev(rdev);
> -	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
> -	int ret;
> -
> -	mutex_lock(&data->update_lock);
> -	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> -	mutex_unlock(&data->update_lock);
> -
> -	if (ret < 0)
> -		return ret;
> -
> -	return !!(ret & PB_OPERATION_CONTROL_ON);
> -}
> -
> -static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
> -{
> -	struct device *dev = rdev_get_dev(rdev);
> -	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
> -	int ret;
> -
> -	mutex_lock(&data->update_lock);
> -	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
> -				     PB_OPERATION_CONTROL_ON,
> -				     enable ? PB_OPERATION_CONTROL_ON : 0);
> -	mutex_unlock(&data->update_lock);
> -
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
> -}
>  
> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> +static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
>  {
> -	int i, status;
> +	int i, status, ret;
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
> @@ -2827,7 +2780,13 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	if (status < 0)
>  		return status;
>  
> -	if (pmbus_regulator_is_enabled(rdev)) {
> +	mutex_lock(&data->update_lock);
> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	mutex_unlock(&data->update_lock);
> +	if (ret < 0)
> +		return status;
> +
> +	if (ret & PB_OPERATION_CONTROL_ON) {

This code is now executed twice. Please keep the original function,
just rename it to pmbus_is_enabled() or similar, then call it from
pmbus_regulator_is_enabled() which then just needs to adjust the
parameter (and maybe pass 'dev' as argument).

>  		if (status & PB_STATUS_OFF)
>  			*flags |= REGULATOR_ERROR_FAIL;
>  
> @@ -2855,6 +2814,61 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_REGULATOR)
> +static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int ret;
> +
> +	mutex_lock(&data->update_lock);
> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	mutex_unlock(&data->update_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(ret & PB_OPERATION_CONTROL_ON);

This could then be as simple as

	return pmbus_is_enabled(rdev_get_dev(rdev));

Thanks,
Guenter

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
