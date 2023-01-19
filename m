Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639516736AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjASLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjASLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:23:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894D6F31D;
        Thu, 19 Jan 2023 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674127411; x=1705663411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R/RxuuT7IkxXhFxtCaN5MvQfGNn2LuusbfKNM0MIJds=;
  b=YgLXzSrfRJTpYzDrX0/J9RzLtVwcWU6Lp1ErUKewkqm2NUhqOa97yGVS
   0igxt9z+Fo4uhhq7k6nUNDuWYNaSTZ0KgOd3Kb7LQN6JczGxUghh83xaD
   FgaGExF99ghg0AS9uH5yncBK9U44qGkNXzZotFCyZN9fb43YjUADTIC6m
   0l4aNv3yNRRGAwq0zphaNJbMWmcxdvKvQX1sEDIrI1vGiQl47Z8XI92YZ
   bhDc9JbxOU0pvi/ZcBxHCYHYtrfUtgCdUdDFn0T7YSHpfSviPysL0JRj4
   +gWsAt02PD3K53RM4IfdRWjyMcEpBs9X0ouc2FF2vMahgWljpvQ8oILSI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304942739"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304942739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802602459"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="802602459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 03:23:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIT0x-00BcTJ-2x;
        Thu, 19 Jan 2023 13:23:27 +0200
Date:   Thu, 19 Jan 2023 13:23:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
Message-ID: <Y8koLwGVjyrDb66P@smile.fi.intel.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
 <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
 <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
 <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
 <bb2e8b7b4ca894ed53d70bf04e2d52bed2553105.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb2e8b7b4ca894ed53d70bf04e2d52bed2553105.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:00:45AM +0100, Nuno Sá wrote:
> On Wed, 2023-01-18 at 08:37 -0800, Lars-Peter Clausen wrote:
> > On 1/18/23 07:49, Andy Shevchenko wrote:
> > > On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen wrote:
> > > > On 1/17/23 23:48, Andy Shevchenko wrote:
> > > > > None of the current users is using gaps in the list of the
> > > > > items.
> > > > > No need to have a specific function for that, just replace it
> > > > > by
> > > > > library available __sysfs_match_string().
> > > > Hm, I specifically remember adding this for a driver where there
> > > > were gaps.
> > > > One of the DACs. But it might be that the driver itself never
> > > > made it
> > > > upstream.
> > > I have checked all modules that have struct iio_enum and/or ("or"
> > > probably may
> > > not happen) IIO_ENUM() in them.
> > > 
> > > It might be that I missed something.
> > I checked too, I can't find it either. The driver probably never made
> > it 
> > upstream.
> 
> Yeah, I also did a quick check and I could find it in one adc (most
> likely we have more downstream users of this) that did not make it
> upstream. Eventually, we want to have it upstream but the ABI using the
> gaps can arguably be dropped...
> 
> Anyways, from my side I'm fine with this change. We can revert it if we
> ever have a real user for this. I'll just have to be careful when
> updating ADI tree (but that is our problem :)).

We usually do not keep a dead code in the kernel, and handling gaps is
a dead code. And yes, we always can return to that when we have a user,
most likely as a part of the generic library and not just IIO.

-- 
With Best Regards,
Andy Shevchenko


