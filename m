Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6070636068
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiKWNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiKWNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:49:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D59039D;
        Wed, 23 Nov 2022 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669210803; x=1700746803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9srsKAsm31l1dTbkfAVTNzSDO2Kf610A6JWSfuub0kk=;
  b=O8w2xloMEqmWt0Oi58sjwSLMJUVXFoFozTFcy8wRZAAYgq7tWXu1PQp0
   3NVBC6PVGoxo+5xzXZaJmVTHFILwV0VW0wMPuyEIzZJIHl6ZJOIFfNgIz
   /NY184QqgbHvTMmsjN6J16AVKDfB83AmcED+ZzYgQ+RTwodf4XQpUarr/
   oN9/1ESKpC+i2iIdbcjZIxWMpD/o4iq2mRXsrF8BqiEjQRlotM9Fku5Ap
   S3z4ha7l5L+en/hmJcBl2lx3MqcCOzKsTtKchvR4F0kKVLhyCoWmkZ/yy
   qy2zoN1kkdOqRVhZYcMoClHGwVfbUCT87WEtg8RNiXMZuRz0d3XLrmKz6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312766696"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312766696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="641799230"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="641799230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2022 05:39:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxpyo-00GIsS-0d;
        Wed, 23 Nov 2022 15:39:58 +0200
Date:   Wed, 23 Nov 2022 15:39:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y34irZRlkpdqLrll@smile.fi.intel.com>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
 <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
 <f3fbf861-37c6-3bcf-615b-2f55261fbf90@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3fbf861-37c6-3bcf-615b-2f55261fbf90@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:58:47AM +0100, Gerald Loacker wrote:
> Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
> > On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:

...

> >> +static const struct {
> >> +	unsigned int scale_int;
> >> +	unsigned int scale_micro;
> > 
> > Can we have a separate patch to define this one eventually in the (one of) IIO
> > generic headers? It's a bit pity that every new driver seems to reinvent the
> > wheel.
> > 
> >> +} tmag5273_scale_table[4][2] = {
> >> +	{ { 0, 0 }, { 0, 0 } },
> >> +	{ { 0, 12200 }, { 0, 24400 } },
> >> +	{ { 0, 40600 }, { 0, 81200 } },
> >> +	{ { 0, 0 }, { 0, 0 } },
> >> +};
> > 
> 
> I'm thinking of defining structs for all similar types of IIO output
> formats in iio.h like this:
> 
> 
> struct iio_val_int_plus_micro {
> 	int val_int;
> 	int val_micro;
> };
> 
> struct iio_val_int_plus_nano {
> 	int val_int;
> 	int val_nano;
> };
> 
> struct iio_val_int_plus_micro_db {
> 	int val_int;
> 	int val_micro_db;
> };

...

> struct iio_val_fractional {
> 	int dividend;
> 	int divisor;
> };

This one...

> struct iio_val_fractional_log2 {
> 	int dividend;
> 	int divisor;
> };

...and this one repeat struct s32_fract (or u32_fract, whatever suits better).

> Do you agree?

Me, yes, but you need a blessing by maintainers of IIO.

-- 
With Best Regards,
Andy Shevchenko


