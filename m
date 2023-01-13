Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF566A524
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjAMVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjAMVcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:32:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F582AE6;
        Fri, 13 Jan 2023 13:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645484; x=1705181484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SLmxe4+aIxsCW+XX4xedaaboKVOBP5e1UnAYk1kMH7Q=;
  b=EMqeV0ErT5Pjbmc8ByBZ9DrKwdyLRwOscb0DW9/ueuWpn8lxYi1ewq6I
   tHPiQ7AWUcNdl1XLY/96ujqQHBtpBHmpZQXI/+WkaHOZY3yFVU1dVwbiY
   IcN4Hi35cK603H96t7uFJbw44CWqjAMyRwtnOdVW6yKqsm4OYj81r6iY6
   MPk0ETIbfx74UBDHl/W+wEHUVh8g+YwlGgLob+nl81UnnlMAl4zWxDSAg
   K1zR7q9ysTHnI/lug/cQBlcRd0GH67g8BJbL3S9VSTcmKTwbI5HN57QH2
   BcvA8fZdRfhkXEZYU6mZKdo8U0H1rUUQoFDmA820sGeoB0N4yjoqBOWO/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="303802037"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="303802037"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:31:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987132454"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="987132454"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 13:31:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGRdu-008rWo-1S;
        Fri, 13 Jan 2023 23:31:18 +0200
Date:   Fri, 13 Jan 2023 23:31:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v2 1/2] pinctrl: bcm: bcm2835: Switch to use
 ->add_pin_ranges()
Message-ID: <Y8HNpokX5qCQTRqu@smile.fi.intel.com>
References: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
 <916654ca-e70f-5663-f3a3-9b370c24aea9@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <916654ca-e70f-5663-f3a3-9b370c24aea9@i2se.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:13:23PM +0100, Stefan Wahren wrote:
> Am 13.01.23 um 18:10 schrieb Andy Shevchenko:

...

> > v2: fixed compilation issues (LKP), Cc'ed to the author of original code
> > 
> > Btw, the commit d2b67744fd99 ("pinctrl: bcm2835: implement hook for
> > missing gpio-ranges") seems problematic in the fist place due to
> > odd of_node_put() call. I dunno how that part had been tested, or
> > how it's supposed to work, i.e. where is the counterpart of_node_get().
> > Anyway this change drops it for good.
> 
> The countpart is in of_pinctrl_get(). I was just following the pattern like
> in other drivers like gpio-rockchip. The original commit has been tested by
> Florian Fainelli and me. I'm not sure if it's safe to drop it completely.

Please, elaborate how of_pinctrl_get() increases refcount of the parameter.
Maybe I'm looking into a wrong place?

> Btw this is not the only platform affected by the gpio-ranges compatibility
> issue [1].

This is the only one that uses unnecessary added callback.

> > Perhaps we can check gpio-ranges property presence inside the GPIO
> > library, so this ->add_pin_ranges() won't be called at all.
> 
> I thought this could be very platform specific, so i implemented a hook. But
> yes my initial hack modified gpiolib-of [2].

The point is that possibly documentation of ->add_pin_ranges() should be
amended to take care of the cases like this. We don't need two or more
hooks to do the same, esp. taking into account that OF specific doesn't
cover other cases.

> [1] - https://patchwork.kernel.org/project/linux-arm-msm/patch/20180412190138.12372-1-chunkeey@gmail.com/
> 
> [2] - https://lore.kernel.org/linux-arm-kernel/75266ed1-666a-138b-80f1-ae9a06b7bdf3@i2se.com/
> 
> > Also I would like to understand the dance around checking for pin
> > control device. The original commit lacks of comments in the non-trivial
> > code.

Any comment on this?

-- 
With Best Regards,
Andy Shevchenko


