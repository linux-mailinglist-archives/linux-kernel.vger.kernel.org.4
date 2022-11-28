Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E063A5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiK1KFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiK1KFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:05:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5EBC10;
        Mon, 28 Nov 2022 02:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669629902; x=1701165902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWoPYCatGVSUuaybeArVFuG56qUBlKkuVtRtbcp/0WA=;
  b=ZFT3Sk1XpiPTOq1Ha8tR772b+9XoEFHrSMEKtsiFFiXgjktLvzqFnsWV
   MlU6EmmYaqrvu2QRldBixHpJm6zJAVXbbVlyBn1gSZ53oAe+K95i5rUly
   hmpTUygK3tOON+b9wBeFgBXdRYXwb3xBwveT9iAbDhvf78OGZvMeSr8bO
   Rd4oT9Ab0mYWw4wzQRnnxjjYdWjJliAL62tyCthOLkJ1BbEiKBjR6NJmP
   hrjzV/FQUDauXmkLvck4e7ZIpMiQd3IXHLxESY0npSIszNdGSmlnHArn/
   0rvAbwiAKitx67IwVMNzRWGQn66tghCa4+1LT08S1hn8WDF3o1L+EWvo3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="312430791"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="312430791"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 02:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="711906853"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="711906853"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 02:04:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozb0U-0014FO-0b;
        Mon, 28 Nov 2022 12:04:58 +0200
Date:   Mon, 28 Nov 2022 12:04:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y4SHyWrYobT88Mgr@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com>
 <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
 <Y4PeCBy/8slpMp2R@fedora>
 <Y4SEjVpLUd1wA8nd@smile.fi.intel.com>
 <Y4SFv9bRc1mlVf2r@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4SFv9bRc1mlVf2r@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:56:15AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 11:51:10AM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 27, 2022 at 05:00:40PM -0500, William Breathitt Gray wrote:
> > > On Sun, Nov 27, 2022 at 07:31:48PM +0100, Michael Walle wrote:
> > > > Am 2022-11-22 11:29, schrieb William Breathitt Gray:

...

> > > > gpiochip doesn't seem to be the correct place, gpiochip_add_irqchip()
> > > > is a noop for gpio-regmap, right? So using gpiochip_irqchip_init_hw()
> > > > seems wrong.
> > > > 
> > > > Maybe make gpio-regmap call it on its own? But really we just connect
> > > > the regmap-irq to the gpiochip irqdomain.
> > > 
> > > I think you're right, it feels strange to handle IRQ initialization via
> > > the GPIO framework. Maybe somewhere in regmap_irq might be more
> > > appropriate?
> > 
> > The problem that that callback solves is possible interrupt storm, spurious
> > interrupts, and Use Before Initialized.
> > 
> > If you can guarantee that in your case it never happens, add a comment
> > and go on.
> > 
> > (It might be useful to tweak code a bit and try CONFIG_DEBUG_SHIRQ=y)
> > 
> > > > What is the purpose of the
> > > > .init_hw callback? I've looked at other drivers which use regmap-irq
> > > > and they all seem to just initialize the hardware in their _probe().
> > > > 
> > > > -michael
> > > 
> > > I'm not opposed to initializing the hardware in _probe(), although I can
> > > see merit in pushing that operation instead closer to the framework
> > > where the initialization is actually relevant.
> > > 
> > > Andy, maybe you can shed some light about .init_hw; I think you
> > > introduced it to gpiolib in commit 9411e3aaa6342.
> > 
> > It seems that commit message doesn't fully  explain the situation behind
> > that change. But it was observed in real life, see above.
> 
> FWIW, real life example:
> e986f0e602f1 ("pinctrl: intel: fix unexpected interrupt")

And another one (seems found from SW perspective):
a33912061607 ("gpio: lynxpoint: Move hardware initialization to callback")

-- 
With Best Regards,
Andy Shevchenko


