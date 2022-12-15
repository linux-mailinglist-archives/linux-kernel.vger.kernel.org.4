Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8764E1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiLOTcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiLOTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:32:09 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7F532CB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:31:13 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 5twkpGLleBonI5twkpk6fX; Thu, 15 Dec 2022 20:31:11 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Dec 2022 20:31:11 +0100
X-ME-IP: 86.243.100.34
Message-ID: <b64004c1-4e25-f266-48ec-b01ad57d393f@wanadoo.fr>
Date:   Thu, 15 Dec 2022 20:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
To:     Joseph Strauss <jstrauss16@proton.me>, pavel@ucw.cz,
        lee@kernel.org, jansimon.moeller@gmx.de
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214222428.7518-1-jstrauss16@proton.me>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221214222428.7518-1-jstrauss16@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/12/2022 à 23:25, Joseph Strauss a écrit :
> Added multicolor support to the BlinkM driver, making it easier to
> control from userspace. The BlinkM LED is a programmable RGB LED. The
> driver currently supports only the regular LED sysfs class, resulting in
> the creation of three distinct classes, one for red, green, and blue.
> The user then has to input three values into the three seperate
> brightness files within those classes. The multicolor LED framework
> makes the device easier to control with the multi_intensity file: the
> user can input three values at once to form a color, while still
> controlling the lightness with the brightness file.
> 
> The main struct blinkm_led has changed slightly. A struct
> led_classdev_mc has been added to represent the multicolor sysfs class,
> and an additional struct led_classdev pointer has been added for
> convenience, which points to the struct led_classdev within struct
> led_classdev_mc. The struct led_classdev for the regular sysfs classes
> remain. Additionally, a field representing the multicolor LED has been
> added to the struct blinkm_data, seperate from the blinkm_leds[3] array.
> 
> In the blinkm_probe function, the multicolor LED class is registered
> after the regular LED classes. The blinkm_set_brightness_mc() function
> had to be added to calculate the three color components and then set the
> fields of the blinkm_data structure accordingly.
> 
> Signed-off-by: Joseph Strauss <jstrauss16@proton.me>

Hi,

a few nits below, should it help.

CJ

> 
> ---
>   Documentation/leds/leds-blinkm.rst |  24 ++++-
>   drivers/leds/Kconfig               |   1 +
>   drivers/leds/leds-blinkm.c         | 154 ++++++++++++++++++++++++-----
>   3 files changed, 151 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
> index c74b5bc877b1..3f5dbd5e97b0 100644
> --- a/Documentation/leds/leds-blinkm.rst
> +++ b/Documentation/leds/leds-blinkm.rst
> @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through separate commands.
>   Also you can store blinking sequences as "scripts" in
>   the controller and run them. Also fading is an option.
> 
> -The interface this driver provides is 2-fold:
> +The interface this driver provides is 3-fold:
> 
> -a) LED class interface for use with triggers
> +a) LED multicolor class interface for use with triggers
> +#######################################################
> +
> +The registration follows the scheme::
> +
> +  blinkm-<i2c-bus-nr>-<i2c-device-nr>-multi
> +
> +  $ ls -h /sys/class/leds/blinkm-1-9-multi
> +  brightness  device  max_brightness  multi_index  multi_intensity  power  subsystem  trigger  uevent
> +
> +The order in which to write the intensity values can be found in multi_index.
> +Exactly three values between 0 and 255 must be written to multi_intensity to change the color::
> +
> +  $ echo 255 100 50 > multi_intensity
> +
> +The overall brightness of the color that you choose can also be changed by
> +writing a value between 0 and 255 to the brightness file.
> +
> +b) LED class interface for use with triggers
>   ############################################
> 
>   The registration follows the scheme::
> @@ -50,7 +68,7 @@ E.g.::
>     $
> 
> 
> -b) Sysfs group to control rgb, fade, hsb, scripts ...
> +c) Sysfs group to control rgb, fade, hsb, scripts ...
>   #####################################################
> 
>   This extended interface is available as folder blinkm
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index b6742b4231bf..6f73deb7d95c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -787,6 +787,7 @@ comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T
>   config LEDS_BLINKM
>   	tristate "LED support for the BlinkM I2C RGB LED"
>   	depends on LEDS_CLASS
> +	depends on LEDS_CLASS_MULTICOLOR
>   	depends on I2C
>   	help
>   	  This option enables support for the BlinkM RGB LED connected
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> index b4e1fdff4186..a78bcc2eaff3 100644
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -15,6 +15,9 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/leds.h>
>   #include <linux/delay.h>
> +#include <linux/led-class-multicolor.h>
> +
> +#define NUM_LEDS 3
> 
>   /* Addresses to scan - BlinkM is on 0x09 by default*/
>   static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> @@ -22,19 +25,26 @@ static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
>   static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
>   static int blinkm_test_run(struct i2c_client *client);
> 
> +/* Contains data structures for both the color-seperated sysfs classes, and the new multicolor class */
>   struct blinkm_led {
>   	struct i2c_client *i2c_client;
> -	struct led_classdev led_cdev;
> +	struct led_classdev monochrome_led_cdev;
> +	/* points to struct led_classdev inside of struct led_classdev_mc */
> +	struct led_classdev *led_cdev;
> +	struct led_classdev_mc mcled_cdev;
>   	int id;
>   };
> 
> -#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, led_cdev)
> +#define monochrome_led_cdev_to_blmled(c)	container_of(c, struct blinkm_led, monochrome_led_cdev)
> +#define mcled_cdev_to_led(c)				container_of(c, struct blinkm_led, mcled_cdev)
> 
>   struct blinkm_data {
>   	struct i2c_client *i2c_client;
>   	struct mutex update_lock;
>   	/* used for led class interface */
> +	struct blinkm_led mc_blinkm_led;
>   	struct blinkm_led blinkm_leds[3];

s/3/NUM_LEDS/ ?

> +
>   	/* used for "blinkm" sysfs interface */
>   	u8 red;			/* color red */
>   	u8 green;		/* color green */
> @@ -260,9 +270,9 @@ static ssize_t test_show(struct device *dev, struct device_attribute *attr,
>   static ssize_t test_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t count)
>   {
> -
>   	struct i2c_client *client;
>   	int ret;
> +

Such things should be part of another patch, because it is unrelated.

>   	client = to_i2c_client(dev);
> 
>   	/*test */
> @@ -317,6 +327,7 @@ static int blinkm_read(struct i2c_client *client, int cmd, u8 *arg)
>   	int result;
>   	int i;
>   	int retlen = blinkm_cmds[cmd].nr_ret;
> +

Ditto

>   	for (i = 0; i < retlen; i++) {
>   		/* repeat for retlen */
>   		result = i2c_smbus_read_byte(client);
> @@ -419,11 +430,53 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
>   	return 0;
>   }
> 
> +static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
> +				 enum led_brightness value)
> +{
> +	struct led_classdev_mc *mcled_cdev;
> +	struct blinkm_led *led;
> +	struct blinkm_data *data;
> +	int i;
> +
> +	mcled_cdev = lcdev_to_mccdev(led_cdev);
> +	led = mcled_cdev_to_led(mcled_cdev);
> +	data = i2c_get_clientdata(led->i2c_client);
> +
> +	led_mc_calc_color_components(mcled_cdev, value);
> +
> +	for (i = 0; i < NUM_LEDS; i++) {
> +		switch (i) {
> +		case RED:
> +			if (data->next_red == (u8) mcled_cdev->subled_info[i].brightness)
> +				break;
> +			data->next_red = (u8) mcled_cdev->subled_info[i].brightness;
> +			break;
> +		case GREEN:
> +			if (data->next_green == (u8) mcled_cdev->subled_info[i].brightness)
> +				break;
> +			data->next_green = (u8) mcled_cdev->subled_info[i].brightness;
> +			break;
> +		case BLUE:
> +			if (data->next_blue == (u8) mcled_cdev->subled_info[i].brightness)
> +				break;
> +			data->next_blue = (u8) mcled_cdev->subled_info[i].brightness;
> +			break;
> +		}
> +	}

Does it really worth all these LoC?

Is this enough?
	data->next_red = (u8)mcled_cdev->subled_info[RED].brightness;
	data->next_green = (u8)mcled_cdev->subled_info[GREEN].brightness;
	data->next_blue = (u8)mcled_cdev->subled_info[BLUE].brightness;

> +	blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
> +	dev_dbg(&led->i2c_client->dev,
> +			"# DONE # next_red = %d, next_green = %d,"
> +			" next_blue = %d\n",

Keep the string on the same line.

> +			data->next_red, data->next_green,
> +			data->next_blue);
> +	return 0;
> +}
> +
>   static int blinkm_led_common_set(struct led_classdev *led_cdev,
>   				 enum led_brightness value, int color)
>   {
>   	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
> -	struct blinkm_led *led = cdev_to_blmled(led_cdev);
> +	struct blinkm_led *led = monochrome_led_cdev_to_blmled(led_cdev);
>   	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
> 
>   	switch (color) {
> @@ -570,7 +623,11 @@ static int blinkm_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
>   	struct blinkm_data *data;
> -	struct blinkm_led *led[3];
> +	/* For multicolor support */
> +	struct blinkm_led *mc_led;
> +	struct mc_subled *mc_led_info;
> +	/* 3 seperate classes for red, green, and blue respectively */
> +	struct blinkm_led *leds[3];

s/3/NUM_LEDS/ ?

>   	int err, i;
>   	char blinkm_led_name[28];
> 
> @@ -581,6 +638,12 @@ static int blinkm_probe(struct i2c_client *client,
>   		goto exit;
>   	}
> 
> +	mc_led_info = devm_kmalloc_array(&client->dev, 3, sizeof(*mc_led_info),

s/3/NUM_LEDS/ ?
s/devm_kmalloc_array(...|__GFP_ZERO)/devm_kcalloc/ ?

> +					GFP_KERNEL | __GFP_ZERO);
> +	if (!mc_led_info) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
>   	data->i2c_addr = 0x08;
>   	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
>   	data->fw_ver = 0xfe;
> @@ -599,28 +662,30 @@ static int blinkm_probe(struct i2c_client *client,
>   		goto exit;
>   	}
> 
> +
> +	/* Register red, green, and blue sysfs classes */
>   	for (i = 0; i < 3; i++) {

s/3/NUM_LEDS/?

>   		/* RED = 0, GREEN = 1, BLUE = 2 */
> -		led[i] = &data->blinkm_leds[i];
> -		led[i]->i2c_client = client;
> -		led[i]->id = i;
> -		led[i]->led_cdev.max_brightness = 255;
> -		led[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> +		leds[i] = &data->blinkm_leds[i];
> +		leds[i]->i2c_client = client;
> +		leds[i]->id = i;
> +		leds[i]->monochrome_led_cdev.max_brightness = 255;
> +		leds[i]->monochrome_led_cdev.flags = LED_CORE_SUSPENDRESUME;
>   		switch (i) {
>   		case RED:
>   			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
>   					 "blinkm-%d-%d-red",
>   					 client->adapter->nr,
>   					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
>   							blinkm_led_red_set;
>   			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> +							&leds[i]->monochrome_led_cdev);
>   			if (err < 0) {
>   				dev_err(&client->dev,
>   					"couldn't register LED %s\n",
> -					led[i]->led_cdev.name);
> +					leds[i]->monochrome_led_cdev.name);
>   				goto failred;
>   			}
>   			break;
> @@ -629,15 +694,15 @@ static int blinkm_probe(struct i2c_client *client,
>   					 "blinkm-%d-%d-green",
>   					 client->adapter->nr,
>   					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
>   							blinkm_led_green_set;
>   			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> +							&leds[i]->monochrome_led_cdev);

Keep the original indentation.

>   			if (err < 0) {
>   				dev_err(&client->dev,
>   					"couldn't register LED %s\n",
> -					led[i]->led_cdev.name);
> +					leds[i]->monochrome_led_cdev.name);
>   				goto failgreen;
>   			}
>   			break;
> @@ -646,34 +711,72 @@ static int blinkm_probe(struct i2c_client *client,
>   					 "blinkm-%d-%d-blue",
>   					 client->adapter->nr,
>   					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> +			leds[i]->monochrome_led_cdev.name = blinkm_led_name;
> +			leds[i]->monochrome_led_cdev.brightness_set_blocking =
>   							blinkm_led_blue_set;
>   			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> +							&leds[i]->monochrome_led_cdev);

Keep the original indentation.

>   			if (err < 0) {
>   				dev_err(&client->dev,
>   					"couldn't register LED %s\n",
> -					led[i]->led_cdev.name);
> +					leds[i]->monochrome_led_cdev.name);
>   				goto failblue;
>   			}
>   			break;
>   		}		/* end switch */
>   	}			/* end for */
> 
> +
> +

One NL is enough.

> +	/* Register multicolor sysfs class */
> +	mc_led = &data->mc_blinkm_led;
> +	mc_led->i2c_client = client;
> +	mc_led->id = 4;

Why 4?
NUM_LEDS+1?

> +
> +	mc_led_info[0].color_index = LED_COLOR_ID_RED;
> +	mc_led_info[0].channel = 0;
> +	mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> +	mc_led_info[1].channel = 1;
> +	mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> +	mc_led_info[2].channel = 2;
> +	mc_led->mcled_cdev.subled_info = mc_led_info;
> +	mc_led->mcled_cdev.num_colors = NUM_LEDS;
> +
> +	mc_led->led_cdev = &mc_led->mcled_cdev.led_cdev;
> +	mc_led->led_cdev->brightness = 255;
> +	mc_led->led_cdev->max_brightness = 255;
> +	mc_led->led_cdev->flags = LED_CORE_SUSPENDRESUME;
> +	snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> +		 "blinkm-%d-%d-multi",
> +		 client->adapter->nr,
> +		 client->addr);
> +	mc_led->led_cdev->name = blinkm_led_name;
> +	mc_led->led_cdev->brightness_set_blocking =
> +					blinkm_set_mc_brightness;
> +
> +	err = led_classdev_multicolor_register(&client->dev, &mc_led->mcled_cdev);
> +	if (err < 0) {
> +		dev_err(&client->dev, "couldn't register LED %s\n",
> +				mc_led->led_cdev->name);
> +		goto failmulti;
> +	}
>   	/* Initialize the blinkm */
>   	blinkm_init_hw(client);
> 
>   	return 0;
> 
> +failmulti:
> +	led_classdev_unregister(&leds[BLUE]->monochrome_led_cdev);
> +
>   failblue:
> -	led_classdev_unregister(&led[GREEN]->led_cdev);
> +	led_classdev_unregister(&leds[GREEN]->monochrome_led_cdev);
> 
>   failgreen:
> -	led_classdev_unregister(&led[RED]->led_cdev);
> +	led_classdev_unregister(&leds[RED]->monochrome_led_cdev);
> 
>   failred:
>   	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> +
>   exit:
>   	return err;
>   }
> @@ -685,8 +788,9 @@ static int blinkm_remove(struct i2c_client *client)
>   	int i;
> 
>   	/* make sure no workqueue entries are pending */
> +	led_classdev_unregister(&data->mc_blinkm_led.mcled_cdev.led_cdev);
>   	for (i = 0; i < 3; i++)

s/3/NUM_LEDS/?

> -		led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
> +		led_classdev_unregister(&data->blinkm_leds[i].monochrome_led_cdev);
> 
>   	/* reset rgb */
>   	data->next_red = 0x00;

