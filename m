Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D966AB71
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjANNCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjANNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:02:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3428A6B;
        Sat, 14 Jan 2023 05:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673701344; x=1705237344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPTuhkAaWgSbDGEK5C1EsaEmaCgD1cZnVukivsOV7ME=;
  b=iK7TMbmRIzV+TPQYJ5MqrrkL7qcDhAJq3mv7c/CUbvRS6Z7VWO6YeR0x
   A6beV58k+BKInTG4LA+C8oJwDUX8o7J4C95zbXbDd9G4IEhuV63+RbL1P
   QlMLpTfcOVzILVCRz/U0b51QjvJc9epMqdE41ysjtsaD9eQa6VZlnCmwn
   /rGn0KCeagEdWMWMeYWpiRbY3IrY8pwfcPA5YmohRcPHv+ALLcFlzDQQb
   VYzlfpGpAEVNIbjwK/YnJR5H+ckWvEvORGQtpjrArduX7iLuGHKuAbzj7
   iDSXncMcVF69lPqHKixWst6hcd1gequ4bycGi05koTpxltmwoXJovSCSB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307742115"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="307742115"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 05:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="660500001"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="660500001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2023 05:02:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pGgAs-0099ko-37;
        Sat, 14 Jan 2023 15:02:18 +0200
Date:   Sat, 14 Jan 2023 15:02:18 +0200
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
Message-ID: <Y8Kn2kGnhWEYS8Ws@smile.fi.intel.com>
References: <20230113171051.19309-1-andriy.shevchenko@linux.intel.com>
 <916654ca-e70f-5663-f3a3-9b370c24aea9@i2se.com>
 <Y8HNpokX5qCQTRqu@smile.fi.intel.com>
 <4b01c9ae-1603-6f42-431d-1158286557b5@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b01c9ae-1603-6f42-431d-1158286557b5@i2se.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:23:49PM +0100, Stefan Wahren wrote:
> Am 13.01.23 um 22:31 schrieb Andy Shevchenko:
> > On Fri, Jan 13, 2023 at 09:13:23PM +0100, Stefan Wahren wrote:
> > > Am 13.01.23 um 18:10 schrieb Andy Shevchenko:

...

> > > > Also I would like to understand the dance around checking for pin
> > > > control device. The original commit lacks of comments in the non-trivial
> > > > code.
> > Any comment on this?
> Do you mean the NULL check? of_pinctrl_get() could return NULL, but
> pinctrl_dev_get_devname() directly access the dev member.

The of_pinctrl_get() call. Why do we need that? AFAIU the code is called
after we call devm_pinctrl_register() and hence it can not be NULL. Am I
mistaken?

P.S. This is out of the scope of the series anyway, I left that untouched.
So it is just for me to understand better the code flow.

-- 
With Best Regards,
Andy Shevchenko


