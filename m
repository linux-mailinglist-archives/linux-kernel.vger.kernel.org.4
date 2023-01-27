Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F167DF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjA0IxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjA0IxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:53:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C753DBFF;
        Fri, 27 Jan 2023 00:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674809596; x=1706345596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N96kW+xetza+QF6MAEJPmzSuLKloyHvRNXkt4jNf/ZE=;
  b=Cc+VU7aXDDm0fx+/HdB28QDecaPW36MPOl2VBc6Qe5AQiyMo1XtJjz8V
   FvMUQcZJ9aB5qYInSH88rbGZC5akDweshhyFrVWk+KnqX5Cnab6rvKQLh
   5sutg4+MHbCQEgnlAT+3EnVzqz2m8tQEWHMEgGtnC7JcvkKzDISe3FvzX
   7gNhuT+vJp9n0vRCoMEkYQWC7IpHwlqfM5PN8SAeWhrHDj5HH9ewwYiVs
   2xFW8Q5UrXqmzm8EZ4lHvMzlV5v2bGaB6e86b+IzmffQN/AmFEO9Ykubb
   +gu8QC9OSym9fTynv5eXs4dj99mB3A5gZKn6NE4VQ1Fp9q3lF7CvDvWQI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391596304"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="391596304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 00:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656531703"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="656531703"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 00:53:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKTv-00Fsou-1N;
        Fri, 27 Jan 2023 10:53:11 +0200
Date:   Fri, 27 Jan 2023 10:53:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] gpiolib: move of_gpio_flags into gpiolib-of.c
Message-ID: <Y9OQ9/3IuVIU8VK7@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-9-arnd@kernel.org>
 <Y9KJpU4rynmTdQMj@smile.fi.intel.com>
 <21657e6c-1101-4c56-91e3-6b2f6f9e10c9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21657e6c-1101-4c56-91e3-6b2f6f9e10c9@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:47:42PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 15:09, Andy Shevchenko wrote:
> > On Thu, Jan 26, 2023 at 02:28:01PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> There is no need for this in the header any more, it's just
> >> an implementation detail now.
> >
> > I have published
> > https://lore.kernel.org/r/20230112145140.67573-1-andriy.shevchenko@linux.intel.com
> > Can it be used?
> 
> Sure, I added a Reviewed-by: on that now. Your patch will conflict
> with my patch 7/8, but we can work that out.

Either Bart takes it independently or you may attach it into your series.
Bart?

-- 
With Best Regards,
Andy Shevchenko


