Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7356243B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKJN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiKJN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:56:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AA7701A4;
        Thu, 10 Nov 2022 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668088609; x=1699624609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Kynfksy1jqiHQeRo7Tb/8wLk+wUbBqH9WM9nmjcUsQ=;
  b=I/5rM/HtoQwnsz+IaJ7jAa4qycdgObUcwfcNLdbE8NeIiIWqqwm1/yJ/
   71ZW4kJCu5j1pJutEh+WhAFTDmAFsodI283YGqIAV1FFstymhEVQEXFV5
   Nl4DhB5JQxMbISlaujK87RCfgbp3tWNoiPmMumlRQ/TDtcqwTv7uXfIL0
   n/RsPtoeHTsdejBF/MlxHjLVcbQ+f7DBXnkLJpVplHVfRoRH6q36o73TX
   6KGbZAZLq0b+V1esvk0KRkamm/WDqF5ceEAw9EvZzK3CBDnopPkpApdbz
   6JzSUZwHx9eioGwUT0njFEd0S0S49KIsj37AmLWqc06gzWzudAnn1Orb2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294659737"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="294659737"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 05:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="742859975"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="742859975"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2022 05:56:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot82v-00A9wK-0V;
        Thu, 10 Nov 2022 15:56:45 +0200
Date:   Thu, 10 Nov 2022 15:56:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data()
 for fwnode
Message-ID: <Y20DHLQiRU3i7UTC@smile.fi.intel.com>
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
 <Y2wZYuadSwbqxpge@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2wZYuadSwbqxpge@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:19:30PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2022 at 05:07:33PM +0200, Andy Shevchenko wrote:

...

> > -	of_node_put(mm_gc->gc.of_node);
> > -	mm_gc->gc.of_node = of_node_get(np);
> > +	fwnode_handle_put(mm_gc->gc.fwnode);
> > +	mm_gc->gc.fwnode = fwnode_handle_get(fwnode);
> 
> Can we reduce the patch to
> 
> 	fwnode_handle_put(mm_gc->gc.fwnode);
> 	mm_gc->gc.fwnode = fwnode_handle_get(of_fwnode_handle(np));
> 
> ?

Sure. As Linus pointed out, it's anyway temporary.

> I do not see a reason for converting the rest of invocations to fwnode
> given that this is clearly an OF API.

...which should go away.

-- 
With Best Regards,
Andy Shevchenko


