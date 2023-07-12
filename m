Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA56750A28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGLN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGLN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:56:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838510C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689170216; x=1720706216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VXHS3xFpizDVY2aWYLnjoKyQjbQnUw1MPOV+IXb5Pz0=;
  b=V+w3XyidsuknxETYcZZrOqs1Fd2hoRYHvIz0ZJSwnzXSv2zQ+mgk6tQY
   +JvFzNADrtyFQu6LiakQmylXh/xqravvSgT/1x8/nWc4p0c6j3eQLOT0x
   uOs+Q5bgY07xjnrl4UHloaoFsiD9EiVIOVDfWLZaji3++PRfsN0SpcysG
   jemwi7r9RNpgvcs8D+rt3HPATEtOJbeRMtquALe/8kB9xorGt3QBMK/FX
   bh1gCg3vvVtbFAMWPylFmP3V2aXSQXD3/Dku+mqPC6fRGavI/UDE7S4v8
   PVzYkQB92mnHCX1ZFWs7rlox0+19jPM22GECiZLkmKgW4ns6SxKrEF8sG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428630600"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="428630600"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 06:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="671873184"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="671873184"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2023 06:56:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJaKq-00295F-0J;
        Wed, 12 Jul 2023 16:56:52 +0300
Date:   Wed, 12 Jul 2023 16:56:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-ID: <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
 <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:47:06PM +0100, Mark Brown wrote:
> On Fri, 30 Jun 2023 20:21:51 +0300, Andy Shevchenko wrote:
> > The code can be simplified with refactored GPIO parts and with use of
> > device_get_match_data(). Besides that couple of additional changes,
> > one for maintenance and one for making IRQ domain agnostic (not being
> > pinned to OF).

> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

JFYI: You might need to amend your scripts (?) as in the merge commit
      the Subject is cut (I believe that your scripts doesn't handle
      RFC2822 long lines in the email headers).

-- 
With Best Regards,
Andy Shevchenko


