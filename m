Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3965DACB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjADQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbjADQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:55:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2923FC90;
        Wed,  4 Jan 2023 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672851102; x=1704387102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQzAaG/riItgL7XH8d4hpWwMRvqYPpCa+e8ZrSNpK3A=;
  b=WhRn8OVtYTz5pNxKNytEem8OJ7QcSaEzX1sMnuIn8pY6ysGyH9LuO8b1
   VPa+IqfpzsnUgwem+8tXgKWgLKv02raR9FWs00/EMLkfK7s3YufQJrWpi
   iL5vitwJ1YbVZwlcXYN/gK6qUeXumG1r8uGUMUoMNdStZm5GcGJtCGto8
   qCQM8+hh6xtSsLP8qsBUyDLXeTvhYKsSxoRjxkVejYd7hMaRNGdR2M55i
   SVON/jBxj0Dz5DaTen4eibMS/IeZA46J5BCd+ch7te+YemqrpxGxINibI
   6odABoLk4+h4MYBzm9Ewz4oHPhjJsIjTmKtNBTBZqqilob0ZjBB0PDPh9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="305485208"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="305485208"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="718509909"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="718509909"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2023 08:51:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pD6z7-004Nww-0l;
        Wed, 04 Jan 2023 18:51:25 +0200
Date:   Wed, 4 Jan 2023 18:51:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [rft, PATCH v4 0/3] gpiolib: eventual of_node retirement
Message-ID: <Y7WujAWPlZ/KWDk5@smile.fi.intel.com>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
 <Y7WsSh6RCNGIgml4@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WsSh6RCNGIgml4@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:41:46PM +0100, Thierry Reding wrote:
> On Wed, Dec 28, 2022 at 11:20:42AM +0200, Andy Shevchenko wrote:
> > Now that all GPIO library users are converted to use fwnode,
> > Drop redundant field from struct gpio_chip and accompanying
> > code.
> > 
> > Bart, I prefer this series to go as soon as possible if you
> > have no objection. Or even as v6.2 material.
> > 
> > Thierry, can you please test it once again, so we will be sure
> > there is no breakage for OF platforms?
> 
> Seems to be working fine on at least Jetson TX1, so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>

Thank you and HNY!

-- 
With Best Regards,
Andy Shevchenko


