Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E4620006
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiKGU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiKGU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:59:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC3CD;
        Mon,  7 Nov 2022 12:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667854783; x=1699390783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGTHGN+T8BY8g8Qhu4pXWi0W2GVU4GPhs0GktNdp+l4=;
  b=e5qAM6ZWzs6LGR9cZCHpop+OdZsy5GInJ/HV2COgbpriswu88RNM4jky
   4kTwIjS0H2B90sRxMSiJiUeMV3R2A8pm8V1LH7zxRmUdAvY4bRxox9PS0
   er0rK0xL73DRSsFZsb7Qw/QXSQ3dtohDUNiIRpyEMQcLmZdinJ7KKBSsZ
   QqI6esY3hF8e/V/D9c1iWNH7EZBfp9VdG9bN341GCHD6TzzKAX9aa+a4U
   SHMyKGVFFfDVt2EoghB6gAlRpPnJMBhk2JS1+wrsjqd7jlYj1UfSOSrmw
   /bJ747fShBjZSCkjBED3gKa71B6I5v15COXY1CvyxAW9pUO1LOXMWxyxf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298036692"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="298036692"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="810984013"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="810984013"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 12:59:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9DX-008pgE-20;
        Mon, 07 Nov 2022 22:59:39 +0200
Date:   Mon, 7 Nov 2022 22:59:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2lxuyvdD3EEbfeE@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
 <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
 <Y2XrL0noH4HqsAU7@google.com>
 <Y2jnGVKDmGvK94AV@smile.fi.intel.com>
 <Y2kucGtw/t9v0245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kucGtw/t9v0245@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 08:12:32AM -0800, Dmitry Torokhov wrote:
> On Mon, Nov 07, 2022 at 01:08:09PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 04, 2022 at 09:48:47PM -0700, Dmitry Torokhov wrote:
> > > On Fri, Nov 04, 2022 at 10:57:31PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 04, 2022 at 12:33:06PM -0700, Dmitry Torokhov wrote:
> > > > > On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> > > > > > On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:

...

> > > > > > > +	/*
> > > > > > > +	 * We expect all swnode-described GPIOs have GPIO number and
> > > > > > > +	 * polarity arguments, hence nargs is set to 2.
> > > > > > > +	 */
> > > > > > 
> > > > > > Maybe instead you can provide a custom macro wrapper that will check the number
> > > > > > of arguments at compile time?
> > > > > 
> > > > > We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
> > > > > that enforces needed arguments.
> > > > 
> > > > Yes, that's what I meant.
> > > 
> > > Where do you think it should go? Not sure if I want to pollute
> > > property.h, I guess linux/gpio/matchine.h will need to include
> > > property.h?
> > 
> > Good question. I was thinking more of a separate header for that,
> > because adding property.h adds tons of stuff which might be not
> > needed otherwise.
> 
> OK, I guess include/linux/gpio/property.h ?

Why not?

...

> > > > > > > +	/*
> > > > > > > +	 * First look up GPIO in the secondary software node in case
> > > > > > > +	 * it was used to store updated properties.
> > > > > > 
> > > > > > Why this is done first? We don't try secondary before we have checked primary.
> > > > > 
> > > > > I believe we should check secondary first, so that secondaries can be
> > > > > used not only to add missing properties, but also to override existing
> > > > > ones in case they are incorrect.
> > > > 
> > > > It contradicts all code we have in the kernel regarding the use of software
> > > > nodes, you need very strong argument to justify that.
> > > > 
> > > > Personally I think this must be fixed.
> > > 
> > > I agree, the rest of the code should be fixed ;) I'll put it on my TODO
> > > list.
> > 
> > I'm not sure what "rest of the code" you are referring to. The core part of
> > device property APIs?
> 
> Yes.

> > > I gave my argument above already: swnodes should not only be useful to
> > > add missing properties, but also allow fixing up existing ones. If I
> > > implemented what you are suggesting then I would not be able to create
> > > this concise example and would need to model entire DT node for GPIO
> > > keys.
> > 
> > Why do you need that in the first place? We should not use swnodes as primary
> > source of the information. The auxiliary one is fine. "Fixing" via priority
> > inversion in current model is not good thing to have.
> > 
> > If you really need that you have to first do the following:
> > - convert fwnode to be a list node
> > - unembed it from struct device (leaving only head of list there
> > - update all necessary APIs respectively
> > 
> > In such implementation list_add() / list_add_tail() will define a priority
> > and you may have stack of properties.
> 
> Hmm, that will complicate things quite a bit. I wonder why you think
> that using swnodes to fix up the "bad" firmware data is not desirable.

I put there "in current model". It means that for secondary-primary and only
them that design doesn't allow to create quirks.

> Swnodes are controlled by the kernel and thus we can potentially allow
> users tweak them from usersoace. There is a desire to allow easier
> access to various driver's parameters - see for example Hans patches to
> Goodix and Silead where he adds code that intercepts reading of device
> properties and instead gets data form module parameter - I would like to
> have such facility in more general way.
> 
> https://lore.kernel.org/all/20221025122930.421377-3-hdegoede@redhat.com/

How can you guarantee that flip-flopping priority of reading properties doesn't
break things?

Moreover, what problem we are trying to hack up? The DT should be fixed in DT.
ACPI? In ACPI properties are not that common, and even that, we shouldn't unleash
vendors to make all possible abuse-like mistakes in ACPI, that's why I do not think
that allowing property quirks is a good idea at all.

> > Doing it in a hackish way by allowing priority inversion in _some_ APIs
> > is no go in my opinion.
> 
> Yes, I agree that we want to have all APIs behave in the similar way. It
> occurred to me that the topic of handling secondary node is actually
> separate from swnode hanlding, so I will remove it from this patch and I
> can start a separate thread/patches for it after we land this series.

As long as the priority is out of the picture I'm fine with this series,

Because as I said the current design seems (I wasn't the author, so I
might be mistaken) had been made with "we trust the firmware" in mind.

-- 
With Best Regards,
Andy Shevchenko


