Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE86CDB44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjC2Nzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjC2Nzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:55:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63401C2;
        Wed, 29 Mar 2023 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680098141; x=1711634141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5I9tE2hnLEdY1WTTcTTJ/HOFXe45bbkHF5No/mcsq4c=;
  b=eUwYjnuRM+UbCwIIpJvUV09VjfWsMptLUbiAJ0QEKKlW0bmQaG7CAyLY
   Jibjj5V7zpL8JrAgg+r+7/MQaWCG0fS/+hKZIVdM0JOe6m9mNhXSvDaQG
   hMySUnWgGWdqBjm4M2rVKyC/bq7Qx/AjQfvGjKz9epmjybCw87u9G/2cG
   UDf/2aHg0yxBTVOa80T8vY/Sosy96FdmzvWOxFo2x61YD0MxEBsSaLSut
   CLcKVC6bO4Elo8eTsWGqTiTBZa7bCu8LFgr97+GV5quSc4r03+r7mPxro
   FgZb1/5fcADUp20n6ZPWVMwYFPm/fpi+gaj+0TIRq1tEJJy6iyP4OLCpf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="405824659"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="405824659"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684271112"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684271112"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 06:55:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phWGw-00A38s-2P;
        Wed, 29 Mar 2023 16:55:30 +0300
Date:   Wed, 29 Mar 2023 16:55:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Split property name from the warning
 message
Message-ID: <ZCRDUp2sniTQWdFU@smile.fi.intel.com>
References: <20230321135310.73153-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MeBbdHYV-_2utMBVy-31GzGbWM8GUD9RRV8vYQ3OzHWrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeBbdHYV-_2utMBVy-31GzGbWM8GUD9RRV8vYQ3OzHWrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:37:16PM +0200, Bartosz Golaszewski wrote:
> On Tue, Mar 21, 2023 at 2:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -               dev_warn(dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
> > -                        count, chip->offset);
> > +               dev_warn(dev, "%s too short (length %d), cannot map names for the gpiochip at offset %u\n",
> > +                        "gpio-line-names", count, chip->offset);
> >                 return 0;
> >         }
> 
> I'd say being able to grep the code easily for messages is more
> important than saving a couple bytes here?

We still grep by the rest of the message. But anyway, up to you,
I've no hard feelings to this patch.

-- 
With Best Regards,
Andy Shevchenko


