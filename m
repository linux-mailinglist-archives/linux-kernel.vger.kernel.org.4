Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCBD6A2A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBYPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:40:36 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2190013D76;
        Sat, 25 Feb 2023 07:40:34 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17264e9b575so2934243fac.9;
        Sat, 25 Feb 2023 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px/d/g9mVgSDLWf3k8rN4W6hufDzMqQKNNkDt2FuWH8=;
        b=d9P0RVCA9ocz8BhfR/p5fOPwEYDaI3drxGs3R8biifxrOx1y4tLq2hsveScMXkS49y
         myLaYWAtFtvl1N5Adick+3rclUIPziw6prWEQvdjuU/jRDSPWv8CDByRlYzacSMbkY1H
         F71+3fgDTlpZ32SiQ+rliMeMBw2zHgdWzFdGXe9EpxA7Hd0aSEBmXWRQbopP2Q+RlB67
         tLEwU8rRQzydrt5ZkM3CYXYHaOJh+pqAInvPiRrVUsse6oQZBfwIyp4heCPwDC36yHOQ
         UsCP7d4DP7LfKKelcQkaxwox3HDw/xBgoiPpqMD/Pf0CstAX30VUZnim7+4kEnuGivA5
         w7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px/d/g9mVgSDLWf3k8rN4W6hufDzMqQKNNkDt2FuWH8=;
        b=DnvS5FocZoHmK4tW5WL3ufMjbEQli4XV5NyfPf7RehE/q1w9OU3VjqyGTlDLVbma9n
         4iIHuRx0+sRkEJXohpTJMvQxvaZD0Ivfp9w0sF6tyXTSSqZ6AgIJ8pXcs390qkpgMqr0
         qjKZii0UsoClnCe6ODSeAj6xT0tt6vxYyETNmK/pzlmrt/ipgZ8iT4jlzQf2hLjIuFCQ
         3xYWp+NKRd1to7nrFB29t9f0uMqEnU7dI3rq/I1Ok8iiv968PJjhjNj/SmwucjhHe9Km
         yiGSR5QRc1LlkZs0Ai5tUZPZglIVPsJ9g4ccvKpKqjisX8l3M+3X4bb62r4mrRFb3cwV
         Vn1g==
X-Gm-Message-State: AO0yUKUMkG7nHE/8jv/Pxid/yxUMY7jISWjgPHThb+YFxxrhPnTBU8Xw
        HVziWCvQgZZ9ZlJhrTjhezRcKuTBiV8=
X-Google-Smtp-Source: AK7set9ktFb5bcN3Mbg8jggMA2lTqbLYvuThWpm9eKl/Avj9JM5nxWIiltoLu3b6ciGQprPXQRgC3A==
X-Received: by 2002:a05:6871:1c8:b0:16e:8e5c:cb4e with SMTP id q8-20020a05687101c800b0016e8e5ccb4emr18504224oad.9.1677339633300;
        Sat, 25 Feb 2023 07:40:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5-20020a056870618500b001723d62f997sm671023oah.32.2023.02.25.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:40:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 07:40:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hwmon: (pmbus/core): Add interrupt support
Message-ID: <20230225154031.GA448701@roeck-us.net>
References: <20230217083631.657430-1-Naresh.Solanki@9elements.com>
 <20230217083631.657430-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217083631.657430-3-Naresh.Solanki@9elements.com>
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

On Fri, Feb 17, 2023 at 09:36:30AM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Changes in V3:
> - Remove pmbus word check for SMBALERT writes
> - Remove variable ret & use err instead.
> - Use dev_dbg_once instead of error.
> - Remove error print when writing to misc_status register.
> - Move client irq check to pmbus_irq_setup.
> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 78 ++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 713ea7915425..11e84e141126 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -26,7 +26,7 @@ enum pmbus_regs {
>  
>  	PMBUS_CAPABILITY		= 0x19,
>  	PMBUS_QUERY			= 0x1A,
> -
> +	PMBUS_SMBALERT_MASK		= 0x1B,
>  	PMBUS_VOUT_MODE			= 0x20,
>  	PMBUS_VOUT_COMMAND		= 0x21,
>  	PMBUS_VOUT_TRIM			= 0x22,
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index f8ac9016ea0e..d0415d5ac7d9 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3105,6 +3105,80 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  }
>  #endif
>  
> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> +{
> +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
> +}
> +
> +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
> +{
> +	struct pmbus_data *data = pdata;
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	int i, status;
> +
> +	mutex_lock(&data->update_lock);
> +	for (i = 0; i < data->info->pages; i++) {
> +		status = pmbus_read_status_word(client, i);
> +		if (status < 0) {
> +			mutex_unlock(&data->update_lock);
> +			return status;

Unfortunately this is not a valid return value for interrupt handlers.
I think the best approach here would be to just continue with the loop.

> +		}
> +
> +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
> +			pmbus_clear_fault_page(client, i);

Should those fault flags even be checked ? If another bit is set, they will
be cleared anyway, and "clear flags only if some other flag is set" seems
a bit inconsistent.

Overall it seems to me that we should maybe just call pmbus_clear_faults()
at the end of the function. Sure, that clears faults on pages where there
is no fault, but the above code reads the status on all pages anyway, so
it is more costly overall then just clearing the faults on all pages.

> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> +{
> +	struct device *dev = &client->dev;
> +	const struct pmbus_status_category *cat;
> +	const struct pmbus_status_assoc *bit;
> +	int i, j, err, func;
> +	u8 mask;
> +
> +	static const u8 misc_status[] = {PMBUS_STATUS_CML, PMBUS_STATUS_OTHER,
> +					 PMBUS_STATUS_MFR_SPECIFIC, PMBUS_STATUS_FAN_12,
> +					 PMBUS_STATUS_FAN_34};
> +
> +	if (!client->irq)
> +		return 0;
> +
> +	for (i = 0; i < data->info->pages; i++) {
> +		func = data->info->func[i];
> +
> +		for (j = 0; j < ARRAY_SIZE(pmbus_status_flag_map); j++) {
> +			cat = &pmbus_status_flag_map[j];
> +			if (!(func & cat->func))
> +				continue;
> +			mask = 0;
> +			for (bit = cat->bits; bit->pflag; bit++)
> +				mask |= bit->pflag;
> +
> +			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
> +			if (err)
> +				dev_dbg_once(dev, "Failed to set smbalert for reg 0x%02x\n",
> +					     cat->reg);
> +		}
> +
> +		for (j = 0; j < ARRAY_SIZE(misc_status); j++)
> +			pmbus_write_smbalert_mask(client, i, misc_status[j], 0xff);
> +	}
> +
> +	/* Register notifiers */
> +	err = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler, 0,
> +					"pmbus-irq", data);
> +	if (err) {
> +		dev_err(dev, "failed to request an irq %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
>  
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
> @@ -3467,6 +3541,10 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	if (ret)
>  		return ret;
>  
> +	ret = pmbus_irq_setup(client, data);
> +	if (ret)
> +		return ret;
> +
>  	ret = pmbus_init_debugfs(client, data);
>  	if (ret)
>  		dev_warn(dev, "Failed to register debugfs\n");
