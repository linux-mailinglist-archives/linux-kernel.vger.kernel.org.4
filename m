Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5741E6B77B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMMlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:40:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B51CBCC;
        Mon, 13 Mar 2023 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678711257; x=1710247257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVoMbrcYcnZK+MhCugK4+/hG5DFvoNRVCXBZHrtuYqI=;
  b=SB+Xe2Xmtf1qZVa2vW8Sp+heVIY5Asz4DtW4+Zz0oC1uQ+DQURpjFqaO
   Nwh/1ADkingggai1Fgky0ZYVB3QsSw2iLbVIf6kp4Z5Qghmq4bd20cWWi
   y9YtY0vI/wvk9JbrGex36VmDvfwLLWpYD3eUXNmmBMMhm9txvYRdKfMUY
   LVekCC+WuGF3MCM8x3mU7HQhUaFb0QxSShrvWFYZAQXkb/GgVlpZkI321
   fFSu5xV1firBlZZsNbjx0fiLjLeDF5gjMX4cneAwJDMzOCT2cS6VWHbbj
   f51pGi0JuNTdRpA9gyqxYf11vhGtl0LcBiAUAPe2UKmjBt3QmXAM8ttXF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="317522076"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="317522076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="742840737"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="742840737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2023 05:40:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbhTw-002ctr-0V;
        Mon, 13 Mar 2023 14:40:52 +0200
Date:   Mon, 13 Mar 2023 14:40:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
 <20230312170848.651b5b2c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312170848.651b5b2c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
> On Sun, 12 Mar 2023 17:06:38 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 6 Mar 2023 11:17:15 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> > Given most modern IIO drivers use fully devm_ based probing, for now I would not
> > expose anything else.  That will reduce the interface a lot which I think
> > is probably a good thing at this stage. 
> > 
> > Keep the non devm stuff internally though as it is a nice structure to have
> > an I can see we may want some of these in non devm form in the future.
> > 
> > Similarly - for now don't expose the individual table building functions
> > as we may never need them in drivers.  We (more or less) only support interfaces
> > that are used and so far they aren't.
> > 
> > For other functions it's worth thinking about whether to not export them
> > initially. I haven't been through them all to figure out what is not currently used.
> > 
> Ah. I forgot the tests that don't have a device so can't use devm.

Why not? I have seen, IIRC, test cases inside the kernel that fakes the device
for that.

-- 
With Best Regards,
Andy Shevchenko


