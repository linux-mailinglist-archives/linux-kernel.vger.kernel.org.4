Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24F6B438F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjCJOPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCJOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:15:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378AB11786A;
        Fri, 10 Mar 2023 06:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457646; x=1709993646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wnHp8QotpEXnl4syrGWTVi+ZzBP8IVSR7jssb+hIwqU=;
  b=e25VbFKxeO1nlE7ALxE6pf2eYKtsx1Xpiko1CAvgvDJ8Oum8OjmR4Pm6
   JYNUdHyOHL7PeqCUmt8rF2RMXLAJmk+B7NcDkizl54bYME2Ua1xZWADKx
   /1NJBB/jXhA9vGRyhWTKGtmEPUlM9k1dcYWW8oH3sf8SX+26ubuvQod5q
   sqDAcMpsPbhcORzmrvg8GVP/Oeq0VobByTguFoqgEgF828RLpm8uMzQ3w
   hX1RMU/sPKXwCCycso+op7tQMDPsNUBZaL3owz1tMKMtJA9L7+wMS4ApZ
   fwui31txsrFvM+TzJLjOlYWBllxhlwHzHnIZinE8+ze5kIyvIMDEB6UET
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="401593953"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401593953"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:13:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671093619"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="671093619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 06:13:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1padVJ-000wyG-1H;
        Fri, 10 Mar 2023 16:13:53 +0200
Date:   Fri, 10 Mar 2023 16:13:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <ZAs7IS8tcc92RVCM@smile.fi.intel.com>
References: <20230309-fix-acpi-gpio-v2-1-9eb20a1fd42c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-fix-acpi-gpio-v2-1-9eb20a1fd42c@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 02:38:10PM +0100, Benjamin Tissoires wrote:
> While trying to set up an SSDT override for a USB-2-I2C chip [0],
> I realized that the function acpi_gpiochip_find() was using the parent
> of the gpio_chip to do the ACPI matching.
> 
> This works fine on my Ice Lake laptop because AFAICT, the DSDT presents
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
> So in my Ice Lake case, gc->fwnode is the one from the parent, meaning
> that the ACPI handle we will get is the one from the GPI0 in the DSDT
> (the pincrtl one). And in the hid-cp2112 case, we get the actual
> fwnode from the gpiochip we created in the HID device, making it working.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


