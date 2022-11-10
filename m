Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4162438E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKJNsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKJNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:48:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532C6B226;
        Thu, 10 Nov 2022 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668088086; x=1699624086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iqIuaIvtYKMdT63Ny4eIOVjjkurqETkhQ3810twA6GI=;
  b=IWJyT7BHGPOzkjyCIeYw0OEg/winq+pYiMbk+sd4ZitHcWF9UInCji0I
   HsFWTl6hJwdChFCQ2UKnFeNRT8gPC7C/lXScCklWsVxWHBMJLcJBAq3Mt
   9ZHZ4yHJIkhr8KG1p3gu6PMtP3uxzUb+5vEOK+iQpoU63qrzz21Ns8GCF
   /4B9i55BTQqJU0yWKcvfxn7ioh7Gvlg4SkBrtJkt0tbySzKAA+o7HycMc
   1Nnkf49Q4pOx68H2WuadcZbI5SVF278kQLkdngYZkhPftPl149E+4ciu1
   idNVZGH0igEFJqLsoF3kWYMMBNGdlyiK9uFred2DoV2gZgkpc4EfY9ZIG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="373430262"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="373430262"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="762286348"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="762286348"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2022 05:48:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot7uU-00A9nE-2g;
        Thu, 10 Nov 2022 15:48:02 +0200
Date:   Thu, 10 Nov 2022 15:48:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: add support for software nodes
Message-ID: <Y20BEuHlY2OEsZ0v@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-6-81f55af5fa0e@gmail.com>
 <Y2uNDmRefzPvUu3P@smile.fi.intel.com>
 <Y2v6lxoCQvlRdr8q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2v6lxoCQvlRdr8q@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:08:07AM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2022 at 01:20:46PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 08, 2022 at 04:26:51PM -0800, Dmitry Torokhov wrote:

...

> > > +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> > > +		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
> > 
> > %pe ?
> 
> "/* %pe with a non-ERR_PTR gets treated as plain %p */".
> 
> I do not think users are interested in the address on success.

Hmm... Perhaps we can teach %pe to behave differently with, e.g. %pe0,
modification. But this is another story. So, let's go with your variant.

...

> > > +#include <dt-bindings/gpio/gpio.h>
> > 
> > Not sure why we have this here.
> 
> For convenience - so that users have access to GPIO_ACTIVE_HIGH/
> GPIO_ACTIVE_LOW and other flags.

Okay, would we make this as a guarantee then?

In such case a comment before this inclusion should be added to explain why
we do that without any actual user to be present in the header file.

-- 
With Best Regards,
Andy Shevchenko


