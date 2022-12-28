Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02459657503
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiL1J76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:59:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC365B9;
        Wed, 28 Dec 2022 01:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672221597; x=1703757597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6N8tmxGsT7JDsqIPTQ19+Zif6bCIsCC4xYlRihxqiLY=;
  b=Flz4GphZSmJqBwwvwvuzIXmUHPXieZQjiitDUzvgQcY7fd3nBIiadOhz
   CnIjY+QVJpT7zUFSOAI6au8KqHXFoJa2FFOkWraA1TuhXRKAF4BKC3WHZ
   0QcmMuY4aBy1hDshKBV5xZbVJeNkS4d1FUYyzuPtBOOKwWBSfSZ1JcT9T
   UxIFsLvYvW6vCsUCl3oKiOGNecPR/p87FpGg9n6090Dn+Ua/DH4kgi+A8
   pXrdkunCYI2A9cPUrTfm7A7wM7ilzMitnTv/FsTFIgksar/sBqQuocBBz
   kunNlmKOX6whYLLc+/wI0XKYGkMaQgoMlGGdpEuz+Rw0xhy4j2xcuPKVd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="322824361"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="322824361"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="653283099"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="653283099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2022 01:59:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pATE1-000WVA-3C;
        Wed, 28 Dec 2022 11:59:53 +0200
Date:   Wed, 28 Dec 2022 11:59:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Switch to use
 spi_get_device_match_data()
Message-ID: <Y6wTmapfACknDKO8@smile.fi.intel.com>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
 <20221223152242.2ee926eb@jic23-huawei>
 <20221223154450.458771b8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223154450.458771b8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:44:50PM +0000, Jonathan Cameron wrote:
> On Fri, 23 Dec 2022 15:22:42 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 14 Dec 2022 13:49:43 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The spi_get_device_match_data() helps to get driver data from the
> > > firmware node or SPI ID table. Use it instead of open coding.
> > > 
> > > While at it, switch ID tables to provide an acrual pointers to
> > > the configuration data.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > 
> > > Requires aea672d054a2 ("spi: Introduce spi_get_device_match_data()
> > > helper") which is part of upstream as of today.  
> > 
> > I rebased to get that (will rebase again on rc1).
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing
> > to keep 0-day busy over my holidays.
> 
> I take it back...  Build test failed...

As comment on the first patch stays this requires an SPI core patch, which is
now the part of the v6.2-rc1.

Can you reapply it taking the above into consideration?

-- 
With Best Regards,
Andy Shevchenko


