Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4267A070
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjAXRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjAXRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:48:17 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60049541;
        Tue, 24 Jan 2023 09:48:12 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so2748145oob.3;
        Tue, 24 Jan 2023 09:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrFn+R1+WoRDi2f+Orum41K5vIa0ar/tkJKZq4XpqOA=;
        b=PonE1S16ys/i4jNUsTe4Y0pT16iA1KmxP6/NMdWFdnLUWKkej/NZtDhJFRmXWFhhh6
         nQtokSXLs7h/B3byad0F84O2Xv/uvCXKsbIie/pMSiE9aPf+gVbKMtOieJ9s6ncVvpgD
         8nhq/KUKp2aHHzDVDSHwswu8N8krQ8sf10Ts27tNr7erJ6v58fXXZpGMz8BzJp3jbM61
         INpwc+BI1FcZQAuUN/tEO1pszE8OGiq+Lf6jdsGLdQRdtcDQzPKopJPZJI6uzbofKGnl
         YFcd3xPpQyuv6kXKvntwWhWnhiyCFKJ/Xcjtf1NSkmxeqpeOtwtekpRGH/HM7oVInaLZ
         2PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrFn+R1+WoRDi2f+Orum41K5vIa0ar/tkJKZq4XpqOA=;
        b=GmQkopdx8dDfo4Nzy3bC9LHB3ENpIn32tk7ejWVrEUJZBx9uDNsWOj7X8FhRy0/f9L
         CKfzg5126jmHyJtuSuJT19Gp/K5TCPRLuQx2BwpQ7DNSZ+COrDdFoJzx1lBL4gh23tCp
         3CWoD76qWLQDs1Ssz2AOc8viXJtYTQO4DXqxsyHZL78lTx+nUm0EdKPWOLcTSDMf2SFG
         Jh2QaITTUy6JZGbDpxrZjtp0JB/gafn6ev2oWWiuk/Lp4Ie1tEIyx4PyNYOPTomTVa4j
         NXvl6QV0xCi61wq7J9k7ZR2XgfpVwdBMcFZG8ogd2P/X5MonNbDTWUe8pFA767sV2ty9
         LJ5Q==
X-Gm-Message-State: AFqh2krtlP7cV/lDuPW1uZ50H+RKFru3iqFVFs76xKjIWK8eoIBRCeYT
        5xuu8zVTRX2qGKvnKM/G2RC0rORfdrc=
X-Google-Smtp-Source: AMrXdXtJgcoLRiE0TnKmN8XyLCa9nGRyMq/G/57KbfrkEj11EsaB3trTh587JQqRQURxWvi02V+Cxw==
X-Received: by 2002:a4a:4f95:0:b0:4f1:f375:c240 with SMTP id c143-20020a4a4f95000000b004f1f375c240mr13917828oob.6.1674582491383;
        Tue, 24 Jan 2023 09:48:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k43-20020a4a94ae000000b004f1f6b25091sm979687ooi.41.2023.01.24.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:48:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Jan 2023 09:48:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] hwmon: (pmbus/core) Generalise pmbus get status
Message-ID: <20230124174809.GA563974@roeck-us.net>
References: <20230123064021.2657670-1-Naresh.Solanki@9elements.com>
 <20230123064021.2657670-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123064021.2657670-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 07:40:19AM +0100, Naresh Solanki wrote:
> Add function pmbus get status that can be used to get both pmbus
> specific status & regulator status
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 148 +++++++++++++++++--------------
>  1 file changed, 82 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 1b70cf3be313..12b662b91306 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2735,64 +2735,16 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
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
>  
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
> +static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error)

Moving this code outside the conditional without usage there will result
in compile errors due to an unused function if compiled with REGULATOR
disabled. While this will (hopefully) change in one of the later patches,
it is still unacceptable because it may result in bisect failures.

>  {
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
> -
> -static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> -{
> -	int i, status;
>  	const struct pmbus_status_category *cat;
>  	const struct pmbus_status_assoc *bit;
> -	struct device *dev = rdev_get_dev(rdev);
> -	struct i2c_client *client = to_i2c_client(dev->parent);
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	u8 page = rdev_get_id(rdev);
> +	struct i2c_client *client = to_i2c_client(data->dev);
>  	int func = data->info->func[page];
> +	int i, status, ret;
>  
> -	*flags = 0;
> +	*error = 0;

You are making personal preference changes here. Maybe that is the reason
why the patch looks that large. Please try to leave existing code alone.
If there is a reason to change a variable name (or other cosmetic changes,
like moving variable declarations around), do it in a separate patch which
only does that, and explain why it is needed and/or makes sense.

Thanks,
Guenter

>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -2803,14 +2755,15 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  
>  		status = _pmbus_read_byte_data(client, page, cat->reg);
>  		if (status < 0) {
> -			mutex_unlock(&data->update_lock);
> -			return status;
> +			ret = status;
> +			goto unlock;
>  		}
>  
>  		for (bit = cat->bits; bit->pflag; bit++) {
>  			if (status & bit->pflag)
> -				*flags |= bit->rflag;
> +				*error |= bit->rflag;
>  		}
> +
>  	}
>  
>  	/*
> @@ -2823,36 +2776,99 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	 * REGULATOR_ERROR_<foo>_WARN.
>  	 */
>  	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> -	mutex_unlock(&data->update_lock);
> -	if (status < 0)
> -		return status;
>  
> -	if (pmbus_regulator_is_enabled(rdev)) {
> +	if (status < 0) {
> +		ret = status;
> +		goto unlock;
> +	}
> +
> +	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	if (ret & PB_OPERATION_CONTROL_ON) {
>  		if (status & PB_STATUS_OFF)
> -			*flags |= REGULATOR_ERROR_FAIL;
> +			*error |= REGULATOR_ERROR_FAIL;
>  
>  		if (status & PB_STATUS_POWER_GOOD_N)
> -			*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +			*error |= REGULATOR_ERROR_REGULATION_OUT;
>  	}
>  	/*
>  	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>  	 * defined strictly as fault indicators (not warnings).
>  	 */
>  	if (status & PB_STATUS_IOUT_OC)
> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> +		*error |= REGULATOR_ERROR_OVER_CURRENT;
>  	if (status & PB_STATUS_VOUT_OV)
> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
> +		*error |= REGULATOR_ERROR_REGULATION_OUT;
>  
>  	/*
>  	 * If we haven't discovered any thermal faults or warnings via
>  	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
>  	 * a (conservative) best-effort interpretation.
>  	 */
> -	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
> +	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
>  	    (status & PB_STATUS_TEMPERATURE))
> -		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
> +		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
>  
> -	return 0;
> +unlock:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
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
>  }
>  
>  static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> -- 
> 2.38.1
> 
