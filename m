Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0FE6C122C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjCTMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:45:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D1525A;
        Mon, 20 Mar 2023 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679316287; x=1710852287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tdLDCcBx+GEfk7tj+nGn51mFKS2z+cvwXx7rQAgBk1k=;
  b=nHHVp6O4JM5zhtayvRd7xrDy9PLTwyg7CdOQR4GpgfUWDuYylm6knkFs
   vrS/yE1LF8V+GZkbN+4nzrG10U5i1tuJc33G5ElvZNlthQ/WdK/CfWjox
   p67kJDnG10rQWuK4kQppy4us789ZeZJ4Hrnj3T2xTuwSC3KnmcagF+U55
   9pwZalr8iIwPr+Zu1W1mOgPjkCKJRJEYKfSOFQT3GuxQeF1dGUB4UuBYg
   GwfgBRAHOfemKckvhiaEQq0j6EWsroJikGjHF/2fbco1pZKPv6Ppyt2QW
   cA78k8si+0VNc7oI72Yh6ooZtTyv721SU9vm5+wyPvapjkrfrAEDxeOQM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="318300662"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="318300662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="681058814"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="681058814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 05:44:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peEsV-006Gif-13;
        Mon, 20 Mar 2023 14:44:43 +0200
Date:   Mon, 20 Mar 2023 14:44:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] regmap-irq: Drop map from handle_mask_sync()
 parameters
Message-ID: <ZBhVOziLz6WL6vv7@smile.fi.intel.com>
References: <cover.1679259085.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679259085.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 05:02:00PM -0400, William Breathitt Gray wrote:
> Changes in v2:
>  - Pull out 104-dio-48e refactor to a precursor patch
> 
> Remove the map parameter from the struct regmap_irq_chip callback
> handle_mask_sync() because it can be passed via the irq_drv_data
> parameter instead. The gpio-104-dio-48e driver is the only consumer of
> this callback and is thus updated accordingly.
> 
> A couple pending patchsets also utilize handle_mask_sync() [0][1], so
> it'll be useful to merge the changes in this series first to avoid
> subsequent noise adjusting the dependent drivers.
> 
> [0] https://lore.kernel.org/r/cover.1677515341.git.william.gray@linaro.org/
> [1] https://lore.kernel.org/r/cover.1678106722.git.william.gray@linaro.org/

Good idea and intention, but something went wrong with bisectability as pointed
out by the build bot. As a last resort you would need to squash these two, but
try first another possible patch series split.

-- 
With Best Regards,
Andy Shevchenko


