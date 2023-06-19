Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6957358F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFSNxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSNxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:53:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8AE63;
        Mon, 19 Jun 2023 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687182825; x=1718718825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGVHZdSP5rkMbWP7bUyJCLbLHxbyvGd63d3EeOzEkZQ=;
  b=OLCTDxSSrpKl5e5MNKVJfFaM3IloUlDOA0vdcAxI4IJvsq416UlPWHSA
   7BAejZIXftZPcQuVvpXg8Gh9d/jILBTmSPpZoFk7WrsremtegLDMu7CAC
   iwDT2yzF2qCX5M3yzfj85NIOhsQWNEIqpPI/K5la+8nhPmwF9aQR9mXQx
   8HM6qfRACB9AyOIxTVDSpL4XUs6atSBdhjXWa4wEYD1Q9eQwiMfMkjBp8
   pJX0SOsI6J/hFu0197m3lDAjam4xVcG1bs14vq+4dJy3kbbInSthdyRjW
   HeCn1YjGyFWNwNf6r70EwS+NXaA+kvKjVdG6hv29dVmKYDyD8I1c0sAKh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="349355711"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="349355711"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:53:45 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="747594278"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="747594278"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2023 06:53:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBFK9-0050TT-1x;
        Mon, 19 Jun 2023 16:53:41 +0300
Date:   Mon, 19 Jun 2023 16:53:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v3 3/3] pinctrl: intel: simplify exit path of
 ->gpio_request_enable() hook
Message-ID: <ZJBd5RQcvrBib8tq@smile.fi.intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
 <20230613085054.10976-4-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613085054.10976-4-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:20:54PM +0530, Raag Jadav wrote:
> Simplify exit path of ->gpio_request_enable() hook and save a few bytes.

> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
> Function                                     old     new   delta
> intel_gpio_request_enable                    186     150     -36
> Total: Before=10453, After=10417, chg -0.34%

While it seems a good footprint improvement, it looks like we do not use goto
in entire drivers/pinctrl/intel. So, I would keep it that way.

-- 
With Best Regards,
Andy Shevchenko


