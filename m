Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E263C4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiK2QVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2QVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:21:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CBCC2;
        Tue, 29 Nov 2022 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669738906; x=1701274906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JeBtJMXrRl19Xe+AbxNLnPJPEyfS8wbk+W2gbNYchuk=;
  b=THJJwDgtTswErvphdN3sxrCL7AbKH5g0a9cace8V8Pyhk7b/Mf42p3fV
   7tcemEbBRunNgDnKAoroY95hw8+8WZlRGFoMqLF1eHwp7ynm4+N9EkPdP
   nPtslxtzQGXLm7OCgQcQG/fmUs9N9cOwhBxa70X8izhy7tdLwSlUoV6/7
   OWgdJ+oC2OZCaF3T/AFdANXI/iP7hqytzWz1/ydnb0FOfoHKpA2JFO+d7
   jnjRxZ4H5Gwz6zHacK66Zfkn/p8nBQHKTjHAf99uKbCJmSRn2oDNr2YLh
   5yIGNDqxK/QL1BqBJXneMW9r4hxO34mEDQwHenI3bN7KWCK/NzDlleBPP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315183928"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315183928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 08:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786093704"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="786093704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2022 08:21:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p03MO-001mWX-13;
        Tue, 29 Nov 2022 18:21:28 +0200
Date:   Tue, 29 Nov 2022 18:21:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: Introduce gpio_device_get() and
 gpio_device_put()
Message-ID: <Y4YxiHISfSs8crRa@smile.fi.intel.com>
References: <20221125181158.67265-1-andriy.shevchenko@linux.intel.com>
 <20221125181158.67265-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf14Q7_gMXaK+hZ8PdV2U5GiL97QRc3SGKLPqmEuSyDxA@mail.gmail.com>
 <Y4YbkUX+bTM5ZEGg@smile.fi.intel.com>
 <CAMRc=MfAJpcvCj+NZcg554XC07VYXAb2p9vb+fq6x_O4j+trjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfAJpcvCj+NZcg554XC07VYXAb2p9vb+fq6x_O4j+trjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:49:34PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 29, 2022 at 3:47 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Nov 29, 2022 at 02:54:10PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Nov 25, 2022 at 7:11 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Introduce gpio_device_get() and gpio_device_put() helpers
> > > > and convert existing users.
> >
> > > This doesn't apply to my for-next branch, can you rebase and resend
> > > (just this one, the other is applied).
> >
> > The problem is that you don't merge or cherry-pick fixes into your
> > for-next branch and they are getting diverged.
> >
> > In PDx86 subsystem we decided to cherry-pick the fixes into for-next.
> > Some other subsystems are doing back-merges (but I remember that Linus
> > T. complained about back merges, although I dunno if it's still
> > the case). Some subsystems merges their fixes into for-next, dunno
> > if it's the best practice either.
> >
> > That said, this can be submitted after v6.2-rc1 is out.
> 
> I do merge tags if I need to. Normally you'd mention any requirements
> for the series in the cover letter.

It's my fault. But thanks for clarifying the process.

> I have not sent any fixes so far in this release cycle BTW.

Yes, that's now obvious...

-- 
With Best Regards,
Andy Shevchenko


