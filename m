Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86BB6D7761
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbjDEIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjDEIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:54:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E81F3;
        Wed,  5 Apr 2023 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680684859; x=1712220859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V+zTDzqniCNLAugrQ5YEmCW1Vqzv6gfhvHx8dIPWqRw=;
  b=fbr3EXKOj6Mb75mmsTXTMZLfjnSTZEHQQi35NsT4vv0JUk9ZOOp83XWj
   5QGjalk5CBqnuj83TOUIQE+F9sMM8M34zzCM6kGF/wFS/vm41IsVUDiqf
   syVT6xTUmAVOuoMufABa2lINPKl937O102q1XJQFKldaahqkGkHqckfd6
   5Xr5PYKNMqYyHHADcPna7MB+CHI4y6GcoxsFi8IKDHqdn1HxJ2G7lBuyu
   FKUyUbz8plUUXE3IOTNWmV97eY5IwKh/4z+vK0+loUNhzc8dROuyQUDZM
   fbyXxhvdn9qOD0StokUnj6h5IIAGFAdD1FVGpfGWyhkdKrJ1ADv8VgLD2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344980579"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344980579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="860898214"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="860898214"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 01:54:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pjyuF-00Cl4B-28;
        Wed, 05 Apr 2023 11:54:15 +0300
Date:   Wed, 5 Apr 2023 11:54:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: addac: stx104: Use
 regmap_read_poll_timeout() for conversion poll
Message-ID: <ZC03N4lTqJQWClz4@smile.fi.intel.com>
References: <cover.1680564468.git.william.gray@linaro.org>
 <f7fa811a002d0572c63b5a5ab7a478a5383ff840.1680564468.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7fa811a002d0572c63b5a5ab7a478a5383ff840.1680564468.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:12:02AM -0400, William Breathitt Gray wrote:
> ADC sample captures take a certain amount of time to complete after
> initiated; this conversion time range can be anywhere from 5 uSec to
> 53.68 Seconds depending on the configuration of the Analog Input Frame
> Timer register. When the conversion is in progress, the ADC Status
> register CNV bit is high. Utilize regmap_read_poll_timeout() to poll
> until the ADC conversion is completed (or timeout if more than 53.68
> Seconds passes).

...

>  		/* trigger ADC sample capture by writing to the 8-bit

Perhaps fix the style here while at it?

		/*
		 * Trigger ADC sample capture by writing to the 8-bit

>  		 * Software Strobe Register and wait for completion
> +		 * Range is 5 uSec to 53.68 Seconds in steps of 25 nanoseconds.

seconds (in SI the small letter is for the unit(s) of seconds).

Same for the commit message.

> +		 * The actual Analog Input Frame Timer time interval is calculated as:
> +		 * ai_time_frame_ns = ( AIFT + 1 ) * ( 25 nSec ).

nSec --> nanosecond

> +		 * Where 0 <= AIFT <= 2147483648.
>  		 */

-- 
With Best Regards,
Andy Shevchenko


