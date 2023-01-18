Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA56719B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjARKxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjARKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:50:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8398767A;
        Wed, 18 Jan 2023 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674036016; x=1705572016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2tZ5Rth2ZJQZY5dRVVWiCqjV6zPqTwq9vKdXrQkoDvQ=;
  b=H6N/EYWVc9oEpTjEy4Rt7lmdhxkjH1efcXnacvNvt9anv7bMyPXQd61L
   g8tY+XDK8nddZN2j6aeMvdhzC9PgPSnAMxonXYu+pCgg9n1G7dRmB0HPO
   YCQGhfWByygG8i339RgQPfFVErYDqaqUw9pnT2qOP41awTeyF0p4DDqxm
   +frmoQj9ES9EDxCB8vBODV5ErCkYKrKCIuP5Yt7MJq3MkoP+U+qTPx2hW
   Ae9Ad3Fe46A1KfrlEHTm3+LDBS5lWtvYuyzELCHykq7gjyjjFVSlSNVXr
   Us9MUQcu9fvfcJpqivB00eLZ7v1bFUfxzpfdhxEM0NWH0TJHlmQyDGe1V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411184688"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411184688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 02:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="723027824"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="723027824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 02:00:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI5Ep-00B6xD-1h;
        Wed, 18 Jan 2023 12:00:11 +0200
Date:   Wed, 18 Jan 2023 12:00:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kushagra Verma <kushagra765@outlook.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: fix extcon dependency
Message-ID: <Y8fDK58AgUotnUw+@smile.fi.intel.com>
References: <20230118090147.2126563-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118090147.2126563-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:01:41AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dwc3 core support now links against the extcon subsystem,
> so it cannot be built-in when extcon is a loadable module:
> 
> arm-linux-gnueabi-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_extcon':
> core.c:(.text+0x572): undefined reference to `extcon_get_edev_by_phandle'
> arm-linux-gnueabi-ld: core.c:(.text+0x596): undefined reference to `extcon_get_extcon_dev'
> arm-linux-gnueabi-ld: core.c:(.text+0x5ea): undefined reference to `extcon_find_edev_by_node'
> 
> There was already a Kconfig dependency in the dual-role support,
> but this is now needed for the entire dwc3 driver.
> 
> It is still possible to build dwc3 without extcon, but this
> prevents it from being set to built-in when extcon is a loadable
> module.

Thank you for fixing this!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: d182c2e1bc92 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/dwc3/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index b2f72b0e75c6..be954a9abbe0 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -3,6 +3,7 @@
>  config USB_DWC3
>  	tristate "DesignWare USB3 DRD Core Support"
>  	depends on (USB || USB_GADGET) && HAS_DMA
> +	depends on (EXTCON || EXTCON=n)
>  	select USB_XHCI_PLATFORM if USB_XHCI_HCD
>  	select USB_ROLE_SWITCH if USB_DWC3_DUAL_ROLE
>  	help
> @@ -44,7 +45,6 @@ config USB_DWC3_GADGET
>  config USB_DWC3_DUAL_ROLE
>  	bool "Dual Role mode"
>  	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
> -	depends on (EXTCON=y || EXTCON=USB_DWC3)
>  	help
>  	  This is the default mode of working of DWC3 controller where
>  	  both host and gadget features are enabled.
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


