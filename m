Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAE6C4EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVO4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCVOzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189B7D98;
        Wed, 22 Mar 2023 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679496934; x=1711032934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h6hskFbHw7KYbk2YVxQW62X04Lp2hb/hxK+OlVrcXP4=;
  b=Rxxgqsu8UAdQnb1h6K303HVluCyVmnz5D30/nhwmcJpyS2ZenbrSU+gm
   xor7pUpiJDVctjX0QEwTy3seq0xPXoPnUc9sMuncpewpEuXtcL3mniXxA
   msnsVqGNYn7nCZ7Sb7m0sbzmR7G+1u+K8Ye68+b+MN+95fXd1m8ubkisk
   u6eIYjWQwJILL7weXKA2jg/GiseLs3iwxvzB/QC89bJUxcQarhb9UI8mQ
   WSqCikoydSgBJNovxKH/rIJ6w9qeLtAJLQCgQ5NFTPq52bsQ0vtRPuAyj
   0MwEwHlTehZrvJvtw4bvhQe8b/XPKlVafmzQygqFre+2ip37Y4pdHvYKi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327613246"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327613246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792583313"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792583313"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:55:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pezsA-007Agk-0e;
        Wed, 22 Mar 2023 16:55:30 +0200
Date:   Wed, 22 Mar 2023 16:55:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU
Message-ID: <ZBsW4XzDvBXNSy2C@smile.fi.intel.com>
References: <20230322121547.14997-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322121547.14997-1-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:15:47PM +0100, Werner Sembach wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However on Clevo NL5xNU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.
> 
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 9.
> 
> This patch is analoge to a very similar patch for NL5xRU, just the DMI
> string changed.

Fine,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpio/gpiolib-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 34ff048e70d0e..055013f959b25 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1624,6 +1624,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.ignore_interrupt = "AMDI0030:00@18",
>  		},
>  	},
> +	{
> +		/*
> +		 * Spurious wakeups from TP_ATTN# pin
> +		 * Found in BIOS 1.7.8
> +		 * https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "ELAN0415:00@9",
> +		},
> +	},
>  	{
>  		/*
>  		 * Spurious wakeups from TP_ATTN# pin
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


