Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE9697F07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBOPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBOPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:01:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E66A60;
        Wed, 15 Feb 2023 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676473282; x=1708009282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byV8wy9GAcUe7GfCIo1f9Ew8oSCPVPqII8FN//zv8qA=;
  b=NOvTUEwToy/7gdFUkIRbDZBpx0BOI+EUb6PHIXuVrfgmrFEOWm+Iu4A8
   D9M2UxYaoxRxigu0KXjxz7UO7YzTwbF5mGKHqY5eqWceX6ug/+GZLzid0
   OPEQWrMKRv7zd6d9KYF+N8H63B8LqonEAS8tIM2OhvoKWKMr0q1BNqutB
   ZrVCtbJLV2z3aXL/YxE1fgRqJuYRxj//m1vOvPBVGzuZc8Wix4GgxJBHl
   nKqfg1AtSSRj6yrxbQyF8qcpY/fvNWEPqrCp0RdOz/8apl5YAEbsGXGxB
   us4+VKW+El/WAguUMDcNEMBuG1IXpxqv/WFSvW40bnvPcecBK0k9tf/Hq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="330077864"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="330077864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 07:00:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662965581"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="662965581"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2023 07:00:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSJH3-007Id8-08;
        Wed, 15 Feb 2023 17:00:45 +0200
Date:   Wed, 15 Feb 2023 17:00:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH v4] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NH5xAx
Message-ID: <Y+zznGKC0jyy9lsS@smile.fi.intel.com>
References: <20230215143941.13247-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215143941.13247-1-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:39:41PM +0100, Werner Sembach wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However for some devices there is a bug, that is causing the touchpad to
> instantly wake up the device again once it gets deactivated. The root cause
> is still under investigation:
> https://lore.kernel.org/linux-acpi/2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com/T/#mb2e738787f6b6208d17b92aa6e72d4de846d4e4d
> 
> To workaround this problem for the time being, introduce a quirk for this
> model that will prevent the wakeup capability for being set for GPIO 16.

I massaged a bit the commit message and pushed for fixes, thanks!

-- 
With Best Regards,
Andy Shevchenko


