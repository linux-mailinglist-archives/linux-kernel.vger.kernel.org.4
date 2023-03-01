Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF96A720F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCAR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCAR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:28:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3444C14;
        Wed,  1 Mar 2023 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677691719; x=1709227719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//eUmlYkmEmSMV0g9eAnakRxqB4JT1ypkuInRj7r90U=;
  b=ni76Y6vcqW0vIUQ01xZi0uI8fIpjhtpZyMbbbjNPHa0DAsO6LTCSnJ+Q
   Bp4WVaNAtNddE4LXowUVt/0gq1CP44OaKp+2h8sW9LCIf5brjO/ON/zmj
   KRghiPEWLnm38j9tSBBT9uVPtpLnI58iE9sJ7rMiEdDP70zehVndh1E0K
   59wDMOzm7SWsMdOD02QvVy2uzGny0aGnzYxLkcszPWDRtg5L868bjo4A9
   VPnwAV5xT1DkvlrOHgZxVO4ecAyqr+TLjXrWtsOletmrXkoU8Nyt1Hw0H
   sWOZyWd+bhdUiS8+4pxof7HyPBkECadRzz0sQcFUGC1rmOQ6Hb76OQHzB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="399258471"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="399258471"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676840373"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="676840373"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 09:28:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQFQ-00Dr6E-0v;
        Wed, 01 Mar 2023 19:28:12 +0200
Date:   Wed, 1 Mar 2023 19:28:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <Y/+LLICwh3T25IGv@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170215.23382-3-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild wrote:
> In order to clearly describe the dependencies between the GPIO
> controller drivers and the users the driver is split up into a core,
> two drivers and a common header.

...

>  .../simple/simatic-ipc-leds-gpio-apollolake.c |  64 +++++++
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 103 ++++++++++++
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  64 +++++++
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 159 ------------------

I'm wondering if you have used -M -C when creating this patch.

...

> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/x86/simatic-ipc-base.h>

+ Blank line?

> +#include "simatic-ipc-leds-gpio.h"

...

> +	.table = {
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 0, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 1, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 2, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),
> +	},

Shouldn't this have the terminator entry?

...

> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_extra = {
> +	.dev_id = NULL,

As per previous patch.

> +	.table = {
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
> +	},

As per above.

> +};

...

> +	.driver = {
> +		.name = KBUILD_MODNAME,

Strictly speaking this is an ABI (as something may instantiate the driver from
the user space or elsewhere by this name. At the same time this may change with
the file name change.

Personally I prefer explicit string literal here.

> +	},

...

> +

Redundant blank line.

> +module_platform_driver(simatic_ipc_led_gpio_apollolake_driver);

...

> +MODULE_ALIAS("platform:" KBUILD_MODNAME);

Why? HAve you missed MODULE_DEVICE_TABLE()?

...

> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c

Similar comments as per above.

-- 
With Best Regards,
Andy Shevchenko


