Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FB63A544
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiK1JmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiK1JmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:42:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBD186C2;
        Mon, 28 Nov 2022 01:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669628521; x=1701164521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kLVSYpCxieBezViNJmOXfw8Ev9qIKORVhxwHMbB9K0=;
  b=fxm9i70QSjM2dZH9lAUvdfHaDGoFzzUq2oLNhJ5flP1hkNm/D4EQWAwr
   gL5TgR/wTb5oe7G1D8RbjhlSryveRxkXe3tYErQ7c2xShi5iY7i89mGia
   3vHvzL5uKG+0t4HiYh9PMLClllo7YghEOB0xVHCCXrRw3K0UDHHX+wOH/
   7gywZyryM9jATZxOf9BkaF+uZfesHTXiSmTQzT3D7Rd9ZUedoQuZnA0iD
   S4HgEPStpxno7Wi9q0alfDk82VdQXnunI9gu/XlFOw3USMx/OX6VhRqh1
   S3xmAitk20cvwvetXh8kJHQpMtmxlWXXyIQJoCn2eZWqVcu+d1G4TkVwl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="316617910"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316617910"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="711901393"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="711901393"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2022 01:41:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozaeD-0013kQ-0h;
        Mon, 28 Nov 2022 11:41:57 +0200
Date:   Mon, 28 Nov 2022 11:41:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y4SCZKr3uEXTQmHZ@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com>
 <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 07:31:48PM +0100, Michael Walle wrote:
> Am 2022-11-22 11:29, schrieb William Breathitt Gray:
> > On Wed, Nov 23, 2022 at 05:01:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 22, 2022 at 02:11:00AM -0500, William Breathitt Gray
> > > wrote:
> > > > +	/* Initialize device interrupt state */
> > > > +	err = regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
> > > > +	if (err)
> > > > +		return err;
> > > 
> > > Use ->init_hw() callback for this.
> > 
> > In a subsequent patch 7/9 we remove direct gpio_chip registration in
> > favor of the i8255 library registration via gpio_regmap. It doesn't look
> > like gpio_regmap_register() sets the init_hw() callback.
> > 
> > Michael, do you see any issues if I introduce init_hw() to
> > gpio_regmap_config? Or do you think this IRQ initialization belongs
> > somewhere else?
> 
> Something like the following?
>   gpiochip->init_hw = config.irq_init_hw;
> 
> gpiochip doesn't seem to be the correct place, gpiochip_add_irqchip()
> is a noop for gpio-regmap, right? So using gpiochip_irqchip_init_hw()
> seems wrong.
> 
> Maybe make gpio-regmap call it on its own? But really we just connect
> the regmap-irq to the gpiochip irqdomain. What is the purpose of the
> .init_hw callback? I've looked at other drivers which use regmap-irq
> and they all seem to just initialize the hardware in their _probe().

The purpose of that callback is to initialize IRQ part of the GPIO hardware
in the appropriate point of time. Of course there are drivers that are using
it and it's not in their ->probe():s, however you can tell that in the same
flow, because it's called synchronously.

-- 
With Best Regards,
Andy Shevchenko


