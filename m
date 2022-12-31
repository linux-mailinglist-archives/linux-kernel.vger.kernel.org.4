Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B9F65A609
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiLaSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 13:24:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6DE9E;
        Sat, 31 Dec 2022 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672511068; x=1704047068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feTp/WmicBThxgI8tutjgB6YS3nkwvOhGW7b7yJzpIg=;
  b=P9BiFDRLUX/+2qbcR0jf/TUc3AWWla7evV5VIY1dBEPC5Dr405ee2d2S
   H4JU97yQh7S77bEg48vRrWOnD9AK1QdzHvlG+c1XYyCpjSHwzbjm7j0KY
   yD5UmxJlbTFxKdVs4zfLEXza7rFA85egtoV+QOy8oGQlIbiwmf/2aFozy
   ng1HuIXtzQjjpvyrkfKSUIRA7eQsjoPQVpie94c8T5DjHrb0GP2JXKawY
   H0CQhNl05xIl1hSFnZ3uZX1DpeO/4lMBwc1losHY/4rHGmii3sbOhCiZc
   KojtMGEcWINC0hFWoUBS8Nf3x1+ejlXZj94vKvQ2mKYRt3EjsWnMMMtvV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="319021498"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="scan'208";a="319021498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2022 10:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="899505083"
X-IronPort-AV: E=Sophos;i="5.96,290,1665471600"; 
   d="scan'208";a="899505083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 31 Dec 2022 10:24:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pBgWv-002PH3-0m;
        Sat, 31 Dec 2022 20:24:25 +0200
Date:   Sat, 31 Dec 2022 20:24:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: Switch to use
 spi_get_device_match_data()
Message-ID: <Y7B+WK9Qqth+j85X@smile.fi.intel.com>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
 <20221223152242.2ee926eb@jic23-huawei>
 <20221223154450.458771b8@jic23-huawei>
 <Y6wTmapfACknDKO8@smile.fi.intel.com>
 <20221231144558.44720f4d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231144558.44720f4d@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 02:45:58PM +0000, Jonathan Cameron wrote:
> On Wed, 28 Dec 2022 11:59:53 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> I should have been more specific though I do mention rebasing to get the
> patch above.. Doesn't build with it.
> 
> Signature of spi_get_device_match_data is:
> extern const void *
> spi_get_device_match_data(const struct spi_device *sdev);
> 
> and you are passing it a struct device * which rather implies you didn't
> successfully build test this.

Definitely. Thanks for spotting this, I'll investigate what happened on my side
that it wasn't built.

-- 
With Best Regards,
Andy Shevchenko


