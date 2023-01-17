Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B6266D844
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAQIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAQId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:33:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DF14E94;
        Tue, 17 Jan 2023 00:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673944437; x=1705480437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0T4IZGdpXC0a4vVV3lEfRA4t5fR3xO5F8rQbdyDYC/Q=;
  b=lXAlRKoh8TpxHCVoyM7i1gtYli+B2R4nGLj1szVJcICP3i3cXG85IBA3
   4Rta/cq0LNhskbUc4cxKDXb67JWlmsZHIFZvQW3xE6BbQST3SGc76CCE3
   TEua2KCNjtVtbxvW64E/2sIcTJB70308FlZo0461L10DIL0mCBPPrItGq
   Hun1R3F1FmeY+TDUrkS9E7ER2djBEQDa5bhHaqEWVaHRWEieLVzyeYaJ+
   FTT1oPfCTNBgxNX3VYI7oIhxfu99wbAu3ugD1GBLEhnAT+L/66zyAT80Y
   SSSF+V8s07y3ZoSv+bf1comf0Mwf85XBGJXAF4FduywKvu1APpe/AZ6id
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326710506"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="326710506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 00:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722566715"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="722566715"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 00:33:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHhPQ-00ARvU-0a;
        Tue, 17 Jan 2023 10:33:32 +0200
Date:   Tue, 17 Jan 2023 10:33:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        regressions@lists.linux.dev, Raul Rangel <rrangel@chromium.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpiolib: acpi: Allow ignoring wake capability on
 pins that aren't in _AEI
Message-ID: <Y8ZdWx018I75E+vI@smile.fi.intel.com>
References: <20230116193702.31356-1-mario.limonciello@amd.com>
 <20230116193702.31356-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116193702.31356-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:37:01PM -0600, Mario Limonciello wrote:
> Using the `ignore_wake` quirk or module parameter doesn't work for any pin
> that has been specified in the _CRS instead of _AEI.
> 
> Extend the `acpi_gpio_irq_is_wake` check to cover both places.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Raul Rangel <rrangel@chromium.org>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1722335
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index bed0380c51360..4287555a12408 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -385,7 +385,7 @@ static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *contro
>  }
>  
>  static bool acpi_gpio_irq_is_wake(struct device *parent,
> -				  struct acpi_resource_gpio *agpio)
> +				  const struct acpi_resource_gpio *agpio)
>  {
>  	unsigned int pin = agpio->pin_table[0];
>  
> @@ -778,7 +778,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  		lookup->info.pin_config = agpio->pin_config;
>  		lookup->info.debounce = agpio->debounce_timeout;
>  		lookup->info.gpioint = gpioint;
> -		lookup->info.wake_capable = agpio->wake_capable == ACPI_WAKE_CAPABLE;
> +		lookup->info.wake_capable = acpi_gpio_irq_is_wake(&lookup->info.adev->dev, agpio);
>  
>  		/*
>  		 * Polarity and triggering are only specified for GpioInt
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


