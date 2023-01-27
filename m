Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1A67DFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjA0JQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjA0JQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:16:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776017753A;
        Fri, 27 Jan 2023 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674810987; x=1706346987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+w715QhoBpJxNDnwlDPLsCRu1Y2v1Jp8jiuFOjJJtQ=;
  b=CRS0ZEKkrpK4nivN4NY4Tk5Elxyamv0QRNy6aOdtSMmScX7042/OEA3T
   BmE5g1zCJhEoLAaPdTl6WhcM+a3j3/OfacNMMbcjOBqZ+PieQRpipn5EY
   HyLVAALAy9Xft854X0EYuM7pnxl1EgRKHpMs5dgObCx3b+mYot2wfmK4v
   +ohcTv0v3EXgi57LUlYfkyXPgBsn5dBFDNZuWQJaaPTWTRPLkeZPjk0H/
   hdN9mLsxeo9RBVl5J3Tr0xuKrVmSyrDcNSB2YLUH01zN82Dhs79fsXu2d
   EMiFmyG+l0KE7On054nHoeqjgqrEtu14Rz1FDQMAD5kAZZJf/yWAia/GR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413272280"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="413272280"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 01:16:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665193275"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="665193275"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 01:16:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKqO-00FtGi-21;
        Fri, 27 Jan 2023 11:16:24 +0200
Date:   Fri, 27 Jan 2023 11:16:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] usb: fotg210: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y9OWaPGpyGvVgIRw@smile.fi.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
 <20230120154437.22025-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdaeAkPuAQu0BW45Bn94Q_eO-Ven0-TSd38upe9XpXMzwA@mail.gmail.com>
 <Y9ORbi8hz7o5ek7W@smile.fi.intel.com>
 <CACRpkdaFZxbZ4Sw0-PKyP5s7nPDYiSjNuJC_EdPiEiORZrQnEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaFZxbZ4Sw0-PKyP5s7nPDYiSjNuJC_EdPiEiORZrQnEw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:10:11AM +0100, Linus Walleij wrote:
> On Fri, Jan 27, 2023 at 9:55 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Jan 26, 2023 at 09:02:30PM +0100, Linus Walleij wrote:
> > > On Fri, Jan 20, 2023 at 4:44 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks for all your reviews!
> >
> > But I think you are a bit late with them as Greg applied the series like
> > a couple of days ago.
> 
> Yeah he's so quick and I'm so slow...
> But these days we record the mail thread link to lore in the
> commit so I can still share the blame ;)

Right, what I meant is not diminish your efforts, but to say that
they won't make Git history.

-- 
With Best Regards,
Andy Shevchenko


