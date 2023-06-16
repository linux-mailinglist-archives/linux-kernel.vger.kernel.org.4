Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A6733244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbjFPNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbjFPNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:33:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245A359E;
        Fri, 16 Jun 2023 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686922432; x=1718458432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4rPdsxf+B69gRS+K2VE3MCran6ryOKf8Z1G6PlTJ9XE=;
  b=dO+s58PQKkD4hBg16McNM2n4anwEIqwWqjbwZJAzkFhIlfSjmGaI4TyZ
   CK3LtKs7uSU/SyotxExEFiyK3szG2PZ6GUZrMPiEeCDrrFfPHUCGJBSSb
   yNzOEcM8aQ3vvfRaXK8/BPeQjzWx9rVmvl0trjBX22ileDoPyw6OtvG0O
   PaLBzzEr1B+0OTP7r0wfq9a3tfBbt+d4BPPqqi9n+D3TNb6BzKbFss60i
   LcVsj8hY7FvTbFQAZnR1EKzgyoW7uuGiQYm1A6mJjpK2gXpRg9tFw/7B6
   tNoDRr3/7xs+kPoxV9YMp9e0WD58msRFxGRFj/rLGyGe30JpHnNFhpfYH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361745297"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="361745297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 06:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825748967"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="825748967"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2023 06:33:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qA9aF-004FzL-2J;
        Fri, 16 Jun 2023 16:33:47 +0300
Date:   Fri, 16 Jun 2023 16:33:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 0/5] gpio: aggregator: Incorporate gpio-delay
 functionality
Message-ID: <ZIxku9jFT9tOY7cY@smile.fi.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
 <4392854.e9J7NaK4W3@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4392854.e9J7NaK4W3@steina-w>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:01:17AM +0200, Alexander Stein wrote:
> Am Donnerstag, 15. Juni 2023, 15:20:18 CEST schrieb Andy Shevchenko:
> > The newly appeared gpio-delay module enables external signal delay lines
> > that may be connected to the GPIOs. But at the same time it copies the
> > GPIO forwarder functionality. Besides that the approach does not scale.
> > If we would have another external component, we would need yet another
> > driver. That's why I think, and seems others support me, better to
> > enable such a functionality inside GPIO aggregator driver.
> > 
> > Patch 1 is a cleanup that may be applied independently on the decision
> > about the rest.
> > 
> > Please, test and comment! Alexander, I would appreciate your tag.
> 
> This works on my platform:
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


