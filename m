Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99C638F79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKYSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKYSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:02:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07AD1C92E;
        Fri, 25 Nov 2022 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669399373; x=1700935373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBzzW7E1Wwa1OMeKtZTVcirSZarNwEtwdhOAc/4sCWI=;
  b=culgEQ9Hpk3+hXoVAC7GtN0yIcM6T71VpMuuLoZBrs7BMQbSZtJgNoP2
   c/WGm1t+z06d06C8oG9upuSFyWFPvbBw152KccqO6m3pdgH593UKZTUOu
   7NKs3bs/AVDuS2JFAhv2G+/xuXMJkCqjjkMxFIXBiCiS+ZHoLhhkO11sJ
   SaRmsT2PH/ofJTU2yPF8p0jrBTCQ79QQ5lDFIvLt1UT+1BDT2KDizyv1z
   t+wzIb9kxvaFJDY2R5C3eheXs4cvHGWPjwKkkDatGaowZ4ZeSR9Rh3RR4
   hCWukn8bdIVkHtJLSabOh8fAdsutGI72BRjkXtcx1X/rszCrcQoSlbcKJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="314556360"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="314556360"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 10:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="971634227"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="971634227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2022 10:02:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyd2I-00HLQf-1n;
        Fri, 25 Nov 2022 20:02:50 +0200
Date:   Fri, 25 Nov 2022 20:02:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4EDSqiq6WSZANt8@smile.fi.intel.com>
References: <20221125153257.528826-1-brgl@bgdev.pl>
 <Y4DsTxPH1tv5eEwf@sol>
 <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
 <Y4EBubusGqo4IroP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4EBubusGqo4IroP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:56:10PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 25, 2022 at 05:48:02PM +0100, Bartosz Golaszewski wrote:

...

An off topic here, can we have this [1] being applied meanwhile?

[1]: https://lore.kernel.org/linux-gpio/d1e86166-b2b0-a235-fe9e-be9ee4d93290@huawei.com/

-- 
With Best Regards,
Andy Shevchenko


