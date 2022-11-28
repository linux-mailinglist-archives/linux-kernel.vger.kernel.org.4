Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380863A59A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiK1KC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiK1KCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:02:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CB227;
        Mon, 28 Nov 2022 02:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669629761; x=1701165761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhUa7axR7dY8Z8jFaQDCM653suLQTUT/HBlRpKPGoGU=;
  b=oJTYzB6FbHTEd34lZZwnm0xFob+ZwDA/LOdvNIM/+wfcMAE3upwQ4O5E
   /SQpJWfpuDge+PWi2UxiMsp0jtlaoZR+UKLrCQhSgpTWu8TvvrrLhW7v3
   OUEEm1hR7hlFZ11nRWsunPjisusCYPMifKpLfCfYyv/mF3jvPCxC4Q3X3
   eoV3FaBiPTFOpWUMvl40xhFmE+GYeRGvtJboxF1A/rjruMHUcc+u36xpK
   5IdcuVMZj472Foh+8xsKfGqI/zxwwNi3Y/qjDmlKWkTrZI/aH9O6ksk5g
   Oe4WqLM7YVZ3ZORzrR9VY0uB2d/WfrwR/1ydLzIsVNyJi1ghd90L0quf+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="379051057"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379051057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 02:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="643332351"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643332351"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 02:02:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozay6-0014By-1Z;
        Mon, 28 Nov 2022 12:02:30 +0200
Date:   Mon, 28 Nov 2022 12:02:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y4SHNtoVnZw1ZjgA@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com>
 <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
 <Y4SCZKr3uEXTQmHZ@smile.fi.intel.com>
 <74fb9467d82cc55e74468459984e9090@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fb9467d82cc55e74468459984e9090@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:56:06AM +0100, Michael Walle wrote:
> Am 2022-11-28 10:41, schrieb Andy Shevchenko:
> > Of course there are drivers that are using it and it's not in
> > their ->probe():s
> 
> I was speaking of gpio drivers which use the regmap-irq stuff. I
> couldn't find any which are using {devm_,}regmap_add_irq_chip*()
> and gpiochip.init_hw().

Ah, that's true.

-- 
With Best Regards,
Andy Shevchenko


