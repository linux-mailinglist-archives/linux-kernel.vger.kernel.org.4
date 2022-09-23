Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94CC5E783C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIWK0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiIWKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:25:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC0C842B;
        Fri, 23 Sep 2022 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663928751; x=1695464751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GOTZeBmUhJvU8ikCmYOcPo8ZN4W2/SE78FyafzLpbKI=;
  b=Lm1wQJasReOs+sTXXu6i5Q/9H8Nbpg3InGtRfctWJxyv6T7JXbl8ZRlY
   LGegrmXOuLRraHLMyYjj6cf6TZV2H61nQAZY1UkZGozS/APQoUAOybyhH
   gryuz9ya8XD8Gj1m/vDJQyEgIH9yFT69a1C7zj39qV2PidC2TNh5Ta6SO
   yVDwaam5f+IXyth7rbVMQrxAt/STpi4etfhUbT13Dp0Asvti8H0YX1wZo
   91HVqiSObIuiRK95W4AlF1NEq0sE3wPgfZ4vQt7ekAUUYx3Q6hcMhhbXa
   TAGIWpUHfOHrjAWOqqsot7RTO2rlGZ5NMkLwMvyp1WWuIUxu6TisKLi/B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299283503"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299283503"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615571117"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2022 03:25:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obfsM-006Q3p-18;
        Fri, 23 Sep 2022 13:25:42 +0300
Date:   Fri, 23 Sep 2022 13:25:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] device property: Add const qualifier to
 device_get_match_data() parameter
Message-ID: <Yy2Jph0AAugY/tn/@smile.fi.intel.com>
References: <20220922135410.49694-1-andriy.shevchenko@linux.intel.com>
 <YyzEHk2TTcsIO0ha@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyzEHk2TTcsIO0ha@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:22:54PM +0000, Sakari Ailus wrote:
> On Thu, Sep 22, 2022 at 04:54:10PM +0300, Andy Shevchenko wrote:
> > Add const qualifier to the device_get_match_data() parameter.
> > Some of the future users may utilize this function without
> > forcing the type.
> 
> From const to non-const? This is what this patch does, right?

Right.

> > All the same, dev_fwnode() may be used with a const qualifier.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > -struct fwnode_handle *dev_fwnode(struct device *dev)
> > +struct fwnode_handle *dev_fwnode(const struct device *dev)
> 
> If you have const struct device pointer, then the embedded fwnode handle in
> that object sure is const, too. Isn't it?
> 
> If you really have const struct device pointer (where do you?), then I'd

device_get_match_data() expects the const parameter, but due to dev_fwnode()
it can't be satisfied. This has been reported by LKP when I tried to submit
a wrapper:
https://lore.kernel.org/linux-spi/20220921204520.23984-1-andriy.shevchenko@linux.intel.com/

Yes, I probably can drop const there, but it will be again awkward to see
almost all APIs beneath using const and upper one without it for unclear
(to the reader) reasons.

> suggest to add another function, dev_fwnode_const() that is otherwise the
> same except the argument as well as the return value are const.

Perhaps this is the case, but does it mean we need to duplicate APIs when
we know we don't modify data? Seems road to bloating the code for peanuts.

> Or alternatively define it as a macro and use _Generic()?

Yeah, I have the mixed feelings about _Generic for generic APIs because
it requires to convert some stuff to macros when type checking of the
parameters can be missed (if a target takes two or more of them).

It might work here (we have a single parameter), but in general...

-- 
With Best Regards,
Andy Shevchenko


