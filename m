Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1960761F181
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiKGLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiKGLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:08:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566D19C15;
        Mon,  7 Nov 2022 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667819294; x=1699355294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VgkXpg0g3QMYpRFiPIn7QWiZu+vWnJimvlKacK9/Qe4=;
  b=OXSlaqhv0BsDK9P2G/AoRfSYG6l9p7vmbU1g05HcFgbgYp43mUCwooKe
   k1WhtZmXU/2FyhsmXuDQbuUx3CO1rbbuPl/jw4O2P5nPu3zUYJtYNaNQ0
   y/QVHc5ys8J02f3AKmgRvBqwr+5xXe79Xcci4c76LOyhHx3yhC0ES2Q01
   /etpAdNnIxxFkRDNFve9idrmd9m6b1GpYbA3YYv7xpwtGHXoxnV1O9gjQ
   brDygzKZk3mpCQuUdohDIFeqbbAP8wVXTPlhS2Fr+k8v+DyT50px6XH/w
   j/0iXxuXL+NM457BKlZrSzcLzXlXgN/5LcoBD+hq98twieH6wY5SqR2gi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="374636889"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="374636889"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="965111051"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="965111051"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2022 03:08:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1orzz7-008bOo-36;
        Mon, 07 Nov 2022 13:08:09 +0200
Date:   Mon, 7 Nov 2022 13:08:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2jnGVKDmGvK94AV@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
 <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
 <Y2XrL0noH4HqsAU7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2XrL0noH4HqsAU7@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 09:48:47PM -0700, Dmitry Torokhov wrote:
> On Fri, Nov 04, 2022 at 10:57:31PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 04, 2022 at 12:33:06PM -0700, Dmitry Torokhov wrote:
> > > On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:

...

> > > > > const struct property_entry simone_key_enter_props[] __initconst = {
> > > > > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > > > 
> > > > > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > > > > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > > > 
> > > > Okay, can we have an example for something like reset-gpios? Because from
> > > > the above I can't easily get what label is and how in the `gpioinfo` tool
> > > > the requested line will look like.
> > > 
> > > The label is something unrelated to gpio. The example was supposed to
> > > match gpio-keys binding found in
> > > Documentation/devicetree/bindings/input/gpio-keys.yaml
> > 
> > Yes, but what would be output of `gpioinfo` for the above  example and
> > if GPIO is named properly (with con_id)?
> 
> Same as if I am using device tree, or ACPI, etc. I am not changing how
> labeling is done, so whatever rules were before adding swnode support
> they will be used with swnodes.
> 
> With the hack patch to gpio-keys.c below and device using the following
> DT fragment I see the following from gpioinfo:
> 
>         gpio_keys: gpio-keys {
>                 status = "okay";
> 
>                 compatible = "gpio-keys";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pen_eject>;
> 
>                 pen_insert: pen-insert {
>                         label = "Pen Insert";
>                         /* Insert = low, eject = high */
>                         /* gpios = <&pio 18 GPIO_ACTIVE_LOW>; */
>                         linux,code = <SW_PEN_INSERTED>;
>                         linux,input-type = <EV_SW>;
>                         wakeup-event-action = <EV_ACT_DEASSERTED>;
>                         wakeup-source;
>                 };
>         };
> 
> Just "gpios" (con_id == NULL):
> 
>         line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]
> 
> With "key-gpios" (con_id == "key") it is exactly the same:
> 
>         line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]
> 
> Ah, I guess you wonder how it will look like if we do not pass this
> "label" into devm_fwnode_gpiod_get() and instead use NULL?
> 
> 	line  18: "PEN_EJECT_OD" "?" input active-low [used]
> 
> If the driver used gpiod_get() or similar it would either have the
> "con_id" label or device name (produced with dev_name(dev) if con_id is
> NULL. Still, not changes from using swnodes compared to ACPI or DT.

Yes, can you add a summary of above to the commit message?

> > > > > 	{ }
> > > > > };

...

> > > > > +	/*
> > > > > +	 * We expect all swnode-described GPIOs have GPIO number and
> > > > > +	 * polarity arguments, hence nargs is set to 2.
> > > > > +	 */
> > > > 
> > > > Maybe instead you can provide a custom macro wrapper that will check the number
> > > > of arguments at compile time?
> > > 
> > > We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
> > > that enforces needed arguments.
> > 
> > Yes, that's what I meant.
> 
> Where do you think it should go? Not sure if I want to pollute
> property.h, I guess linux/gpio/matchine.h will need to include
> property.h?

Good question. I was thinking more of a separate header for that,
because adding property.h adds tons of stuff which might be not
needed otherwise.

...

> > > > > +	/*
> > > > > +	 * First look up GPIO in the secondary software node in case
> > > > > +	 * it was used to store updated properties.
> > > > 
> > > > Why this is done first? We don't try secondary before we have checked primary.
> > > 
> > > I believe we should check secondary first, so that secondaries can be
> > > used not only to add missing properties, but also to override existing
> > > ones in case they are incorrect.
> > 
> > It contradicts all code we have in the kernel regarding the use of software
> > nodes, you need very strong argument to justify that.
> > 
> > Personally I think this must be fixed.
> 
> I agree, the rest of the code should be fixed ;) I'll put it on my TODO
> list.

I'm not sure what "rest of the code" you are referring to. The core part of
device property APIs?

> I gave my argument above already: swnodes should not only be useful to
> add missing properties, but also allow fixing up existing ones. If I
> implemented what you are suggesting then I would not be able to create
> this concise example and would need to model entire DT node for GPIO
> keys.

Why do you need that in the first place? We should not use swnodes as primary
source of the information. The auxiliary one is fine. "Fixing" via priority
inversion in current model is not good thing to have.

If you really need that you have to first do the following:
- convert fwnode to be a list node
- unembed it from struct device (leaving only head of list there
- update all necessary APIs respectively

In such implementation list_add() / list_add_tail() will define a priority
and you may have stack of properties.

Doing it in a hackish way by allowing priority inversion in _some_ APIs
is no go in my opinion.

-- 
With Best Regards,
Andy Shevchenko


