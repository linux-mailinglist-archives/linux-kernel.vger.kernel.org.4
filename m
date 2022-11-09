Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04DC622C48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKINXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKINXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:23:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A1FAE3;
        Wed,  9 Nov 2022 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668000197; x=1699536197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8t5I4mGipn7NqdHpZ+N6y1yem02cWRc/fgwL67uLPs=;
  b=N6dKbWGu9oDZn6ANlwYwaSGKbuiVKWDmDoc47OKX/E+tnq0NZlKStbzh
   P2+86ZatSpExyg9qcvjeaOSlJcC8k3P4SL+Nr01c4m4cQ4Uqhy1rTvtaD
   8bavgqbBinExqGecayRg+A8ocU4CbvEIPcKjzx+nFQcDKc+LUKAq3yKEP
   8gtnBLMnYa7QFF4g5GAizLd2z+eu3TpuWlJLAth3z5BgApPIO5WVO/UCE
   JxiwYgJPcyg4XOzVXZ90N7bgnc395g9n7ezmicu/jFwtEszuOJyvfVHf9
   hVupm/0b1S1d+xttw/G0EV+vGE3ga9AkU6OfkxZ45H4K8k00BMtl1/037
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290690135"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="290690135"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 05:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="725973925"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="725973925"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Nov 2022 05:23:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osl2j-009kmf-2R;
        Wed, 09 Nov 2022 15:23:01 +0200
Date:   Wed, 9 Nov 2022 15:23:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
Message-ID: <Y2uptb+DCohXHPC5@smile.fi.intel.com>
References: <20221107161027.43384-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md7yN2cw14EAPbODGeLOXw=7VGceK_uYdTx-NsN6P64HQ@mail.gmail.com>
 <CAMRc=MdvcQgOvEU+t8ck2EFJUtM_HSTR9cMZf4wVdtB3TRs5Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdvcQgOvEU+t8ck2EFJUtM_HSTR9cMZf4wVdtB3TRs5Zw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 02:13:55PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 9, 2022 at 2:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Mon, Nov 7, 2022 at 5:10 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Applied, thanks!
> >
> I actually applied v2 and both the patches from this series.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


