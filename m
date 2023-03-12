Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC976B6900
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCLRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCLRzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:55:14 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90B18165;
        Sun, 12 Mar 2023 10:55:13 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso1526824oop.11;
        Sun, 12 Mar 2023 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoQHn5T6biYyj4hdWfbtnkoSrfY7Ep9xdtM1lhPHbiM=;
        b=oPunSEYUR1uvnTPrF/i440sanU6oUpkIUgDc2EhwX2zIYSALPSHjol/IlRdx3JOoGp
         0ihLi96XP47OkqGjhkDb6BwRVzgcs9NR+Lv8nDQi1xF46GDvXS90WorQpMSIosOZbJK+
         ntgUT02QFZF+iLjLu4bx+YjCZx9OFEvnFXayQnO0n14BM59BGNa2MShWfUxH+awpF2a1
         gjX+Xh9O9I5k1iDh/RGAOtpDS79IVwlCln8wO27sv+Okxn74bmJGwCvC3pMjr71vaFI2
         HbDhfjgwekkE/X/OjUqWE2Hw3YTPS6wKVptn69rt3y54TTmdrIqnYcZ/hBg89gxxgWS0
         sf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoQHn5T6biYyj4hdWfbtnkoSrfY7Ep9xdtM1lhPHbiM=;
        b=e5RX5YM2PwudQu54PcmDi7G1usS/U9yGDOzqLXiFrivkLNKFH0VJRay4whMQwGa2la
         qEWNwO37prIoJ4A5318mVUO21NcKTiwK1hazOw8I6ojYxFHHigYVpDNo3DR4Iq9vN79F
         +AlXKs/ryGbYbMqH3GqgWcaE6Srj+XnF4Hr5iSSi/toF1UdmnHRQ8v5hBy67a2ttG7Kb
         bAXcWE2ccHc1j6GYQ4AjNezLjrto064MEPDyuCNpuNlxwgcl9mxpP42jkuweHKUlvBXT
         Fzq8lxAzWyRysrM9ZRBIv1rpLoUA4db/6y7wqEVt9yyLgAvVSJ3fj8jjlZVU1OSC7Iwm
         cWrA==
X-Gm-Message-State: AO0yUKVxhpmeCmRFomysi1yZKoTx1Gtc3H6aw3POzs0ERq3Nv3HgiOop
        T37NseTLyTjHVgRgK8fhMTo=
X-Google-Smtp-Source: AK7set833UkN6xA7orT1x4uZcQWDAlsrsf7nQohf/YSMX0kfDsjDXmrhluAUIqUdNBMaCNgsVGooLQ==
X-Received: by 2002:a4a:d637:0:b0:525:4058:2fcd with SMTP id n23-20020a4ad637000000b0052540582fcdmr5054102oon.1.1678643712663;
        Sun, 12 Mar 2023 10:55:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11-20020a4a940b000000b0051ac0f54447sm2296886ooi.33.2023.03.12.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:55:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:55:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] hwmon: (pmbus/core): Add interrupt support
Message-ID: <473d6a29-29cf-4b8a-b40b-d71fd8a5bcc8@roeck-us.net>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
 <20230301164434.1928237-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301164434.1928237-3-Naresh.Solanki@9elements.com>
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

On Wed, Mar 01, 2023 at 05:44:33PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement PMBUS irq handler.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...

This should be "---"

Applied.

Thanks,
Guenter

> Changes in V4:
> - Clear fault using pmbus_clear_faults at end of interrupt handler.
> - Remove for loop.
> Changes in V3:
> - Remove pmbus word check for SMBALERT writes
> - Remove variable ret & use err instead.
> - Use dev_dbg_once instead of error.
> - Remove error print when writing to misc_status register.
> - Move client irq check to pmbus_irq_setup.
> ---
>  drivers/hwmon/pmbus/pmbus.h      |  2 +-
>  drivers/hwmon/pmbus/pmbus_core.c | 70 ++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 1 deletion(-)
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
> index f8ac9016ea0e..dfd227459d8b 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -3105,6 +3105,72 @@ static int pmbus_regulator_register(struct pmbus_data *data)
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
> +
> +	mutex_lock(&data->update_lock);
> +	/* TODO: Check status flag & notify hwmon events */
> +
> +	pmbus_clear_faults(client);
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
> @@ -3467,6 +3533,10 @@ int pmbus_do_probe(struct i2c_client *client, struct pmbus_driver_info *info)
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
