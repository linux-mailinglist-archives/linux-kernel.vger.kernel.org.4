Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619476ACF1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCFUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:25:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D9410B7;
        Mon,  6 Mar 2023 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678134324; x=1709670324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bpjTmGt2FFmjIz5dpuGkKtkZK2wYWT5pskh8rVUTPcY=;
  b=PkFOrTHoEBFlEb4X1fT2cooCRZYq41SKGk0e9r9KH+i4hZjHGnZLS3wQ
   MhvOegzesTDeoKdE321a+yhmojl4eLxIoYJOCoRrQktcA35MVXBZiQcUD
   tdjTasXZlFtlu5B6klBy3J8pcfPw55v53O47wuHAG3ZR7RUxEXSBIE8bK
   GZOK7WM0ZXMbPwwn7PLOcB2ZWdK78zT3z+6fQeUQlvlugKG17UUQAhwcF
   PYSsXPpO3kC9Am8MNtZf5/D8w5knsjdX5WQeFdyMo3YM4vJo8o++iNDEw
   cvHUTvqHs7ZHk9mWGeL5czu6qlPNPmhOc0LaOk9x6SmRJfNmA/Y0OMLU9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="316065427"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="316065427"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 12:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745196118"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745196118"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 12:25:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZHOV-00Gbuf-30;
        Mon, 06 Mar 2023 22:25:15 +0200
Date:   Mon, 6 Mar 2023 22:25:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: Re: [PATCH v1 00/16] gpio: Use string_choices.h
Message-ID: <ZAZMK8YLDN2gDObv@smile.fi.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:55:40PM +0200, Andy Shevchenko wrote:
> Use string_choices.h in the GPIO drivers and library.
> It has been tested on x86_64 and (semi-)compile tested
> over all.

Forgot to mention that this is based on top of the immutable tag I sent PR with
earlier today.

-- 
With Best Regards,
Andy Shevchenko


