Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17819656669
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 02:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiL0BTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 20:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiL0BTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 20:19:07 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161842AE8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:19:06 -0800 (PST)
Date:   Tue, 27 Dec 2022 01:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1672103941; x=1672363141;
        bh=Au5noIoHw/3Xo7O/X6HTBEZNcnvuqe2ir7DgSftQY2o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CegFVo6IkUclSaT/6IBL8YDiKNsM9vSyEmDX7WF4OOdIcKmXguAnME85QFLWpfAtD
         MIPetji2Da34mib3EzD+08kNie54I1xGuAPulE8qs6fEZVY6zrq9VLbs1gAT2FujyT
         yUUDvsNKuJ7naNXSwprhZgHh4izwh6VR00ZTNC69Vj1OGANOUKdNm2e4dJJCZppgl4
         vYK2uNJSnEA/m0iR5xuI8yCkP137mR7zaTUvGYH6KZ8hamnTMeOgR8j5KDhULWoiva
         3lN7GwV2aE3GguYYKb7M0gLRujP9MoJxmT7OqwJf7SPv3O5EYGFacX6Ajk5nUGTHkt
         JiFACpYw5eVeg==
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
From:   Joseph Strauss <jstrauss16@proton.me>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <20221227011853.rjnodbrllhrakpkx@libretux>
In-Reply-To: <b64004c1-4e25-f266-48ec-b01ad57d393f@wanadoo.fr>
References: <20221214222428.7518-1-jstrauss16@proton.me> <b64004c1-4e25-f266-48ec-b01ad57d393f@wanadoo.fr>
Feedback-ID: 52406082:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/15 08:31PM, Christophe JAILLET wrote:
> Le 14/12/2022 =C3=A0 23:25, Joseph Strauss a =C3=A9crit=C2=A0:
> > Added multicolor support to the BlinkM driver, making it easier to
> > control from userspace. The BlinkM LED is a programmable RGB LED. The
> > driver currently supports only the regular LED sysfs class, resulting i=
n
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
> > added to the struct blinkm_data, seperate from the blinkm_leds[3] array=
.
> >
> > In the blinkm_probe function, the multicolor LED class is registered
> > after the regular LED classes. The blinkm_set_brightness_mc() function
> > had to be added to calculate the three color components and then set th=
e
> > fields of the blinkm_data structure accordingly.
> >
> > Signed-off-by: Joseph Strauss <jstrauss16@proton.me>
>
> Hi,
>
> a few nits below, should it help.
>
> CJ
>
> >
> > ---
> >   Documentation/leds/leds-blinkm.rst |  24 ++++-
> >   drivers/leds/Kconfig               |   1 +
> >   drivers/leds/leds-blinkm.c         | 154 ++++++++++++++++++++++++----=
-
> >   3 files changed, 151 insertions(+), 28 deletions(-)
> >
> > diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/le=
ds-blinkm.rst
> > index c74b5bc877b1..3f5dbd5e97b0 100644
> > --- a/Documentation/leds/leds-blinkm.rst
> > +++ b/Documentation/leds/leds-blinkm.rst
> > @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through =
separate commands.
> >   Also you can store blinking sequences as "scripts" in
> >   the controller and run them. Also fading is an option.
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
> > +  brightness  device  max_brightness  multi_index  multi_intensity  po=
wer  subsystem  trigger  uevent
> > +
> > +The order in which to write the intensity values can be found in multi=
_index.
> > +Exactly three values between 0 and 255 must be written to multi_intens=
ity to change the color::
> > +
> > +  $ echo 255 100 50 > multi_intensity
> > +
> > +The overall brightness of the color that you choose can also be change=
d by
> > +writing a value between 0 and 255 to the brightness file.
> > +
> > +b) LED class interface for use with triggers
> >   ############################################
> >
> >   The registration follows the scheme::
> > @@ -50,7 +68,7 @@ E.g.::
> >     $
> >
> >
> > -b) Sysfs group to control rgb, fade, hsb, scripts ...
> > +c) Sysfs group to control rgb, fade, hsb, scripts ...
> >   #####################################################
> >
> >   This extended interface is available as folder blinkm
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index b6742b4231bf..6f73deb7d95c 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -787,6 +787,7 @@ comment "LED driver for blink(1) USB RGB LED is und=
er Special HID drivers (HID_T
> >   config LEDS_BLINKM
> >   =09tristate "LED support for the BlinkM I2C RGB LED"
> >   =09depends on LEDS_CLASS
> > +=09depends on LEDS_CLASS_MULTICOLOR
> >   =09depends on I2C
> >   =09help
> >   =09  This option enables support for the BlinkM RGB LED connected
> > diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> > index b4e1fdff4186..a78bcc2eaff3 100644
> > --- a/drivers/leds/leds-blinkm.c
> > +++ b/drivers/leds/leds-blinkm.c
> > @@ -15,6 +15,9 @@
> >   #include <linux/pm_runtime.h>
> >   #include <linux/leds.h>
> >   #include <linux/delay.h>
> > +#include <linux/led-class-multicolor.h>
> > +
> > +#define NUM_LEDS 3
> >
> >   /* Addresses to scan - BlinkM is on 0x09 by default*/
> >   static const unsigned short normal_i2c[] =3D { 0x09, I2C_CLIENT_END }=
;
> > @@ -22,19 +25,26 @@ static const unsigned short normal_i2c[] =3D { 0x09=
, I2C_CLIENT_END };
> >   static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
> >   static int blinkm_test_run(struct i2c_client *client);
> >
> > +/* Contains data structures for both the color-seperated sysfs classes=
, and the new multicolor class */
> >   struct blinkm_led {
> >   =09struct i2c_client *i2c_client;
> > -=09struct led_classdev led_cdev;
> > +=09struct led_classdev monochrome_led_cdev;
> > +=09/* points to struct led_classdev inside of struct led_classdev_mc *=
/
> > +=09struct led_classdev *led_cdev;
> > +=09struct led_classdev_mc mcled_cdev;
> >   =09int id;
> >   };
> >
> > -#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, =
led_cdev)
> > +#define monochrome_led_cdev_to_blmled(c)=09container_of(c, struct blin=
km_led, monochrome_led_cdev)
> > +#define mcled_cdev_to_led(c)=09=09=09=09container_of(c, struct blinkm_=
led, mcled_cdev)
> >
> >   struct blinkm_data {
> >   =09struct i2c_client *i2c_client;
> >   =09struct mutex update_lock;
> >   =09/* used for led class interface */
> > +=09struct blinkm_led mc_blinkm_led;
> >   =09struct blinkm_led blinkm_leds[3];
>
> s/3/NUM_LEDS/ ?
>
> > +
> >   =09/* used for "blinkm" sysfs interface */
> >   =09u8 red;=09=09=09/* color red */
> >   =09u8 green;=09=09/* color green */
> > @@ -260,9 +270,9 @@ static ssize_t test_show(struct device *dev, struct=
 device_attribute *attr,
> >   static ssize_t test_store(struct device *dev, struct device_attribute=
 *attr,
> >   =09=09=09  const char *buf, size_t count)
> >   {
> > -
> >   =09struct i2c_client *client;
> >   =09int ret;
> > +
>
> Such things should be part of another patch, because it is unrelated.
>
> >   =09client =3D to_i2c_client(dev);
> >
> >   =09/*test */
> > @@ -317,6 +327,7 @@ static int blinkm_read(struct i2c_client *client, i=
nt cmd, u8 *arg)
> >   =09int result;
> >   =09int i;
> >   =09int retlen =3D blinkm_cmds[cmd].nr_ret;
> > +
>
> Ditto
>
> >   =09for (i =3D 0; i < retlen; i++) {
> >   =09=09/* repeat for retlen */
> >   =09=09result =3D i2c_smbus_read_byte(client);
> > @@ -419,11 +430,53 @@ static int blinkm_transfer_hw(struct i2c_client *=
client, int cmd)
> >   =09return 0;
> >   }
> >
> > +static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
> > +=09=09=09=09 enum led_brightness value)
> > +{
> > +=09struct led_classdev_mc *mcled_cdev;
> > +=09struct blinkm_led *led;
> > +=09struct blinkm_data *data;
> > +=09int i;
> > +
> > +=09mcled_cdev =3D lcdev_to_mccdev(led_cdev);
> > +=09led =3D mcled_cdev_to_led(mcled_cdev);
> > +=09data =3D i2c_get_clientdata(led->i2c_client);
> > +
> > +=09led_mc_calc_color_components(mcled_cdev, value);
> > +
> > +=09for (i =3D 0; i < NUM_LEDS; i++) {
> > +=09=09switch (i) {
> > +=09=09case RED:
> > +=09=09=09if (data->next_red =3D=3D (u8) mcled_cdev->subled_info[i].bri=
ghtness)
> > +=09=09=09=09break;
> > +=09=09=09data->next_red =3D (u8) mcled_cdev->subled_info[i].brightness=
;
> > +=09=09=09break;
> > +=09=09case GREEN:
> > +=09=09=09if (data->next_green =3D=3D (u8) mcled_cdev->subled_info[i].b=
rightness)
> > +=09=09=09=09break;
> > +=09=09=09data->next_green =3D (u8) mcled_cdev->subled_info[i].brightne=
ss;
> > +=09=09=09break;
> > +=09=09case BLUE:
> > +=09=09=09if (data->next_blue =3D=3D (u8) mcled_cdev->subled_info[i].br=
ightness)
> > +=09=09=09=09break;
> > +=09=09=09data->next_blue =3D (u8) mcled_cdev->subled_info[i].brightnes=
s;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
>
> Does it really worth all these LoC?
>
> Is this enough?
> =09data->next_red =3D (u8)mcled_cdev->subled_info[RED].brightness;
> =09data->next_green =3D (u8)mcled_cdev->subled_info[GREEN].brightness;
> =09data->next_blue =3D (u8)mcled_cdev->subled_info[BLUE].brightness;
>
> > +=09blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
> > +=09dev_dbg(&led->i2c_client->dev,
> > +=09=09=09"# DONE # next_red =3D %d, next_green =3D %d,"
> > +=09=09=09" next_blue =3D %d\n",
>
> Keep the string on the same line.
>
> > +=09=09=09data->next_red, data->next_green,
> > +=09=09=09data->next_blue);
> > +=09return 0;
> > +}
> > +
> >   static int blinkm_led_common_set(struct led_classdev *led_cdev,
> >   =09=09=09=09 enum led_brightness value, int color)
> >   {
> >   =09/* led_brightness is 0, 127 or 255 - we just use it here as-is */
> > -=09struct blinkm_led *led =3D cdev_to_blmled(led_cdev);
> > +=09struct blinkm_led *led =3D monochrome_led_cdev_to_blmled(led_cdev);
> >   =09struct blinkm_data *data =3D i2c_get_clientdata(led->i2c_client);
> >
> >   =09switch (color) {
> > @@ -570,7 +623,11 @@ static int blinkm_probe(struct i2c_client *client,
> >   =09=09=09const struct i2c_device_id *id)
> >   {
> >   =09struct blinkm_data *data;
> > -=09struct blinkm_led *led[3];
> > +=09/* For multicolor support */
> > +=09struct blinkm_led *mc_led;
> > +=09struct mc_subled *mc_led_info;
> > +=09/* 3 seperate classes for red, green, and blue respectively */
> > +=09struct blinkm_led *leds[3];
>
> s/3/NUM_LEDS/ ?
>
> >   =09int err, i;
> >   =09char blinkm_led_name[28];
> >
> > @@ -581,6 +638,12 @@ static int blinkm_probe(struct i2c_client *client,
> >   =09=09goto exit;
> >   =09}
> >
> > +=09mc_led_info =3D devm_kmalloc_array(&client->dev, 3, sizeof(*mc_led_=
info),
>
> s/3/NUM_LEDS/ ?
> s/devm_kmalloc_array(...|__GFP_ZERO)/devm_kcalloc/ ?
>
> > +=09=09=09=09=09GFP_KERNEL | __GFP_ZERO);
> > +=09if (!mc_led_info) {
> > +=09=09err =3D -ENOMEM;
> > +=09=09goto exit;
> > +=09}
> >   =09data->i2c_addr =3D 0x08;
> >   =09/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
> >   =09data->fw_ver =3D 0xfe;
> > @@ -599,28 +662,30 @@ static int blinkm_probe(struct i2c_client *client=
,
> >   =09=09goto exit;
> >   =09}
> >
> > +
> > +=09/* Register red, green, and blue sysfs classes */
> >   =09for (i =3D 0; i < 3; i++) {
>
> s/3/NUM_LEDS/?
>
> >   =09=09/* RED =3D 0, GREEN =3D 1, BLUE =3D 2 */
> > -=09=09led[i] =3D &data->blinkm_leds[i];
> > -=09=09led[i]->i2c_client =3D client;
> > -=09=09led[i]->id =3D i;
> > -=09=09led[i]->led_cdev.max_brightness =3D 255;
> > -=09=09led[i]->led_cdev.flags =3D LED_CORE_SUSPENDRESUME;
> > +=09=09leds[i] =3D &data->blinkm_leds[i];
> > +=09=09leds[i]->i2c_client =3D client;
> > +=09=09leds[i]->id =3D i;
> > +=09=09leds[i]->monochrome_led_cdev.max_brightness =3D 255;
> > +=09=09leds[i]->monochrome_led_cdev.flags =3D LED_CORE_SUSPENDRESUME;
> >   =09=09switch (i) {
> >   =09=09case RED:
> >   =09=09=09snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> >   =09=09=09=09=09 "blinkm-%d-%d-red",
> >   =09=09=09=09=09 client->adapter->nr,
> >   =09=09=09=09=09 client->addr);
> > -=09=09=09led[i]->led_cdev.name =3D blinkm_led_name;
> > -=09=09=09led[i]->led_cdev.brightness_set_blocking =3D
> > +=09=09=09leds[i]->monochrome_led_cdev.name =3D blinkm_led_name;
> > +=09=09=09leds[i]->monochrome_led_cdev.brightness_set_blocking =3D
> >   =09=09=09=09=09=09=09blinkm_led_red_set;
> >   =09=09=09err =3D led_classdev_register(&client->dev,
> > -=09=09=09=09=09=09    &led[i]->led_cdev);
> > +=09=09=09=09=09=09=09&leds[i]->monochrome_led_cdev);
> >   =09=09=09if (err < 0) {
> >   =09=09=09=09dev_err(&client->dev,
> >   =09=09=09=09=09"couldn't register LED %s\n",
> > -=09=09=09=09=09led[i]->led_cdev.name);
> > +=09=09=09=09=09leds[i]->monochrome_led_cdev.name);
> >   =09=09=09=09goto failred;
> >   =09=09=09}
> >   =09=09=09break;
> > @@ -629,15 +694,15 @@ static int blinkm_probe(struct i2c_client *client=
,
> >   =09=09=09=09=09 "blinkm-%d-%d-green",
> >   =09=09=09=09=09 client->adapter->nr,
> >   =09=09=09=09=09 client->addr);
> > -=09=09=09led[i]->led_cdev.name =3D blinkm_led_name;
> > -=09=09=09led[i]->led_cdev.brightness_set_blocking =3D
> > +=09=09=09leds[i]->monochrome_led_cdev.name =3D blinkm_led_name;
> > +=09=09=09leds[i]->monochrome_led_cdev.brightness_set_blocking =3D
> >   =09=09=09=09=09=09=09blinkm_led_green_set;
> >   =09=09=09err =3D led_classdev_register(&client->dev,
> > -=09=09=09=09=09=09    &led[i]->led_cdev);
> > +=09=09=09=09=09=09=09&leds[i]->monochrome_led_cdev);
>
> Keep the original indentation.
>
> >   =09=09=09if (err < 0) {
> >   =09=09=09=09dev_err(&client->dev,
> >   =09=09=09=09=09"couldn't register LED %s\n",
> > -=09=09=09=09=09led[i]->led_cdev.name);
> > +=09=09=09=09=09leds[i]->monochrome_led_cdev.name);
> >   =09=09=09=09goto failgreen;
> >   =09=09=09}
> >   =09=09=09break;
> > @@ -646,34 +711,72 @@ static int blinkm_probe(struct i2c_client *client=
,
> >   =09=09=09=09=09 "blinkm-%d-%d-blue",
> >   =09=09=09=09=09 client->adapter->nr,
> >   =09=09=09=09=09 client->addr);
> > -=09=09=09led[i]->led_cdev.name =3D blinkm_led_name;
> > -=09=09=09led[i]->led_cdev.brightness_set_blocking =3D
> > +=09=09=09leds[i]->monochrome_led_cdev.name =3D blinkm_led_name;
> > +=09=09=09leds[i]->monochrome_led_cdev.brightness_set_blocking =3D
> >   =09=09=09=09=09=09=09blinkm_led_blue_set;
> >   =09=09=09err =3D led_classdev_register(&client->dev,
> > -=09=09=09=09=09=09    &led[i]->led_cdev);
> > +=09=09=09=09=09=09=09&leds[i]->monochrome_led_cdev);
>
> Keep the original indentation.
>
> >   =09=09=09if (err < 0) {
> >   =09=09=09=09dev_err(&client->dev,
> >   =09=09=09=09=09"couldn't register LED %s\n",
> > -=09=09=09=09=09led[i]->led_cdev.name);
> > +=09=09=09=09=09leds[i]->monochrome_led_cdev.name);
> >   =09=09=09=09goto failblue;
> >   =09=09=09}
> >   =09=09=09break;
> >   =09=09}=09=09/* end switch */
> >   =09}=09=09=09/* end for */
> >
> > +
> > +
>
> One NL is enough.
>
> > +=09/* Register multicolor sysfs class */
> > +=09mc_led =3D &data->mc_blinkm_led;
> > +=09mc_led->i2c_client =3D client;
> > +=09mc_led->id =3D 4;
>
> Why 4?
> NUM_LEDS+1?
>
> > +
> > +=09mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
> > +=09mc_led_info[0].channel =3D 0;
> > +=09mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
> > +=09mc_led_info[1].channel =3D 1;
> > +=09mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
> > +=09mc_led_info[2].channel =3D 2;
> > +=09mc_led->mcled_cdev.subled_info =3D mc_led_info;
> > +=09mc_led->mcled_cdev.num_colors =3D NUM_LEDS;
> > +
> > +=09mc_led->led_cdev =3D &mc_led->mcled_cdev.led_cdev;
> > +=09mc_led->led_cdev->brightness =3D 255;
> > +=09mc_led->led_cdev->max_brightness =3D 255;
> > +=09mc_led->led_cdev->flags =3D LED_CORE_SUSPENDRESUME;
> > +=09snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> > +=09=09 "blinkm-%d-%d-multi",
> > +=09=09 client->adapter->nr,
> > +=09=09 client->addr);
> > +=09mc_led->led_cdev->name =3D blinkm_led_name;
> > +=09mc_led->led_cdev->brightness_set_blocking =3D
> > +=09=09=09=09=09blinkm_set_mc_brightness;
> > +
> > +=09err =3D led_classdev_multicolor_register(&client->dev, &mc_led->mcl=
ed_cdev);
> > +=09if (err < 0) {
> > +=09=09dev_err(&client->dev, "couldn't register LED %s\n",
> > +=09=09=09=09mc_led->led_cdev->name);
> > +=09=09goto failmulti;
> > +=09}
> >   =09/* Initialize the blinkm */
> >   =09blinkm_init_hw(client);
> >
> >   =09return 0;
> >
> > +failmulti:
> > +=09led_classdev_unregister(&leds[BLUE]->monochrome_led_cdev);
> > +
> >   failblue:
> > -=09led_classdev_unregister(&led[GREEN]->led_cdev);
> > +=09led_classdev_unregister(&leds[GREEN]->monochrome_led_cdev);
> >
> >   failgreen:
> > -=09led_classdev_unregister(&led[RED]->led_cdev);
> > +=09led_classdev_unregister(&leds[RED]->monochrome_led_cdev);
> >
> >   failred:
> >   =09sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> > +
> >   exit:
> >   =09return err;
> >   }
> > @@ -685,8 +788,9 @@ static int blinkm_remove(struct i2c_client *client)
> >   =09int i;
> >
> >   =09/* make sure no workqueue entries are pending */
> > +=09led_classdev_unregister(&data->mc_blinkm_led.mcled_cdev.led_cdev);
> >   =09for (i =3D 0; i < 3; i++)
>
> s/3/NUM_LEDS/?
>
> > -=09=09led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
> > +=09=09led_classdev_unregister(&data->blinkm_leds[i].monochrome_led_cde=
v);
> >
> >   =09/* reset rgb */
> >   =09data->next_red =3D 0x00;
>
Hi!

Thank you very much for reviewing my patch. I will be sure to make those
changes, as they were mostly small oversights and silly mistakes.

Best Regards,
Joe

