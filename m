Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E75E9E21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiIZJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIZJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:45:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730D15711;
        Mon, 26 Sep 2022 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664185430; x=1695721430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2ofBCBpdftIlM/Orx1EIGaCpNLoaj4BYeHzamm1P3a4=;
  b=jKjGTKpQxfjUEIzksWdj8Q+lQPYkFclyPI6Oe9PW1UgplkB2YKvWOCci
   oVfvvV54FsBpkEWtgoa1WyduKpuvPW3lKDsNlIg88oK9YhDZpH6sRMksK
   7wzkszI5QFJlM5XYyfIorGkEvTZEBV0cuQT1/ZmBEk+ZLk2mx8JyAcwrN
   In02xJcB9dwwt/Z9T3zUH74zPhYnxBvados81yQIe7YQ8BBGnI4Mq7KM3
   t3/4xZffc6zcyBWPN7yIE3/8AbgR/ECNMQOyEGEQE45nXAyW8Lp23oUWW
   0BzjgriO3FlSovYVU3aSMbNS9d+FNFDKOu2o2ifBshoBaXP5S0JCyuNRt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="362815577"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="362815577"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 02:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="689491308"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="689491308"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2022 02:43:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ockeR-007jS2-1l;
        Mon, 26 Sep 2022 12:43:47 +0300
Date:   Mon, 26 Sep 2022 12:43:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <YzF0U7q5Fl0UaogR@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
 <20220924095945.pzyhc24jhjwlfdin@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924095945.pzyhc24jhjwlfdin@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:59:45AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Sep 08, 2022 at 04:56:51PM +0300, Andy Shevchenko wrote:
> > Avoid unnecessary pollution of the global symbol namespace by
> > moving library functions in to a specific namespace and import
> > that into the drivers that make use of the functions.
> > 
> > For more info: https://lwn.net/Articles/760045/
> > 
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-lpss-pci.c      | 1 +
> >  drivers/pwm/pwm-lpss-platform.c | 1 +
> >  drivers/pwm/pwm-lpss.c          | 2 ++
> >  3 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> > index 75b778e839b3..9f2c666b95ec 100644
> > --- a/drivers/pwm/pwm-lpss-pci.c
> > +++ b/drivers/pwm/pwm-lpss-pci.c
> > @@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
> >  
> >  MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(PWM_LPSS);
> 
> Each user of the lpss.h header needs that, right? Then the
> MODULE_IMPORT_NS statement can go into the header, too.

With the same answer as for v1: any user that might include the header for
the sake of data types will get the NS inclusion even if they don't need
that (yes, I don't think it's practical, but slightly better to make sure
that if one uses an API, one adds necessary NS inclusions; also note that
in case of stale header inclusion this again might bring unnecessary NS,
while the header should be removed -- with that being said, I think we
might need some kind of extended includecheck to see if the APIs and data
structures are actually used when a certain header is included).

> Even without this change:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks!


-- 
With Best Regards,
Andy Shevchenko


