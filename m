Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB25C662387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjAIK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjAIK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:56:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4739A10543
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673261765; x=1704797765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=432/GTUDWbVLE2I1BF6A2bekIYJZUgz/xcsj/jl86LE=;
  b=aQ4w4RDTU4PKgNfnSeUapqqEV0flEuU6IqWKsturHZmCJy/gXSKgDyCp
   rgixxi/L30lSCynZCTh7IdGKkU8SsUCwY/q+iVv1f84FPNomJZ3LnsanF
   gCuJFS718wwn8F8ylcCtyMuVfhV0YhsaHpk57WPPpoqFwAbWUpU+O4V5T
   F09X2U8sFeZ95up87+jw7LEBryAAuKv1JZKpSmosNxiq0SzgqdhkBm3pO
   mJQdstzKd82aOsExkOocztzv1qfVY3/a2/00Y4DMYymHPWj+GuvBmfktT
   3HBwzOpx+8AtTaU/GcGTrehaaDcpyf7uVjAa5dnrRSYS3sMbFUwa+iWkt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="320547437"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="320547437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 02:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="901958882"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="901958882"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2023 02:56:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEpou-006M1y-0C;
        Mon, 09 Jan 2023 12:56:00 +0200
Date:   Mon, 9 Jan 2023 12:55:59 +0200
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
Message-ID: <Y7vyv7mEmvCSA0eM@smile.fi.intel.com>
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

...

> >> I see at least four cases that were missed
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

I'm not sure what should I do about that series. Shall I split AMD and Intel
parts? (Assuming Intel will go as a series with cover letter.)

-- 
With Best Regards,
Andy Shevchenko


