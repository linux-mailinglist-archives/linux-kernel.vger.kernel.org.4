Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6767D6923F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjBJRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjBJRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:05:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D671031;
        Fri, 10 Feb 2023 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676048740; x=1707584740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kVL093vuqMy/XSj3eiI+5YfoBG6X1O8lTOOxXMxMQI=;
  b=n9QZDxcPuqQf5FwQOGXStJ5NVLSSU6uMwoXRbRbHN0y6eBbHLbXeyINf
   Nov//lyDlVVijnw+8vDOhgC4n+SsemLuri1ueTSg4HHPwCU6beuK9huDq
   /YK4Cg3pK56uZilLfvhsX6rW27PwBt+qg2y+nZ7Sop8Gg1cGg9qOLHDhn
   ndUCgAs44MAnvOyclDm9HjQFAjy9zPUzYlVnzBPPpXMb7ioHtUOqzUuCo
   aPQv7YJ6R5G9EndblP50V+gPzOuEqbrQx6e8SfN7FbyT3YqfmgNHcsJHH
   xwcaqti7ModylVVCsNbGDHZ3BjslvK4i3l4uU7ASRAebuoZGVIP7le4sm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328158465"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328158465"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 09:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="700537280"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="700537280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2023 09:04:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pQWpV-0058Qb-2k;
        Fri, 10 Feb 2023 19:04:57 +0200
Date:   Fri, 10 Feb 2023 19:04:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210164636.628462-1-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> ActiveLow and level triggered but connected to a pull up.

I'm not sure I understand the issue here. From what you say here it seems
correct ACPI description.

> As soon as the
> system suspends the touchpad loses power and then the system wakes up.
> 
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 10.

I'm not against fixing this, but wouldn't be better to actually target the root
cause and have a different quirk? Or is it me who didn't get what is the root
cause?

-- 
With Best Regards,
Andy Shevchenko


