Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6561A78F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKEEsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEEsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:48:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF81C402;
        Fri,  4 Nov 2022 21:48:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso6152056pjc.2;
        Fri, 04 Nov 2022 21:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpxdRqL+dkJv4/HHt8a4Epp35V0m09+rczWeETBMLPY=;
        b=pRlvJCvrMGfptaNYC9m4TAdhYQs8dKGjERXR6+HRH/FXermgHoskU4XlCAbwmMG0ZX
         LVU63qDRUaOZAZce/CvN8/tomHWf8ABfo+XtUd7HpUvic1tdMbsQz/gWMW7lz1n6OEUd
         IYncTnzsLRnkd5JHlmnu4XL0+qDFdM5GoLWzzoUGPRvraw/6JdfmVkB9o8MKXfrgZl+w
         8XkMVyiqnb/JhzvC4DLZG16M5RAZN6xwwrWou7Hq6Fix5i3n8LsfVbio9VZyFdb2Zt33
         z3dT/jxI9j3ICNLrX32Z5h4e2eef6l98K+QbeMDhfV+JCm3/q7+YNDtLLzCY85W4qj+t
         07Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpxdRqL+dkJv4/HHt8a4Epp35V0m09+rczWeETBMLPY=;
        b=r5cRHDnpA40OFGz5Tsv2+FzHhAs1j9VcxeBjZgzkQcKW1c28CKRet5+C63+9CnD2v4
         Vru+KEYSN//kmHIiGstlttTqdvDgsNdTJz4HFHOCEUNxh0JLYqt0G8awsRMXFD8e+8d+
         M5dSp+PhVTbUr5xgS1w1wD71AsiS89topFxRQOo3PrV9ttXTVMi36cwyqrNN8A5qgzUW
         oW1HVjyJD/+sfp0ot9eOGgfXSpqjtsrtvjA/qXxt9NG1XKa1qVGSORjbHOg7rxNEuHFe
         g6UyS7g8qms7LUxO8yVukfbjzGL2ZcvRA2CVbFFfKTeqoBCSY6l5ToW0qPP3h9hmE2ZQ
         FN1A==
X-Gm-Message-State: ACrzQf24Vx6xNMGx1AKBmV475ELl6wh/HUVTJ8iL/uKyYuqgWkAAvMkf
        EFbj/OX7wyRn+vcGoWtRhPdzW6MLl+I=
X-Google-Smtp-Source: AMsMyM6k4iAP5tS4ioTHzC6NDpfddONQYAOOu49tTBtG0FbaAtsd5bYClXSJVvtTpt1jZZyhEzbvMw==
X-Received: by 2002:a17:902:ecc1:b0:186:b57e:d229 with SMTP id a1-20020a170902ecc100b00186b57ed229mr39688708plh.167.1667623730790;
        Fri, 04 Nov 2022 21:48:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5e7f:d665:c23a:5a4c])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a684400b00212daa6f41dsm469092pjm.28.2022.11.04.21.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 21:48:50 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:48:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2XrL0noH4HqsAU7@google.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
 <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:57:31PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 04, 2022 at 12:33:06PM -0700, Dmitry Torokhov wrote:
> > On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > const struct property_entry simone_key_enter_props[] __initconst = {
> > > > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > > 
> > > > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > > > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > > 
> > > Okay, can we have an example for something like reset-gpios? Because from
> > > the above I can't easily get what label is and how in the `gpioinfo` tool
> > > the requested line will look like.
> > 
> > The label is something unrelated to gpio. The example was supposed to
> > match gpio-keys binding found in
> > Documentation/devicetree/bindings/input/gpio-keys.yaml
> 
> Yes, but what would be output of `gpioinfo` for the above  example and
> if GPIO is named properly (with con_id)?

Same as if I am using device tree, or ACPI, etc. I am not changing how
labeling is done, so whatever rules were before adding swnode support
they will be used with swnodes.

With the hack patch to gpio-keys.c below and device using the following
DT fragment I see the following from gpioinfo:

        gpio_keys: gpio-keys {
                status = "okay";

                compatible = "gpio-keys";
                pinctrl-names = "default";
                pinctrl-0 = <&pen_eject>;

                pen_insert: pen-insert {
                        label = "Pen Insert";
                        /* Insert = low, eject = high */
                        /* gpios = <&pio 18 GPIO_ACTIVE_LOW>; */
                        linux,code = <SW_PEN_INSERTED>;
                        linux,input-type = <EV_SW>;
                        wakeup-event-action = <EV_ACT_DEASSERTED>;
                        wakeup-source;
                };
        };

Just "gpios" (con_id == NULL):

        line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]

With "key-gpios" (con_id == "key") it is exactly the same:

        line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]

Ah, I guess you wonder how it will look like if we do not pass this
"label" into devm_fwnode_gpiod_get() and instead use NULL?

	line  18: "PEN_EJECT_OD" "?" input active-low [used]

If the driver used gpiod_get() or similar it would either have the
"con_id" label or device name (produced with dev_name(dev) if con_id is
NULL. Still, not changes from using swnodes compared to ACPI or DT.

> 
> > > > 	{ }
> > > > };
> 
> ...
> 
> > > > +	/*
> > > > +	 * We expect all swnode-described GPIOs have GPIO number and
> > > > +	 * polarity arguments, hence nargs is set to 2.
> > > > +	 */
> > > 
> > > Maybe instead you can provide a custom macro wrapper that will check the number
> > > of arguments at compile time?
> > 
> > We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
> > that enforces needed arguments.
> 
> Yes, that's what I meant.

Where do you think it should go? Not sure if I want to pollute
property.h, I guess linux/gpio/matchine.h will need to include
property.h?

> 
> ...
> 
> > > > +		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
> > > > +			__func__, prop_name, fwnode, idx);
> > > 
> > > __func__ is not needed. Dynamic Debug can automatically add it.
> > > Since you have an fwnode, use that as a marker.
> > 
> > I was mimicking gpiolib-of.c::of_get_named_gpiod_flags(). I guess we can
> > guess the function from other log messages we emit, but does it hurt
> > having it?
> 
> I think it's redundant. You can modify message itself to improve its
> uniqueness.

¯\_(ツ)_/¯ I think we are moving into extreme bikeshedding direction
here.

> 
> ...
> 
> > > > +	/*
> > > > +	 * This is not very efficient, but GPIO lists usually have only
> > > > +	 * 1 or 2 entries.
> > > > +	 */
> > > > +	count = 0;
> > > > +	while (fwnode_property_get_reference_args(fwnode, prop_name, NULL,
> > > > +						  0, count, &args) == 0)
> > > 
> > > I would put it into for loop (and looking into property.h I think propname
> > > is fine variable name):
> > > 
> > > 	for (count = 0; ; count++) {
> > > 		if (fwnode_property_get_reference_args(fwnode, propname, NULL, 0, count, &args))
> > > 			break;
> > > 	}
> > 
> > OK on name, but I like explicit counting with the "while" loop as it
> > shows the purpose of the code.
> 
> OK, let's see how it will look like with the proper dropped reference.
> 
> > > Btw, what about reference counting? Do we need to care about it?
> > 
> > Yes, indeed, we need to drop the reference, thank you for noticing!
> 
> ...
> 
> > > > +	/*
> > > > +	 * First look up GPIO in the secondary software node in case
> > > > +	 * it was used to store updated properties.
> > > 
> > > Why this is done first? We don't try secondary before we have checked primary.
> > 
> > I believe we should check secondary first, so that secondaries can be
> > used not only to add missing properties, but also to override existing
> > ones in case they are incorrect.
> 
> It contradicts all code we have in the kernel regarding the use of software
> nodes, you need very strong argument to justify that.
> 
> Personally I think this must be fixed.

I agree, the rest of the code should be fixed ;) I'll put it on my TODO
list.

I gave my argument above already: swnodes should not only be useful to
add missing properties, but also allow fixing up existing ones. If I
implemented what you are suggesting then I would not be able to create
this concise example and would need to model entire DT node for GPIO
keys.

Thanks.

-- 
Dmitry


diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 22a91db645b8f..5fe51c5baa6bb 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,6 +30,17 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/input/gpio-keys.h>
 
+#include <linux/property.h>
+#include <linux/gpio/machine.h>
+const struct software_node gpio_bank_node = {
+	.name = "pinctrl_paris",
+};
+
+const struct property_entry pen_insert_props[] = {
+	PROPERTY_ENTRY_REF("key-gpios", &gpio_bank_node, 18, GPIO_ACTIVE_LOW),
+	{ }
+};
+
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
 	struct input_dev *input;
@@ -519,8 +530,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	spin_lock_init(&bdata->lock);
 
 	if (child) {
+		if (!strcmp(fwnode_get_name(child), "pen-insert"))
+			child->secondary = fwnode_create_software_node(pen_insert_props, NULL);
+
 		bdata->gpiod = devm_fwnode_gpiod_get(dev, child,
-						     NULL, GPIOD_IN, desc);
+						     "key", GPIOD_IN, desc);
 		if (IS_ERR(bdata->gpiod)) {
 			error = PTR_ERR(bdata->gpiod);
 			if (error == -ENOENT) {
@@ -1056,14 +1070,18 @@ static struct platform_driver gpio_keys_device_driver = {
 	}
 };
 
+
+
 static int __init gpio_keys_init(void)
 {
+	software_node_register(&gpio_bank_node);
 	return platform_driver_register(&gpio_keys_device_driver);
 }
 
 static void __exit gpio_keys_exit(void)
 {
 	platform_driver_unregister(&gpio_keys_device_driver);
+	software_node_unregister(&gpio_bank_node);
 }
 
 late_initcall(gpio_keys_init);

