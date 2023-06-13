Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED672E726
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbjFMPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbjFMPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:25:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21C19B2;
        Tue, 13 Jun 2023 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669923; x=1718205923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVgR+CC/FpiYe7I/46OPA1Xr0GFffqj7swiaicrCsd0=;
  b=QTifKtjNrsSnMiobwHOaKRQ6JI2lEqSejaHLx34baylnQF5UNYb8lw7N
   HbmQ5Br9sG57veUGHT2nA8sf9gsQ9q64FJnSKSAHpoginfaTlnDk5zoO5
   UgkV7GIV0SdH1qcrA9iZrXJX69yEBQ/kRO4hE+bauN3Oiaf1cj4jc3XGW
   ZiNWtb33yYs7mPlDBTRMefBkZEZB5v+54nNxYVjyhzS30NzJgJ9y94fuN
   8cDpHKhG0Ve8RSLqiQu2/Q+Vt09IhfXU4lwNBnT0dbtIrnhuFauYFNyBy
   ZmuWUfFiyAJFLo8KSG5R+sJGiD8eDn9vFKxmXX68e6Aw5i8OcgBkTtcC8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358363261"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="358363261"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="776871596"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="776871596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2023 08:25:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95tF-003UDR-38;
        Tue, 13 Jun 2023 18:25:01 +0300
Date:   Tue, 13 Jun 2023 18:25:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] rtc: isl12022: implement support for the
 #clock-cells DT property
Message-ID: <ZIiKTXmrxBHw+gkG@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-9-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613130011.305589-9-linux@rasmusvillemoes.dk>
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

On Tue, Jun 13, 2023 at 03:00:10PM +0200, Rasmus Villemoes wrote:
> If device tree implies that the chip's IRQ/F_OUT pin is used as a
> clock, expose that in the driver. For now, pretend it is a
> fixed-rate (32kHz) clock; if other use cases appear the driver can be
> updated to provide its own clk_ops etc.
> 
> When the clock output is not used on a given board, one can prolong
> the battery life by ensuring that the FOx bits are 0. For the hardware
> I'm currently working on, the RTC draws 1.2uA with the FOx bits at
> their default 0001 value, dropping to 0.88uA when those bits are
> cleared.

...

> +#define ISL12022_INT_FO_MASK	GENMASK(3, 0)
> +#define ISL12022_INT_FO_OFF	0x0
> +#define ISL12022_INT_FO_32K	0x1

A nit-pick. Are they decimal or bit fields? To me seems like
the 0x can be dropped.

...

> +	ret = regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);

Seems too long even for 100 limit.
Maybe:

	ret = regmap_update_bits(regmap, ISL12022_REG_INT,
				 ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);

?

-- 
With Best Regards,
Andy Shevchenko


