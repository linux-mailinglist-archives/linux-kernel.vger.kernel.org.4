Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04512697A35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjBOKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjBOKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:49:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5F20D13;
        Wed, 15 Feb 2023 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676458190; x=1707994190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A1GVDAatWTbg3vYiCbvEQRHzPOG8qGp7+GAnChLvirM=;
  b=J9XOdUr36xKViVg4K5F6h6yii3An23oQerGY9w/3+U6kW5u0AA1mrjUh
   ay44omEm3bjr591rzOr2rb1p/kPTkTtz43mLtdi747nexzdDyFINsolMc
   ryLM+7aGAh+z5SsACT233DUbsPduIwUilOnxMi+ri52zVA0dWrxkw4aLh
   3UiFVgSKRA41dTrNqaC9CHS5FRxCodmRsTLUhTjPvyrJ+YTTKtoRx/tXx
   h+5/kZQlmkq68hC+O2TfO/D5xhspCDqYVjhMmJOjV0cfXYacKvqVA2UGr
   ahSMClKg/Ib74zVhZrJhCIKww7W8YrvR9okj4RwiOSL7EmofnSH2+eBS1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311763741"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="311763741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 02:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733238704"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="733238704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2023 02:49:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSFMA-007DXH-0B;
        Wed, 15 Feb 2023 12:49:46 +0200
Date:   Wed, 15 Feb 2023 12:49:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH v3] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NH5xAx
Message-ID: <Y+y4ycHtPkABr/Ia@smile.fi.intel.com>
References: <20230214125810.10715-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214125810.10715-1-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:58:10PM +0100, Werner Sembach wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However for some devices there is a bug, that is causing the touchpad to
> instantly wake up the device again once it gets deactivated. The root cause
> is still under investigation:
> https://lore.kernel.org/linux-acpi/2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com/T/#mb2e738787f6b6208d17b92aa6e72d4de846d4e4d

Bart, I'm fine if it goes directly via your tree, or I can send it in usual
bundle of fixes after rc1 (however it seems this deserves to make v6.2).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> To workaround this problem for the time being, introduce a quirk for this
> model that will prevent the wakeup capability for being set for GPIO 16.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index e2ab4d5253bea..82e8e43582eba 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1612,6 +1612,18 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.ignore_wake = "ELAN0415:00@9",
>  		},
>  	},
> +	{
> +		/*
> +		 * Spurious wakeups from TP_ATTN# pin
> +		 * Found in BIOS 1.7.7
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.ignore_wake = "SYNA1202:00@16",
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


