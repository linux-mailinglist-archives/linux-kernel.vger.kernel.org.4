Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63536663C76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjAJJNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjAJJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:13:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629E49166;
        Tue, 10 Jan 2023 01:13:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso10964470pjl.2;
        Tue, 10 Jan 2023 01:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvr55aXHbea2ozkc5Nlpf+W9U5hKlHGp9lm0Hq7tg40=;
        b=Ili++olI3d46r39kc+7hgIjnePKnztN5oW1YR2QSCjd8+Xs8r6MNQqM3Az+qRJlGjw
         1FDnrZQi32Xxy9ij3wpCZ6I7StWiRxYygIFCxDOpG4b1pyhf2iefIKdKfaq/+3mEz2Ao
         i/zYcgApHZWidDvw3KAKpAISDJsRj973k3d276bCue4UItkmEPOxdSlnQ024otNZzt/6
         /qJ/U51bL7wVE0xYQYsf/Hd2RInrpwrjipRHa3fnF5NqTVniJlMhuG2KHEdaBKTB1ejZ
         mZkClb7GhIDhPHPVAVV+3HTHYsHAQf77++HlBwQKxCVbAGq7l6E7PZ/rT1qHkTMTn3wL
         SQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvr55aXHbea2ozkc5Nlpf+W9U5hKlHGp9lm0Hq7tg40=;
        b=4hCg/gaDWdu7osnuUPnLGKhKHIkS+o9sdtH0lS7VrA+EmoaaNR3//8n7dGal3guy45
         EaLJZf3qjWJJRoFDdYl9h2G1AjB65KEs00OmOmebWN8JvH86QSrsRtkMAMhRDcSTEn+S
         2srPHV+/DNKKdRfTEAALZ4qClLyweW8ctvPjGg0G+Qg4KCdNxGDJVAVrFXgMj7AjVmCC
         nYkcs+nEj6/B8WbBLY192+/bJDV5NIixgtQ6IxFoTKtx8oVpSOVudAXPJ8WLfbXATkoC
         Lgnf1kpP6vYGPqlz5kXlLuSAKm80dOMKp5d0/hx/UEWikqLhDsuITsHJvaojhskkrNVG
         AkPQ==
X-Gm-Message-State: AFqh2kp7dAhj9mDUJ/fsl7XWUDWAWMZoAZHwWLy91f4n/dqIwnwPJyWv
        LZEMxX/4ShXY2gcsILClLoU=
X-Google-Smtp-Source: AMrXdXunOTAU4rVGN9E45AJZ8FcDH7haTASDYLb+uOXCWebSbTYbOk5Fp1QFUAWYSyGrTUWpjKM0UQ==
X-Received: by 2002:a17:902:6bca:b0:189:d8fb:152d with SMTP id m10-20020a1709026bca00b00189d8fb152dmr68631996plt.25.1673341984495;
        Tue, 10 Jan 2023 01:13:04 -0800 (PST)
Received: from debian.me (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id ik18-20020a170902ab1200b001929f0b4582sm7474945plb.300.2023.01.10.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 01:13:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AE18F10500B; Tue, 10 Jan 2023 16:13:00 +0700 (WIB)
Date:   Tue, 10 Jan 2023 16:13:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niyas Sait <niyas.sait@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y70sHNqLVvx6UF41@debian.me>
References: <20230109205456.30618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rYYIAqDIcaSJJTee"
Content-Disposition: inline
In-Reply-To: <20230109205456.30618-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rYYIAqDIcaSJJTee
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 10:54:56PM +0200, Andy Shevchenko wrote:
> diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/dri=
ver-api/pin-control.rst
> index 0022e930e93e..0274313e9997 100644
> --- a/Documentation/driver-api/pin-control.rst
> +++ b/Documentation/driver-api/pin-control.rst
> @@ -11,7 +11,7 @@ This subsystem deals with:
>  - Multiplexing of pins, pads, fingers (etc) see below for details
> =20
>  - Configuration of pins, pads, fingers (etc), such as software-controlled
> -  biasing and driving mode specific pins, such as pull-up/down, open dra=
in,
> +  biasing and driving mode specific pins, such as pull-up, pull-down, op=
en drain,
>    load capacitance etc.
> =20
>  Top-level interface

Immediately there is two "Define foo"s, which should have been like:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 22a82ee23a4156..57dd75fa091661 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -17,14 +17,12 @@ This subsystem deals with:
 Top-level interface
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Definition of PIN CONTROLLER:
+Definitions:
=20
-- A pin controller is a piece of hardware, usually a set of registers, that
+- A PIN CONTROLLER is a piece of hardware, usually a set of registers, that
   can control PINs. It may be able to multiplex, bias, set load capacitanc=
e,
   set drive strength, etc. for individual pins or groups of pins.
=20
-Definition of PIN:
-
 - PINS are equal to pads, fingers, balls or whatever packaging input or
   output line you want to control and these are denoted by unsigned intege=
rs
   in the range 0..maxpin. This numberspace is local to each PIN CONTROLLER=
, so

> @@ -95,7 +96,7 @@ this in our driver::
>  To enable the pinctrl subsystem and the subgroups for PINMUX and PINCONF=
 and
>  selected drivers, you need to select them from your machine's Kconfig en=
try,
>  since these are so tightly integrated with the machines they are used on.
> -See for example arch/arm/mach-ux500/Kconfig for an example.
> +See arch/arm/mach-ux500/Kconfig for an example.
> =20
>  Pins usually have fancier names than this. You can find these in the dat=
asheet
>  for your chip. Notice that the core pinctrl.h file provides a fancy macro

Don't use "I" for technical documentation like this:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 57dd75fa091661..214a84e5a723c0 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -98,16 +98,16 @@ See arch/arm/mach-ux500/Kconfig for an example.
=20
 Pins usually have fancier names than this. You can find these in the datas=
heet
 for your chip. Notice that the core pinctrl.h file provides a fancy macro
-called PINCTRL_PIN() to create the struct entries. As you can see I enumer=
ated
-the pins from 0 in the upper left corner to 63 in the lower right corner.
+called PINCTRL_PIN() to create the struct entries. As you can see the pins=
 are
+enumerated from 0 in the upper left corner to 63 in the lower right corner.
 This enumeration was arbitrarily chosen, in practice you need to think
 through your numbering system so that it matches the layout of registers
 and such things in your driver, or the code may become complicated. You mu=
st
 also consider matching of offsets to the GPIO ranges that may be handled by
 the pin controller.
=20
-For a padring with 467 pads, as opposed to actual pins, I used an enumerat=
ion
-like this, walking around the edge of the chip, which seems to be industry
+For a padding with 467 pads, as opposed to actual pins, the enumeration wi=
ll
+be like this, walking around the edge of the chip, which seems to be indus=
try
 standard too (all these pads had names, too)::
=20
=20
Also, I need to align numbers and change vertices to lines (dashes and pipe=
s)
in the enumeration loop diagram:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 214a84e5a723c0..e4938c28af14fb 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -106,17 +106,17 @@ and such things in your driver, or the code may becom=
e complicated. You must
 also consider matching of offsets to the GPIO ranges that may be handled by
 the pin controller.
=20
-For a padding with 467 pads, as opposed to actual pins, the enumeration wi=
ll
-be like this, walking around the edge of the chip, which seems to be indus=
try
-standard too (all these pads had names, too)::
+For a padding with 467 pads, as opposed to actual pins, the enumeration wi=
ll be
+like a closed loop: walking around the edge of the chip, which seems to be
+industry standard too (all these pads also had names)::
=20
=20
-     0 ..... 104
-   466        105
-     .        .
-     .        .
-   358        224
-    357 .... 225
+     0 ----- 104
+   466       105
+    |         |
+    |         |
+   358       224
+   357 ----- 225
=20
=20
 Pin groups

>  The pin configuration driver implements callbacks for changing pin
> -configuration in the pin controller ops like this::
> +configuration in the pin controller ops like this:
> +
> +.. code-block:: c
> =20
> -	#include <linux/pinctrl/pinctrl.h>
>  	#include <linux/pinctrl/pinconf.h>
> +	#include <linux/pinctrl/pinctrl.h>
> +
>  	#include "platform_x_pindefs.h"
> =20
>  	static int foo_pin_config_get(struct pinctrl_dev *pctldev,
> -			unsigned offset,
> -			unsigned long *config)
> +				      unsigned int offset,
> +				      unsigned long *config)
>  	{
>  		struct my_conftype conf;
> =20
> @@ -235,28 +226,28 @@ configuration in the pin controller ops like this::
>  	}
> =20
>  	static int foo_pin_config_set(struct pinctrl_dev *pctldev,
> -			unsigned offset,
> -			unsigned long config)
> +				      unsigned int offset,
> +				      unsigned long config)
>  	{
>  		struct my_conftype *conf =3D (struct my_conftype *) config;
> =20
>  		switch (conf) {
>  			case PLATFORM_X_PULL_UP:
>  			...
> -			}
> +			break;
>  		}
>  	}
> =20
> -	static int foo_pin_config_group_get (struct pinctrl_dev *pctldev,
> -			unsigned selector,
> -			unsigned long *config)
> +	static int foo_pin_config_group_get(struct pinctrl_dev *pctldev,
> +					    unsigned selector,
> +					    unsigned long *config)
>  	{
>  		...
>  	}
> =20
> -	static int foo_pin_config_group_set (struct pinctrl_dev *pctldev,
> -			unsigned selector,
> -			unsigned long config)
> +	static int foo_pin_config_group_set(struct pinctrl_dev *pctldev,
> +					    unsigned selector,
> +					    unsigned long config)
>  	{
>  		...
>  	}

Sphinx reports:

Documentation/driver-api/pin-control.rst:210: WARNING: Could not lex litera=
l_block as "c". Highlighting skipped.

I have to comment out "Find setting" comment:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 0274313e999722..22a82ee23a4156 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -220,7 +220,7 @@ configuration in the pin controller ops like this:
 	{
 		struct my_conftype conf;
=20
-		... Find setting for pin @ offset ...
+		/* ... Find setting for pin @ offset ... */
=20
 		*config =3D (unsigned long) conf;
 	}

> @@ -378,7 +380,7 @@ will get a pin number into its handled number range. =
Further it is also passed
>  the range ID value, so that the pin controller knows which range it shou=
ld
>  deal with.
> =20
> -Calling pinctrl_add_gpio_range from pinctrl driver is DEPRECATED. Please=
 see
> +Calling pinctrl_add_gpio_range() from pinctrl driver is DEPRECATED. Plea=
se see
>  section 2.1 of Documentation/devicetree/bindings/gpio/gpio.txt on how to=
 bind
>  pinctrl and gpio drivers.
> =20

On "Pinmux conventions" subsection, the term "Definitions" is a misnomer for
convention lists, so I have to correct that:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index e4938c28af14fb..95333dadcbdd08 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -466,7 +466,7 @@ in your machine configuration. It is inspired by the cl=
k, GPIO and regulator
 subsystems, so devices will request their mux setting, but it's also possi=
ble
 to request a single pin for e.g. GPIO.
=20
-Definitions:
+The conventions are:
=20
 - FUNCTIONS can be switched in and out by a driver residing with the pin
   control subsystem in the drivers/pinctrl/* directory of the kernel. The

>  Debugfs files
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  These files are created in ``/sys/kernel/debug/pinctrl``:
> =20
>  - ``pinctrl-devices``: prints each pin controller device along with colu=
mns to
> @@ -1440,7 +1428,7 @@ These files are created in ``/sys/kernel/debug/pinc=
trl``:
>  - ``pinctrl-handles``: prints each configured pin controller handle and =
the
>    corresponding pinmux maps
> =20
> -- ``pinctrl-maps``: print all pinctrl maps
> +- ``pinctrl-maps``: prints all pinctrl maps
> =20
>  A sub-directory is created inside of ``/sys/kernel/debug/pinctrl`` for e=
ach pin
>  controller device containing these files:
> @@ -1448,20 +1436,22 @@ controller device containing these files:
>  - ``pins``: prints a line for each pin registered on the pin controller.=
 The
>    pinctrl driver may add additional information such as register content=
s.
> =20
> -- ``gpio-ranges``: print ranges that map gpio lines to pins on the contr=
oller
> +- ``gpio-ranges``: prints ranges that map gpio lines to pins on the cont=
roller
> =20
> -- ``pingroups``: print all pin groups registered on the pin controller
> +- ``pingroups``: prints all pin groups registered on the pin controller
> =20
> -- ``pinconf-pins``: print pin config settings for each pin
> +- ``pinconf-pins``: prints pin config settings for each pin
> =20
> -- ``pinconf-groups``: print pin config settings per pin group
> +- ``pinconf-groups``: prints pin config settings per pin group
> =20
> -- ``pinmux-functions``: print each pin function along with the pin group=
s that
> +- ``pinmux-functions``: prints each pin function along with the pin grou=
ps that
>    map to the pin function
> =20
> -- ``pinmux-pins``: iterate through all pins and print mux owner, gpio ow=
ner
> +- ``pinmux-pins``: iterates through all pins and prints mux owner, gpio =
owner
>    and if the pin is a hog
> =20
> -- ``pinmux-select``: write to this file to activate a pin function for a=
 group::
> +- ``pinmux-select``: write to this file to activate a pin function for a=
 group:
> +
> +  .. code-block:: sh
> =20
>          echo "<group-name function-name>" > pinmux-select

Code keywords (variables, function names, file paths) are inlined here but
not on elsewhere in this doc, so I have to inline the remaining keywords:

---- >8 ----
diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/drive=
r-api/pin-control.rst
index 95333dadcbdd08..7ef6da61ea8da2 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -94,17 +94,17 @@ this in our driver:
 To enable the pinctrl subsystem and the subgroups for PINMUX and PINCONF a=
nd
 selected drivers, you need to select them from your machine's Kconfig entr=
y,
 since these are so tightly integrated with the machines they are used on.
-See arch/arm/mach-ux500/Kconfig for an example.
+See ``arch/arm/mach-ux500/Kconfig`` for an example.
=20
 Pins usually have fancier names than this. You can find these in the datas=
heet
 for your chip. Notice that the core pinctrl.h file provides a fancy macro
-called PINCTRL_PIN() to create the struct entries. As you can see the pins=
 are
-enumerated from 0 in the upper left corner to 63 in the lower right corner.
-This enumeration was arbitrarily chosen, in practice you need to think
-through your numbering system so that it matches the layout of registers
-and such things in your driver, or the code may become complicated. You mu=
st
-also consider matching of offsets to the GPIO ranges that may be handled by
-the pin controller.
+called ``PINCTRL_PIN()`` to create the struct entries. As you can see the =
pins
+are enumerated from 0 in the upper left corner to 63 in the lower right co=
rner.
+This enumeration was arbitrarily chosen, in practice you need to think thr=
ough
+your numbering system so that it matches the layout of registers and such
+things in your driver, or the code may become complicated. You must also
+consider matching of offsets to the GPIO ranges that may be handled by the=
 pin
+controller.
=20
 For a padding with 467 pads, as opposed to actual pins, the enumeration wi=
ll be
 like a closed loop: walking around the edge of the chip, which seems to be
@@ -131,7 +131,7 @@ on { 0, 8, 16, 24 }, and a group of pins dealing with a=
n I2C interface on pins
 on { 24, 25 }.
=20
 These two groups are presented to the pin control subsystem by implementing
-some generic pinctrl_ops like this:
+some generic ``pinctrl_ops`` like this:
=20
 .. code-block:: c
=20
@@ -177,7 +177,7 @@ some generic pinctrl_ops like this:
 		.pctlops =3D &foo_pctrl_ops,
 	};
=20
-The pin control subsystem will call the .get_groups_count() function to
+The pin control subsystem will call the ``.get_groups_count()`` function to
 determine the total number of legal selectors, then it will call the other=
 functions
 to retrieve the name and pins of the group. Maintaining the data structure=
 of
 the groups is up to the driver, this is just a simple example - in practic=
e you
@@ -199,7 +199,7 @@ unconnected.
 Pin configuration can be programmed by adding configuration entries into t=
he
 mapping table; see section `Board/machine configuration`_ below.
=20
-The format and meaning of the configuration parameter, PLATFORM_X_PULL_UP
+The format and meaning of the configuration parameter, ``PLATFORM_X_PULL_U=
P``
 above, is entirely defined by the pin controller driver.
=20
 The pin configuration driver implements callbacks for changing pin
@@ -318,23 +318,23 @@ like this:
 		...
 	}
=20
-So this complex system has one pin controller handling two different
-GPIO chips. "chip a" has 16 pins and "chip b" has 8 pins. The "chip a" and
-"chip b" have different .pin_base, which means a start pin number of the
+So this complex system has one pin controller handling two different GPIO
+chips. ``chip_a`` has 16 pins and ``chip_b`` has 8 pins. The ``chip a`` and
+``chip_b`` have different ``.pin_base``, which means a start pin number of=
 the
 GPIO range.
=20
-The GPIO range of "chip a" starts from the GPIO base of 32 and actual
-pin range also starts from 32. However "chip b" has different starting
-offset for the GPIO range and pin range. The GPIO range of "chip b" starts
-from GPIO number 48, while the pin range of "chip b" starts from 64.
+The GPIO range of ``chip_a`` starts from the GPIO base of 32 and actual
+pin range also starts from 32. However ``chip_b`` has different starting
+offset for the GPIO range and pin range. The GPIO range of ``chip_b`` star=
ts
+from GPIO number 48, while the pin range of ``chip b`` starts from 64.
=20
-We can convert a gpio number to actual pin number using this "pin_base".
+We can convert a gpio number to actual pin number using this ``pin_base``.
 They are mapped in the global GPIO pin space at:
=20
-chip a:
+``chip_a``:
  - GPIO range : [32 .. 47]
  - pin range  : [32 .. 47]
-chip b:
+``chip_b``:
  - GPIO range : [48 .. 55]
  - pin range  : [64 .. 71]
=20
@@ -355,9 +355,9 @@ numbers can be encoded in the range like this:
 		.gc =3D &chip,
 	};
=20
-In this case the pin_base property will be ignored. If the name of a pin
+In this case the ``pin_base property`` will be ignored. If the name of a p=
in
 group is known, the pins and npins elements of the above structure can be
-initialised using the function pinctrl_get_group_pins(), e.g. for pin
+initialised using the function ``pinctrl_get_group_pins()``, e.g. for pin
 group "foo":
=20
 .. code-block:: c
@@ -378,15 +378,15 @@ will get a pin number into its handled number range. =
Further it is also passed
 the range ID value, so that the pin controller knows which range it should
 deal with.
=20
-Calling pinctrl_add_gpio_range() from pinctrl driver is DEPRECATED. Please=
 see
-section 2.1 of Documentation/devicetree/bindings/gpio/gpio.txt on how to b=
ind
-pinctrl and gpio drivers.
+Calling ``pinctrl_add_gpio_range()`` from pinctrl driver is DEPRECATED. Pl=
ease
+see section 2.1 of ``Documentation/devicetree/bindings/gpio/gpio.txt`` on =
how
+to bind pinctrl and gpio drivers.
=20
=20
 PINMUX interfaces
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-These calls use the pinmux_* naming prefix.  No other calls should use that
+These calls use the ``pinmux_*`` naming prefix.  No other calls should use=
 that
 prefix.
=20
=20
@@ -469,7 +469,7 @@ to request a single pin for e.g. GPIO.
 The conventions are:
=20
 - FUNCTIONS can be switched in and out by a driver residing with the pin
-  control subsystem in the drivers/pinctrl/* directory of the kernel. The
+  control subsystem in the ``drivers/pinctrl/*`` directory of the kernel. =
The
   pin control driver knows the possible functions. In the example above yo=
u can
   identify three pinmux functions, one for spi, one for i2c and one for mm=
c.
=20
@@ -513,9 +513,9 @@ The conventions are:
   the core will simply select the first and only group available.)
=20
   In the example case we can define that this particular machine shall
-  use device spi0 with pinmux function fspi0 group gspi0 and i2c0 on funct=
ion
-  fi2c0 group gi2c0, on the primary pin controller, we get mappings
-  like these:
+  use device ``spi0`` with pinmux function ``fspi0`` group ``gspi0`` and
+  ``i2c0`` on function ``fi2c0`` group ``gi2c0``, on the primary pin
+  controller, we get mappings like these:
=20
   .. code-block:: c
=20
@@ -571,8 +571,9 @@ is possible to perform the requested mux setting, poke =
the hardware so that
 this happens.
=20
 Pinmux drivers are required to supply a few callback functions, some are
-optional. Usually the .set_mux() function is implemented, writing values i=
nto
-some certain registers to activate a certain mux setting for a certain pin.
+optional. Usually the ``.set_mux()`` function is implemented, writing valu=
es
+into some certain registers to activate a certain mux setting for a certain
+pin.
=20
 A simple driver for the above example will work by setting bits 0, 1, 2, 3=
, 4, or 5
 into some register named MUX to select a certain function with a certain
@@ -696,19 +697,20 @@ All the above functions are mandatory to implement fo=
r a pinmux driver.
 Pin control interaction with the GPIO subsystem
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Note that the following implies that the use case is to use a certain pin
-from the Linux kernel using the API in <linux/gpio/consumer.h> with gpiod_=
get()
-and similar functions. There are cases where you may be using something
-that your datasheet calls "GPIO mode", but actually is just an electrical
-configuration for a certain device. See the section below named
+Note that the following implies that the use case is to use a certain pin =
=66rom
+the Linux kernel using the API in ``<linux/gpio/consumer.h>`` with
+gpiod_get() and similar functions. There are cases where you may be using
+something that your datasheet calls "GPIO mode", but actually is just an
+electrical configuration for a certain device. See the section below named
 `GPIO mode pitfalls`_ for more details on this scenario.
=20
-The public pinmux API contains two functions named pinctrl_gpio_request()
-and pinctrl_gpio_free(). These two functions shall *ONLY* be called from
-gpiolib-based drivers as part of their .request() and .free() semantics.
-Likewise the pinctrl_gpio_direction_input()/pinctrl_gpio_direction_output()
-shall only be called from within respective .direction_input() /
-.direction_output() gpiolib implementation.
+The public pinmux API contains two functions named ``pinctrl_gpio_request(=
)``
+and ``pinctrl_gpio_free()``. These two functions shall *ONLY* be called fr=
om
+gpiolib-based drivers as part of their ``.request()`` and ``.free()``
+semantics. Likewise the
+``pinctrl_gpio_direction_input()``/``pinctrl_gpio_direction_output()`` sha=
ll
+only be called from within respective ``.direction_input()`` /
+``.direction_output()`` gpiolib implementation.
=20
 NOTE that platforms and individual drivers shall *NOT* request GPIO pins t=
o be
 controlled e.g. muxed in. Instead, implement a proper gpiolib driver and h=
ave
@@ -722,8 +724,8 @@ In this case, the function array would become 64 entrie=
s for each GPIO
 setting and then the device functions.
=20
 For this reason there are two functions a pin control driver can implement
-to enable only GPIO on an individual pin: .gpio_request_enable() and
-.gpio_disable_free().
+to enable only GPIO on an individual pin: ``.gpio_request_enable()`` and
+``.gpio_disable_free()``.
=20
 This function will pass in the affected GPIO range identified by the pin
 controller core, so you know which GPIO pins are being affected by the req=
uest
@@ -731,27 +733,27 @@ operation.
=20
 If your driver needs to have an indication from the framework of whether t=
he
 GPIO pin shall be used for input or output you can implement the
-.gpio_set_direction() function. As described this shall be called from the
+``.gpio_set_direction()`` function. As described this shall be called from=
 the
 gpiolib driver and the affected GPIO range, pin offset and desired directi=
on
 will be passed along to this function.
=20
 Alternatively to using these special functions, it is fully allowed to use
-named functions for each GPIO pin, the pinctrl_gpio_request() will attempt=
 to
-obtain the function "gpioN" where "N" is the global GPIO pin number if no
-special GPIO-handler is registered.
+named functions for each GPIO pin, the ``pinctrl_gpio_request()`` will att=
empt
+to obtain the function ``gpioN`` where ``N`` is the global GPIO pin number=
 if
+no special GPIO-handler is registered.
=20
=20
 GPIO mode pitfalls
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Due to the naming conventions used by hardware engineers, where "GPIO"
-is taken to mean different things than what the kernel does, the developer
-may be confused by a datasheet talking about a pin being possible to set
-into "GPIO mode". It appears that what hardware engineers mean with
-"GPIO mode" is not necessarily the use case that is implied in the kernel
-interface <linux/gpio/consumer.h>: a pin that you grab from kernel code an=
d then
-either listen for input or drive high/low to assert/deassert some
-external line.
+Due to the naming conventions used by hardware engineers, where "GPIO" is =
taken
+to mean different things than what the kernel does, the developer may be
+confused by a datasheet talking about a pin being possible to set into "GP=
IO
+mode". It appears that what hardware engineers mean with "GPIO mode" is not
+necessarily the use case that is implied in the kernel interface
+``<linux/gpio/consumer.h>``: a pin that you grab from kernel code and then
+either listen for input or drive high/low to assert/deassert some external
+line.
=20
 Rather hardware engineers think that "GPIO mode" means that you can
 software-control a few electrical properties of the pin that you would
@@ -859,8 +861,8 @@ wake up and maybe even gpiod_get()/gpiod_put() as part =
of this cycle. This
 all gets very complicated.
=20
 The solution is to not think that what the datasheet calls "GPIO mode"
-has to be handled by the <linux/gpio/consumer.h> interface. Instead view t=
his as
-a certain pin config setting. Look in e.g. <linux/pinctrl/pinconf-generic.=
h>
+has to be handled by the ``<linux/gpio/consumer.h>`` interface. Instead vi=
ew this as
+a certain pin config setting. Look in e.g. ``<linux/pinctrl/pinconf-generi=
c.h>``
 and you find this in the documentation:
=20
   PIN_CONFIG_OUTPUT:
@@ -1038,7 +1040,7 @@ Finally, some devices expect the mapping table to con=
tain certain specific
 named states. When running on hardware that doesn't need any pin controller
 configuration, the mapping table must still contain those named states, in
 order to explicitly indicate that the states were provided and intended to
-be empty. Table entry macro PIN_MAP_DUMMY_STATE serves the purpose of defi=
ning
+be empty. Table entry macro ``PIN_MAP_DUMMY_STATE`` serves the purpose of =
defining
 a named state without causing any pin controller to be programmed:
=20
 .. code-block:: c
@@ -1163,7 +1165,7 @@ Pin control requests from drivers
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 When a device driver is about to probe the device core will automatically
-attempt to issue pinctrl_get_select_default() on these devices.
+attempt to issue ``pinctrl_get_select_default()`` on these devices.
 This way driver writers do not need to add any of the boilerplate code
 of the type found below. However when doing fine-grained state selection
 and not using the "default" state, you may have to do some device driver
@@ -1181,8 +1183,8 @@ some cases where a driver needs to e.g. switch betwee=
n different mux mappings
 at runtime this is not possible.
=20
 A typical case is if a driver needs to switch bias of pins from normal
-operation and going to sleep, moving from the PINCTRL_STATE_DEFAULT to
-PINCTRL_STATE_SLEEP at runtime, re-biasing or even re-muxing pins to save
+operation and going to sleep, moving from the ``PINCTRL_STATE_DEFAULT`` to
+``PINCTRL_STATE_SLEEP`` at runtime, re-biasing or even re-muxing pins to s=
ave
 current in sleep mode.
=20
 A driver may request a certain control state to be activated, usually just=
 the
@@ -1228,49 +1230,49 @@ arrangement on your bus.
=20
 The semantics of the pinctrl APIs are:
=20
-- pinctrl_get() is called in process context to obtain a handle to all pin=
ctrl
-  information for a given client device. It will allocate a struct from the
-  kernel memory to hold the pinmux state. All mapping table parsing or sim=
ilar
-  slow operations take place within this API.
+- ``pinctrl_get()`` is called in process context to obtain a handle to all
+  pinctrl information for a given client device. It will allocate a struct=
 from
+  the kernel memory to hold the pinmux state. All mapping table parsing or
+  similar slow operations take place within this API.
=20
-- devm_pinctrl_get() is a variant of pinctrl_get() that causes pinctrl_put=
()
-  to be called automatically on the retrieved pointer when the associated
-  device is removed. It is recommended to use this function over plain
-  pinctrl_get().
+- ``devm_pinctrl_get()`` is a variant of ``pinctrl_get()`` that causes
+  ``pinctrl_put()`` to be called automatically on the retrieved pointer wh=
en
+  the associated device is removed. It is recommended to use this function=
 over
+  plain ``pinctrl_get()``.
=20
-- pinctrl_lookup_state() is called in process context to obtain a handle t=
o a
-  specific state for a client device. This operation may be slow, too.
+- ``pinctrl_lookup_state()`` is called in process context to obtain a hand=
le to
+  a specific state for a client device. This operation may be slow, too.
=20
-- pinctrl_select_state() programs pin controller hardware according to the
+- ``pinctrl_select_state()`` programs pin controller hardware according to=
 the
   definition of the state as given by the mapping table. In theory, this i=
s a
   fast-path operation, since it only involved blasting some register setti=
ngs
   into hardware. However, note that some pin controllers may have their
   registers on a slow/IRQ-based bus, so client devices should not assume t=
hey
-  can call pinctrl_select_state() from non-blocking contexts.
+  can call ``pinctrl_select_state()`` from non-blocking contexts.
=20
-- pinctrl_put() frees all information associated with a pinctrl handle.
+- ``pinctrl_put()`` frees all information associated with a pinctrl handle.
=20
-- devm_pinctrl_put() is a variant of pinctrl_put() that may be used to
-  explicitly destroy a pinctrl object returned by devm_pinctrl_get().
-  However, use of this function will be rare, due to the automatic cleanup
-  that will occur even without calling it.
+- ``devm_pinctrl_put()`` is a variant of ``pinctrl_put()`` that may be use=
d to
+  explicitly destroy a pinctrl object returned by ``devm_pinctrl_get()``.
+  However, use of this function will be rare, due to the automatic cleanup=
 that
+  will occur even without calling it.
=20
-  pinctrl_get() must be paired with a plain pinctrl_put().
-  pinctrl_get() may not be paired with devm_pinctrl_put().
-  devm_pinctrl_get() can optionally be paired with devm_pinctrl_put().
-  devm_pinctrl_get() may not be paired with plain pinctrl_put().
+  ``pinctrl_get()`` must be paired with a ``plain pinctrl_put()``.
+  ``pinctrl_get()`` may not be paired with ``devm_pinctrl_put()``.
+  ``devm_pinctrl_get()`` can optionally be paired with ``devm_pinctrl_put(=
)``.
+  ``devm_pinctrl_get()`` may not be paired with plain ``pinctrl_put()``.
=20
 Usually the pin control core handled the get/put pair and call out to the
 device drivers bookkeeping operations, like checking available functions a=
nd
-the associated pins, whereas pinctrl_select_state() pass on to the pin con=
troller
-driver which takes care of activating and/or deactivating the mux setting =
by
-quickly poking some registers.
+the associated pins, whereas ``pinctrl_select_state()`` pass on to the pin
+controller driver which takes care of activating and/or deactivating the m=
ux
+setting by quickly poking some registers.
=20
-The pins are allocated for your device when you issue the devm_pinctrl_get=
()
-call, after this you should be able to see this in the debugfs listing of =
all
-pins.
+The pins are allocated for your device when you issue the
+``devm_pinctrl_get()`` call, after this you should be able to see this in =
the
+debugfs listing of all pins.
=20
-NOTE: the pinctrl system will return -EPROBE_DEFER if it cannot find the
+NOTE: the pinctrl system will return ``-EPROBE_DEFER`` if it cannot find t=
he
 requested pinctrl handles, for example if the pinctrl driver has not yet
 registered. Thus make sure that the error path in your driver gracefully
 cleans up and is ready to retry the probing later in the startup process.
@@ -1295,7 +1297,7 @@ So say that your driver is fetching its resources lik=
e this:
 	pinctrl =3D devm_pinctrl_get_select_default(&dev);
 	gpio =3D devm_gpiod_get(&dev, "foo");
=20
-Here we first request a certain pin state and then request GPIO "foo" to be
+Here we first request a certain pin state and then request GPIO ``foo`` to=
 be
 used. If you're using the subsystems orthogonally like this, you should
 nominally always get your pinctrl handle and select the desired pinctrl
 state BEFORE requesting the GPIO. This is a semantic convention to avoid
@@ -1312,7 +1314,7 @@ to communicate directly with the pinctrl subsystem, u=
sing the latter as a
 back-end. This is when the GPIO driver may call out to the functions
 described in the section `Pin control interaction with the GPIO subsystem`_
 above. This only involves per-pin multiplexing, and will be completely
-hidden behind the gpiod_*() function namespace. In this case, the driver
+hidden behind the ``gpiod_*()`` function namespace. In this case, the driv=
er
 need not interact with the pin control subsystem at all.
=20
 If a pin control driver and a GPIO driver is dealing with the same pins
@@ -1326,13 +1328,14 @@ pin control system.
 System pin control hogging
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
-Pin control map entries can be hogged by the core when the pin controller
-is registered. This means that the core will attempt to call pinctrl_get(),
-pinctrl_lookup_state() and pinctrl_select_state() on it immediately after
-the pin control device has been registered.
+Pin control map entries can be hogged by the core when the pin controller =
is
+registered. This means that the core will attempt to call ``pinctrl_get()`=
`,
+``pinctrl_lookup_state()`` and ``pinctrl_select_state()`` on it immediately
+after the pin control device has been registered.
=20
-This occurs for mapping table entries where the client device name is equal
-to the pin controller device name, and the state name is PINCTRL_STATE_DEF=
AULT:
+This occurs for mapping table entries where the client device name is equa=
l to
+the pin controller device name, and the state name is
+``PINCTRL_STATE_DEFAULT``:
=20
 .. code-block:: c
=20
@@ -1366,9 +1369,9 @@ function, but with different named in the mapping as =
described under
 "Advanced mapping" above. So that for an SPI device, we have two states na=
med
 "pos-A" and "pos-B".
=20
-This snippet first initializes a state object for both groups (in foo_prob=
e()),
-then muxes the function in the pins defined by group A, and finally muxes =
it in
-on the pins defined by group B:
+This snippet first initializes a state object for both groups (in
+``foo_probe()``), then muxes the function in the pins defined by group A, =
and
+finally muxes it in on the pins defined by group B:
=20
 .. code-block:: c
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rYYIAqDIcaSJJTee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY70sEwAKCRD2uYlJVVFO
o1xlAQCJR18rwXpMrTWbERCx2urvZEIXLEDeFk+Bt2bR5BJ8RAEA2NwXz0t/wFdW
BrpMPFuAbBj6JiHqDBRVfkG0rYRJ5AI=
=BXGQ
-----END PGP SIGNATURE-----

--rYYIAqDIcaSJJTee--
