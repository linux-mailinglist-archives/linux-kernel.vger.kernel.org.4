Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABB622A90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKIL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIL3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:29:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C3E0F3;
        Wed,  9 Nov 2022 03:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667993385; x=1699529385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=weDABe4QTLm1KrZFnbFPqLVoV09bftWW7j0CQtDumik=;
  b=mZQYm2cDeA3CxZwWXe76Le0CeAWLaGkVSZhky1HQMabQUIq5St6mVVm/
   Zo2UuNX76snddsfjIu1x0oTUe0YVasRmKY1dW0DArgpyW3bBuykD2lmjq
   tnCKqtMKE1fYB2P/wvoTCdSCEPIc1IrIewWmWODm/5wWpM86XxGgC/VT1
   XZu3QXf+/SFjxLxJLwelEamYmJpUUdRio+WN9DFjIxyxwHTnJHAfxcO66
   03tix07TR0B7AfCNsGKZFYeVsREKFnB3yOaAFI0CEe4M3hrgxFAybHaO0
   IPBZO5xDv7FDf0+6MBY8WUKxeGHebftVs4GdkrSTlo6zSqXTxbXkp/eCR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298475926"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="298475926"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="631223690"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="631223690"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2022 03:29:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osjH3-009ibe-33;
        Wed, 09 Nov 2022 13:29:41 +0200
Date:   Wed, 9 Nov 2022 13:29:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for software nodes to gpiolib
Message-ID: <Y2uPJfkYpuI/uHeQ@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
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

On Tue, Nov 08, 2022 at 04:26:45PM -0800, Dmitry Torokhov wrote:
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
>  * the device that used platform data.
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

Thank for an update!

I have almost nothing serious except two nit-picks I think we can address:
- dropping const qualifier for no (?) reason
- having a superfluous check and extra dev_dbg()

If you are are going to address them, feel free to add my Rb tag to
the patches 5 & 6.

-- 
With Best Regards,
Andy Shevchenko


