Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23F6597F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiL3MEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiL3MEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:04:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A51A07D;
        Fri, 30 Dec 2022 04:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672401886; x=1703937886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+0Sd0M5EfEEbNGgY1F9xuNdCdzW6vsBcJ7mE1FI7jo=;
  b=i0ICmGo82vf8kgBZLAtzt8R89mjx1yE+1LoWOVZU/qd8vn/X+/NUY/kM
   9wqMKpBC4KpWApBb7tcC234n3wF9E/vZi/B8doJyVYIjYia7r/lxcNsqJ
   vHGSFRTUb+CwewXxZfH8Qj35rKWP38tgUSSicQQhto12C8I0ZBWUZM/Sm
   9k4/ZM1HBMzhtxduWmz1etxw8MksgMrKF9nzilSxe7kVZWMUZfx1XhOOw
   xBeEBwGjFVkwf/QpxKJsFvuPFFbeAkaazFD7zsw+Ytze+07MGY20mn4pk
   Am/ZdMlQlFiZspUer/JoE3JB6OaYnPMsz6LL8g9RcFGFFB5FBetD/Ajko
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="308962497"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="308962497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 04:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="827962197"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="827962197"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2022 04:04:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pBE7u-001eLH-1I;
        Fri, 30 Dec 2022 14:04:42 +0200
Date:   Fri, 30 Dec 2022 14:04:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 1/4] gpio: pca953x: avoid to use uninitialized value
 pinctrl
Message-ID: <Y67T2u0VfSnq48KQ@smile.fi.intel.com>
References: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 12:05:58AM +0200, Andy Shevchenko wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> There is a variable pinctrl declared without initializer. And then
> has the case (switch operation chose the default case) to directly
> use this uninitialized value, this is not a safe behavior. So here
> initialize the pinctrl as 0 to avoid this issue.
> This is reported by Coverity.

Bart, any comments on the series?

-- 
With Best Regards,
Andy Shevchenko


