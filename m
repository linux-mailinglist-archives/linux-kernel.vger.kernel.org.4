Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA91624B43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJUKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiKJUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:10:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104F10B5F;
        Thu, 10 Nov 2022 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668111041; x=1699647041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyLP1OFDfjLFdrnLtrPCMT1/7GJGV+zVR22r3TPCCJQ=;
  b=C+lCdKBSgG3O0TZ4AJhF09Ic4fNMEbKyTHi4qpwr5lzgB2Jo5UCKdMEW
   plWeu8LFL0HzidE6wWB85xeCJcQ6ch4Q6Ckij8KjcC/7mKjbYwI6ehuxu
   PJAQqo0UD5bPzU8B0x3PzctbqjekowN08DJCqaS5/b8eDWWqLILeHH+zi
   KqG7/+h8wmJsDXm6SUCMFJ1kFg26Ko8idkHr6er4E2s+nxvmDnKsS1Az5
   ydYYlwoPjMQd0EPXDjncoVsP2MhqWnMllXlmkDlh1DeSvJcwUZ8CcUOV7
   XFYyhax/DSxYM9zdN9eadwLeDB52vMOM23ycYMcm3vp62vB2ivrSe7EP1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309056977"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="309056977"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 12:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706286235"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="706286235"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2022 12:10:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otDsj-00AKBU-07;
        Thu, 10 Nov 2022 22:10:37 +0200
Date:   Thu, 10 Nov 2022 22:10:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y21avEvX8Vd2Mj0j@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
 <Y2uOEhib5dvIcobF@smile.fi.intel.com>
 <Y2v4ze4y8qDThjrv@google.com>
 <Y2z/0IUOQMSonASw@smile.fi.intel.com>
 <Y20zN8WpWamUQtWp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20zN8WpWamUQtWp@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:21:59AM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 10, 2022 at 03:42:40PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 09, 2022 at 11:00:29AM -0800, Dmitry Torokhov wrote:
> > > On Wed, Nov 09, 2022 at 01:25:06PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Nov 08, 2022 at 04:26:50PM -0800, Dmitry Torokhov wrote:

...

> > > > > +	if (!IS_ERR_OR_NULL(fwnode))
> > > > 
> > > > I think this is superfluous check.
> > > > 
> > > > Now in the form of this series, you have only a single dev_dbg() that tries to
> > > > dereference it. Do we really need to have it there, since every branch has its
> > > > own dev_dbg() anyway?
> > > 
> > > As I mentioned, I like to keep this check to show the reader that we
> > > should only descend into gpiod_find_by_fwnode() if we have a valid
> > > fwnode. It is less about code generation and more about the intent.
> > 
> > Yes, but if fwnode is not found, we have a next check for that.
> 
> No, the check you are talking about is for the GPIO not being located.
> It does not have anything to do with fwnode validity. You are relying on
> intimate knowledge of gpiod_find_by_fwnode() implementation and the fact
> that in the current form it will withstand ERR_PTR-encoded or NULL
> fwnode.
> 
> I want to have the source code so clear in its intent so that I can be
> woken up in the middle of the night with a huge hangover and still be
> able to tell how it is supposed to behave.

As you said let's leave it to Bart and Linus.

> > I really don't
> > think we lose anything by dropping the check and gaining the code generation as
> > a side effect.
> 
> This is cold path, happening only on startup. I am not saying that we
> want to make it slow unnecessarily, but a condition branch that might
> even get optimized out is not something we should be concerned here.

Agree, that's why I called it "side effect".

-- 
With Best Regards,
Andy Shevchenko


