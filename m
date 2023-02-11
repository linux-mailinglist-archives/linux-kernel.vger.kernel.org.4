Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37CA693205
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBKPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:37:33 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE1274AB;
        Sat, 11 Feb 2023 07:37:32 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id k15-20020a4adfaf000000b00517450f9bd7so818001ook.8;
        Sat, 11 Feb 2023 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efNSPSl29pf4HoKYhm7Cmos409EV+PeL5jl73WM1c8k=;
        b=ac0VIM1B4Z/axRS4YCyewKk7W+OGiPdqsL8+PaeKxfOZVZ/R+2E1pGMQuS2oibYyfq
         4X84CJpBnZ8QXlkWazfD8k3BSsH4Z/KfbzymVUg+tpPjx/eyh4ogCFwjdIbKwM7bdc6q
         oxUT5nS0f8AFrfSpd0fGmuVIr8koa0BtQV3AGGR27PMZCgbaCLSjI41qu8X2CKu5RR31
         D4BlmSLJb4w9ElcOzypujjVX7W+hGU0tcUA8Q5f520lNWEJfAjtfsWrv6LVpksJlek+7
         XlIZrb6hL78GeixMaRfHrAeb/x1dI2ILacJmzp6BBbXdmYTBDmNgcO2/p0D/EkFFW7Wa
         Nhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efNSPSl29pf4HoKYhm7Cmos409EV+PeL5jl73WM1c8k=;
        b=V+EDx24UZ/lvwSDnDIUkA9ABRJNjQmrvtuwxEaFrZo8gJD9Wl1HLNPbSwxrqJDFZHK
         SEkHIrI2aiyRBpJAGlkHrAKs10Dy/gc2rHGGkOW5ddyzW5q30ia4Ak2q8Ypb4Hd/VG1Y
         eKbG/gupu1yLI6vhAX52zwWM8xii+DUNp7uASmvTFFf3YSthPWPDvlk4ffNKNIoPtt59
         wFpDx0a+MJSZhJ8An7M/wAMgr3yKWTzuSHiMr34Er9AabqOGMVZ5VhtBqmqT+YeUAsAk
         0xPBzs7ApxiIW+S5f2aGJMbtiKxYbR7S7BuG5I3hik2OO4PGhPCFY1xEfQy0nyhygk/f
         3mMg==
X-Gm-Message-State: AO0yUKWkvkBjFQLpDMSuzc2qxcwcfOCSO2gTfxBTHwozQC3lwsQOeInH
        dpU9GXl2FlKG3bugBHa99fvGv/ob/Os=
X-Google-Smtp-Source: AK7set8ZOVw5FCC9J5VSoTNdb1bxmQpw8lxXpvnrzxqv7FWMxok+Kat1amoqR2Qrj9m9pU1LasSSqQ==
X-Received: by 2002:a4a:d8d7:0:b0:517:7580:4764 with SMTP id c23-20020a4ad8d7000000b0051775804764mr9827411oov.0.1676129851297;
        Sat, 11 Feb 2023 07:37:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e187-20020a4a55c4000000b0051a72e69e24sm2680704oob.37.2023.02.11.07.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:37:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Feb 2023 07:37:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hwmon: (pmbus/core): Add interrupt support
Message-ID: <20230211153729.GA203244@roeck-us.net>
References: <20230207120241.2800662-1-Naresh.Solanki@9elements.com>
 <20230207120241.2800662-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207120241.2800662-3-Naresh.Solanki@9elements.com>
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

On Tue, Feb 07, 2023 at 01:02:40PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 85 ++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletion(-)
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
> index 5ccae8126a56..d5403baad60a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3093,6 +3093,85 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>  }
>  #endif
>  
> +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> +{
> +	int err;
> +
> +	err = pmbus_check_word_register(client, page, reg | (val << 8));
> +	if (err)
> +		return err;

I am not convinced that this is necessary. The next command will return an
error anyway if the register or the specific mask is not supported, so what
is the point ?

> +
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
> +		}
> +
> +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
> +			pmbus_clear_fault_page(client, i);
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
> +	int i, j, err, ret, func;
> +	u8 mask;
> +	u8 misc_status[] = {PMBUS_STATUS_CML, PMBUS_STATUS_OTHER, PMBUS_STATUS_MFR_SPECIFIC,
> +			    PMBUS_STATUS_FAN_12, PMBUS_STATUS_FAN_34};

static const u8 ... 

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
> +				dev_err_once(dev, "Failed to set smbalert for reg 0x%02x\n",
> +					     cat->reg);

dev_err implies an error. This is ignored and thus not an error. On top of that,
not all chips support PMBUS_SMBALERT_MASK. All of those would see this message.
We can't have that. At best make it a dev_dbg.

> +		}
> +
> +		for (j = 0; j < ARRAY_SIZE(misc_status); j++) {
> +			err = pmbus_write_smbalert_mask(client, i, misc_status[j], 0xff);
> +			if (err)
> +				dev_err_once(dev, "Failed to set smbalert for reg 0x%02x\n",
> +					     misc_status[j]);

We definitely can't have a message here; that would fire for almost
every chip.

> +		}
> +	}
> +
> +	/* Register notifiers - can fail if IRQ is not given */

If there is no irq, what is the point of executing this code in the first
place ? No, wait, in that case the function isn't called in the first place.
I think the comment doesn't add any value and is just confusing.

> +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler, 0,
> +					"pmbus-irq", data);
> +	if (ret) {

Why both "err" and "ret" ?

> +		dev_warn(dev, "IRQ disabled %d\n", ret);

The calling code aborts, so this should be dev_err() and say something
better than "IRQ disabled"; It should be something like "failed to
request irq".

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
>  
>  #if IS_ENABLED(CONFIG_DEBUG_FS)
> @@ -3455,6 +3534,12 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
>  	if (ret)
>  		return ret;
>  
> +	if (client->irq > 0) {
> +		ret = pmbus_irq_setup(client, data);
> +		if (ret)
> +			return ret;
> +	}
> +

I think it would be better to have the check in pmbus_irq_setup():

pmbus_irq_setup()
{
	if (!client->irq)
		return 0;
	
	...
}

and here
	ret = pmbus_irq_setup(client, data);
	if (ret)
		return ret;


>  	ret = pmbus_init_debugfs(client, data);
>  	if (ret)
>  		dev_warn(dev, "Failed to register debugfs\n");
