Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A787263D9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiK3PnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiK3PnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:43:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340827CF7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:43:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o5so18715961wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2CPt6UUr0Ol+tNsMseBtxKGb1V1YnEDZLgJ/pQSTJE=;
        b=Qh7NW5O8feAEpRF4RfY1NyIvt4OCMfmxylOq07XHAVR5icBbFlugYrCLT7F0Khqgfn
         dUe9WWwMsL/BqLJImG63POpMsY2QUinpf/IxSeGqfsIN7Z+MgXr5p1P8aMEeZ24Dys2o
         ht3MrHLMCJspvj2DCecMunWLO5+ilxmj/tPy/1Y687qVv2BSi8H/q4omnKeF6GS0zG87
         6y1Yd6gN6sRVmJfqt8JjB2o1MjXPOk6JzTji7pC8xgcWvwL8OHJedKc7gMfAhKlm8nHV
         cyGYxQ2HoobelLGj8RShLwsbEIAs+1pNT4oabhB0nYJA4Tlv1knO8RrOsDbmKGwEuYiF
         4XtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2CPt6UUr0Ol+tNsMseBtxKGb1V1YnEDZLgJ/pQSTJE=;
        b=0A17qoTak/w0uJiLP8Uo0WLeJ/4sSe/q/kCNCqGb/ru7Q3K7xuuUyuls8xAC3UraeM
         gzVDlJwWo6WQoiwyrl5SoqzOMJ7GCZp2c3H+g885tR0FcV3H6qnmkvrqCVHWSamV9ck5
         q3HoJmX83c0p/1CM5AT4ztvU81ROkfnb2cCI7RHE/twUQTAW9GurhQRMIYas0qjby33/
         JAuOdmHpSSJakhLI685lg0C6trO5nPoST3ZsA4c4IMw5EmX/RFBp13Hgf3D1VXqeXFJl
         sDowh5Ox7AACDIjedLOQpxs8TKURK9+RombqXXBzyV9p53tHOUOMb3gntziM2nOcmf1j
         Bp6g==
X-Gm-Message-State: ANoB5plzrn0DwcbPSzKMK0eXFQW3RUi2XzQHr0c4EfZUH0FdPvMIUOym
        uMEEBrywrRJzN0Cg1bBetuW5CQ==
X-Google-Smtp-Source: AA0mqf6mR8xZZlFFx8vK9E56TuMKX3JBbqqwiLnmgbM0OEUkeD36SH/sMsql6ujX6d9YfmcytkdNxQ==
X-Received: by 2002:a05:6000:114e:b0:242:257f:3006 with SMTP id d14-20020a056000114e00b00242257f3006mr4487966wrx.147.1669822984217;
        Wed, 30 Nov 2022 07:43:04 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b003cf71b1f66csm2300932wmh.0.2022.11.30.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:43:03 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] input/touchscreen: imagis: Add supports for
 Imagis IST3038
In-Reply-To: <20221118182103.3405-4-linmengbo0689@protonmail.com>
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
 <20221118182103.3405-4-linmengbo0689@protonmail.com>
Date:   Wed, 30 Nov 2022 16:43:03 +0100
Message-ID: <87edtksb20.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 18:21, "Lin, Meng-Bo" <linmengbo0689@protonmail.com> wrote:

> From: Markuss Broks <markuss.broks@gmail.com>
>
> Imagis IST3038 is another variant of Imagis IST3038 IC, which has
> a different register interface from IST3038C (possibly firmware defined).
>
> This should also work for IST3044B (though untested), however other
> variants using this interface/protocol(IST3026, IST3032, IST3026B,
> IST3032B) have a different format for coordinates, and they'd need
> additional effort to be supported by this driver.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> [Use IST3038C_REG_CHIPID_BASE]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/touchscreen/imagis.c | 62 ++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index b667914a44f1..eb3b0684817f 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -13,7 +13,8 @@
>  
>  #define IST3038C_HIB_ACCESS		(0x800B << 16)
>  #define IST3038C_DIRECT_ACCESS		BIT(31)
> -#define IST3038C_REG_CHIPID		0x40001000
> +#define IST3038C_REG_CHIPID_BASE	0x40001000
> +#define IST3038C_REG_CHIPID(base)	(base | IST3038C_DIRECT_ACCESS)
>  #define IST3038C_REG_HIB_BASE		0x30000100
>  #define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
>  #define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
> @@ -31,8 +32,24 @@
>  #define IST3038C_FINGER_COUNT_SHIFT	12
>  #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
>  
> +#define IST30XX_REG_STATUS		0x20
> +#define IST30XXB_REG_CHIPID_BASE	0x40000000
> +#define IST30XX_WHOAMI			0x30003000
> +#define IST30XXA_WHOAMI			0x300a300a
> +#define IST30XXB_WHOAMI			0x300b300b
> +#define IST3038_WHOAMI			0x30383038
> +
> +struct imagis_properties {
> +	unsigned int interrupt_msg_cmd;
> +	unsigned int touch_coord_cmd;
> +	unsigned int chipid_base;
> +	unsigned int whoami_val;
> +	bool protocol_b;
> +};
> +
>  struct imagis_ts {
>  	struct i2c_client *client;
> +	const struct imagis_properties *tdata;
>  	struct input_dev *input_dev;
>  	struct touchscreen_properties prop;
>  	struct regulator_bulk_data supplies[2];
> @@ -84,8 +101,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
>  	int i;
>  	int error;
>  
> -	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE,
> -				    &intr_message);
> +	error = imagis_i2c_read_reg(ts, ts->tdata->interrupt_msg_cmd, &intr_message);
>  	if (error) {
>  		dev_err(&ts->client->dev,
>  			"failed to read the interrupt message: %d\n", error);
> @@ -104,9 +120,13 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
>  	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
>  
>  	for (i = 0; i < finger_count; i++) {
> -		error = imagis_i2c_read_reg(ts,
> -					    IST3038C_REG_TOUCH_COORD + (i * 4),
> -					    &finger_status);
> +		if (ts->tdata->protocol_b)
> +			error = imagis_i2c_read_reg(ts,
> +						    ts->tdata->touch_coord_cmd, &finger_status);
> +		else
> +			error = imagis_i2c_read_reg(ts,
> +						    ts->tdata->touch_coord_cmd + (i * 4),
> +						    &finger_status);
>  		if (error) {
>  			dev_err(&ts->client->dev,
>  				"failed to read coordinates for finger %d: %d\n",
> @@ -261,6 +281,12 @@ static int imagis_probe(struct i2c_client *i2c)
>  
>  	ts->client = i2c;
>  
> +	ts->tdata = device_get_match_data(dev);
> +	if (!ts->tdata) {
> +		dev_err(dev, "missing chip data\n");
> +		return -EINVAL;
> +	}
> +
>  	error = imagis_init_regulators(ts);
>  	if (error) {
>  		dev_err(dev, "regulator init error: %d\n", error);
> @@ -279,15 +305,13 @@ static int imagis_probe(struct i2c_client *i2c)
>  		return error;
>  	}
>  
> -	error = imagis_i2c_read_reg(ts,
> -			IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS,
> -			&chip_id);
> +	error = imagis_i2c_read_reg(ts, IST3038C_REG_CHIPID(ts->tdata->chipid_base), &chip_id);
>  	if (error) {
>  		dev_err(dev, "chip ID read failure: %d\n", error);
>  		return error;
>  	}
>  
> -	if (chip_id != IST3038C_WHOAMI) {
> +	if (chip_id != ts->tdata->whoami_val) {
>  		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
>  		return -EINVAL;
>  	}
> @@ -343,9 +367,25 @@ static int __maybe_unused imagis_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
>  
> +static const struct imagis_properties imagis_3038_data = {
> +	.interrupt_msg_cmd = IST30XX_REG_STATUS,
> +	.touch_coord_cmd = IST30XX_REG_STATUS,
> +	.chipid_base = IST30XXB_REG_CHIPID_BASE,
> +	.whoami_val = IST3038_WHOAMI,
> +	.protocol_b = true,
> +};
> +
> +static const struct imagis_properties imagis_3038c_data = {
> +	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
> +	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
> +	.chipid_base = IST3038C_REG_CHIPID_BASE,
> +	.whoami_val = IST3038C_WHOAMI,
> +};
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id imagis_of_match[] = {
> -	{ .compatible = "imagis,ist3038c", },
> +	{ .compatible = "imagis,ist3038", .data = &imagis_3038_data },
> +	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, imagis_of_match);
> -- 
> 2.30.2
