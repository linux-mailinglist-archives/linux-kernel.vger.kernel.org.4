Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F020736FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjFTPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjFTPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:04:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7731BF1;
        Tue, 20 Jun 2023 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687273444; x=1718809444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ivrsLAv5ei2pZb4Fe2LCuh5oh+6GLbCVwN4d6QsS9D8=;
  b=Ls+OE77fthsZ7s/JXh7RdhQD3L6XDslz042uflQhqPqtvD021cTH2Z3H
   BCVUet9v/HzWkHj2+g4W23VDSrch38e8iVY+kLSK7RmdwXLdb/yM8U6DF
   9KbozY016ZC1OwFEn9d3HWD0F8PVjjUZYRVjldX7TL6lSJP5aSJ9yppu2
   p/hqFtajuzq898WvqJ13+fDWJNaLc/bhGb3HYv0pJtkhXqMnlrvbqz+Nl
   Yta5ATv7vUDj48Uc0tlJRe4KT3e0Shp6zvI0K3uh2FhWNbMBsl1sVmEVs
   nvSlsYYh3wRCqZOjpa4Na1yRYyYfDdtwBrJOJCrPSe43/G0KO/bvrQrqV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="423546437"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="423546437"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 08:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708309489"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="708309489"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 08:03:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBct4-005Had-02;
        Tue, 20 Jun 2023 18:03:18 +0300
Date:   Tue, 20 Jun 2023 18:03:17 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] pktcdvd: Use clamp_val() instead of min()+max()
Message-ID: <ZJG/tfh7kKauoMZJ@smile.fi.intel.com>
References: <20230616142614.36206-1-andriy.shevchenko@linux.intel.com>
 <9258be5d31104805b63bb1a64317a448@AcuMS.aculab.com>
 <ZJGooPbZQq6G2BjI@smile.fi.intel.com>
 <cd039ed4855c4e78a0867c4b5173e879@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd039ed4855c4e78a0867c4b5173e879@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:35:11PM +0000, David Laight wrote:
> From: 'Andy Shevchenko'
> > Sent: 20 June 2023 14:25
> > On Tue, Jun 20, 2023 at 12:06:49PM +0000, David Laight wrote:

...

> > > > +		*hi = clamp_val(*hi, 500, 1000000);
> > >
> > > (standard rant about minmax.h)
> > >
> > > clamp_val() is pretty much broken by design.
> > > It MIGHT be ok here but it casts both limits to the
> > > type of the value being compared.
> > > In general that is just plain wrong.
> > >
> > > Like min_t() it is generally ok because the kernel only uses
> > > unsigned values between 0 and MAXINT.
> > >
> > > If min/max were ok, then using clamp() should also be ok.
> > 
> > Submit a patch to fix it, if you think you can make it better.
> > Obviously your comment can be addressed separately if we even
> > need that.
> 
> Did you try using clamp() ?
> 
> To see why clamp_val() is broken consider?
> 	unsigned char val = 200;
> 	...
> 	xxx = clamp_val(val, 10, 300);
>  
> This sets xxx to 44 - not exactly expected.

Right, clamp_val() has to be improved.
However this is not the case in this driver.

I have just sent a v2 with clamp().

-- 
With Best Regards,
Andy Shevchenko


