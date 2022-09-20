Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AAE5BE561
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiITMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiITMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:12:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6CA6B8D2;
        Tue, 20 Sep 2022 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663675958; x=1695211958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8a/x35vyOCwISTweIxR3wnUES3MlUkr8sKyPLn6Tc8=;
  b=CQZShiEDWbpXvyXcdK6qdzkgtHSC5JMqFxQo5XPtfZkGwMMU6+PFx1zv
   Y7pLnElO6DhW2sP4YsBzQjMq2RK/DshUHm6AUycuRjdIe3vS8nNNQUbL6
   UhuC38mpr9WTeOZIUtYcQZ5Zf/9o/xUO6hw11wZWMGLhF/PebD+nfQi5X
   NIBFom0P83VSHJO1/xoUGnLgyPgVvV3IZA+m7AbxAP57jTaKVJlHo3JPy
   a3seFFJ9iKB0DbmKfNXR51cf4j96VrNpZsgSLVEv4yUYfkFYWuQ0em8Z7
   zze0sn1OxLE5+m2cuRwixZopzKmbawKrer301xoRqygp9qGXu1q5/b20R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299666103"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="299666103"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="707969050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2022 05:12:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oac77-004yyw-0V;
        Tue, 20 Sep 2022 15:12:33 +0300
Date:   Tue, 20 Sep 2022 15:12:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.or, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH RESEND] gpiolib: make gpiochip_find_by_name to be common
 function
Message-ID: <YymuMNGlFBMJAkdb@smile.fi.intel.com>
References: <20220920011747.824280-1-jay.xu@rock-chips.com>
 <CAMRc=McYhs8yoJ=_TQEcjr=-6UaYkGuZOpZnAGOTFs_oMOQrUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McYhs8yoJ=_TQEcjr=-6UaYkGuZOpZnAGOTFs_oMOQrUw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:39:59AM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 20, 2022 at 3:17 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:
> >
> > Move find_chip_by_name from gpiolib to the gpio/driver.h, also rename to
> > gpiochip_find_by_name, make it to be a common function.
> 
> Why did you resend it immediately?

I'm also puzzled with this. It's not the first time you resend the lot for
the unknown reasons.

> And what is the reason for this change?

First of all, it's Suggested-by: me (missed tag), second, it should be a part
of the patch set to answer your question.

-- 
With Best Regards,
Andy Shevchenko


