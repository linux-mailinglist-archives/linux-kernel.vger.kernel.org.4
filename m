Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7586B6037
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCKT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:28:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A53EF90;
        Sat, 11 Mar 2023 11:28:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D30A60DE5;
        Sat, 11 Mar 2023 19:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA88FC433EF;
        Sat, 11 Mar 2023 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678562881;
        bh=VFKDknYpU98shV0cokL9ytozmlENE2BZsbsJV5R4Ig4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eb6MLAMM/QwHcgi1PATGqkNkcr+gtCPM7/hS4j6lsScWPK+vswMrC7yfWe9BSVPI1
         84yRR82try4ZWFmFt+LKvA+lttnnFv6uNcchhwJxFtkyaiDgh8M5VIEIocDsOvVfBS
         DUeJA+6I7AMgECijA3v3aaEzfrK4f/7z64j7FMqIggImRBdhFcuVhx2ERitzVKlyau
         cmiHxRYZVAuoi0p6HaY/LsqK41OTRUaCe80FpJbL8BvjqbNtQ23IuCrQa99geWXjbg
         jK13emjOmW2ebonhX+RrOVREOmD36Kzp18OdGGB8hXSZAxOqOZDV/Eb2lTSIPWsnzZ
         xll+wy2klIe+w==
Date:   Sat, 11 Mar 2023 19:28:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] misc: adps990x: convert to OF
Message-ID: <20230311192805.2c24f974@jic23-huawei>
In-Reply-To: <20230308090219.12710-3-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
        <20230308090219.12710-3-clamor95@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Mar 2023 11:02:17 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add ability to get essential values from device tree.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Hi,

Some comments inline.

> ---
>  drivers/misc/apds990x.c | 56 +++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
> index 0024503ea6db..c53ead5a575d 100644
> --- a/drivers/misc/apds990x.c
> +++ b/drivers/misc/apds990x.c
> @@ -180,8 +180,8 @@ static const u16 arates_hz[] = {10, 5, 2, 1};
>  static const u8 apersis[] = {1, 2, 4, 5};
>  
>  /* Regulators */
> -static const char reg_vcc[] = "Vdd";
> -static const char reg_vled[] = "Vled";
> +static const char reg_vcc[] = "vdd";
> +static const char reg_vled[] = "vled";

Doesn't this break existing users?  That's fine if we are dropping platform
data support, but this patch doesn't do that.

>  
>  static int apds990x_read_byte(struct apds990x_chip *chip, u8 reg, u8 *data)
>  {
> @@ -1048,9 +1048,38 @@ static struct attribute *sysfs_attrs_ctrl[] = {
>  };
>  
>  static const struct attribute_group apds990x_attribute_group[] = {
> -	{.attrs = sysfs_attrs_ctrl },
> +	{ .attrs = sysfs_attrs_ctrl },

As below - white space changes are fine, but not in the same patch as
functional stuff.  Just makes ti harder to read.

>  };
>  
> +static int apds990x_of_probe(struct i2c_client *client,
> +			     struct apds990x_chip *chip)
> +{
> +	struct apds990x_platform_data *pdata;
> +	u32 ret, val;
> +
> +	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32(&client->dev, "avago,pdrive", &val);
> +	if (ret) {
> +		dev_info(&client->dev, "pdrive property is missing: ret %d\n", ret);

Is this required to work?  If so dev_err_probe() is neater and make sure to handle the
error return at the caller.

> +		return ret;
> +	}
> +	pdata->pdrive = val;
> +
> +	ret = device_property_read_u32(&client->dev, "avago,ppcount", &val);
> +	if (ret) {
> +		dev_info(&client->dev, "ppcount property is missing: ret %d\n", ret);
> +		return ret;

As above.

> +	}
> +	pdata->ppcount = val;
> +
> +	chip->pdata = pdata;
> +
> +	return 0;
> +}
> +
>  static int apds990x_probe(struct i2c_client *client)
>  {
>  	struct apds990x_chip *chip;
> @@ -1065,13 +1094,10 @@ static int apds990x_probe(struct i2c_client *client)
>  
>  	init_waitqueue_head(&chip->wait);
>  	mutex_init(&chip->mutex);
> -	chip->pdata	= client->dev.platform_data;
>  
> -	if (chip->pdata == NULL) {
> -		dev_err(&client->dev, "platform data is mandatory\n");
> -		err = -EINVAL;
> -		goto fail1;
> -	}
> +	chip->pdata = client->dev.platform_data;

Are there known users of the platform data?  If not can we drop that whilst
doing this conversion?

> +	if (!chip->pdata)
> +		apds990x_of_probe(client, chip);

For a modern driver, don't make it of specific. There are other firmware
types that can use the of table you've added. Look for PRP0001 ACPI
bindings for example that use this.  So name this
apds990x_fw_probe() instead.  You have done all the stuff correctly
with the generic accessors so the actual function looks good to me.

Needs error handling as you can end up without pdata being set.


>  
>  	if (chip->pdata->cf.ga == 0) {
>  		/* set uncovered sensor default parameters */
> @@ -1160,8 +1186,7 @@ static int apds990x_probe(struct i2c_client *client)
>  
>  	err = request_threaded_irq(client->irq, NULL,
>  				apds990x_irq,
> -				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW |
> -				IRQF_ONESHOT,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Ideally the irq type is a problem for device tree, not the driver
(that lets the DT deal with describing the affect of inverters etc in
the signal path).

That causes problems for old DT that assumes the driver is doing it.
I'd like to see a clear description of why this change is here in
the patch description (even better to pull it out to a separate patch
as not obviously connected to of conversion).


>  				"apds990x", chip);
>  	if (err) {
>  		dev_err(&client->dev, "could not get IRQ %d\n",
> @@ -1252,11 +1277,16 @@ static int apds990x_runtime_resume(struct device *dev)
>  
>  #endif
>  
> +static const struct of_device_id apds990x_match_table[] = {
> +	{ .compatible = "avago,apds990x" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, apds990x_match_table);
> +
>  static const struct i2c_device_id apds990x_id[] = {
>  	{"apds990x", 0 },
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, apds990x_id);
>  
>  static const struct dev_pm_ops apds990x_pm_ops = {
> @@ -1270,12 +1300,12 @@ static struct i2c_driver apds990x_driver = {
>  	.driver	 = {
>  		.name	= "apds990x",
>  		.pm	= &apds990x_pm_ops,
> +		.of_match_table = apds990x_match_table,
>  	},
>  	.probe_new = apds990x_probe,
>  	.remove	  = apds990x_remove,
>  	.id_table = apds990x_id,
>  };
> -

Try to avoid unrelated white space changes in a patch that does something else.
Fine to tidy them all up in a separate patch though!

>  module_i2c_driver(apds990x_driver);
>  
>  MODULE_DESCRIPTION("APDS990X combined ALS and proximity sensor");

