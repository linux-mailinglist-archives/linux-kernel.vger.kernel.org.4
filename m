Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656636259F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiKKMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKKMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:01:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C055BD71;
        Fri, 11 Nov 2022 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168114; x=1699704114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxMDF9YsdxZxuQZMs5AsEobdIllhpLgUIIiVSCXywkE=;
  b=OjCpG3plltUSZ/K7BcDh37ayxgQ4z57CWtz6YQj6szOyMpIUj5wa3GV2
   EcY3vZkDVVBi4RQ9M2VuhuXuUUg6Jhw8jYwAYEoyrMBSV4nKmF/nir+qn
   Yf9HKgPQ3OyZaORDcWZIgVuR8jvNMJRZWVnkRxMXXGxaf73E8/r1j04AF
   wMAB5sJ9pR+vFpb8diys2IEHhaU5UPjeiWq9w36/4TwtFt8yPFAg62e+v
   TlgSCkr/RiTm8C9KZkvdSSkZlN0dc6y2qNHUsXdjwITgjYjicli64XIPP
   Wj2kx7naJwBxKastHNWYA0puf7E2weZFVgqSAyve62Z48MxOSi/7WBqWo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="311587535"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="311587535"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726767492"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="726767492"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2022 04:01:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otSjH-00AgRD-1v;
        Fri, 11 Nov 2022 14:01:51 +0200
Date:   Fri, 11 Nov 2022 14:01:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pinctrl: Move for_each_maps() to namespace and
 hide iterator inside
Message-ID: <Y245rxdl0NRCKP78@smile.fi.intel.com>
References: <20221109155724.42354-1-andriy.shevchenko@linux.intel.com>
 <Y2vQgdzBl+MvoqQM@smile.fi.intel.com>
 <CACRpkda=vhL_LKU1BjOBkJKPuFe5YOX8cAPpzU8SaRKRw1fq-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda=vhL_LKU1BjOBkJKPuFe5YOX8cAPpzU8SaRKRw1fq-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:55:47AM +0100, Linus Walleij wrote:
> On Wed, Nov 9, 2022 at 5:08 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 09, 2022 at 05:57:24PM +0200, Andy Shevchenko wrote:

...

> > Meanwhile, Linus, do you think this change is useful?
> 
> Even if just a name change, it makes things better by being more
> readable so yes :)

v2 has been sent.

-- 
With Best Regards,
Andy Shevchenko


