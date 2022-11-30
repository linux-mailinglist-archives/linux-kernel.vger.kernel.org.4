Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C163DC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiK3RnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3RnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:43:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A914B75A;
        Wed, 30 Nov 2022 09:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669830191; x=1701366191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3wDv3vpOG1kZHQ2h29A6+y3D/5UJp4mktosEpyu5cc=;
  b=nHjr/IPxrWc8SUZtgsZUP2PLGcaPYcmp9cJPIjqXm2OxfwO+LoPOCRSq
   SFmDrEbYSMG8JaWXUNEvw1nkal/vv9e216PL7H4C2auQ6eZ8luycY08c8
   PYiRJewy5XmpZl6nmrJRUjqHN7GPIqB0xbpG9SvE1y6V0bCs4KPQFsjHG
   69DyL6aA9AkwJyPTkXUC3Ecqtkde4H67r23DAOCFitBRkNLZzBoz9FLKK
   ouOm++JCw5yATeuLJUsUWY3JxiOp8alJ97eNhKaL9W5BUhWhynoMFz5TH
   uP6bAD+/HCJI1XhWikagrbw9WGBmrZA5N9ASuyLJh4eU+huG4dfwwWEXW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313089050"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313089050"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 09:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="768915535"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="768915535"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2022 09:43:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0R6v-002NTX-1s;
        Wed, 30 Nov 2022 19:43:05 +0200
Date:   Wed, 30 Nov 2022 19:43:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v5 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4eWKdJXOR7hJTF3@smile.fi.intel.com>
References: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
 <20221130145356.1129901-4-gerald.loacker@wolfvision.net>
 <Y4d3NZkCdALLkwU7@smile.fi.intel.com>
 <ef3ec278-d9dd-4318-5b8a-d0ed363fbaab@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3ec278-d9dd-4318-5b8a-d0ed363fbaab@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:32:10PM +0100, Gerald Loacker wrote:
> Am 30.11.2022 um 16:31 schrieb Andy Shevchenko:
> > On Wed, Nov 30, 2022 at 03:53:56PM +0100, Gerald Loacker wrote:

...

> >> +	switch (data->devid) {
> >> +	case TMAG5273_MANUFACTURER_ID:
> >> +		/*
> >> +		 * The device name matches the orderable part number. 'x' stands
> >> +		 * for A, B, C or D devices, which have different I2C addresses.
> >> +		 * Versions 1 or 2 (0 and 3 is reserved) stands for different
> >> +		 * magnetic strengths.
> >> +		 */
> >> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);
> >> +		if (data->version < 1 || data->version > 2)
> >> +			dev_warn(data->dev, "Unsupported device %s\n", data->name);
> >> +		return 0;
> >> +	default:
> > 
> >> +		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
> >> +		return 0;
> > 
> > And we still continue?! Wouldn't be a problem if that ID drastically changed in
> > terms of programming model and may actually be broken by a wrong sequence?
> 
> It was suggested by Jonathan to just print a warning instead of
> returning with -ENODEV. Reason was "Often manufacturers spin new
> versions of chips that are compatible enough that we give them a
> fallback compatible in device tree.". For me this makes sense.

Ah, I see. Maybe adding a comment summarizing above?

> >> +	}

-- 
With Best Regards,
Andy Shevchenko


