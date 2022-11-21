Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35AA632C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKUS4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKUS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:56:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27185B9730;
        Mon, 21 Nov 2022 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669056973; x=1700592973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uktFm8U+CZEc9QqoQd5IBG0VetVrj/pdFPw5Za1xU8=;
  b=Pq5SxbflvqVh0Z2VKUqxz8Sj3A4D+IMNr02tN7csaxUBSjhNwEot+Hih
   dJEAGpWqyNpLUKhs/iv3rmCvbFSg/7W+inX4SnREFHa5ULw6tm4cHAONO
   I20VJ1UNaINF/1gHNOMIw0oqONMrbo6wznntrwBppg94TVwJlG3myeRP5
   3G6iLdCnHdKPmnYDFzTpo7eDwxSlIOyhLtN/mPVM29Bk+QvJyfsXBf0XW
   CjP3rUe3KnNBKGep1N/jPLmBWhGvDq1fUT7vTWq/SHHRueG1hV+xWPxu6
   kHuvF4bvVqlUQh3Ocp+n8XSLAEDPqvlR4yhi/uR+A5/5SlFTrz9GSZHsP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315459480"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315459480"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="709916954"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="709916954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2022 10:56:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxBxf-00FQqh-2c;
        Mon, 21 Nov 2022 20:56:07 +0200
Date:   Mon, 21 Nov 2022 20:56:07 +0200
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
Message-ID: <Y3vJx6YBB2qRD8R9@smile.fi.intel.com>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
 <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
 <Y3uFWH5GV/x7UDcP@smile.fi.intel.com>
 <96a632c2-7ac1-7b9d-0cb0-9874ae21a8eb@wolfvision.net>
 <Y3vGNVZcSuILCHxW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vGNVZcSuILCHxW@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:40:53PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 21, 2022 at 06:24:18PM +0100, Gerald Loacker wrote:
> > Am 21.11.2022 um 15:04 schrieb Andy Shevchenko:
> > > On Mon, Nov 21, 2022 at 01:35:42PM +0100, Gerald Loacker wrote:

...

> > >> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u",
> > > 
> > > There is a difference between %1u and %.1u. And I believe you wanted the
> > > latter, but...
> > 
> > %1u works fine for me. Can you point me to the documentation for %.1u?
> 
> man printf(3)
> 
> It was a surprise to me that many developers don't know the difference here.
> The %NNNNu defines the _minimum_ digits to print, while the %.NNNu defines
> the _exact_ amount of digits to print (NNN -- a number).
> 
> > >> +			 data->version);

Even me trapped to this one more time :-)

The above is only applies to the strings and floats. So in your case it has no
difference.

-- 
With Best Regards,
Andy Shevchenko


