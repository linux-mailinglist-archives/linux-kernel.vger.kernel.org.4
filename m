Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47EF65DC67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjADSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjADSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:55:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C031DF00
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672858537; x=1704394537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6CS1YaqJdLRkKNpM+ISDo/CBjJK7EGwS7kmRWufSFo=;
  b=Rz7FcouESPtvsCCBpFgd9dL1u3fX1lVAE86gj1MqgHMnEKAOxigadfdl
   nRuRRRKRwitSGpIKGHYUdEFv6I8+EmhrH1TrnFc4UaD8otcW5Z7zauIR6
   k7iVjmEuXqr62GdQbEYe92j7J8s55TTwJbDjHfJF4fA5Ib5DRq4PBnNWL
   6JLO/5jep0505rMTEOsVwZUdiVDw3zj1wMcTKp1oDWiLZHRAltyTEsv6+
   PXlMn8cp6WTis1DZ4JXjeKEgVYP5yd/eSQ4f0sO3o4JOFXJ6M0lJNMw01
   5Y8jjKPEEWCfLS+AmhXzpLVyt8uhbotoMgRV83i7F9tV8RCiZrFjSbgmp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319721352"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="319721352"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 10:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657214817"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="657214817"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jan 2023 10:55:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD8vD-004RD0-2V;
        Wed, 04 Jan 2023 20:55:31 +0200
Date:   Wed, 4 Jan 2023 20:55:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7XLo8febtiSLGAD@smile.fi.intel.com>
References: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
 <Y7W0VOJKlMtaIp13@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7W0VOJKlMtaIp13@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:16:04PM +0000, Mark Brown wrote:
> On Wed, Jan 04, 2023 at 06:48:11PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 04, 2023 at 04:42:28PM +0000, Mark Brown wrote:
> 
> > > According to b4 you've only acked the first patch here because Andy
> > > doesn't send cover letters :/
> 
> > Is b4 capable to spread tags from cover letter to the whole series?
> > (Sorry, I'm a bit outdated with all Swiss-knife possibilities that
> >  b4 provides)
> 
> Yes, it does that.

Oh, cool to know! So it makes a lot of sense to create the cover letters
even for straightforward independent changes that are united into the
series for the easy handling.

Thank you!

P.S. Tell me if I need to resend with tags applied this time?

-- 
With Best Regards,
Andy Shevchenko


