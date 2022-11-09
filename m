Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECB6231E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKIRuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKIRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:49:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DDC760;
        Wed,  9 Nov 2022 09:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668016195; x=1699552195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JIWJ4EH85m/Zy1AYOZ16tTErIMHKa3lrdAajfeCmHqw=;
  b=WsoNPzVUL6v5pNcVjp+eB0HxVF3eBzGP0xB1FfGAKg6vewr2HvNjAsAW
   t3XFD8/uJBjP1+ZIl4Sh3ad869qjgw6cBMBHmdY3slWWl6Arsfr3FhK6l
   nnCD5/hc2CfEvdoeWBfAZRGOfiv/k37Yg3kWblt+YBtZHy8ac0D/8vWf7
   bSURGiYaiTAronVQm6Z5oC0+ECq9BYwGPpq1dOvWSFp7+orwYftPw/TbQ
   0GJVRubNKfTlcPaCKYTzt1RWaDH8li5Gj78bpQlMAxigsqlguZ3Od9Y8y
   kUiSIO9sJIRcN8DasxOPRzukyQ7jZYi3z2UealS+lWzkkgJ4mvaGhwIc5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337791858"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="337791858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 09:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="779436272"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="779436272"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2022 09:49:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ospCx-009r8Q-0t;
        Wed, 09 Nov 2022 19:49:51 +0200
Date:   Wed, 9 Nov 2022 19:49:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/6] pinctrl: intel: Enable PWM optional feature
Message-ID: <Y2voPgNfdQ+Sc4nS@smile.fi.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <Y2vl8qXwGOXaky/a@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2vl8qXwGOXaky/a@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 06:40:02PM +0100, Thierry Reding wrote:
> On Tue, Nov 08, 2022 at 04:22:20PM +0200, Andy Shevchenko wrote:
> > This is a continuation of the previously applied PWM LPSS cleanup series.
> > Now, we would like to enable PWM optional feature that may be embedded
> > into Intel pin control IPs (starting from Sky Lake platforms).
> > 
> > I would like to route this via Intel pin control tree with issuing
> > an immutable branch for both PINCTRL and PWM subsystems, but I'm
> > open for other suggestions.
> 
> I don't have any objections for this to go through the Intel tree as
> long as Uwe is happy with this.

So far Uwe acknowledged patch 2 only, hopefully he will have time to go
thru the rest.

> Most of this is just reworking existing
> things and the stub additions look good to me, so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


