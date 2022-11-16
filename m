Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11E62BA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKPKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiKPKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:49:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E5D2705;
        Wed, 16 Nov 2022 02:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668595110; x=1700131110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNw1ffHFpGMeiSvbhl5OVj8Sum6H6sXuAz+LjPT1Npc=;
  b=jKALuSkTNyDctHEHmLy0oV6FI91cv2fHT3kRU1LY6X1AzW+NqFktbp3H
   mFOXv8B+PWfxPfpQSRUKhX1klddIeVzjdhu3l8Dg7ZskJa0qv7+zR06/I
   3KLhXJ1Go5v8VT1aMXn+lv5jaIPgBtff2GkGM92V1F7qccxaaND7Olg16
   vNRuetFNuHiWvq2JCAO3br/PvlZtL9IFIM9+E5TJ6yPt6KXtIvNWbxpg8
   Fko1cYkGSBiIQFu39vfuE80gewosPN0CY+Kb7f9PzW/F4ej6kQbKe2OfU
   32TBxjLt7IoahJ0T6mlzbWZkckd5qVNgqbFifb8FIccgkVb0Rb6LgYbNo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="310141030"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310141030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:38:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="814041739"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="814041739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2022 02:38:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovFoH-00D5ej-04;
        Wed, 16 Nov 2022 12:38:25 +0200
Date:   Wed, 16 Nov 2022 12:38:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Brian Masney <bmasney@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y3S9oEw6qfLVgGhR@smile.fi.intel.com>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
 <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
 <Y3S62i7OzocP5QrT@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3S62i7OzocP5QrT@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:34AM +0100, Thierry Reding wrote:
> On Tue, Nov 15, 2022 at 12:18:00PM +0100, Marijn Suijten wrote:
> > On 2022-11-14 16:15:25, Brian Masney wrote:
> > > On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > The OF node store in chip->fwnode is used to explicitly override the FW
> > > > node for a GPIO chip. For chips that use the default FW node (i.e. that
> > > > of their parent device), this will be NULL and cause the chip not to be
> > > > fully registered.
> > > > 
> > > > Instead, use the GPIO device's FW node, which is set to either the node
> > > > of the parent device or the explicit override in chip->fwnode.
> > > > 
> > > > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > 
> > > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > > Tested-by: Brian Masney <bmasney@redhat.com>
> > > 
> > > I separately sent a similar type of patch to fix the same issue today:
> > > https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@redhat.com/T/#u
> > 
> > For completeness, your linked patch fixes a synchronous external abort
> > on multiple Qualcomm platforms pointed out in [1].  This patch however
> > does not, are you sure they fix the exact same issue?

Yes, they fix the same issue.

> > [1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/
> 
> Can you check if the below fixes the MSM issue that you're seeing
> (applied on top of my earlier patch, though with Brian's reverted
> temporarily)?

I don't know why we would need this. Brian's patch (already applied into
GPIO tree) is correct, no? (Moreover, it makes yours unneeded, but I'm fine
with having it anyway.)

-- 
With Best Regards,
Andy Shevchenko


