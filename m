Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D81677AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAWMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAWMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:23:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFA902D;
        Mon, 23 Jan 2023 04:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674476593; x=1706012593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGgD7whDEY/8n5iwKWV38/lNDe31QKJgf6jUF7ERzLg=;
  b=FB2dQhhTxwuLv+/sPyjlL9rwzc2Vn8V0GxnI2s9LZl6Aei+HINXS9XVZ
   pYN5DaU42HvyEQJbTUY0GkBGj6wlYo/z/UnevEUoulvW8Z+ei9z7CnNXc
   0v/ovipF6iibZhIcDPDKNK9lm2smHkhSA2wm+j5HHxXGv2oEd05AKc3Pq
   BVUOoOUlTrtw5gnTnjhnZr4ALjVlB82LLLa9GLFwaKNvfVZBFoiUesJqK
   1lnR5rWIJkBqkHhwo905UPQmU/UyT5ch0+156hYZMtlPBfcjh0EtnTMb7
   5+TyNfLg2pWC6cwfIR2qh3ZdsfYWcDVtg8S2RQumSl6ozHT6ZhzbV1qBL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390529807"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390529807"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:23:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="663540221"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="663540221"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 04:23:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJvqs-00DjGb-1H;
        Mon, 23 Jan 2023 14:23:06 +0200
Date:   Mon, 23 Jan 2023 14:23:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Raul E Rangel <rrangel@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Message-ID: <Y858KiEntqtleiRM@smile.fi.intel.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121134812.16637-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 07:48:11AM -0600, Mario Limonciello wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> adjusted the policy to enable wakeup by default if the ACPI tables
> indicated that a device was wake capable.
> 
> It was reported however that this broke suspend on at least two System76
> systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> When the machines are set to s2idle, wakeup behaves properly.
> 
> Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
> set it when the system supports low power idle.

Fine by me,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set wake_irq")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
> Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> Suggested-by: Raul Rangel <rrangel@chromium.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 9ef0f5641b521..17c53f484280f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
>  				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
>  			}
>  
> -			if (wake_capable)
> +			/* avoid suspend issues with GPIOs when systems are using S3 */
> +			if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>  				*wake_capable = info.wake_capable;
>  
>  			return irq;
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


