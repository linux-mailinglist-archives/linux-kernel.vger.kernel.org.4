Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F32703FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbjEOVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbjEOVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:40:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E510E5C;
        Mon, 15 May 2023 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684186846; x=1715722846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvW3OVIO11rtZpjrfrNpvFqRUCOTmH5JtdCGGW08rcc=;
  b=St8h7TAqtAIL2rGevUCLUw5t5eIe3C1tpdy+SnA27qAaKc9gqDmTqRrc
   B83czgAuCPmt66PTlWZXac60OiL4mPdudx0cMK/Y9WrLQmEYb2ZjIntfz
   I2Leui3u5nhdWi1uRn9d1YwJIcAhsMgajmkoNUzMEkZhBd9KbLXP0f/QR
   oFx30n3yrnUaSydRJ8/JHZ3R3dNRJw2RobipWH0x7zXJUDifu9Sws0R11
   wwgnHpzM75jOPi0G+d2C4WT0aDlTN8l+lQ9W1XhLbD/N+LitmX+l7MxaS
   O8JS8j6EIqk0+fkJrpnW9KM1rCh3LVBGkHT2Mo+gtt0O465z7zwgX+/f2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437656217"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="437656217"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 14:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="651583790"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="651583790"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2023 14:40:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pyfvm-00074t-2o;
        Tue, 16 May 2023 00:40:34 +0300
Date:   Tue, 16 May 2023 00:40:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio
 pins into another table
Message-ID: <ZGKm0jQv/8/Tgg/a@smile.fi.intel.com>
References: <20230515150352.30925-1-henning.schild@siemens.com>
 <20230515150352.30925-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515150352.30925-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:03:50PM +0200, Henning Schild wrote:
> There are two special pins needed to init the LEDs. We used to have them
> at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
> way is to have a dedicated table for the special pins.

...

>  static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
>  	.dev_id = "leds-gpio",
> @@ -26,6 +27,12 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 3, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 4, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 5, GPIO_ACTIVE_LOW),

Missing terminator. I'm wondering how this works...

> +	},
> +};
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {
> +	.dev_id = NULL, /* Filled during initialization */
> +	.table = {
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
>  	},
> @@ -40,9 +47,15 @@ static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
>  		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),

Ditto.

> +	},
> +};
> +
> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {
> +	.dev_id = NULL, /* Filled during initialization */
> +	.table = {
>  		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
>  		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),

Ditto.

> -	}
> +	},
>  };

-- 
With Best Regards,
Andy Shevchenko


