Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05174659C85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiL3Vgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Vgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:36:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67BDE9A;
        Fri, 30 Dec 2022 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672436205; x=1703972205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhmLOiAZf7BxRbrYtXcXiCs8onuPuJHs5gnpEYdvPwU=;
  b=ZgDrcwUi5dXMC5Q/1+w3CHoJDLt4qWXUNMGIDICzXrU5vnOUBNBITBQg
   BG4G6/Fw2wJFQ/abg27pN0YNj/+nlpQa32vmlFJzB0loaT7PKGo0T4q09
   MAtNpq0I8cbp5RD5MU3rsD8nf09BncEoJwTuyp8i5EDwFURTFceiNgVkB
   GlNDdd63uQ1bUtS29GT6Jfd9Ko3TFV5pyawCyL1dRxrKcCJSF/3bUm8Wl
   62oMBvI1l/QB4uDst/6uvzc8HrjbBEynmM6XK9ob9DgbamN3eOWkKjFUs
   DBGLIV7WHwjNAmz3oSBbvxVsm+VW1sJh23rQzRN2aD0uX2GYf8GhelKXx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="309022250"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="309022250"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 13:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="982742689"
X-IronPort-AV: E=Sophos;i="5.96,288,1665471600"; 
   d="scan'208";a="982742689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 30 Dec 2022 13:36:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pBN3Q-001thA-2g;
        Fri, 30 Dec 2022 23:36:40 +0200
Date:   Fri, 30 Dec 2022 23:36:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 1/4] gpio: pca953x: avoid to use uninitialized value
 pinctrl
Message-ID: <Y69Z6FhmypFASRyX@smile.fi.intel.com>
References: <20221210220601.77648-1-andriy.shevchenko@linux.intel.com>
 <Y67T2u0VfSnq48KQ@smile.fi.intel.com>
 <CAMRc=MdZ4RN=EFS0Brf0Avis9FOVh9+8x5rB52b8eO_Ln+CGiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdZ4RN=EFS0Brf0Avis9FOVh9+8x5rB52b8eO_Ln+CGiA@mail.gmail.com>
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

On Fri, Dec 30, 2022 at 01:48:20PM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 30, 2022 at 1:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Dec 11, 2022 at 12:05:58AM +0200, Andy Shevchenko wrote:
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > There is a variable pinctrl declared without initializer. And then
> > > has the case (switch operation chose the default case) to directly
> > > use this uninitialized value, this is not a safe behavior. So here
> > > initialize the pinctrl as 0 to avoid this issue.
> > > This is reported by Coverity.
> >
> > Bart, any comments on the series?
> 
> Now applied. I just got back from Christmas break, give me a moment. :)

Sure and thank you! Merry xmas!

-- 
With Best Regards,
Andy Shevchenko


