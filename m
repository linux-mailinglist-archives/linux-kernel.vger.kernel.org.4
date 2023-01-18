Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD055672226
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjARPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjARPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:51:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613E43462;
        Wed, 18 Jan 2023 07:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056978; x=1705592978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2KTLpDLI59XYuNm6chvF++y1aXAv7uQxEewm8vdKkWg=;
  b=nPT0tJIcnJYtfSd55fiv0e6y4QXYK3Am83cb27QV7/9qzt9fc7Pm/6As
   vB2AOBAYcavh7I5XO5yGNUqJ1PjxKOb/rAz2FkJ1o9akuBxcDV4N9RXft
   E/9ZDGry/A0wTJcl/HEXQ2cw9kJSQwzWKezMd5JGKRpXJL7JFx8zc9B8K
   85ufYQqFmeKAsgQt/zJA5yk8n1Q2zxHZfPwAVc9ZHPpx//0TD7ZASDnfA
   FUQmVXW5/TWM4L8n74Kg10SQHpO97pbn6cWQm68BvJMargBI+I5WGPBrX
   /RbMpyzWCUrkUpDnN8TbVnEyCRVvaiyr8BNMrpuSVYlT/t7h8VutcsCXC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322702396"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322702396"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661760886"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661760886"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 07:49:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIAgw-00BFdy-1J;
        Wed, 18 Jan 2023 17:49:34 +0200
Date:   Wed, 18 Jan 2023 17:49:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
Message-ID: <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
 <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen wrote:
> On 1/17/23 23:48, Andy Shevchenko wrote:
> > None of the current users is using gaps in the list of the items.
> > No need to have a specific function for that, just replace it by
> > library available __sysfs_match_string().
> 
> Hm, I specifically remember adding this for a driver where there were gaps.
> One of the DACs. But it might be that the driver itself never made it
> upstream.

I have checked all modules that have struct iio_enum and/or ("or" probably may
not happen) IIO_ENUM() in them.

It might be that I missed something.

-- 
With Best Regards,
Andy Shevchenko


