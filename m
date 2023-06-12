Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA572CCF1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjFLRfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbjFLReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:34:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CA4497;
        Mon, 12 Jun 2023 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686591145; x=1718127145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVDfAUTAXFV5BfIrJ9ItRq/i2wyOxOvXPgprmaXrves=;
  b=ZMiIjCS5brL9o0viDla8XGuzBSEy0CyZaijcwfnkTOsGiUFdGv38ODs+
   rBWaEhPvGR1GmWb9fDPDor+9e1l5QFM9lBdQ9pqxBW6RJUuEADgvY1sh1
   pfjaWqHmLZV51BQPNHa0VWNQ4Uj/cE0dK1/1J97gBTgkj8SUTYy8Raa3Q
   4LwBXW9TTKWjNfRb53F5VhdPEI9d3rWjyz4uY/5hwJ6YTYqPwSEW8++OH
   EDoDWY97XZte47wFtkg2VaMc6g/Xu4mfMCQnmMegt2iEff5tuVKNUzZ2/
   qIHkm8r+u9Mxfs9Z0Tg58XWkb/WeRDw20CEBCnILSgiyZTsKs/btNBNEq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338475232"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338475232"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 10:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="744397459"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="744397459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2023 10:30:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8lNW-003GWA-2L;
        Mon, 12 Jun 2023 20:30:54 +0300
Date:   Mon, 12 Jun 2023 20:30:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux@ew.tq-group.com" <linux@ew.tq-group.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
Message-ID: <ZIdWTvOWQrMWuy39@smile.fi.intel.com>
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
 <4808746.GXAFRqVoOG@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4808746.GXAFRqVoOG@steina-w>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:40:15AM +0200, Alexander Stein wrote:
> Am Donnerstag, 8. Juni 2023, 18:23:08 CEST schrieb Andy Shevchenko:
> > The aggregator mode can also handle properties of the platform, that
> > do not belong to the GPIO controller itself. One of such a property
> > is signal delay line. Intdoduce support of it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > I don't like the idea of gpio-delay or similar. We have already GPIO
> > aggregator that incorporates the GPIO proxy / forwarder functionality.
> > 
> > This one is RFC because:
> > 1) just compile tested;
> > 2) has obvious issues with CONFIG_OF_GPIO;
> > 3) contains ~5 patches in a single change for now;
> > 4) requires additional work with blocking sysfs for this;
> > 5) requires some DT bindings work;
> > 6) ...whatever I forgot...
> > 
> > Any comments are appreciated, and tests are esp. welcome!
> 
> FWIW: Replacing CONFIG_GPIO_DELAY=m with CONFIG_GPIO_AGGREGATOR=m works as 
> well on my platform.

Thank you for testing!

> But I'm not sure if it's worth the additional complexity for gpio-aggregator 
> to replace gpio-delay.

The (main) problem is that it does not scale. Today we have RC chain, tomorrow
(hypothetically) LC or LRC. Are we going to create (repeat) the similar approach
for each single case?

I would probably tolerate the existence of the gpio-delay, but we already have
GPIO forwarder, which implements 70% (?) percent of gpio-delay already.

-- 
With Best Regards,
Andy Shevchenko


