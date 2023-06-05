Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95888722C33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjFEQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjFEQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:08:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59DCD;
        Mon,  5 Jun 2023 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685981283; x=1717517283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WsTl8q/03NmXvbUZeuZjP7EEn4sjQ1TeIpWAboty3qg=;
  b=JkfGarj8L3HN/9CQak14EE/0Xfa2x9MdPDXmJnGnodPLqv+DvMeYQWUM
   rNZ4iSq+UdlZ8Ugo8oJwhjsfCilVShQLmzvA6wPHuPzvaH2eQLvPglz9F
   qtRJYWoq2/1ELV4kOOu5JogO6bLkjfkjKBFTkNe87cJH34SjT11NcrrvH
   7LxFIEC3Bi5aiUvOWYxGkui7BSS+lmvTzUGOm0UATXCy2G+wGEhw1bqMg
   ZS5jjxxQdpQOyAaWfdeXaRHAUNJLbi6YEZDhiEr8JkwxDYnu6Kr0O0f2x
   1lEMx9xq2MRhSODxdzPQiqH9d/hHreMjG/ENE2uT8ZIiXEM6MeeZu3r6q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="353898984"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353898984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 09:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738411169"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="738411169"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 09:07:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Cjs-001PpH-2k;
        Mon, 05 Jun 2023 19:07:24 +0300
Date:   Mon, 5 Jun 2023 19:07:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/1] backlight: hx8357: Convert to agnostic GPIO API
Message-ID: <ZH4IPJuPoX3gi5Ga@smile.fi.intel.com>
References: <20230317185230.46189-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYXTk2pzXEM9MTjt=oT-CbhENABSLeb9dN7ZvEy8oqiag@mail.gmail.com>
 <ZBhJctqSkdtoUmBi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBhJctqSkdtoUmBi@smile.fi.intel.com>
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

On Mon, Mar 20, 2023 at 01:54:26PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 09:53:40PM +0100, Linus Walleij wrote:
> > On Fri, Mar 17, 2023 at 7:51 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The of_gpio.h is going to be removed. In preparation of that convert
> > > the driver to the agnostic API.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thanks for fixing this Andy!
> > 
> > > -#if !IS_ENABLED(CONFIG_LCD_HX8357)
> > > +#if IS_ENABLED(CONFIG_LCD_HX8357)
> > >                 /*
> > >                  * Himax LCD controllers used incorrectly named
> > >                  * "gpios-reset" property and also specified wrong
> > > @@ -452,7 +452,7 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
> > >                  */
> > >                 const char *compatible;
> > >         } gpios[] = {
> > > -#if !IS_ENABLED(CONFIG_LCD_HX8357)
> > > +#if IS_ENABLED(CONFIG_LCD_HX8357)
> > >                 /* Himax LCD controllers used "gpios-reset" */
> > >                 { "reset",      "gpios-reset",  "himax,hx8357" },
> > >                 { "reset",      "gpios-reset",  "himax,hx8369" },
> > 
> > Eh what happened here .. it's even intuitively wrong.
> 
> I believe it had to be something  like
> 
> 	#if 0 && IS_ENABLED()
> 
> to show that this change is for the future.
> Currently it does something unneeded for the kernels with that option off.
> 
> > I would add
> > Fixes: fbbbcd177a27 ("gpiolib: of: add quirk for locating reset lines
> > with legacy bindings")
> 
> I'm not sure. But it's fine, I can add it. Just want to double confirm
> you really want this Fixes tag.
> 
> > It wasn't used until now it seems so not a regression and no
> > need for a separate patch.
> 
> Exactly why I'm not sure about the tag :-)
> 
> > Other than that it looks correct.
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thank you!

Lee, is anything I can do here to move this forward?

-- 
With Best Regards,
Andy Shevchenko


