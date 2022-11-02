Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F59616292
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:19:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2600233A8;
        Wed,  2 Nov 2022 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667391579; x=1698927579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gSmXqHgQAkc1Vf0+T3qTpwJHYWgvUSv1OFFYjEDKiU=;
  b=Mdeh+YqGkb0usPeDfvA/mKR2yleYvV8wmlktpN47QYLMqrsgG1LX3EAf
   Makybfbx7YM0wSazL/vB3a6jjaVrBsJbDsEmW6QMazbGWRTzzD8G2FHUY
   jpsT0KM7cYYmzXBhiI1GefzmHWA8bLU0dlfAqUEFKPfKGmsVirasiVVwI
   NJo5C36//yDRhT+OymnV3cnHfOUylmLTWidGO9bkHd4AB1wOliPjuaczT
   5zA7s55ack5HYveZyfRyAS4KoLl/CVpU1a++wL8ZLzITQxBhuJIjJ7V9V
   0QI3Uflnj4rFdKYWBymeAukcSaQwwGcSL1pZKwldTH7d0j0VShk7sLIEv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289104748"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="289104748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776873074"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="776873074"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2022 05:19:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0BE05155; Wed,  2 Nov 2022 14:19:59 +0200 (EET)
Date:   Wed, 2 Nov 2022 14:19:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/6] pinctrl: intel: Enable PWM optional feature
Message-ID: <Y2Jgb5/U0/yt7u7o@black.fi.intel.com>
References: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Nov 01, 2022 at 05:56:36PM +0200, Andy Shevchenko wrote:
> This is a continuation of the previously applied PWM LPSS clean up.
> Now, we would like to enable PWM optional feature that may be embedded
> into Intel pin control IPs (starting from Sky Lake platforms).
> 
> I would like to route this via Intel pin control tree with issuing
> an immutable branch for both PINCTRL and PWM subsystems, but I'm
> open for other suggestions.
> 
> Hans, I dared to leave your Rb tags, however the patches are slighly
> differ, because of the Uwe's suggestion on how to handle the missing
> headers. I hope you is okay with that. If not, please comment what
> must be ammended then.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Andy Shevchenko (6):
>   pwm: Add a stub for devm_pwmchip_add()
>   pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
>   pwm: lpss: Include headers we are direct user of
>   pwm: lpss: Allow other drivers to enable PWM LPSS
>   pwm: lpss: Add pwm_lpss_probe() stub
>   pinctrl: intel: Enumerate PWM device when community has a capabilitty

Looks good to me. For the entire series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
