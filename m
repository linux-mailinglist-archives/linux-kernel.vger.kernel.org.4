Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4B62E88F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiKQWjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQWjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:39:01 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695D14877E;
        Thu, 17 Nov 2022 14:39:00 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso2023794otb.2;
        Thu, 17 Nov 2022 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzc4Q2RrCyrUGod2Zml3PFkTAVtf8vqrot7kLoQWlTQ=;
        b=CM3GAjharx/2BPsRMkTU4FbkxD6u3ERBE43l5cDmlMI35e1iGnSI4CtBlJ+DbLM6WC
         Ze7kWTpZoUNJdRL2n/nBxmplkZJWxf/ZwX91zeKFV9zY+6pbiEFV5xOG6UrDuQnVrFji
         +w3PFI5ilf47vh/KtMAoodI0jxudRk1sitNyV0AkaUPQgmgTspSUJ0VW8SRqK6GOmnWV
         fyT118i+yYx71etqMoImiaK80gEnZEwjLXxIIcYHqV4nNnon9TWHeUq+7UEBk9ZFTftV
         jTskabyGB+w7b1EBtVj6aJ1KO/aWZbx61K0l+AAWk40c5eMFV9tr4TVFmfSGwZ2Q/eVz
         qcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzc4Q2RrCyrUGod2Zml3PFkTAVtf8vqrot7kLoQWlTQ=;
        b=FqvpbBvE4Sk0mKFW5b+pTXiOYocLtcf+u+l2YINJM+kx0JFaWumoVD6EAFSJ284DXb
         1CdZy5ZW7BkpdUW6es6LLbSXp9kxLwzQ3u+MrpJDIbZbe+e1W56ih7h7eMfig8LeAcnz
         I/+0FS8tORUfmmIfl90a04wwdEuAlRPuGp1VoRkuiJt9Q1ys0Zk6Q8LwdTF8SfFQv970
         qCUQIw4M2H7IKy0VmkVpOuY0yQWA3rX8mq6MdEkXvDw9SaHzyL18Ec2BInGUlpLUs4fz
         scpSQypS6UeGCDBCu34izHErfDQjArt9b+vV4qKzBdPjwP8cmRLKxAMjgkeW/2S2F2MK
         e1ZA==
X-Gm-Message-State: ANoB5pnanaylrJO8O3N7yh413/IaXSpKGP/CP9ixWEjxYl2taQtyoGzN
        ZgVwr88u2RjscaKo5FoaaOVGHd8+O+0=
X-Google-Smtp-Source: AA0mqf6OIDRi7ao6JUWBuNBxm+ttuu1N8L4/yUXJrbNnFh76tTCfL3Dfc7sX1PkI9+22HVM0zUCDAw==
X-Received: by 2002:a05:6830:134a:b0:661:a273:f0c4 with SMTP id r10-20020a056830134a00b00661a273f0c4mr2602437otq.120.1668724739699;
        Thu, 17 Nov 2022 14:38:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6c54000000b0066dc76d9b7fsm872038otq.31.2022.11.17.14.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:38:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Nov 2022 14:38:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: pm_bus: core: Implement regulator get_status
Message-ID: <20221117223856.GA675221@roeck-us.net>
References: <20221117194352.1904264-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117194352.1904264-1-Naresh.Solanki@9elements.com>
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

On Thu, Nov 17, 2022 at 08:43:51PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 78 ++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 7ec04934747e..d5e2b0662da5 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2851,6 +2851,83 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int status, status2;
> +
> +	mutex_lock(&data->update_lock);
> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> +	mutex_unlock(&data->update_lock);
> +	if (status < 0)
> +		 return status;
> +
> +	if (status & PB_STATUS_VIN_UV ||
> +	    status & PB_STATUS_IOUT_OC ||
> +	    status & PB_STATUS_VOUT_OV ||
> +	    status & PB_STATUS_UNKNOWN)
> +		 return REGULATOR_STATUS_ERROR;

	if (status & (PB_STATUS_VIN_UV | PB_STATUS_IOUT_OC | ...))

PB_STATUS_UNKNOWN can mean anything and doesn't necessarily indicate
an error. Not sure if it makes sense to report that as error.

> +
> +	if (status & PB_STATUS_VOUT_OV &&

PB_STATUS_VOUT_OV was checked above already, and the code won't get here
if the bit is set.

> +	    data->info->func[page] & PMBUS_HAVE_STATUS_VOUT) {
> +		 mutex_lock(&data->update_lock);
> +		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_VOUT);
> +		 mutex_unlock(&data->update_lock);
> +		 if (status2 < 0)
> +			  return status2;
> +		 if (status2 & PB_VOLTAGE_OV_FAULT ||
> +		     status2 & PB_VOLTAGE_UV_FAULT)

		if (status2 & (...))

> +			  return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_IOUT_OC &&

Same as above - this condition will never be true.

> +	    data->info->func[page] & PMBUS_HAVE_STATUS_IOUT) {
> +		 mutex_lock(&data->update_lock);
> +		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_IOUT);
> +		 mutex_unlock(&data->update_lock);
> +		 if (status2 < 0)
> +			  return status2;
> +		 if (status2 & PB_POUT_OP_FAULT ||
> +		     status2 & PB_IOUT_UC_FAULT ||
> +		     status2 & PB_IOUT_OC_LV_FAULT ||
> +		     status2 & PB_IOUT_OC_FAULT)

		if (status2 & (...))

> +			  return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_VIN_UV &&

and again.

> +	    data->info->func[page] & PMBUS_HAVE_STATUS_INPUT) {
> +		 mutex_lock(&data->update_lock);
> +		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_INPUT);
> +		 mutex_unlock(&data->update_lock);
> +		 if (status2 < 0)
> +			  return status2;
> +		 if (status2 & PB_IIN_OC_FAULT ||
> +		     status2 & PB_VOLTAGE_OV_FAULT ||
> +		     status2 & PB_VOLTAGE_UV_FAULT)

and again

> +			  return REGULATOR_STATUS_ERROR;
> +	}
> +	if (status & PB_STATUS_TEMPERATURE &&
> +	    data->info->func[page] & PMBUS_HAVE_STATUS_TEMP) {
> +		 mutex_lock(&data->update_lock);
> +		 status2 = _pmbus_read_byte_data(client, page, PMBUS_STATUS_TEMPERATURE);
> +		 mutex_unlock(&data->update_lock);
> +		 if (status2 < 0)
> +			  return status2;
> +		 if (status2 & PB_TEMP_UT_FAULT ||
> +		     status2 & PB_TEMP_OT_FAULT)

and again

> +			  return REGULATOR_STATUS_ERROR;
> +	}
> +
> +	if (status & PB_STATUS_OFF)
> +		 return REGULATOR_STATUS_OFF;
> +
> +	if (status & PB_STATUS_POWER_GOOD_N)
> +		 return REGULATOR_STATUS_OFF;

Wouldn't it be better to check those bits first ?
Also, it should be

	if (status & (PB_STATUS_OFF | PB_STATUS_POWER_GOOD_N))

> +
> +	return REGULATOR_STATUS_ON;
> +}
> +
>  static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>  {
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2991,6 +3068,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>  	.disable = pmbus_regulator_disable,
>  	.is_enabled = pmbus_regulator_is_enabled,
>  	.get_error_flags = pmbus_regulator_get_error_flags,
> +	.get_status = pmbus_regulator_get_status,
>  	.get_voltage = pmbus_regulator_get_voltage,
>  	.set_voltage = pmbus_regulator_set_voltage,
>  	.list_voltage = pmbus_regulator_list_voltage,
> 
> base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
> -- 
> 2.37.3
> 
