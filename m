Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42626626F94
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiKMMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiKMMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:52:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF212ADA;
        Sun, 13 Nov 2022 04:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668343964; x=1699879964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WfgPPDuQdDb/vxvL2QBg0JV1eZu6yCyOBqwRrjyf7lA=;
  b=ARwVl6fxDnZYX/qVpGcFKszAtZfPwQh/p6ZFsgfC1n3VdVL4smqqIwaM
   txlbSX20iaBAxaX1k65YFbr85LtxoR6ASwMtvyGNdS0ZaJcgvb0w/8ujE
   MNvzLeSSYiESOd52p3JfU/z/fAPAm139Sqor0MVXLB8IXijq1qXAqDxSV
   bz4sVOjaEjVA1znJeOquDt2mT629kS6Gv+o4Z5WwP86uc5oZJinZViVeW
   8LXn7KNlOroMfxbqBNhm4EmqYMTPBYoELuLSuc0O11SFdc3wHBWtaOTS5
   f6hsN5QBK2yL7sk4aP0bCg4TIdJ8QqUakhFJrkO0bE2nUCICYDhLcGAEM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="376074164"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="376074164"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 04:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="669302081"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669302081"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2022 04:52:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouCTY-00BgGu-0Z;
        Sun, 13 Nov 2022 14:52:40 +0200
Date:   Sun, 13 Nov 2022 14:52:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3Dol6rHduFNQT85@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:55:53PM -0500, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. The 104-dio-48e and gpio-mm modules depend on
> the i8255 library and are thus updated accordingly.
> 
> By leveraging the gpio_regmap API, the i8255 library is reduced to
> simply a devm_i8255_regmap_register() function, a configuration
> structure struct i8255_regmap_config, and a helper macro
> i8255_volatile_regmap_range() provided to simplify volatile PPI register
> hinting for the regmap.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Suggested-by?
(I'm not insisting, just consider if it's appropriate to use here or in the
 other patches)

> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/Kconfig            |   2 +
>  drivers/gpio/gpio-104-dio-48e.c | 397 ++++++++++-------------------
>  drivers/gpio/gpio-gpio-mm.c     | 151 +++--------
>  drivers/gpio/gpio-i8255.c       | 429 +++++++++++---------------------
>  drivers/gpio/gpio-i8255.h       |  80 +++---

Can we actually split this to a few steps:
 - providing gpio-i8255-regmap
 - providing gpio-mm-regmap
 - converting the driver
 - removing not used modules (one by one)
?

In this case if any regression somewhere appears, we can always perform a
(semi-)revert for a certain driver.


-- 
With Best Regards,
Andy Shevchenko


