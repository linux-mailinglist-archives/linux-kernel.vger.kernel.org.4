Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FE6B3E33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCJLls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:41:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCA1102B9;
        Fri, 10 Mar 2023 03:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678448470; x=1709984470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8uJ+SHxf2x4/ypjczFk1TZ2tA36nKyiU5NKtQOsNtTE=;
  b=Ja/NdsA8JIkXo2p0dZPH+O9e4f9C7wtgB0GW8O7FIEpCGtnANPvHkC6n
   MCea3XN7iY7xUTm43A+WsYVfIkYPEEh0PMqrhAvQ3ItvOMS0H0HD+oCi2
   5YvT/xLQF4ep6LEs6E9BDUymu8lwZWnqjZNMAIU8S4dq8KP13qKaMrxVR
   DrNT2bYgkBOBVOVqAL4s1X+4xq+wFn62PhLpx5CZBptnqJ7MNH45xGG4K
   T5dpCeQ0SRH/OTVPd97/ah2A2kSx74TR5c2AQYz5uPWQrAPEAMCYNTTp8
   VEQyxSuuU7ahTzHKUaLZHy3Qw6PP7Zmw0FrGzurBOyponICbhe1TkyQ+S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399307817"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399307817"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923655089"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923655089"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2023 03:41:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 32ACF143; Fri, 10 Mar 2023 13:41:50 +0200 (EET)
Date:   Fri, 10 Mar 2023 13:41:50 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Kaehn <kaehndan@gmail.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: use the fwnode in acpi_gpiochip_find()
Message-ID: <20230310114150.GA62143@black.fi.intel.com>
References: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309-fix-acpi-gpio-v1-1-b392d225efe8@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
> that the ACPI handle we will get is the one from the GPI0 in the DSDT
> (the pincrtl one). And in the hid-cp2112 case, we get the actual
> fwnode from the gpiochip we created in the HID device, making it working.
> 
> Link: https://lore.kernel.org/linux-input/20230227140758.1575-1-kaehndan@gmail.com/T/#m592f18081ef3b95b618694a612ff864420c5aaf3 [0]
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
