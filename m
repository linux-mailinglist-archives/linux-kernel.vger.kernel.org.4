Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD0674033
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjASRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjASRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:41:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3454CE52;
        Thu, 19 Jan 2023 09:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674150080; x=1705686080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxXDwRveZtxucvUYmAPZ/GPhSHbN8IenrbMpJ2+g3fI=;
  b=O9/bzeomdYHsNPTFqOZHviOEHDj5bwSV89x+gK+WR2l27EA23gPa3RgN
   VvZ48QRUKGtFO3ZCpwjWPORz0nLBYSah2kjNnwKGJAybEtFPU1ARZWHPQ
   IS6HDHnlcFRU5NtvBkd++i+x4OZ+rLRLWcnKrpphpghXKmEuNS5O7Qvwd
   fjVmmTRLDRjlDwZs/bjLy1Oxh2GE70D1s6YhltuRXt+yIkRt+CxGxVYuG
   WRIJNT8xB1H2/j1752Qnqe/ZFvXf80zA6J3e4pcEaW4YXMlHS58a2pYEx
   OKNV3qcpfraNdF5In8BJSNWbNq9/CshZ91BIt2N4WdpRSb52Hrk4lbC+5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326638866"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326638866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610146349"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610146349"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 09:41:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIYuW-00BnBe-1i;
        Thu, 19 Jan 2023 19:41:12 +0200
Date:   Thu, 19 Jan 2023 19:41:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v3 0/4] gpiolib: get rid of exessive
 ->of_gpio_ranges_fallback()
Message-ID: <Y8mAuFCI2vHqNKvw@smile.fi.intel.com>
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
 <b16c0134-b8a6-573c-4ad9-c4620fc98d5c@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16c0134-b8a6-573c-4ad9-c4620fc98d5c@i2se.com>
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

On Thu, Jan 19, 2023 at 06:28:27PM +0100, Stefan Wahren wrote:
> Hi Andy,
> 
> Am 13.01.23 um 22:53 schrieb Andy Shevchenko:
> > The ->of_gpio_ranges_fallback() repeats the idea that lies behind
> > ->add_pin_ranges(), while the latter covers more cases that the former
> > hook. Drop the former one for good.
> 
> i successful tested booting of this series with multi_v7_defconfig on
> Raspberry Pi 4 (with and without gpio-ranges in DTB):
> 
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


