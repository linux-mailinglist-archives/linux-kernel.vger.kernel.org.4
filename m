Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126056A4DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjB0WUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB0WUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:20:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36C29E22;
        Mon, 27 Feb 2023 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677536432; x=1709072432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWzJuDCIfMNelei3Vs40367kYpKfkSaH7kj9hcULpyU=;
  b=Uc7xo9k3u6Y2Kanm1j0OihtQOgFiGIFQtHEWFWYU6E/t9C7bNi8jLvhN
   W8yjoznpzQUm8ksxlTv/ZVXpdwIOR6fT06iL8FQTXDVa30JhRB8mvtAV+
   LXxAapOBDiKYIg944FeuhjQJnoQnnJJ5RaCk58DMSC/kvy6/bZpZW33Dc
   ReO4AMFgG8CRF1ZpMTfIH7Exe2NVUqqLWXIQiardIUcyX9oFqmUTlUn0N
   YUvkIwIiKqUsGNqEQX/lH70gGr+XbrxGxhPRYD0+i5z40k9FU78M2Vvb0
   T4RaIl35qTHhwjk62tneidVrCE7rwmDincw/JopIuEFfnI30YjfQ6yVBN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="317781596"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="317781596"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673898060"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="673898060"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2023 14:20:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pWlqv-00D1T5-01;
        Tue, 28 Feb 2023 00:20:13 +0200
Date:   Tue, 28 Feb 2023 00:20:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
Message-ID: <Y/0snOSbw+oTyL65@smile.fi.intel.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
 <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
 <be808124-f350-125c-9c74-5a3f87db32af@microchip.com>
 <Y+9sKN2QcBV2VYKC@smile.fi.intel.com>
 <CACRpkdbbJUc+ciknee8puu4-gEPU+PJp3GvpJcKGiW+O0JPaWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbbJUc+ciknee8puu4-gEPU+PJp3GvpJcKGiW+O0JPaWA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:44:21PM +0100, Linus Walleij wrote:
> On Fri, Feb 17, 2023 at 12:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 17, 2023 at 11:54:02AM +0000, Claudiu.Beznea@microchip.com wrote:
> > > On 15.02.2023 15:42, Andy Shevchenko wrote:

...

> > > >                 girq->num_parents = 1;
> > > > -               girq->parents = devm_kcalloc(&pdev->dev, 1,
> > > > +               girq->parents = devm_kcalloc(dev, girq->num_parents,
> > >
> > > There is still the change of the 2nd argument of devm_kcalloc() from 1 ->
> > > girq->num_parents (no functional change, though) which doesn't match the
> > > purpose of the patch and is not specified anywhere. Other than this:
> > >
> > > Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > >
> > > >                                              sizeof(*girq->parents),
> > > >                                              GFP_KERNEL);
> >
n
> > Thanks for review. I have no time to fix this. So if Linus is okay to take
> > the first 4 patches, I'm fine. You or somebody else can submit an updated
> > 5th patch later on.
> 
> I applied all 5 patches. The num_parents is set to 1 on the line right
> above and it's the right thing to do, and has a reviewed tag so I don't
> see the problem with this patch, let's not overinvest in process.
> 
> Thanks for the very nice cleanups!

Thank you!

> I applied it locally so it won't be in linux-next until after the merge
> window closes.

-- 
With Best Regards,
Andy Shevchenko


