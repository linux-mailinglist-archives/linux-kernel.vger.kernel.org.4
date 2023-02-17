Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C360F69AAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBQL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBQL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:59:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BE6667C;
        Fri, 17 Feb 2023 03:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676635181; x=1708171181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJ0XXovZvuVRPzpJ0he0BctqjLk19rnMRczRmbpqKLs=;
  b=N+mrYv5Gnn5ciShpa6Cc7mxrKrcqKkpS/8ryfgTrZST+1wKFheAfc9ca
   auJs8Mdp77jYDzLeAdLGcW6h7CKi9tbP0tHke2COKE5ZtXgjqoHEhUz0U
   paOLhvoWIUmyrw2oq4UMwwSymBrk33gz1dMAzhr8q4NDNGXvkmKbhZwDX
   /cP9UmInPe6ElmhHv9258UkEEvFVV2hjcOBMTERCVH1f1huPIJB8NLl5D
   FxymBVCBVuW2TmkC11TNtDrHX78ruUTKTebmX08N1M1K6ZK8dNEncD2aq
   7mEjuer/bYm5Mapj0jUMfpkLE1I0MCoyeFP+SDcTjZSZfUprEvyZxA/Ed
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333330482"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333330482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813345778"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="813345778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2023 03:59:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSzOr-008Bt4-0G;
        Fri, 17 Feb 2023 13:59:37 +0200
Date:   Fri, 17 Feb 2023 13:59:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Claudiu.Beznea@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        linus.walleij@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
Message-ID: <Y+9sKN2QcBV2VYKC@smile.fi.intel.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
 <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
 <be808124-f350-125c-9c74-5a3f87db32af@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be808124-f350-125c-9c74-5a3f87db32af@microchip.com>
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

On Fri, Feb 17, 2023 at 11:54:02AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 15.02.2023 15:42, Andy Shevchenko wrote:
> > @@ -1758,7 +1750,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
> >         if (!gpiochip_prev) {
> >                 girq->parent_handler = gpio_irq_handler;
> >                 girq->num_parents = 1;
> > -               girq->parents = devm_kcalloc(&pdev->dev, 1,
> > +               girq->parents = devm_kcalloc(dev, girq->num_parents,
> 
> There is still the change of the 2nd argument of devm_kcalloc() from 1 ->
> girq->num_parents (no functional change, though) which doesn't match the
> purpose of the patch and is not specified anywhere. Other than this:
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> >                                              sizeof(*girq->parents),
> >                                              GFP_KERNEL);

Thanks for review. I have no time to fix this. So if Linus is okay to take
the first 4 patches, I'm fine. You or somebody else can submit an updated
5th patch later on.

-- 
With Best Regards,
Andy Shevchenko


