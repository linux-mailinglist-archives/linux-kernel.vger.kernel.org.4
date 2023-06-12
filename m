Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AADF72CAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjFLPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbjFLPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:54:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D151A7;
        Mon, 12 Jun 2023 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585293; x=1718121293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OmlB9fd/SZKZioKkBBkhE9JBfd98aiviiICcFmjDiWY=;
  b=gIIS/wMUMFuxnyrbV9XArR4UzeO/AFybXTTXXDWky4UbOZLXODzHn9u4
   yR82EfmkXTVB86EDI2QemNBjvcuIxofGCalkbct6ID6BPP7LrUyhXNSq8
   c7LFrD7jjUAl3FEgLY6rzfRu7FMxARBC1KLC/IaNl8nNXv6H9a4D8D180
   ihUklHNUf7bX1aCdzXyZMPuqkRz+jFc2oZy3jUzhCDuGc3s2lC47pJM97
   3bonIZHLefoy7T49Zf3MT1b2TF4tGWoiGAGkdrTzUkbjOy9tENDLQQxCJ
   GYpN9hXsU8wDpz6vNv+LVk7cwO9wbwzQjXKoRWXX5efym2QkdD/9Zem40
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358080099"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358080099"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:54:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="711257660"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="711257660"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2023 08:54:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jsJ-0039Us-0I;
        Mon, 12 Jun 2023 18:54:35 +0300
Date:   Mon, 12 Jun 2023 18:54:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZIc/uvB1zxNRnuRS@smile.fi.intel.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <3a41a5ae9857cacdb062c398715a5938ccd47014.1686578554.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a41a5ae9857cacdb062c398715a5938ccd47014.1686578554.git.mehdi.djait.k@gmail.com>
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

On Mon, Jun 12, 2023 at 04:22:08PM +0200, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.

...

> +	chip_info = spi_get_device_match_data(spi);

Missing check. You addressed only I²C case. Is there any explanation?

...

>  struct kx022a_data {
> +	const struct kx022a_chip_info *chip_info;
>  	struct regmap *regmap;

I would suggest to run bloat-o-meter with this version and if you place
chip_info after regmap. Does it gain us some memory?

>  	struct iio_trigger *trig;
>  	struct device *dev;

-- 
With Best Regards,
Andy Shevchenko


