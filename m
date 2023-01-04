Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3665DAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjADQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjADQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:52:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12F4FCEB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672850936; x=1704386936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEq9W5dgWpSJiZZbrWI25k4VVJPZgYN5UhDmi7NHqNs=;
  b=FLUSwfB5OU9/M9puZaZupMmips0aySB4WCQcLbJcha1hN7vC2+pbM3h3
   64PJAXCf84faVIyHQwjweb9oLCJqSWPOT1zIHykr3gpii8VLyKWRAzDf/
   y0hwJnmk9X1bflsezIc7+sqKwt+TRP3fS1jp38DVZ5kWPFsVhNfNPDNIo
   95t/kDMkKT3OLZyNtdo9FKdAZu4X/V9xdSEJphcdmbnPAi/8NMzBl7lq1
   YW0azn9eVSDJazFHQSyv77Vz8533T6EMTvvHilfqCRTDYp4j0Jv05RhZD
   wJO01E8NsNOZxRiNScCDkgx8LH86xxnDcJAAqSF4dT8SO+ywFfYT3S8MT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="302351235"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="302351235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797600777"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="797600777"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 08:48:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD6vz-004Nt0-25;
        Wed, 04 Jan 2023 18:48:11 +0200
Date:   Wed, 4 Jan 2023 18:48:11 +0200
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
Message-ID: <Y7WtywhUZCTx3akM@smile.fi.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
 <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
 <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
 <Y7WsdF1rK/JmS01W@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WsdF1rK/JmS01W@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:42:28PM +0000, Mark Brown wrote:
> On Wed, Jan 04, 2023 at 08:15:27AM -0600, Pierre-Louis Bossart wrote:
> 
> > For this series
> 
> > Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> According to b4 you've only acked the first patch here because Andy
> doesn't send cover letters :/

Is b4 capable to spread tags from cover letter to the whole series?
(Sorry, I'm a bit outdated with all Swiss-knife possibilities that
 b4 provides)

-- 
With Best Regards,
Andy Shevchenko


