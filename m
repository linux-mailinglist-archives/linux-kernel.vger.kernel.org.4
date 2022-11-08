Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835062123E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKHNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiKHNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:24:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D27140B5;
        Tue,  8 Nov 2022 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667913843; x=1699449843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+1HC3GujTzU+fud5bj9bfqgHuiMuI/I1+8C6ZuJqK0=;
  b=YjFVE7ADFN8+IjYSIl4t96OjiaXxAh2Cy+1KmHFWTQMDExwjKGsJebf2
   IQ/KtQcPqsLKLdRIComHtgMptfEStpvoWlyC/Cx9N5MPMkk/Qjl4btd6D
   /FXmE02QcUVNvOjYxev9J82N5tZ0ZcKdpVd+Y3MkHS1iDGEnX+530oSXi
   1lALeSDTLTKHExiL/KhjxeS+5PDbakJxV7iL+0MP/GXVztjMnwR5gvsUj
   rH8S3yVGaxcUprtw2ju2qTf2hoo5qrEHck0bGnPILTHnqr4BjFcF1kDfd
   /Dt7t9UMXg0w5XFDX7hcLi8A07/O5T2iG1JEhb4hQDbPR4gIjdvae/Fq7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312481227"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="312481227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587369663"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="587369663"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2022 05:24:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osOa7-00995C-2B;
        Tue, 08 Nov 2022 15:23:59 +0200
Date:   Tue, 8 Nov 2022 15:23:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Integrate
 of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
Message-ID: <Y2pYb/h1eu/A+hLz@smile.fi.intel.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <20221107161027.43384-2-andriy.shevchenko@linux.intel.com>
 <Y2lMdQ/bE2w4skOO@google.com>
 <Y2lz/4wEDYnaIJF/@smile.fi.intel.com>
 <Y2l7ZRe7+wb9YkEm@google.com>
 <Y2oWRofuTzPbzHdE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2oWRofuTzPbzHdE@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:41:43AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 07, 2022 at 01:40:53PM -0800, Dmitry Torokhov wrote:
> > On Mon, Nov 07, 2022 at 11:09:19PM +0200, Andy Shevchenko wrote:

...

> > I am more worried about sz being odd and the loop ending up trying to
> > dereference ranges[-1].
> 
> I see. What if we take amount of ranges as the parameter and convert to size by
> multiplying by 2?

Okay, I found a way how to avoid additional churn and add validation.
I will incorporate that in v2 with your tags.

-- 
With Best Regards,
Andy Shevchenko


