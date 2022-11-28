Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900D063A57E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiK1J4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1J4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:56:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C3193EA;
        Mon, 28 Nov 2022 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669629379; x=1701165379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sVe+3HXGQg6252gQ0Wbkddzjii9xckisjHP4R0Kg/mA=;
  b=ibgKPd3pktXj/GWW0CJfJJqaKP0bTYnWzMZSKR68DNjSGXFCfLDkwCvy
   H5k7EIQG/NswRCbxK96PDcbCqKKcUvIIHO2ueA5hjcJrR6dyDCibuCIrU
   mx9ZLJx5srxkdAKoprKDsIa2RWoahmXod9TDJ5Ov/Kz/CcnExj5gRPH+b
   JY61oqtcz+Hzc1IRYzjBAqC2KnsBbitk1BfXGpN6Elqxoo0MhqFFqDaP/
   4oUv04pHElNxjbEYHLTXhLF3nRW0B9yNIPK2Gd+Lip0EEHoQppC110Ys0
   3o1r9gkKO6pRx+RrTSXZnU1CaM0j24id1dvSdeWwTC1CCB4dWWNHH0nJ9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="312428890"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="312428890"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="785566761"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785566761"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 01:56:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozas3-00143E-1d;
        Mon, 28 Nov 2022 11:56:15 +0200
Date:   Mon, 28 Nov 2022 11:56:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y4SFv9bRc1mlVf2r@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com>
 <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
 <Y4PeCBy/8slpMp2R@fedora>
 <Y4SEjVpLUd1wA8nd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4SEjVpLUd1wA8nd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:51:10AM +0200, Andy Shevchenko wrote:
> On Sun, Nov 27, 2022 at 05:00:40PM -0500, William Breathitt Gray wrote:
> > On Sun, Nov 27, 2022 at 07:31:48PM +0100, Michael Walle wrote:
> > > Am 2022-11-22 11:29, schrieb William Breathitt Gray:

...

> > > gpiochip doesn't seem to be the correct place, gpiochip_add_irqchip()
> > > is a noop for gpio-regmap, right? So using gpiochip_irqchip_init_hw()
> > > seems wrong.
> > > 
> > > Maybe make gpio-regmap call it on its own? But really we just connect
> > > the regmap-irq to the gpiochip irqdomain.
> > 
> > I think you're right, it feels strange to handle IRQ initialization via
> > the GPIO framework. Maybe somewhere in regmap_irq might be more
> > appropriate?
> 
> The problem that that callback solves is possible interrupt storm, spurious
> interrupts, and Use Before Initialized.
> 
> If you can guarantee that in your case it never happens, add a comment
> and go on.
> 
> (It might be useful to tweak code a bit and try CONFIG_DEBUG_SHIRQ=y)
> 
> > > What is the purpose of the
> > > .init_hw callback? I've looked at other drivers which use regmap-irq
> > > and they all seem to just initialize the hardware in their _probe().
> > > 
> > > -michael
> > 
> > I'm not opposed to initializing the hardware in _probe(), although I can
> > see merit in pushing that operation instead closer to the framework
> > where the initialization is actually relevant.
> > 
> > Andy, maybe you can shed some light about .init_hw; I think you
> > introduced it to gpiolib in commit 9411e3aaa6342.
> 
> It seems that commit message doesn't fully  explain the situation behind
> that change. But it was observed in real life, see above.

FWIW, real life example:
e986f0e602f1 ("pinctrl: intel: fix unexpected interrupt")

-- 
With Best Regards,
Andy Shevchenko


