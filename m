Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF17424C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF2LKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjF2LJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:09:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF8294E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688036950; x=1719572950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dt51Frbc0VtpgKsRkoOje6ipINA90raC3oWM4OnSZKU=;
  b=WUiuah0w5Gq9nhxaN7UTxQllcv7lgi4UHpWTHrtT6Yt403QJIOhFyxIS
   bVpNyFhbcdzqtvWJWjup6aEfnpmWb/ngBJG2UexPvYWUQmzXCYOLqWX9U
   OVCrLf3+OuM72rPEDqb1OnHsUKASaSRjcu3L52akLdTEvWsqNR30lVdPc
   keHJxtyyJbwxelteIC9CQ/UMil2ZvgfaX/UV9zmdbwJiLw56K2LTZEJr5
   eYaCVc3v1VGeQEJwOcUg2JTewKlXCXdTgQzcW+yz9BCVAb0m2M+EB5B5r
   MqKFPIRMR4f05Ve/5rsCNVm7bcMnETJJEw0/aZJQldxkVKEoauw5yaIRG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="362118837"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362118837"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 04:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="861890475"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="861890475"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2023 04:09:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEpWM-000ps9-1A;
        Thu, 29 Jun 2023 14:09:06 +0300
Date:   Thu, 29 Jun 2023 14:09:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/3] ASoC: rt5677: Use device_get_match_data()
Message-ID: <ZJ1mUmI7wOhp710M@smile.fi.intel.com>
References: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
 <20230629104603.88612-3-andriy.shevchenko@linux.intel.com>
 <33d3ba54-e391-454f-942c-67f498711078@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d3ba54-e391-454f-942c-67f498711078@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:56:10AM +0100, Mark Brown wrote:
> On Thu, Jun 29, 2023 at 01:46:02PM +0300, Andy Shevchenko wrote:

...

> > +	rt5677->type = (enum rt5677_type)(uintptr_t)device_get_match_data(dev);

> Double casts, always a sign of a successful simplification! :P

Unfortunate of the C language and use of plain numbers when
pointers are required. :-( I feel your pain.

> > +	if (rt5677->type == 0)
> >  		return -EINVAL;
> > -	}

I would prefer to see in the ID table something like

	.compatible = "foo", .data = &codec[RT5677],

but in this driver it seems it will require quite a refactoring.

-- 
With Best Regards,
Andy Shevchenko


