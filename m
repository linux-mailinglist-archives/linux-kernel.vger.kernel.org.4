Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA5C65D0A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjADK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:29:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70C63A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672828175; x=1704364175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=arwmrU6pTPoOLqCBDphrff/+pF//A9r4I80+Attw2tM=;
  b=c1Db9WQjDL1iVswlhAXvIEDSWL9/ROld0ckclsEPPqwxHwHW/lC+IbAs
   /x+qrf9VpZqSar3vj+hARs6Hkm2IqGXCTphmHPWbZXVudfQSp6g26+Yx5
   1k0X8AITwavEJIjFfGjrqB0gnyYRFd++cxz7124F2K31TPBEWynQKRYPc
   akAKxOr0i/5aDBjDAID9LkFCmTOxYBHry78dc9q7GaCuBQCZUsFyK/HvP
   iNsWLbf/O8VEySu3INWBj/DVBFAoMXUx/qLUvvFfDw0gHUila3oyEJCvT
   omf04w3SLF/Mi2nXCo+QNIYXiBVIBXioB867xghouZN3t0FxQxm2dfj+x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305406978"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="305406978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 02:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="718407267"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="718407267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2023 02:29:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD11W-004GDy-0d;
        Wed, 04 Jan 2023 12:29:30 +0200
Date:   Wed, 4 Jan 2023 12:29:29 +0200
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
Message-ID: <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:08:20AM -0600, Pierre-Louis Bossart wrote:
> On 1/2/23 14:30, Andy Shevchenko wrote:
> > Instead of calling put_device(&adev->dev) where adev is a pointer
> > to an ACPI device, use specific call, i.e. acpi_dev_put().
> > 
> > Also move it out of the conditional to make it more visible in case
> > some other code will be added which may use that pointer. We need
> > to keep a reference as long as we use the pointer.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Answering for the series: we should make the change across all Intel
> machine drivers. I see at least four cases that were missed
> 
> bytcr_rt5640.c:         put_device(&adev->dev);
> bytcr_rt5651.c:         put_device(&adev->dev);
> bytcr_wm5102.c: put_device(&adev->dev);
> sof_es8336.c:           put_device(&adev->dev);

Aren't they (they all problematic, btw) covered by the fixes series
https://lore.kernel.org/r/20230102203014.16041-1-andriy.shevchenko@linux.intel.com?

-- 
With Best Regards,
Andy Shevchenko


