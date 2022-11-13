Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2AB626FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiKMNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKMNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:11:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D89BE26;
        Sun, 13 Nov 2022 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668345067; x=1699881067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CcCCmPTjaNaAfq31TEG9o/ZixEAsxHy4/I5W8DpGz4g=;
  b=WmXtkrGaySgSQeWnDRHsvRl0UHsy++BmLZCZh9DirtfIC6txT6pu0PrL
   vnlD1OVg3Yv3JAw64ewLIGU7kGQdywEjGftPzX86U9KMeKWMG4rgGrn1a
   zVPONtv5StHgVdLwFaMzZMdm56hQJoFS1dxRMsGdWgkLDJKJoDJawOv7E
   A42Z5TPiA0wgGIGqk/zERAC6ZLnv+mgpmS3HiDwl5hAmxFYycFArMMccy
   DAJ9LqyojAD1nsdKSXj1P6PymGIXAsBB4zKZddersLQO0d2EaZ8zuPvtE
   8gJbMwlx01nxMpLZTQgvCD6YCoJ+UZVbW6x3fFNJJwjske3dXDqd0faAl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="292208672"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292208672"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 05:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="967268678"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="967268678"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2022 05:11:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouClL-00BgbJ-2N;
        Sun, 13 Nov 2022 15:11:03 +0200
Date:   Sun, 13 Nov 2022 15:11:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 2/4] regmap-irq: Add handle_mask_sync() callback
Message-ID: <Y3Ds59lTf5/4Vfe3@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <53e9e89cc9d7e9c20cbdfc13b360dcb43d07f832.1668129763.git.william.gray@linaro.org>
 <Y3DmSfdG9ZeV8inu@smile.fi.intel.com>
 <Y3DsWFQfE3Ov8s2t@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3DsWFQfE3Ov8s2t@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 08:08:40AM -0500, William Breathitt Gray wrote:
> On Sun, Nov 13, 2022 at 02:42:49PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 08:55:51PM -0500, William Breathitt Gray wrote:
> > > Provide a public callback handle_mask_sync() that drivers can use when
> > > they have more complex IRQ masking logic. The default implementation is
> > > regmap_irq_handle_mask_sync(), used if the chip doesn't provide its own
> > > callback.

...

> > > + * @handle_mask_sync: Callback used to handle IRQ mask syncs. The index will be
> > > + *		      in the range [0, num_regs[
> > 
> > Not sure if it's a typo ([ vs. ]), but if you want to say "not including the
> > last", use mathematical notation, i.e. "[0, num_regs)".
> 
> I was following the convention used in the @get_irq_reg description, but
> I agree that mathematical notation would be much clearer.

Ah, maybe cleaning up the rest then?

-- 
With Best Regards,
Andy Shevchenko


