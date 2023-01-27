Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0D67DF7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjA0Itj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0Itc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:49:32 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214E17149;
        Fri, 27 Jan 2023 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674809371; x=1706345371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K3i7HVZI8vuGSyJRyNI2NxTcK4pR6nC3JEQB24kP9MM=;
  b=Io5+qYfYekuKuaxM3YdoyQe7Zi9/4XSWnYjwC7lMNFSfqlQOGjZQkz7f
   CsjqR6EmvmMq8VFIJe+iPFU4NLlkVSofhEsq6gX/VKSnyRn8eKEkxhCgS
   5qPx9Jh/pgiDzcfwNoKr7CGjlV+KcYCnQpvVIazYYDyhPumt9hYNtW5XI
   jAMHljFaCivqNJ/hky/fCbfqNg3la8Dp5CsN8+YLDL2wtlcIJKop2twGW
   8KfvaTEiyUBGf3O/zymJKB43+/3bTUSBoZqZn2Cpxq/5jxvqxZMBNQbyn
   byHDMRBhLmkeg7ovkWb9Ql2Lwgv8/veNlPZsazHnZ7dLlRyIoNgWNl96s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389419786"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="389419786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 00:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="613114524"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="613114524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 00:49:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKQF-00FskW-1h;
        Fri, 27 Jan 2023 10:49:23 +0200
Date:   Fri, 27 Jan 2023 10:49:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Move enum of_gpio_flags to its only
 user
Message-ID: <Y9OQEzbMMMUSVblf@smile.fi.intel.com>
References: <20230112145140.67573-1-andriy.shevchenko@linux.intel.com>
 <0805b351-1661-4c90-89e1-2fea2fc98867@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0805b351-1661-4c90-89e1-2fea2fc98867@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 03:46:32PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 12, 2023, at 15:51, Andy Shevchenko wrote:
> > GPIO library for OF is the only user for enum of_gpio_flags.
> > Move it there.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I made the same patch independently, but you sent it first, so
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thank you!

Bart, I guess we have a consensus to proceed with this, the worries I have
can be addressed later on, i.e. as a followup patch.

-- 
With Best Regards,
Andy Shevchenko


