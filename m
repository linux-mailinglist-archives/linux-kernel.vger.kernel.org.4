Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9C6B7907
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCMNcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCMNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:32:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003A2885D;
        Mon, 13 Mar 2023 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678714314; x=1710250314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eXRGU8Dbv87gxv29BMJhptmZs0zvJuCM7qRwk7FFIU=;
  b=lFaIT0uQWau3hUvyT17f8UUiNFa2Z32cqTYCu8OYJ2qUvdwY4Wa2qFmt
   ohtXkla1MluJvQZrl1W1wWbgQWmOGvtDVdbHC98qWdMBO2Uke7ychX4Km
   B4iINJExXp4bQvkWGSD3Eod02Ycrhz4rDKPLOY2HkbpmHvL2c2OyJN1pZ
   PWkm9bmsF+ehpzRNAAxMYQJAfiwchg9YQjbtAEpCxmlEJ6rkPmWM3BRG9
   CMq0bKhX0BATeCabWQveL+CIHw/OLrxKU+XEO41dICgnH3BnneA7qToao
   mLE8+AbgH3vokCVgscH5Udw2K2qDHpyoCQi+nse6tXUDCcoxtpmebkgaO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="320995256"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="320995256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678680031"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="678680031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 06:29:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbiEu-002e8N-2i;
        Mon, 13 Mar 2023 15:29:24 +0200
Date:   Mon, 13 Mar 2023 15:29:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
 <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:11:52PM +0200, Matti Vaittinen wrote:
> On 3/13/23 14:40, Andy Shevchenko wrote:
> > On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
> > > On Sun, 12 Mar 2023 17:06:38 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > Ah. I forgot the tests that don't have a device so can't use devm.
> > 
> > Why not? I have seen, IIRC, test cases inside the kernel that fakes the device
> > for that.
> 
> I'd appreciated any pointer for such an example if you have one at hand. (I
> can do the digging if you don't though!)
> 
> I am not a fan of unit tests. They add huge amount of inertia to
> development, and in worst case, they stop people from contributing where
> improving a feature requires test code modification(s). And harder the test
> code is to understand, worse the unwanted side-effects. Also, harder the
> test code is to read, more time and effort it requires to analyze a test
> failure... Hence, I am _very_ conservative what comes to adding size of test
> code with anything that is not strictly required.
> 
> After that being said, unit tests are a great tool when carefully used - and
> I assume/hope stubbing a device for devm_ tests does not add much extra...
> But let me see if I can find an example :)

drivers/gpu/drm/tests/drm_managed_test.c ?

(somewhere underneath:

 ret = platform_driver_register(&fake_platform_driver);

which suggests... what exactly? :-)

-- 
With Best Regards,
Andy Shevchenko


