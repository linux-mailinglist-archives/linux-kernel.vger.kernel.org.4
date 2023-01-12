Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4391667101
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjALLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbjALLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:33:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4D11C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522699; x=1705058699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4bLAnsOE+ifM6eaLLc0QK8S9x6WlDjUjqMkbCurEswY=;
  b=ka+T9lmCGsWFYa+sUfWiuD98+SGzB7loBAS0BSDX5Ia5orhnvveaJorF
   lSq7CP14TnlfvFrawx9xIGu2/tDahA5rvOknSnxxmTrRe1gEbiNR4/I8g
   6k4sPDILEYOmiZICmL37jQNRuGclX7L1mYEWWW9cOVADINE1/LqvR2Luq
   aS4qvUH2Ki7aGX6LlAfpOhpXmzSXxX++l+XioKjsDsolspyJ2tLrYse5C
   BKvGFazzKdohMQ0kkXIgHaa+5084iK19kb2/nBvnYb++Zy0o+atQd+HoQ
   hGIKG4WnhTnvWsuSM/9uyyhjQSyc4IcP5DjJOd9tWag5WZn9Ww5Lsh90I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325704654"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="325704654"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:24:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607750425"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="607750425"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2023 03:24:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFvhP-0081D0-2K;
        Thu, 12 Jan 2023 13:24:47 +0200
Date:   Thu, 12 Jan 2023 13:24:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1 2/6] ASoC: Intel: bytcht_es8316: Drop reference count
 of ACPI device after use
Message-ID: <Y7/t/2LCY2R+nZ8e@smile.fi.intel.com>
References: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
 <20230102203014.16041-2-andriy.shevchenko@linux.intel.com>
 <edde76c0-a444-1c3a-3541-af79897701fa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edde76c0-a444-1c3a-3541-af79897701fa@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:20:08PM -0600, Pierre-Louis Bossart wrote:
> On 1/2/23 14:30, Andy Shevchenko wrote:
> > Theoretically the device might gone if its reference count drops to 0.
> > This might be the case when we try to find the first physical node of
> > the ACPI device. We need to keep reference to it until we get a result
> > of the above mentioned call. Refactor the code to drop the reference
> > count at the correct place.
> > 
> > While at it, move to acpi_dev_put() as symmetrical call to the
> > acpi_dev_get_first_match_dev().
> > 
> > Fixes: 3c22a73fb873 ("ASoC: Intel: bytcht_es8316: fix HID handling")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> How do we proceed for this patchset? I am happy to ack a v2 if Andy
> splits the AMD and Intel patches w/ a cover letter, but this could also
> be added directly if there is no objection.

I have split out the AMD stuff, so I will resend v2 without it and with cover
letter.

-- 
With Best Regards,
Andy Shevchenko


