Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F862C668
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiKPRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiKPRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:32:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60932BAC;
        Wed, 16 Nov 2022 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668619945; x=1700155945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3Mt2zvxz7/ueWTGbr7K4kLTgJ3MbCP5UiSfr+GFz54=;
  b=Fp0KF7YojpblEyNWVh4+IrePsTrhIMnGqSg3pFs/yIDPakxep3tPNS6M
   fORFg+2MwMQufv8oSFx+J+0AGcd67ahpoiEf5dlg+rlve3sqqss8xjC6f
   NTlC9n2wLDS1M47L+yoYjBeVWsnWjWEwqaGnG2xvzoghpBtRS6L3WQOkK
   +udLzzbrlgMalEjxUPV4u2UQv8vzA+XPhMfQGvsHpR067JQPFcLdD2ege
   ezkUFjYNS0SN7/IsaCTmOsmh516jCu25YElVY6lrn49MM9QiIkN8o+/zv
   28jiAeLhYrKW12ewbUK6mKJim5UQjSRd5Jd0o10Dp+Vth06odwR7Z62jq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312617427"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="312617427"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 09:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="672472288"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="672472288"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2022 09:32:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovMGl-00DF0p-0q;
        Wed, 16 Nov 2022 19:32:15 +0200
Date:   Wed, 16 Nov 2022 19:32:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/7] pinctrl: intel: Enable PWM optional feature
Message-ID: <Y3Uenh/U2WPPARds@smile.fi.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:55:38PM +0200, Andy Shevchenko wrote:
> This is a continuation of the previously applied PWM LPSS cleanup series.
> Now, we would like to enable PWM optional feature that may be embedded
> into Intel pin control IPs (starting from Sky Lake platforms).
> 
> I would like to route this via Intel pin control tree with issuing
> an immutable branch for both PINCTRL and PWM subsystems, but I'm
> open for other suggestions.
> 
> Hans, I dared to leave your Rb tags, however the patches are slightly
> differ, because of the Uwe's suggestion on how to handle the missing
> headers. I hope you are okay with that. If not, please comment what
> must be amended then.

Uwe, it would be nice if you have a chance to look at this one more time.
If it is okay, I can push it to an immutable branch and send out for all
stakeholders.

> Changelog v4:
> - added patch "Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()"
> 
> Changelog v3:
> - added tags (Uwe, Linus, Thierry)
> - fixed some spelling issues in the commit messages
> - changed a paragraph in the commit message of the patch 3 (Uwe)
> - replaced -ENODEV check with IS_REACHABLE() in the patch 6 (Uwe)
> 
> Changelog v2:
> - added tag (Mika)
> - added base-commit to the series, to make sure LKP can test it
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Andy Shevchenko (7):
>   pwm: Add a stub for devm_pwmchip_add()
>   pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
>   pwm: lpss: Include headers we are the direct user of
>   pwm: lpss: Allow other drivers to enable PWM LPSS
>   pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
>   pwm: lpss: Add devm_pwm_lpss_probe() stub
>   pinctrl: intel: Enumerate PWM device when community has a capability
> 
>  drivers/pinctrl/intel/pinctrl-intel.c      | 32 ++++++++++++++++
>  drivers/pwm/pwm-lpss-pci.c                 |  2 +-
>  drivers/pwm/pwm-lpss-platform.c            |  2 +-
>  drivers/pwm/pwm-lpss.c                     |  8 ++--
>  drivers/pwm/pwm-lpss.h                     | 34 ++++-------------
>  include/linux/platform_data/x86/pwm-lpss.h | 44 ++++++++++++++++++++++
>  include/linux/pwm.h                        |  5 +++
>  7 files changed, 95 insertions(+), 32 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/pwm-lpss.h
> 
> 
> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


