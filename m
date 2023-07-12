Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00046750C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGLPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjGLPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:31:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55C1BD7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689175894; x=1720711894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+P6DY1kMpYQo5BltfsoW7T7wXyR4mMsyCwiFJRuKxMA=;
  b=bl8XmjEuOHFm//JeYhFd5+mRCoM4aM1qh9avFg6c03bGBCk+yXXGMO+9
   MLmpmqpbMwIG/Oq0BmxYWAC2LISTHTd7WV9at0w3lM/HQFoAcPckBxUjq
   ZgoOS9f6FIsmpObYyt9wlths7aHOlsuibxRS72bag8ezUnfYTW6WoMH3/
   g1RGQRJrccOdIyVWDxlvi/2HyZCHn8UbsjGCy50VRNyI3e/6+dlS5TBip
   OyICG5REqPHhA6REG3krliUh54ph2Sk1ynQPchTBYCTT/vu7nt7PyPiTr
   BjaL4R4l3AAOcKhQ2JwTJjzqwPINmeNedr00HsM9yeiu3bWxV28rIuvjy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354833459"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="354833459"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791664496"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791664496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 08:31:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJboP-002AJr-13;
        Wed, 12 Jul 2023 18:31:29 +0300
Date:   Wed, 12 Jul 2023 18:31:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-ID: <ZK7HUTyKB6hoaBtV@smile.fi.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
 <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
 <ZK6xI8l7Vdp35yJG@smile.fi.intel.com>
 <d5cac1ef-1d44-4ab7-a933-b381108b1eaa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cac1ef-1d44-4ab7-a933-b381108b1eaa@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Konstantin.

Konstantin, seems b4 doesn't handle long Subject lines for merge commits
(PR mode).

On Wed, Jul 12, 2023 at 04:23:11PM +0100, Mark Brown wrote:
> On Wed, Jul 12, 2023 at 04:56:51PM +0300, Andy Shevchenko wrote:
> 
> > JFYI: You might need to amend your scripts (?) as in the merge commit
> >       the Subject is cut (I believe that your scripts doesn't handle
> >       RFC2822 long lines in the email headers).
> 
> Report that to Konstantin, this is just b4.



-- 
With Best Regards,
Andy Shevchenko


