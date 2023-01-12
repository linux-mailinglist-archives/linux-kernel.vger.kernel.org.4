Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471D0667100
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjALLel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjALLdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:33:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923833752F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673522658; x=1705058658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1AKaJWXiYCekS8GbE9LC/wsL+PQo29nYc0+r3HZLg8=;
  b=HUnxcSxJ/tmVcCc/yolPjRHn/960+P7bSIn8Gw5Pu2PDBnOtUgr0Nf+A
   ImhRZwpcpbe/RBhw1jyPqMMwr/oULN8ENhgeAR2Mz760NoDySvDjToMj9
   m2mInc28PPy1Yc+P8PbjMvr7+Cj0dK7pi4KHXFfVme3aloU6DICud3BfR
   9w+vQyHkgnJoHdWvKYNWcr/Y4+b50gvXsWkbsRBUKsSdpv7huhs2w3WbA
   3renxRkqkXECMJ7K+yucrWouwyIo3/uL0D8K8rel03NBCuYAfykIuaLHq
   WVeMyjlwe6HNVXUvC7j7CGp/yA//2z7J4w/RotpjdaS37SaNr3yLul9o/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="304057698"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="304057698"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:24:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800169380"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800169380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 03:24:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFvgn-0081Bx-25;
        Thu, 12 Jan 2023 13:24:09 +0200
Date:   Thu, 12 Jan 2023 13:24:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1 1/6] ASoC: amd: acp-es8336: Drop reference count of
 ACPI device after use
Message-ID: <Y7/t2Sw+PFkv8seP@smile.fi.intel.com>
References: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
 <6d3380db-5e21-a3e5-b1c2-8618819d1cb2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d3380db-5e21-a3e5-b1c2-8618819d1cb2@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 08:35:41AM +0530, Mukunda,Vijendar wrote:
> On 03/01/23 02:00, Andy Shevchenko wrote:
> > Theoretically the device might gone if its reference count drops to 0.
> > This might be the case when we try to find the first physical node of
> > the ACPI device. We need to keep reference to it until we get a result
> > of the above mentioned call. Refactor the code to drop the reference
> > count at the correct place.
> >
> > While at it, move to acpi_dev_put() as symmetrical call to the
> > acpi_dev_get_first_match_dev().
> >
> > Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Thank you and HNY!

I have split this patch separately and sent as v2.

-- 
With Best Regards,
Andy Shevchenko


