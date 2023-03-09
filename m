Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536EC6B2642
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCIOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCIOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:06:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0DF2C2E;
        Thu,  9 Mar 2023 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370715; x=1709906715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyu2LhQmiWMU7PEtu0Xqa5WBJtDdVhaFUmfdUENtKaQ=;
  b=X0jppAABYmvm7dDz4YhZfEVFesTTZv6g3TingN8cFot8igaeOLsH1NDn
   OTueHIqkZg/hmlZl2szP2GEkSWQzdhOe7sUVJtlGyRl8fZGPqb3SuvWyc
   M+uJYUaHZ2DsTNBfR4W71E/MKaCEvWKNaWplIay675px25r3LZjFGwqkg
   w7KAzqUEkydzXcmCCe19QUwDqQaaYz/NjCl+LAqDJiqxntmKT8XDUmhr1
   yA/AiTeryyUzRSIx5VzNuwn6eD/0D5QSogfEShU6tBNZ1Ro+Dnr6DKhBk
   4eO6QN6w14KJTrDOFor6BofQJPAkM9UascPq6j9L0s33nq8mIy+ACRhR1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320279826"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="320279826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741571681"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="741571681"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2023 06:03:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paGrX-000Loh-0G;
        Thu, 09 Mar 2023 16:03:19 +0200
Date:   Thu, 9 Mar 2023 16:03:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <ZAnnJpdtlEOS4tiS@smile.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:40:51PM +0100, Benjamin Tissoires wrote:
> While trying to set up an SSDT override for a USB-2-I2C chip [0],
> I realized that the function acpi_gpiochip_find() was using the parent
> of the gpio_chip to do the ACPI matching.
> 
> This works fine on my icelake laptop because AFAICT, the DSDT presents

Ice Lake

> the PCI device INT3455 as the "Device (GPI0)", but is in fact handled
> by the pinctrl driver in Linux.
> The pinctrl driver then creates a gpio_chip device. This means that the
> gc->parent device in that case is the GPI0 device from ACPI and everything
> works.
> 
> However, in the hid-cp2112 case, the parent is the USB device, and the
> gpio_chip is directly under that USB device. Which means that in this case
> gc->parent points at the USB device, and so we can not do an ACPI match
> towards the GPIO device.
> 
> I think it is safe to resolve the ACPI matching through the fwnode
> because when we call gpiochip_add_data(), the first thing it does is
> setting a proper gc->fwnode: if it is not there, it borrows the fwnode
> of the parent.
> 
> So in my icelake case, gc->fwnode is the one from the parent, meaning

Ice Lake

> that the ACPI handle we will get is the one from the GPI0 in the DSDT
> (the pincrtl one). And in the hid-cp2112 case, we get the actual
> fwnode from the gpiochip we created in the HID device, making it working.

Thinking more about it. In ACPI we have those nodes defined as devices, right?
So, strictly speaking the platform tells us that they _are_ devices.

The question here is what this device node in ACPI means:
1) the physical device or subdevice of the physical device OR
2) the physical device even if it's a part of combined (Multi-Functional)
   device.

Second question is, does Device Tree specification allows something
that is not a device node, but can be enumerated as a subdevice of
a physical one?

P.S. I don't have objections against the patch, but I would like to
have a clear picture on what the semantics of the two specifications
WRT possibilities of device enumeration. It might be that we actually
abuse ACPI specification in cases of Diolan DLN-2 or other way around
trying to abuse it with this patch.

-- 
With Best Regards,
Andy Shevchenko


