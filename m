Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143276B36C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCJGmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCJGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:42:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D42DCA45;
        Thu,  9 Mar 2023 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678430546; x=1709966546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqgvZtjOayYUzOC46Z2VKVj5sGkB2Yka1uFwzIGH5Fg=;
  b=YtMvM/LGsNnimBfaA+kgGc6q3cJiYIaK9FtJsXQ6r1VUwiRzRn01Mfyg
   NOJEsWNV43pfrBLeOm/cxo7kgIs0Nn0hay+t9EINRsJs06oWrniQx1MI5
   dlfTUydosf7KKjDAVrhW2Dh2yibMLjtqfGdGvvNUFsaULJctiGW9wEOS/
   k4WNMl//tgN30SftJIB+UIsyk85ONSDTg4K4rTqqDOlNJZtoWJ5ImT+jG
   lh8RLjpJI5ljSWhV/wtCw0YLIuMTFfy+CFIix8zyUN0doC+hYqoVr7xpO
   uuA0BX08AM5AZMkypz8W2n0E1JyQQ56c/meU75pU1Rf49J5h6Ag3xGkAT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="316313744"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="316313744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 22:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923555136"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="923555136"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2023 22:42:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2B529143; Fri, 10 Mar 2023 08:43:08 +0200 (EET)
Date:   Fri, 10 Mar 2023 08:43:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <20230310064308.GW62143@black.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
 <ZAnnJpdtlEOS4tiS@smile.fi.intel.com>
 <ZAnxgooAixXAJvDn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAnxgooAixXAJvDn@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 09, 2023 at 04:47:30PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 09, 2023 at 04:03:19PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 09, 2023 at 02:40:51PM +0100, Benjamin Tissoires wrote:
> > > While trying to set up an SSDT override for a USB-2-I2C chip [0],
> > > I realized that the function acpi_gpiochip_find() was using the parent
> > > of the gpio_chip to do the ACPI matching.
> > > 
> > > This works fine on my icelake laptop because AFAICT, the DSDT presents
> > 
> > Ice Lake
> > 
> > > the PCI device INT3455 as the "Device (GPI0)", but is in fact handled
> > > by the pinctrl driver in Linux.
> > > The pinctrl driver then creates a gpio_chip device. This means that the
> > > gc->parent device in that case is the GPI0 device from ACPI and everything
> > > works.
> > > 
> > > However, in the hid-cp2112 case, the parent is the USB device, and the
> > > gpio_chip is directly under that USB device. Which means that in this case
> > > gc->parent points at the USB device, and so we can not do an ACPI match
> > > towards the GPIO device.
> > > 
> > > I think it is safe to resolve the ACPI matching through the fwnode
> > > because when we call gpiochip_add_data(), the first thing it does is
> > > setting a proper gc->fwnode: if it is not there, it borrows the fwnode
> > > of the parent.
> > > 
> > > So in my icelake case, gc->fwnode is the one from the parent, meaning
> > 
> > Ice Lake
> > 
> > > that the ACPI handle we will get is the one from the GPI0 in the DSDT
> > > (the pincrtl one). And in the hid-cp2112 case, we get the actual
> > > fwnode from the gpiochip we created in the HID device, making it working.
> > 
> > Thinking more about it. In ACPI we have those nodes defined as devices, right?
> > So, strictly speaking the platform tells us that they _are_ devices.
> > 
> > The question here is what this device node in ACPI means:
> > 1) the physical device or subdevice of the physical device OR
> > 2) the physical device even if it's a part of combined (Multi-Functional)
> >    device.
> > 
> > Second question is, does Device Tree specification allows something
> > that is not a device node, but can be enumerated as a subdevice of
> > a physical one?
> > 
> > P.S. I don't have objections against the patch, but I would like to
> > have a clear picture on what the semantics of the two specifications
> > WRT possibilities of device enumeration. It might be that we actually
> > abuse ACPI specification in cases of Diolan DLN-2 or other way around
> > trying to abuse it with this patch.
> 
> I have read the ACPI specification and it doesn't tell that Device is allowed
> to describe non-hardware entity. It means that in the Linux driver model,
> whenever we use Device() in the ACPI, we have an accompanying struct device.
> 
> For GPIO chip case, we have physical device (parent) and GPIO device, which
> is Linux internal representation. So, physical device should have a description
> in the ACPI table, or other way around: any Device() in ACPI has to be
> considered as physical. That said, I think that Daniel was right and we need
> to have parent properly assigned (to the Device(GPI0) node).
> 
> Another way, is to drop children from the descripton and use a single device
> node for entire box.
> 
> TL;DR: if Device() is present we must use it as a parent to Linux
> representation.
> 
> I would like also to hear Mika's opinion on this.

Agree with the patch. We should be using whatever the gc->fwnode points
to.
