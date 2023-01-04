Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE365DAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjADQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbjADQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:47:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7344348
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672850724; x=1704386724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n827LXFF0m/V8FFdJYZ6rHgfWaPvWoE7fWU+oAtQlfQ=;
  b=XsmsQ6jqo9eY1FLtAFy3kBTGgT37cIVTOou/JSosWror+ujj2SqhAv+I
   +e8kOIjfK/INjW8Yox6xP7CM7GFlADCStLnuC/pmXdrY6+ZDL5bkQGSCL
   u2Ev7vZrdEZC3xKgSRWbrKadRmkkMgoSX/13mb/sbT2TKvd9iWQcvzCUP
   kmf4tFRBhfCdGO0/aQQOBicj+CbaPe2fdisgvM1/9opi6biZoWd67B1tk
   ht1KwqymDIDxjqPClYCwJ6oqWujkrvRltp0kz6OTdU05oDuXvJ7SKJvBX
   dGN0/bOsHcGFF3wk91S03dWUszuD5FsQ/EAk7xxgA2Plfg+h0r0ekX2ZC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408233894"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="408233894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="648635619"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="648635619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2023 08:45:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD6t6-004Noc-1d;
        Wed, 04 Jan 2023 18:45:12 +0200
Date:   Wed, 4 Jan 2023 18:45:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
Message-ID: <Y7WtGBenfisLjwbu@smile.fi.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
 <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
 <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:15:27AM -0600, Pierre-Louis Bossart wrote:
> On 1/4/23 04:29, Andy Shevchenko wrote:
> > On Tue, Jan 03, 2023 at 09:08:20AM -0600, Pierre-Louis Bossart wrote:
> >> On 1/2/23 14:30, Andy Shevchenko wrote:
> >>> Instead of calling put_device(&adev->dev) where adev is a pointer
> >>> to an ACPI device, use specific call, i.e. acpi_dev_put().
> >>>
> >>> Also move it out of the conditional to make it more visible in case
> >>> some other code will be added which may use that pointer. We need
> >>> to keep a reference as long as we use the pointer.
> >>>
> >>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>
> >> Answering for the series: we should make the change across all Intel
> >> machine drivers. I see at least four cases that were missed
> >>
> >> bytcr_rt5640.c:         put_device(&adev->dev);
> >> bytcr_rt5651.c:         put_device(&adev->dev);
> >> bytcr_wm5102.c: put_device(&adev->dev);
> >> sof_es8336.c:           put_device(&adev->dev);
> > 
> > Aren't they (they all problematic, btw) covered by the fixes series
> > https://lore.kernel.org/r/20230102203014.16041-1-andriy.shevchenko@linux.intel.com?
> 
> They are indeed, but if you group AMD-related patches with Intel ones,
> it's only human for reviewers to skip the thread entirely, even more so
> when catching up with email on January 3 :-)

Ah, I will try to remember to split also by platform (there are not many that's
why I decided to group them by the problem type only).

> For this series
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thank you and HNY!

-- 
With Best Regards,
Andy Shevchenko


