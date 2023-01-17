Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB566D842
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjAQIeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjAQId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:33:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A556468B;
        Tue, 17 Jan 2023 00:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673944436; x=1705480436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uH2fB088cGnOr7hqS9w5uSuu3uYOrmGvb6kAqqLC9f8=;
  b=HEOZtIvaHI/gT+tuCgfXPY/S0TQ/aVAhWrYxYeamzCJaw5F5/bsFHXD4
   lNpIUV3cdMXJAjHNz/K2oV891QR3GRxgKU/tB/nNJ6AYo9oo6YPgF5REk
   BajkxGHAtKbibSj3Nq0fcosDJ1VHYE7YNPTPJCXOEDJewbGjSHaUaImA3
   7Cpx3VNBmF3cVp4ypahIJI3C1h5tp2TWjxB5doIrGS5jBz4IK66G+qnF3
   YTOTUrlQ71HlHV1mtUs3sVt8tFhvTMU9Tpm8Ff2Av7cjMh0A2Rd5ju9w4
   vQzTxSbWNXCDI43+BsUpmWr2ed/T/7csj/O5GrquvQDLkWoPNTM2HUJpB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="312506361"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="312506361"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 00:33:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="661208510"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="661208510"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2023 00:33:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHhPi-00ARvt-0S;
        Tue, 17 Jan 2023 10:33:50 +0200
Date:   Tue, 17 Jan 2023 10:33:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        regressions@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NL5xRU
Message-ID: <Y8ZdbVT+5z+q9xvC@smile.fi.intel.com>
References: <20230116193702.31356-1-mario.limonciello@amd.com>
 <20230116193702.31356-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116193702.31356-3-mario.limonciello@amd.com>
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

On Mon, Jan 16, 2023 at 01:37:02PM -0600, Mario Limonciello wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However on Clevo NL5xRU there is a mistake in the ACPI tables that the
> TP_ATTN# signal connected to GPIO 9 is configured as ActiveLow and level
> triggered but connected to a pull up. As soon as the system suspends the
> touchpad loses power and then the system wakes up.
> 
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 9.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> Reported-by: Werner Sembach <wse@tuxedocomputers.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 4287555a12408..9ef0f5641b521 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1623,6 +1623,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
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
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "ELAN0415:00@9",
> +		},
> +	},
>  	{} /* Terminating entry */
>  };
>  
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


