Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CC6E390B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDPOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDPOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:03:26 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968C2684;
        Sun, 16 Apr 2023 07:03:25 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-32a89b6f185so15071515ab.2;
        Sun, 16 Apr 2023 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681653805; x=1684245805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Q5a3sCpYPTN+Zi1WEfE4euE7V9hW8im2FIQCqWm4Ws=;
        b=h+/XgDyuiC6IskB6ds1o+2VjpsGiYZ/d4FcHHYQ24jb3I8Dfqayo+hIQI/dTn6mn1d
         0Crw/sTYQFG4/hG5C7yGl9++n9vMiDYMNUy9dnz1Ca+aDjdQH3JfW4AVPQpA5So5FNo8
         GTR88dTAItT3P5YLtGsg2hsffawDiujX9TjVK9iuNk0odlxsYJqS7pklHB0RYaC4N23p
         PxtfvBVh8ss7CFbYrOUJybA45n1nkK01Q0qXgXf7ohLl6cHhM1TooWDpJBQNq2sNgaOn
         07I9QALZv0v4pV/Qs2beAh2L8dF1vWhXLXcp1vd21W61XgelOLEyTaLbtoDO+3km1u33
         iEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681653805; x=1684245805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q5a3sCpYPTN+Zi1WEfE4euE7V9hW8im2FIQCqWm4Ws=;
        b=QeYb7C2FENvp6O33qo3O2oTc87QGu1TVbg1/0un4BsZZpbvSHHqHLXrVmHp6xaOMV7
         K95//Ih7Dfl29ihxnSQ5Kn+9ym/2+RpELUvzJJER288SYcgxsI679PRiqg96VWf0hMCz
         Q6WaViFXj3P6mWakKcrp4tfkxdS1L4oU+LXI10eJOOdQg9lvM3eFyJM29HjKuLA0c5Ak
         LGG2JipIDQ6WZIhm6qdU0gED8L26WFaNg1Hg1IH996Tp1qxyJhWDw3zRgMc4Z9lhCCD/
         y9koFDgg7fJM+MzgzhKxb5jhAIoBVwN98OdBiWsLt4S1Cs4qJqPxOHW2y/pabAnHBGKS
         eosw==
X-Gm-Message-State: AAQBX9cyOcfETWjKrFlLUnZc6Rkgd54b4gJLlPuNEwjYyfj17FmIlLXO
        O4rjpxFw0/Bx7enpDCr58nAn0BB6098=
X-Google-Smtp-Source: AKy350YT8kntZVymC+a3V44jzSJfWpANrr/B2NgrsGs2ljXU22k/xtfJnAy1/0dNXLMJacZbvRXpvg==
X-Received: by 2002:a05:6e02:4c8:b0:32a:d9af:3df5 with SMTP id f8-20020a056e0204c800b0032ad9af3df5mr2561672ils.9.1681653804604;
        Sun, 16 Apr 2023 07:03:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14-20020a056638408e00b0040da21cbc2fsm2538472jam.154.2023.04.16.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:03:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:03:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/core) Add lock and unlock functions
Message-ID: <e3a1667d-b707-4955-9146-337944f4d99a@roeck-us.net>
References: <20230412161526.252294-1-eajames@linux.ibm.com>
 <20230412161526.252294-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412161526.252294-2-eajames@linux.ibm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:15:25AM -0500, Eddie James wrote:
> Debugfs operations may set the page number, which must be done
> atomically with the subsequent i2c operation. Lock the update_lock
> in the debugfs functions and provide a function for pmbus drivers
> to lock and unlock the update_lock.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 ++
>  drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 11e84e141126..b0832a4c690d 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -505,6 +505,8 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
>  			      enum pmbus_fan_mode mode);
>  int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
>  			      enum pmbus_fan_mode mode);
> +int pmbus_lock_interruptible(struct i2c_client *client);
> +void pmbus_unlock(struct i2c_client *client);
>  int pmbus_update_fan(struct i2c_client *client, int page, int id,
>  		     u8 config, u8 mask, u16 command);
>  struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index ca4510e4f918..04b4c65666fd 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3212,8 +3212,13 @@ static int pmbus_debugfs_get(void *data, u64 *val)
>  {
>  	int rc;
>  	struct pmbus_debugfs_entry *entry = data;
> +	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
>  
> +	rc = mutex_lock_interruptible(&pdata->update_lock);
> +	if (rc)
> +		return rc;
>  	rc = _pmbus_read_byte_data(entry->client, entry->page, entry->reg);
> +	mutex_unlock(&pdata->update_lock);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -3230,7 +3235,11 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
>  	struct pmbus_debugfs_entry *entry = data;
>  	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
>  
> +	rc = mutex_lock_interruptible(&pdata->update_lock);
> +	if (rc)
> +		return rc;
>  	rc = pdata->read_status(entry->client, entry->page);
> +	mutex_unlock(&pdata->update_lock);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -3246,10 +3255,15 @@ static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
>  {
>  	int rc;
>  	struct pmbus_debugfs_entry *entry = file->private_data;
> +	struct pmbus_data *pdata = i2c_get_clientdata(entry->client);
>  	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>  
> +	rc = mutex_lock_interruptible(&pdata->update_lock);
> +	if (rc)
> +		return rc;
>  	rc = pmbus_read_block_data(entry->client, entry->page, entry->reg,
>  				   data);
> +	mutex_unlock(&pdata->update_lock);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -3587,6 +3601,22 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
>  }
>  EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, PMBUS);
>  
> +int pmbus_lock_interruptible(struct i2c_client *client)
> +{
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +
> +	return mutex_lock_interruptible(&data->update_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(pmbus_lock_interruptible, PMBUS);
> +
> +void pmbus_unlock(struct i2c_client *client)
> +{
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +
> +	mutex_unlock(&data->update_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(pmbus_unlock, PMBUS);
> +
>  static int __init pmbus_core_init(void)
>  {
>  	pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
