Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B103B7427F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjF2OIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:08:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A626B6;
        Thu, 29 Jun 2023 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688047694; x=1719583694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xmDZpF6sc1XpPDTUdv/IYr02rtOyyvGSFPAQ64hfvSc=;
  b=O9a6JblVm8P/sVHwidDQ0hN+lXyUZDUdaPvOvweRUcP1nf4X4bMWsoh3
   yfGaUh33Z4hgxvzDj6RQJgURzTwP7aYERKiKbesPhgNLT/8+CbCM03OmY
   weyUDKgusHAQzyLZWJPkFEwzYKbb3U/+dmi/EdxqDXhZpk36XQ4xAjqn3
   nK3wZufEiJ98gC/P4Qsn/y6gBNaFFYbcR8VJIc5z0uMAW91JRB52JLyfT
   RtdATzwgMW1KOJPTy9ROCGoS3SYhV80g0vWPwLqidiUdvyijT3k3cO7L5
   pASNYetcqLzrcAoZ46Fymobo2696uqjq2hWlFcihlxQc+xxsR7dcCPcEG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428149996"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="428149996"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1047776124"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="1047776124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 06:55:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEs7e-000sBw-1G;
        Thu, 29 Jun 2023 16:55:46 +0300
Date:   Thu, 29 Jun 2023 16:55:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        kernel@axis.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] led: leds-lp50xx: Add max-brightness as in
 leds-pwm
Message-ID: <ZJ2NYrskskXCNJZv@smile.fi.intel.com>
References: <20230629134722.3908637-1-astrid.rost@axis.com>
 <20230629134722.3908637-2-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629134722.3908637-2-astrid.rost@axis.com>
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

On Thu, Jun 29, 2023 at 03:47:21PM +0200, Astrid Rost wrote:
> Add max-brightness in order to reduce the current on the connected LEDs.
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.

This will be 4th driver in the LED subsystem that will use this (optional)
property. Perhaps it's time to actually move it to the LED generic bindings
and call this from led_parse_fwnode_props()?

-- 
With Best Regards,
Andy Shevchenko


