Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EE619E55
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKDRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiKDRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:18:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A3190;
        Fri,  4 Nov 2022 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667582304; x=1699118304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+3YtT9dFPOt7OAFl6ViICU9zmM2RG2gFbTZrOGYm6k=;
  b=UKhsz+MYV5sfHK0RvohxDoA4FMaSL3m1WvmbXd8LnwMTZVZyAm+hmI9g
   +nn8Bs3CZhTB3326FzZgkscEgM+jkcpiyyD6Dv7pRHFGnB9vPoeKjQZ33
   Y64+lCzjFOkiu9gsMmMJrJ05Rj2+tEjIyxFV4lwkmq78xv1U6tyJpPAcw
   4Sww6t37Qg7bxDmtfvuz0+AONPauw0lF0AIgZZmzx0lBUmWRj8akysyUK
   ec+dLDY0/OPlQ7aiGWbmn0/xrUICJ0mhH87eMMMRTVPpp8e+cDEm5s4Bi
   1uJmvwQS7CUALFMvfG5TZ2zTaRiRVvN6IYkYeRH6PrGPUPRDaCNQ/ueBp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="307646005"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="307646005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="704157950"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="704157950"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2022 10:18:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or0Kj-007Swi-1m;
        Fri, 04 Nov 2022 19:18:21 +0200
Date:   Fri, 4 Nov 2022 19:18:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add support for software nodes to gpiolib
Message-ID: <Y2VJXWSqBhtYhL1Q@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:10:10PM -0700, Dmitry Torokhov wrote:
> This series attempts to add support for software nodes to gpiolib, using
> software node references. This allows us to convert more drivers to the
> generic device properties and drop support for custom platform data.
> 
> To describe a GPIO via software nodes we can create the following data
> items:
> 
> /* Node representing the GPIO controller/GPIO bank */
> static const struct software_node gpio_bank_b_node = {
>         .name = "B",
> };
> 
> /*
>  * Properties that will be assigned to a software node assigned to
>  * the devicei that used platform data.
>  */
> static const struct property_entry simone_key_enter_props[] = {
>         PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
>         PROPERTY_ENTRY_STRING("label", "enter"),
>         PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
>         { }
> };
> 
> The code in gpiolib handling software nodes uses the name in the
> software node representing GPIO controller to locate the actual instance
> of GPIO controller.
> 
> Note that kbuild robot is likely to complain about this patchset because
> it depends on patches removing [devm_]gpiod_get_from_of_node() and
> devm_fwnode_get_[index_]gpiod_from_child() APIs that are still pending.
> I pushed them to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tmp-gpiolib
> 
> for your reference.

I agree with Bart, this is nice work!
So, for the patches 1-4:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> To: Linus Walleij <linus.walleij@linaro.org>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> 
> ---
> Dmitry Torokhov (6):
>       gpiolib: of: change of_find_gpio() to accept device node
>       gpiolib: acpi: change acpi_find_gpio() to accept firmware node
>       gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
>       gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
>       gpiolib: consolidate GPIO lookups
>       gpiolib: add support for software nodes
> 
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++----------
>  drivers/gpio/gpiolib-acpi.h   |  54 +---------
>  drivers/gpio/gpiolib-of.c     |  52 +--------
>  drivers/gpio/gpiolib-of.h     |  16 +--
>  drivers/gpio/gpiolib-swnode.c | 106 +++++++++++++++++++
>  drivers/gpio/gpiolib-swnode.h |  13 +++
>  drivers/gpio/gpiolib.c        | 239 ++++++++++++++++++++----------------------
>  8 files changed, 316 insertions(+), 297 deletions(-)
> ---
> base-commit: dc04f5ab1b1114aa19b9026f816fc01ca9c9941d
> change-id: 20221031-gpiolib-swnode-948203f49b23
> 
> -- 
> Dmitry
> 

-- 
With Best Regards,
Andy Shevchenko


