Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CF6B2873
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCIPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCIPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:11:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5F1CBC3;
        Thu,  9 Mar 2023 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678374509; x=1709910509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmHMHjWsIEv+/bgOBchMG8SZINqNerskiXVC/GNNJKU=;
  b=YF0AP8lHQkLa6/38DFcMN1mcpgSsMIi1kwuQL77Z7U1QayoUTNVRXrK9
   PaTHqJGT2LCGiN59qKePfHSW38FecPXBBbKxHP19kfqTp0M7Msq/ROOch
   No0YbDrhwIOyVglNMPGOjEs/KvEYtzj4i2Y1GmHshFi5pONxgMK5/McoF
   jJILtrjUFRcI2+IYkcvL6hy3H4niaeJ2gMURY81AszTDua9QHYtwPdjY5
   h0+domJNhpRFntdNyGiSsym+MyEByjIW2QRz9N4ZAacIF4pGnunyFZRkZ
   wIImrkat6kPmyZMexLhfsBD5buVQ0DP2Q/AJXJCbw12fzn32yh6N2D10e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="320311475"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="320311475"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820619470"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="820619470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 06:47:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paHYI-000NDm-25;
        Thu, 09 Mar 2023 16:47:30 +0200
Date:   Thu, 9 Mar 2023 16:47:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <ZAnxgooAixXAJvDn@smile.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
 <ZAnnJpdtlEOS4tiS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnnJpdtlEOS4tiS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:03:19PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 09, 2023 at 02:40:51PM +0100, Benjamin Tissoires wrote:
> > While trying to set up an SSDT override for a USB-2-I2C chip [0],
> > I realized that the function acpi_gpiochip_find() was using the parent
> > of the gpio_chip to do the ACPI matching.
> > 
> > This works fine on my icelake laptop because AFAICT, the DSDT presents
> 
> Ice Lake
> 
> > the PCI device INT3455 as the "Device (GPI0)", but is in fact handled
> > by the pinctrl driver in Linux.
> > The pinctrl driver then creates a gpio_chip device. This means that the
> > gc->parent device in that case is the GPI0 device from ACPI and everything
> > works.
> > 
> > However, in the hid-cp2112 case, the parent is the USB device, and the
> > gpio_chip is directly under that USB device. Which means that in this case
> > gc->parent points at the USB device, and so we can not do an ACPI match
> > towards the GPIO device.
> > 
> > I think it is safe to resolve the ACPI matching through the fwnode
> > because when we call gpiochip_add_data(), the first thing it does is
> > setting a proper gc->fwnode: if it is not there, it borrows the fwnode
> > of the parent.
> > 
> > So in my icelake case, gc->fwnode is the one from the parent, meaning
> 
> Ice Lake
> 
> > that the ACPI handle we will get is the one from the GPI0 in the DSDT
> > (the pincrtl one). And in the hid-cp2112 case, we get the actual
> > fwnode from the gpiochip we created in the HID device, making it working.
> 
> Thinking more about it. In ACPI we have those nodes defined as devices, right?
> So, strictly speaking the platform tells us that they _are_ devices.
> 
> The question here is what this device node in ACPI means:
> 1) the physical device or subdevice of the physical device OR
> 2) the physical device even if it's a part of combined (Multi-Functional)
>    device.
> 
> Second question is, does Device Tree specification allows something
> that is not a device node, but can be enumerated as a subdevice of
> a physical one?
> 
> P.S. I don't have objections against the patch, but I would like to
> have a clear picture on what the semantics of the two specifications
> WRT possibilities of device enumeration. It might be that we actually
> abuse ACPI specification in cases of Diolan DLN-2 or other way around
> trying to abuse it with this patch.

I have read the ACPI specification and it doesn't tell that Device is allowed
to describe non-hardware entity. It means that in the Linux driver model,
whenever we use Device() in the ACPI, we have an accompanying struct device.

For GPIO chip case, we have physical device (parent) and GPIO device, which
is Linux internal representation. So, physical device should have a description
in the ACPI table, or other way around: any Device() in ACPI has to be
considered as physical. That said, I think that Daniel was right and we need
to have parent properly assigned (to the Device(GPI0) node).

Another way, is to drop children from the descripton and use a single device
node for entire box.

TL;DR: if Device() is present we must use it as a parent to Linux
representation.

I would like also to hear Mika's opinion on this.

-- 
With Best Regards,
Andy Shevchenko


