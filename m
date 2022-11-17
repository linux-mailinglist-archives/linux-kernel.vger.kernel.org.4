Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AB62D826
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbiKQKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiKQKhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:37:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17C31DD4;
        Thu, 17 Nov 2022 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668681429; x=1700217429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d/BwTcDjTby7+EvF7SJminV1ic477402fiCW3AFm03g=;
  b=SninrCjIKdJbxb6pyy4gKicXWjNL2H7IoaBy4vZAMoE7NfiT3JEZQckn
   0/1enSqE7l2QBrDZQZ/TR2Xmau1OZHEzE4GgcZONMuUB2nWt3yP7NyWBX
   9sEuwS/Nd7izkGJUhD94ZeirFzyqNTx/C0j6Nt3MPa53T/JQxJJLuYX7E
   7m8wK12UPTPzPNmBRziJMfwPQfZG3SKvmO/vnygOmbFFHAR3Sgz7z1pN4
   Jym8EP4aeIBQQcsX3+81P4SuFYNIaPyaIKS2GKfQsgV1UpmRxacjsjdRm
   rhf2Fv9lOhGdUSbtDTKsh94yl1BqYpH4nREs15skToL5aw7xG0iSrfJAH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="399105946"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="399105946"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 02:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884814164"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="884814164"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2022 02:37:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovcGV-00DXBD-2m;
        Thu, 17 Nov 2022 12:37:03 +0200
Date:   Thu, 17 Nov 2022 12:37:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 7/7] pinctrl: intel: Enumerate PWM device when
 community has a capability
Message-ID: <Y3YOz/9oLdjFwuK5@smile.fi.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
 <20221114165545.56088-8-andriy.shevchenko@linux.intel.com>
 <20221117090605.ktgyaverpzl3irjo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117090605.ktgyaverpzl3irjo@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:06:05AM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 14, 2022 at 06:55:45PM +0200, Andy Shevchenko wrote:
> > Some of the Communities may have PWM capability. In such cases,
> 
> Is "Communities" is proper name in this context? If not, I'd not
> capitalize it.

Intel pin control is a set of so called Communities, which are divided by
groups of pins. (There is an intermediate division, but it doesn't affect
software anyhow, so I haven't mentioned it).

> > enumerate the PWM device via respective driver. User is still
> 
> s/User/A user/ ?

OK!

> > responsible for setting correct pin muxing for the line that
> > needs to output the signal.

...

> > +	pwm = devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
> > +	if (IS_ERR(pwm))
> > +		return PTR_ERR(pwm);
> > +
> > +	return 0;
> 
> The last 3 codelines can be replaced by
> 
> 	return PTR_ERR_OR_ZERO(pwm);
> 
> (but I know it's subjective if you like that or not, so I won't insist;
> see also b784c77075023e1a71bc06e6b4f711acb99e9c73).

Yes, it used to be like that in some of my previous attempts
(maybe not public), but have been changed due to an additional
error check which is gone, so it can be reinstantiated now.

...

> All in all this is all very minor, so:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> even if you keep the patch as is.

Thank you, I will amend as you suggested.

-- 
With Best Regards,
Andy Shevchenko


