Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5605A6C5A38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCVXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCVXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:21:22 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE73206BD;
        Wed, 22 Mar 2023 16:21:19 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PhkxP73VYz9skM;
        Thu, 23 Mar 2023 00:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1679527274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMHz/b/rhu3TckkP+Vu/yjBYa6HHmovUoHJqISNVO04=;
        b=wSt7l1GBaHrx11EocXw4Sq4rB8BV/E6pFr34ObRVo3LlU7HTdCxXP7HzS0WrmMOtAzyH0i
        x/VqaeNI8r3USvbXR+GY5urn/dYoF2BgxyhQM1d8GRiB9sPHMQyQfjHCm2Pp+Ya3aDfvMm
        9gbEVELEIbHbsj/0dDxARVml7KiUMvDSw0ON8Q9s3YKsf8o9kHvvq40dhE4F4FxI6KKT+f
        KDYAuiXFHcHlkegIQxLNvsUyxrXsbld2pGwQYNq8SK9uXidW2DSEvxxV0wq7ZdhUKIRD6a
        ESjf27Zey8WQmEhUL0n7V0cx/8UzZuer8hz2/Exrc81+AVi59srUI1/bUSrcdw==
Date:   Wed, 22 Mar 2023 18:21:09 -0500
From:   Joseph Strauss <jstrauss@mailbox.org>
To:     Lee Jones <lee@kernel.org>
Cc:     pavel@ucw.cz, jansimon.moeller@gmx.de, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <20230322232109.zddbr4umzfr76wgf@libretux>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
 <20230315161614.GC9667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315161614.GC9667@google.com>
X-MBO-RS-META: achc7ume6me6eeg8y3uwtpu5k7khedpi
X-MBO-RS-ID: 5c84305d07e6ebc00ef
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/15 04:16PM, Lee Jones wrote:
> On Tue, 27 Dec 2022, Joseph Strauss wrote:
> 
> > Added multicolor support to the BlinkM driver, making it easier to
> > control from userspace. The BlinkM LED is a programmable RGB LED. The
> > driver currently supports only the regular LED sysfs class, resulting in
> > the creation of three distinct classes, one for red, green, and blue.
> > The user then has to input three values into the three seperate
> > brightness files within those classes. The multicolor LED framework
> > makes the device easier to control with the multi_intensity file: the
> > user can input three values at once to form a color, while still
> > controlling the lightness with the brightness file.
> >
> > The main struct blinkm_led has changed slightly. A struct
> > led_classdev_mc has been added to represent the multicolor sysfs class,
> > and an additional struct led_classdev pointer has been added for
> > convenience, which points to the struct led_classdev within struct
> > led_classdev_mc. The struct led_classdev for the regular sysfs classes
> > remain. Additionally, a field representing the multicolor LED has been
> > added to the struct blinkm_data, seperate from the blinkm_leds[3] array.
> >
> > In the blinkm_probe function, the multicolor LED class is registered
> > after the regular LED classes. The blinkm_set_mc_brightness() function
> > had to be added to calculate the three color components and then set the
> > fields of the blinkm_data structure accordingly.
> >
> > Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> > ---
> > Changes in v2:
> > - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> > - Fixed formatting errors
> > - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
> >   statements
> > - Changed id of multicolor class from 4 to 3
> > - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> >
> >  Documentation/leds/leds-blinkm.rst |  26 +++++-
> >  drivers/leds/Kconfig               |   1 +
> >  drivers/leds/leds-blinkm.c         | 143 +++++++++++++++++++++++------
> >  3 files changed, 137 insertions(+), 33 deletions(-)
> >
> > diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
> > index c74b5bc877b1..542a35432c57 100644
> > --- a/Documentation/leds/leds-blinkm.rst
> > +++ b/Documentation/leds/leds-blinkm.rst
> > @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through separate commands.
> >  Also you can store blinking sequences as "scripts" in
> >  the controller and run them. Also fading is an option.
> >
> > -The interface this driver provides is 2-fold:
> > +The interface this driver provides is 3-fold:
> >
> > -a) LED class interface for use with triggers
> > +a) LED multicolor class interface for use with triggers
> > +#######################################################
> > +
> > +The registration follows the scheme::
> > +
> > +  blinkm-<i2c-bus-nr>-<i2c-device-nr>-multi
> > +
> > +  $ ls -h /sys/class/leds/blinkm-1-9-multi
> > +  brightness  device  max_brightness  multi_index  multi_intensity  power  subsystem  trigger  uevent
> > +
> > +The order in which to write the intensity values can be found in multi_index.
> > +Exactly three values between 0 and 255 must be written to multi_intensity to change the color::
> > +
> > +  $ echo 255 100 50 > multi_intensity
> > +
> > +The overall brightness of the color that you choose can also be changed by
> > +writing a value between 0 and 255 to the brightness file.
> > +
> > +b) LED class interface for use with triggers
> >  ############################################
> >
> >  The registration follows the scheme::
> > @@ -50,7 +68,7 @@ E.g.::
> >    $
> >
> >
> > -b) Sysfs group to control rgb, fade, hsb, scripts ...
> > +c) Sysfs group to control rgb, fade, hsb, scripts ...
> >  #####################################################
> >
> >  This extended interface is available as folder blinkm
> > @@ -79,6 +97,6 @@ E.g.::
> >
> >
> >
> > -as of 6/2012
> > +as of 12/2022
> >
> >  dl9pf <at> gmx <dot> de
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index 499d0f215a8b..8ec06f1f60af 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -731,6 +731,7 @@ comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T
> >  config LEDS_BLINKM
> >  	tristate "LED support for the BlinkM I2C RGB LED"
> >  	depends on LEDS_CLASS
> > +    depends on LEDS_CLASS_MULTICOLOR
> 
> Indentation?
> 
> >  	depends on I2C
> >  	help
> >  	  This option enables support for the BlinkM RGB LED connected
> > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > index 3fb6a2fdaefa..252b20da7137 100644
> > --- a/drivers/leds/leds-blinkm.c
> > +++ b/drivers/leds/leds-blinkm.c
> > @@ -15,6 +15,9 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/leds.h>
> >  #include <linux/delay.h>
> > +#include <linux/led-class-multicolor.h>
> > +
> > +#define NUM_LEDS 3
> >
> >  /* Addresses to scan - BlinkM is on 0x09 by default*/
> >  static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> > @@ -22,19 +25,26 @@ static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> >  static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
> >  static int blinkm_test_run(struct i2c_client *client);
> >
> > +/* Contains data structures for both the color-seperated sysfs classes, and the new multicolor class */
> >  struct blinkm_led {
> >  	struct i2c_client *i2c_client;
> > -	struct led_classdev led_cdev;
> > +	struct led_classdev monochrome_led_cdev;
> > +	/* points to struct led_classdev inside of struct led_classdev_mc */
> 
> You mean mcled_cdev (1 line below) or something different?
> 
> If the former, why not just use mcled_cdev directly?
> 
> > +	struct led_classdev *led_cdev;
> > +	struct led_classdev_mc mcled_cdev;
> >  	int id;
> >  };
> >
> > -#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, led_cdev)
> > +#define monochrome_led_cdev_to_blmled(c)	container_of(c, struct blinkm_led, monochrome_led_cdev)
> > +#define mcled_cdev_to_led(c)				container_of(c, struct blinkm_led, mcled_cdev)
> >
> >  struct blinkm_data {
> >  	struct i2c_client *i2c_client;
> >  	struct mutex update_lock;
> >  	/* used for led class interface */
> > -	struct blinkm_led blinkm_leds[3];
> > +	struct blinkm_led mc_blinkm_led;
> > +	struct blinkm_led blinkm_leds[NUM_LEDS];
> 
> Why not just use the first element in the mc case?
> 
> >  	/* used for "blinkm" sysfs interface */
> >  	u8 red;			/* color red */
> >  	u8 green;		/* color green */
> > @@ -419,11 +429,36 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
> >  	return 0;
> >  }
> >
> > +static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
> > +				 enum led_brightness value)
> > +{
> > +	struct led_classdev_mc *mcled_cdev;
> > +	struct blinkm_led *led;
> > +	struct blinkm_data *data;
> > +
> > +	mcled_cdev = lcdev_to_mccdev(led_cdev);
> > +	led = mcled_cdev_to_led(mcled_cdev);
> 
> Do these 2 on the declaration lines.
> 
> > +	data = i2c_get_clientdata(led->i2c_client);
> > +
> > +	led_mc_calc_color_components(mcled_cdev, value);
> > +
> > +	data->next_red = (u8) mcled_cdev->subled_info[RED].brightness;
> > +	data->next_green = (u8) mcled_cdev->subled_info[GREEN].brightness;
> > +	data->next_blue = (u8) mcled_cdev->subled_info[BLUE].brightness;
> > +
> > +	blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
> 
> '\n'
> 
> > +	dev_dbg(&led->i2c_client->dev,
> > +			"# DONE # next_red = %d, next_green = %d, next_blue = %d\n",
> > +			data->next_red, data->next_green,
> > +			data->next_blue);
> 
> Please consider how useful this really is and delete it if possible.
> 
> > +	return 0;
> > +}
> > +
> >  static int blinkm_led_common_set(struct led_classdev *led_cdev,
> >  				 enum led_brightness value, int color)
> >  {
> >  	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
> > -	struct blinkm_led *led = cdev_to_blmled(led_cdev);
> > +	struct blinkm_led *led = monochrome_led_cdev_to_blmled(led_cdev);
> >  	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
> >
> >  	switch (color) {
> > @@ -480,8 +515,9 @@ static int blinkm_led_blue_set(struct led_classdev *led_cdev,
> >
> >  static void blinkm_init_hw(struct i2c_client *client)
> >  {
> > -	blinkm_transfer_hw(client, BLM_STOP_SCRIPT);
> > -	blinkm_transfer_hw(client, BLM_GO_RGB);
> > +	int ret;
> > +	ret = blinkm_transfer_hw(client, BLM_STOP_SCRIPT);
> > +	ret = blinkm_transfer_hw(client, BLM_GO_RGB);
> 
> This is an unused variable, no?
> 
> Did you build with W=1?
> 
> >  }
> >
> >  static int blinkm_test_run(struct i2c_client *client)
> > @@ -569,7 +605,11 @@ static int blinkm_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *id)
> >  {
> >  	struct blinkm_data *data;
> > -	struct blinkm_led *led[3];
> > +	/* For multicolor support */
> > +	struct blinkm_led *mc_led;
> > +	struct mc_subled *mc_led_info;
> > +	/* 3 seperate classes for red, green, and blue respectively */
> > +	struct blinkm_led *leds[NUM_LEDS];
> >  	int err, i;
> >  	char blinkm_led_name[28];
> >
> > @@ -580,6 +620,12 @@ static int blinkm_probe(struct i2c_client *client,
> >  		goto exit;
> >  	}
> >
> > +	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
> > +					GFP_KERNEL);
> > +	if (!mc_led_info) {
> > +		err = -ENOMEM;
> > +		goto exit;
> > +	}
> >  	data->i2c_addr = 0x08;
> >  	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
> >  	data->fw_ver = 0xfe;
> > @@ -598,28 +644,30 @@ static int blinkm_probe(struct i2c_client *client,
> >  		goto exit;
> >  	}
> >
> > -	for (i = 0; i < 3; i++) {
> > +
> > +	/* Register red, green, and blue sysfs classes */
> > +	for (i = 0; i < NUM_LEDS; i++) {
> >  		/* RED = 0, GREEN = 1, BLUE = 2 */
> > -		led[i] = &data->blinkm_leds[i];
> > -		led[i]->i2c_client = client;
> > -		led[i]->id = i;
> > -		led[i]->led_cdev.max_brightness = 255;
> > -		led[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> > +		leds[i] = &data->blinkm_leds[i];
> > +		leds[i]->i2c_client = client;
> > +		leds[i]->id = i;
> > +		leds[i]->monochrome_led_cdev.max_brightness = 255;
> > +		leds[i]->monochrome_led_cdev.flags = LED_CORE_SUSPENDRESUME;
> >  		switch (i) {
> >  		case RED:
> >  			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> >  					 "blinkm-%d-%d-red",
> >  					 client->adapter->nr,
> >  					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> > +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
> >  							blinkm_led_red_set;
> >  			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > +						    &leds[i]->monochrome_led_cdev);
> >  			if (err < 0) {
> >  				dev_err(&client->dev,
> >  					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > +					leds[i]->monochrome_led_cdev.name);
> >  				goto failred;
> >  			}
> >  			break;
> > @@ -628,15 +676,15 @@ static int blinkm_probe(struct i2c_client *client,
> >  					 "blinkm-%d-%d-green",
> >  					 client->adapter->nr,
> >  					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> > +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
> >  							blinkm_led_green_set;
> >  			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > +						    &leds[i]->monochrome_led_cdev);
> >  			if (err < 0) {
> >  				dev_err(&client->dev,
> >  					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > +					leds[i]->monochrome_led_cdev.name);
> >  				goto failgreen;
> >  			}
> >  			break;
> > @@ -645,34 +693,70 @@ static int blinkm_probe(struct i2c_client *client,
> >  					 "blinkm-%d-%d-blue",
> >  					 client->adapter->nr,
> >  					 client->addr);
> > -			led[i]->led_cdev.name = blinkm_led_name;
> > -			led[i]->led_cdev.brightness_set_blocking =
> > +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> > +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
> >  							blinkm_led_blue_set;
> >  			err = led_classdev_register(&client->dev,
> > -						    &led[i]->led_cdev);
> > +						    &leds[i]->monochrome_led_cdev);
> >  			if (err < 0) {
> >  				dev_err(&client->dev,
> >  					"couldn't register LED %s\n",
> > -					led[i]->led_cdev.name);
> > +					leds[i]->monochrome_led_cdev.name);
> >  				goto failblue;
> >  			}
> >  			break;
> >  		}		/* end switch */
> >  	}			/* end for */
> >
> > +	/* Register multicolor sysfs class */
> > +	mc_led = &data->mc_blinkm_led;
> > +	mc_led->i2c_client = client;
> > +	mc_led->id = 3;
> 
> NUM_LEDS?
> 
> > +	mc_led_info[0].color_index = LED_COLOR_ID_RED;
> 
> These magic numbers should be defined.
> 
> > +	mc_led_info[0].channel = 0;
> 
> Are these channel numbers arbitrary?
> 

On second glance, I'm not sure if channel numbers are necessary for this
driver. I don't have much experience with other LEDs, so I'm not sure
what they would be used for. Deleting them does not seem to break the
driver, so I could do that...

> > +	mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> > +	mc_led_info[1].channel = 1;
> > +	mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> > +	mc_led_info[2].channel = 2;
> > +	mc_led->mcled_cdev.subled_info = mc_led_info;
> > +	mc_led->mcled_cdev.num_colors = NUM_LEDS;
> > +
> > +	mc_led->led_cdev = &mc_led->mcled_cdev.led_cdev;
> > +	mc_led->led_cdev->brightness = 255;
> > +	mc_led->led_cdev->max_brightness = 255;
> > +	mc_led->led_cdev->flags = LED_CORE_SUSPENDRESUME;
> > +	snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +		 "blinkm-%d-%d-multi",
> > +		 client->adapter->nr,
> > +		 client->addr);
> > +	mc_led->led_cdev->name = blinkm_led_name;
> > +	mc_led->led_cdev->brightness_set_blocking =
> > +					blinkm_set_mc_brightness;
> 
> 100-chars.
> 

I am not sure what you mean by this. The following line is 78
characters.
> > +	err = led_classdev_multicolor_register(&client->dev, &mc_led->mcled_cdev);
> > +	if (err < 0) {
> > +		dev_err(&client->dev, "couldn't register LED %s\n",
> > +				mc_led->led_cdev->name);
> > +		goto failmulti;
> > +	}
> 
> '\n'
> 
> >  	/* Initialize the blinkm */
> 
> This comment is superfluous.
> 
> >  	blinkm_init_hw(client);
> >
> >  	return 0;
> >
> > +failmulti:
> > +	led_classdev_unregister(&leds[BLUE]->monochrome_led_cdev);
> > +
> >  failblue:
> > -	led_classdev_unregister(&led[GREEN]->led_cdev);
> > +	led_classdev_unregister(&leds[GREEN]->monochrome_led_cdev);
> >
> >  failgreen:
> > -	led_classdev_unregister(&led[RED]->led_cdev);
> > +	led_classdev_unregister(&leds[RED]->monochrome_led_cdev);
> >
> >  failred:
> >  	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> > +
> >  exit:
> 
> If you want to submit a patch to get rid of this exit label ...
> 

This exit label existed before my patch and is used in several places. I
don't quite see what's wrong with it. Would you please clarify?

> >  	return err;
> >  }
> > @@ -684,8 +768,9 @@ static void blinkm_remove(struct i2c_client *client)
> >  	int i;
> >
> >  	/* make sure no workqueue entries are pending */
> > -	for (i = 0; i < 3; i++)
> > -		led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
> > +	led_classdev_unregister(&data->mc_blinkm_led.mcled_cdev.led_cdev);
> > +	for (i = 0; i < NUM_LEDS; i++)
> > +		led_classdev_unregister(&data->blinkm_leds[i].monochrome_led_cdev);
> >
> >  	/* reset rgb */
> >  	data->next_red = 0x00;
> > --
> > 2.38.1
> >
> 
> --
> Lee Jones [李琼斯]

Thank you Lee for the feedback, much appreciated! v3 should be ready
soon.

Joe Strauss
