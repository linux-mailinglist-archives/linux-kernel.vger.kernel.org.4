Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2FF69E19A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjBUNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjBUNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:45:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E091E1E0;
        Tue, 21 Feb 2023 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676987111; x=1708523111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=23msXls3K1pf3326O/TTlUGpsqk4HGbdQVHDHS8vDSs=;
  b=aqocSrKHTdqB93EvfJ0am4ibgCVsVkqxEdrINcN5a+Udj87nYmY7pO78
   Wkkgerk2idWufpmocCux5dHlBLMLWtsR4XGFGA2UZbhvqk/fjUI1VLUgH
   wjQZyA3Vx/hYzyxOwKPiJkZFJ1Ap2D9F91JMI80Zuv4riOch/eM6jfxly
   mqCKJ1jbiBMt9fplsyKnxRsFd+SBZxyGgC1mwrzCcqCy7/BTbuRAMM1pl
   8jPP9Y6+M0lW0INkOOOlQ4eiPjx+xEF30Af1HKYxA2rggguNQP5GHG4QS
   tHVJ/2VpzjeM3n9r/s+eTn6PLNHQHPVXu6zDaumI9A2lIaNKP4j+GVoay
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="418854521"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="418854521"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 05:45:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="795525666"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="795525666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 05:45:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUSx8-009yKY-1A;
        Tue, 21 Feb 2023 15:45:06 +0200
Date:   Tue, 21 Feb 2023 15:45:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio
 pins into another table
Message-ID: <Y/TK4tJZ5kmgsRNJ@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221122414.24874-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:24:12PM +0100, Henning Schild wrote:
> There are two special pins needed to init the LEDs. We used to have them
> at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
> way is to have a dedicated table for the special pins.

...

> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e_extra = {

> +	.dev_id = NULL,

No need.

...

> +static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g_extra = {

> +	.dev_id = NULL,

Ditto.

-- 
With Best Regards,
Andy Shevchenko


