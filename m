Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2364656E39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiL0TVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiL0TUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:20:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EC115C;
        Tue, 27 Dec 2022 11:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672168852; x=1703704852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBW05D8jURN+a9kSEVt1uU2bkDRoWz4gCfkvdZ6Tv4k=;
  b=ArAUL0FFtUor1LPP7YMg5oN6h0OY7JCMnRYOuam6x9J6r7fnWpBoGZcK
   YEbn1kKqDsVHp5Ht9TV75JUMlDW4f3RaL4vPFDSbkDSLmCxCHp8oobTKh
   3PaaaiTlQovDOb0aRPvG8+yKNCIV163jiHC3fTi0XgAgcM/QUyIfFpogM
   iRlIxo5c4DtVdfyIqbPzq26pJzsfv3XUcKvv6a0pdo/LKg9Thk7XiY0H9
   F91lfPhGwIUO1oiIabT9eCsciEzE11RLrkOGRsLytaYsWIokGa/Q1NV6H
   DrvcRL6emzVIC2o2YHBPgVYIcfsbZNlgzm8SoYC7efnkPuLWtkUyj1ED8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="321981242"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="321981242"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="898444467"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="898444467"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 27 Dec 2022 11:20:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAFVI-000C5H-2y;
        Tue, 27 Dec 2022 21:20:48 +0200
Date:   Tue, 27 Dec 2022 21:20:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Convert to
 generic_handle_domain_irq()
Message-ID: <Y6tFkOv29kww6Fqm@smile.fi.intel.com>
References: <20221219122722.3639-1-andriy.shevchenko@linux.intel.com>
 <Y6B2RUCQ1ImSUOsq@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B2RUCQ1ImSUOsq@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:33:41PM +0200, Mika Westerberg wrote:
> On Mon, Dec 19, 2022 at 02:27:22PM +0200, Andy Shevchenko wrote:
> > Replace construct that matches generic_handle_irq(irq_find_mapping())
> > to a single call to generic_handle_domain_irq().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks|

-- 
With Best Regards,
Andy Shevchenko


