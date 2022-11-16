Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586162B4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKPIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiKPIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:17:12 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF036C2F;
        Wed, 16 Nov 2022 00:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668586631; x=1700122631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6E6aodHiBS2N1vbKhR1jmzSh1KadIn0j6YXcFDXzBFg=;
  b=jngspRpmgJAZTj8geVqLsb0hredJLDNFxiwIbZS/Vm0VYhDVtHkq0l7e
   R7SHsdiRzS+YUCqfUfjsPzuMArjIdgt3UWQK2B/YuVwmI+7iytaEbFapt
   sYG1qZ6HhWdjvnixxCBHy52uqDuheMiKSs4a25Fxay40QlqkmXB+pvJSQ
   Hcu28Sxxs06KRRKNKU4cHOkBgc/kcqICvaqAmk/b8qDeF6kJQw8y/Of1I
   oetbcKCre6EvpzT521mVV2LHSXH/sOtx0YTy7LwSpiofA3PxZ9NPeL8i1
   l6shIS1f+wnyWwb2DkUR7SBazdULu2/sdfz7gmVHQu1clWzceTLos51kA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="300011533"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="300011533"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="590105251"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="590105251"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2022 00:17:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovDbY-00D2Qu-1C;
        Wed, 16 Nov 2022 10:17:08 +0200
Date:   Wed, 16 Nov 2022 10:17:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: Mark free pwm IDs as used in alloc_pwms()
Message-ID: <Y3SchHhvLZoRO0w6@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115211515.3750209-4-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:15:14PM +0100, Uwe Kleine-König wrote:
> alloc_pwms() only identified a free range of IDs and this range was marked
> as used only later by pwmchip_add(). Instead let alloc_pwms() already do
> the marking (which makes the function actually allocating the range and so
> justifies the function name). This way access to the allocated_pwms
> bitfield is limited to two functions only.

This change is a bit fragile in a long term. Currently we know that we have
no points of error after alloc_pwms() in ->probe(), but if somebody misses
this in the future, we became to the case where bitmap might be exhausted
(kinda resource leakage).

-- 
With Best Regards,
Andy Shevchenko


