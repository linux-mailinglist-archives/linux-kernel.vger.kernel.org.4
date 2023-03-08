Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017CE6B0805
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCHNKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjCHNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:10:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796FD93E25;
        Wed,  8 Mar 2023 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678280907; x=1709816907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=do/DGUv3CfzRbDhno/1swumIUePUV3RZP5mnHddaz90=;
  b=T7pcaxBrrsB2KKXiff5YBFAU21dOGAjA/hQvNCGkyCmDNdWGoRWMQuCK
   JArNOI0yrHLHUaC7uy6PxmJstyu3QTqHyc1Vddo6/HPQqKOfO+9jodlr4
   v0bFRsmvrAAhIF8V2Hsy584NrVMn5i9VlvwSN4LaGEqexDUoO41uA0xqX
   D9wKmAg1PAeUkKUe525JgrfriTmRlppj6fqbDNTCX78gH6VB9eDOo+Joj
   tOAJZtH3xf/EOdj6BUGaMpqOL88GItV9JPJyt10JK3q+tKaN39nOog1eQ
   iHtic+Uiz0U9QYbowjd2J1mb7O/MysXDdcb3ySdn+DE3UYO4zQRU2U/cC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338472904"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="338472904"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626914660"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="626914660"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 05:06:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZtUo-00HR12-2E;
        Wed, 08 Mar 2023 15:06:18 +0200
Date:   Wed, 8 Mar 2023 15:06:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [PATCH v4 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZAiISgAroSD3YOfk@smile.fi.intel.com>
References: <cover.1678106722.git.william.gray@linaro.org>
 <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
 <ZAX2k9gW1AA88T/P@smile.fi.intel.com>
 <ZAf4LudZkYLsWVWh@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAf4LudZkYLsWVWh@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:51:26PM -0500, William Breathitt Gray wrote:
> On Mon, Mar 06, 2023 at 04:20:03PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 06, 2023 at 07:59:53AM -0500, William Breathitt Gray wrote:

...

> > > -	raw_spinlock_t lock;
> > > +	spinlock_t lock;
> > 
> > This is a regression.
> > That said, do we need a support of raw spin locks in the regmap IRQ?
> 
> So this code has a similar need as the gpio-pcie-idio-24 patch: guard
> registers between handle_mask_sync() and set_type_config(); however, now
> we also need to protect registers in regmap_irq_thread(). We can't use a
> mutex here because regmap_irq_thread() is executed in an interrupt
> context so we cannot sleep.
> 
> This might be a mistake in my understanding: I chose spinlock_t here
> because I believed it to map out to a raw_spinlock_t anyway underneath,
> whereas on RT kernels it would map out to whatever the equivalent is. I
> suspect this is not actually the case. Would using raw_spinlock_t
> explicitly be the correct way to go for this particular case?

You may read the commit message of the 27d9098cff6e ("pinctrl: intel:
Use raw_spinlock for locking"). TL;DR: this is only affects IRQ chips,
so if your GPIO controller is _not_ an IRQ chip, you are fine.

WRT the other driver, can_sleep may reduce scope of the use of GPIOs
and even make a regression if any consumer don't want that behaviour
and currently works.

> > > +	u8 irq_mask[WS16C48_NUM_IRQS / WS16C48_NGPIO_PER_REG];
> > 
> > Can this be a bitmap? Or is it too over engineered with it?
> 
> I also considered a bitmap at first, but I believe it adds an
> unnecessary abstraction in this particular case: irq_mask is just a
> buffer to hold the previous mask_buf state to check if it's changed when
> ws16c48_handle_mask_sync() is called. Since all we do with it is save
> the mask_buf directly, using the bitmap API seems like overkill.

Thanks for elaboration!

-- 
With Best Regards,
Andy Shevchenko


