Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C07656E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiL0TTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0TTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:19:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD95CED;
        Tue, 27 Dec 2022 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672168756; x=1703704756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOi4PXBqYkIzZusLiDFjgnfOzGLjVOlHD5pXargyOns=;
  b=CEfOY7jhnkCBlR+6EfX3wBh5opiYagUp6Q+CilZArF7ThthLxwrJAWsx
   V9t+qGq1v8D6g/EjX5lXoYxQNPlYO0iuVXbQTTCvBFPwhN7QmYp6mouvq
   83icmgERBGB4nUKQvts0NhgLtzEj7QkW1QcOAPlQRXGkaG6m6/Y545rnz
   /ofAEUn1DjVO3tLHwlOReQRnQqT+ozkKE4xSlm1aD7o7Dp68QZwaFRpHO
   bv+l+rIddgh1Aikgeo1/fJzsmTFh46IChw4k5PQT493UZObqvLhYibpU/
   cX/BjJwdVGRU69eac1fC59AJSdk15riVFPsuC7QfWrjMZ77QILaRRs0pm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="318423833"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="318423833"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741819623"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="741819623"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2022 11:19:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAFTl-000C24-09;
        Tue, 27 Dec 2022 21:19:13 +0200
Date:   Tue, 27 Dec 2022 21:19:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/17] pinctrl: intel: Introduce INTEL_COMMUNITY_*()
 to unify community macros
Message-ID: <Y6tFMB5S23PgmxQd@smile.fi.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
 <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2FyOvOK2rR9H9@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:32:55PM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 02:26:27PM +0200, Andy Shevchenko wrote:
> > Now it becomes visible that we can deduplicate SoC specific
> > *_COMMUNITY() macros across the Intel pin control drivers.
> > For that, introduce a common INTEL_COMMUNITY_GPPS() and
> > INTEL_COMMUNITY_SIZE() macros in the pinctrl-intel.h.
> 
> You should really start learning how to use --cover-letter option with
> git format-patch because for anything more than one patch pretty much
> requires such. Here I would really like to see how much lines this
> series ends up removing :)
> 
> The series looks good to me, though.

The series has been pushed to my review and testing branch, thanks!

P.S. I dared to convert the above into your Acked-by tag. Tell me if it must
not be the case.

-- 
With Best Regards,
Andy Shevchenko


