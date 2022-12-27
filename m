Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAB657017
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiL0Vqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiL0Vqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:46:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF36264;
        Tue, 27 Dec 2022 13:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672177596; x=1703713596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kmcjgEDAykC0AR++Xx1za8yHHknHDmL1rEM6R1K8MBo=;
  b=GRhGz2uQyGFc0HvG7I2F41wGFJQ7LcZ8loiXEU7hNF8KJL/90biA39s3
   VUKHVxWKvAo25S7+N5mDneIIFrWeDRTHX0OOqiAc631BwDuOcrGpPe3wZ
   K8EdcJ5lh6doGJi7zrlw0h5Dl5pVWpAx/QK1R3QQ+1iKYISv4iXGv3A+R
   pDV9vjggbTWdv0zNprocYmZAn958VpeJsqoEKzv70nWDwZE7aUHLiEota
   0z5difTR/GeAyTFF5dBl7LdkD1uIUeWBdgGjmd3YJP/ouSYqIq5F9l375
   JLg/8RLwAipLRpjq6kMexHHeaOqkhhfFJcjEQTSiOEGvAxa5RUDns7HzW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="320845536"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="320845536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="981891396"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="981891396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 27 Dec 2022 13:46:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAHmL-000Gsk-2t;
        Tue, 27 Dec 2022 23:46:33 +0200
Date:   Tue, 27 Dec 2022 23:46:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/8] pinctrl: Introduce struct pinfunction and
 PINCTRL_PINFUNCTION() macro
Message-ID: <Y6tnuTIzRIld+LM3@smile.fi.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
 <Y6B4YZZW0GS/2kDV@smile.fi.intel.com>
 <Y6FULyRF4IxdtGoG@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6FULyRF4IxdtGoG@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:20:31AM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 04:42:41PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 19, 2022 at 02:42:33PM +0200, Andy Shevchenko wrote:
> > > There are many pin control drivers define their own data type for
> > > pin function representation which is the same or embed the same data
> > > as newly introduced one. Provide the data type and convenient macro
> > > for all pin control drivers.
> > 
> > The stats for the entire series:
> > 
> > drivers/pinctrl/intel/pinctrl-baytrail.c   | 10 +++++-----
> > drivers/pinctrl/intel/pinctrl-cherryview.c |  6 +++---
> > drivers/pinctrl/intel/pinctrl-intel.c      |  6 +++---
> > drivers/pinctrl/intel/pinctrl-intel.h      | 16 +++++-----------
> > drivers/pinctrl/intel/pinctrl-lynxpoint.c  |  8 ++++----
> > drivers/pinctrl/intel/pinctrl-merrifield.c |  6 +++---
> > drivers/pinctrl/intel/pinctrl-moorefield.c |  6 +++---
> > include/linux/pinctrl/pinctrl.h            | 20 ++++++++++++++++++++
> > 8 files changed, 46 insertions(+), 32 deletions(-)
> 
> Thanks!
> 
> For the series,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


