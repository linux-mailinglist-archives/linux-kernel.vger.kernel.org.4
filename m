Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8B6C1577
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjCTOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjCTOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:46:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE7B757;
        Mon, 20 Mar 2023 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679323512; x=1710859512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qK1L3tZe5U3jouCMbrv1LYBji2zf9KQMH40R1IURD58=;
  b=NerxX3xEsER7gE80DYJTpKO04+SY0rOdNIWIdS7AzqkxCIN/VbhUTh4X
   sBY0kvXUVNdUNB/E0QTHDaqfG79I90/u6Q50FFV/49gHvPL8B0GugQIHD
   W8wmkRqPrhwmbv1plCSGaLQ5UatWUGFsSleTtNoOp/uz2wNhK5yYco3fJ
   WG61Wnb3oJdHuJ76+/onR8KcTN8AOBvY9hWfGjx72wXIaYmf3Y7a+1l/a
   eoSGupskeFoCfsyQ/wjuSgkmdAa15niryYyT1JOlxVg9S/N7WKI/tEK+W
   qKYzxJkjAS4azR0Ac9kAUnaZOHdIig6Tdc84oe/hqd5i351ox0XRp0crR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="338704713"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="338704713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 07:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="631157408"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="631157408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2023 07:45:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peGkv-006Jk7-0Z;
        Mon, 20 Mar 2023 16:45:01 +0200
Date:   Mon, 20 Mar 2023 16:45:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] regmap-irq: Drop map from handle_mask_sync()
 parameters
Message-ID: <ZBhxbAlvjplGcAie@smile.fi.intel.com>
References: <cover.1679259085.git.william.gray@linaro.org>
 <ZBhVOziLz6WL6vv7@smile.fi.intel.com>
 <ZBd8PZa0kCcG4MQD@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBd8PZa0kCcG4MQD@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 05:18:53PM -0400, William Breathitt Gray wrote:
> On Mon, Mar 20, 2023 at 02:44:43PM +0200, Andy Shevchenko wrote:
> > On Sun, Mar 19, 2023 at 05:02:00PM -0400, William Breathitt Gray wrote:
> > > Changes in v2:
> > >  - Pull out 104-dio-48e refactor to a precursor patch
> > > 
> > > Remove the map parameter from the struct regmap_irq_chip callback
> > > handle_mask_sync() because it can be passed via the irq_drv_data
> > > parameter instead. The gpio-104-dio-48e driver is the only consumer of
> > > this callback and is thus updated accordingly.
> > > 
> > > A couple pending patchsets also utilize handle_mask_sync() [0][1], so
> > > it'll be useful to merge the changes in this series first to avoid
> > > subsequent noise adjusting the dependent drivers.
> > > 
> > > [0] https://lore.kernel.org/r/cover.1677515341.git.william.gray@linaro.org/
> > > [1] https://lore.kernel.org/r/cover.1678106722.git.william.gray@linaro.org/
> > 
> > Good idea and intention, but something went wrong with bisectability as pointed
> > out by the build bot. As a last resort you would need to squash these two, but
> > try first another possible patch series split.

> I should have build tested each commit when I rebased rather than just
> the last.

Right, that's what we call a "compile time bisectability".

> I'd rather avoid a squash so that these changes are distinct
> for the sake of a clear git history on the regmap API change;

That's my point! I glad we are on the same page.

> I'll submit a v3 soon with the minor changes needed.

-- 
With Best Regards,
Andy Shevchenko


