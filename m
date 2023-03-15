Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF426BB5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjCOOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjCOONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:13:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A382A21BD;
        Wed, 15 Mar 2023 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678889606; x=1710425606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vDg6EYzYD0Xn/6ZgNP53WjBSQBlxhKFptOilwPqjoiE=;
  b=WBqhTJ+caGM9VbJOMi7mPnZnVhYcI/uyHeKYAFZe6pBXJka0Dk4S/iWl
   xf0seBS6w2+WZDBsdwgEFcuY00hV1FzWqV2DIurq7avSld3bd3hWQLqiX
   4SLiuhxwpzQvVQPMd5XHvhwwqYGDRD946pXl91wZU41mW3DCLVsM9HMLC
   mSMH0BjBGQGsRlW/W5cDIu4FLhp6XzPTQY00nv+TtRZK1nQRtv99t4xhP
   PFMQKH4WjNEX5R6rTt0TpRkDSanQZGrj1yGz0bntarY1CiUn+vQaHDEdd
   FTQhaLHjuUoWY8/sOp3H+yRQ8P2AAokhIWJo4mqACRFGR9/qWDMNtXWmc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340075235"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340075235"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="803313745"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="803313745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2023 07:13:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pcRsB-003rV3-2Y;
        Wed, 15 Mar 2023 16:12:59 +0200
Date:   Wed, 15 Mar 2023 16:12:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        maxime@cerno.tech, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZBHSa3CU7zGI7qCX@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
 <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
 <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
 <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:51:26PM +0200, Matti Vaittinen wrote:
> On 3/13/23 15:59, Matti Vaittinen wrote:
> > On 3/13/23 15:29, Andy Shevchenko wrote:
> > > On Mon, Mar 13, 2023 at 03:11:52PM +0200, Matti Vaittinen wrote:
> > > > On 3/13/23 14:40, Andy Shevchenko wrote:
> > > > > On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
> > > > > > On Sun, 12 Mar 2023 17:06:38 +0000
> > > > > > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > > > > Ah. I forgot the tests that don't have a device so can't use devm.
> > > > > 
> > > > > Why not? I have seen, IIRC, test cases inside the kernel
> > > > > that fakes the device
> > > > > for that.
> > > > 
> > > > I'd appreciated any pointer for such an example if you have one
> > > > at hand. (I
> > > > can do the digging if you don't though!)
> > > > 
> > > > I am not a fan of unit tests. They add huge amount of inertia to
> > > > development, and in worst case, they stop people from contributing where
> > > > improving a feature requires test code modification(s). And
> > > > harder the test
> > > > code is to understand, worse the unwanted side-effects. Also, harder the
> > > > test code is to read, more time and effort it requires to analyze a test
> > > > failure... Hence, I am _very_ conservative what comes to adding
> > > > size of test
> > > > code with anything that is not strictly required.
> > > > 
> > > > After that being said, unit tests are a great tool when
> > > > carefully used - and
> > > > I assume/hope stubbing a device for devm_ tests does not add
> > > > much extra...
> > > > But let me see if I can find an example :)
> > > 
> > > drivers/gpu/drm/tests/drm_managed_test.c ?
> > > 
> > > (somewhere underneath:
> > > 
> > >   ret = platform_driver_register(&fake_platform_driver);
> > > 
> > > which suggests... what exactly? :-)
> 
> Thanks to pointer from Andy I found the
> drm_kunit_helper_[alloc/free]_device() functions. I renamed them to
> test_kunit_helper_[alloc/free]_device(), move them to drivers/base, add
> declarations to include/kunit/test-helpers.h fixed KConfigs and existing
> callers + added the tests for managed interfaces. I have this in place in my
> personal playground where I am working towards the v4 of the series.
> 
> ...
> 
> After that I asked from Maxime if he had a reason to not make those generic
> and available to other subsystems besides drm in the first place...
> 
> And Maxime was kind enough to point me to the fact that something like this
> was done in the CCF context:
> https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
> 
> I like the 'single function to get the dummy device which can be passed to
> devm'-approach used in drm helpers. I do also like Stephen's idea of having
> the prototypes in kunit/platform_device.h which matches the
> linux/platform_device.h.
> 
> However, I don't know when Stephen's work will be finished and merged to
> IIO-tree so that it could be used/extended for the needs of these tests.
> 
> Meanwhile, I don't think it makes sense to go forward with my changes
> splitting the helpers out of drm until we see what Stephen's changes will
> bring us. On the other hand, I don't like delaying the gts-helpers or the
> sensor drivers.
> 
> So, any suggestions what I should do? I see following options:
> 
> 1) Drop the tests for managed interfaces for now.
> 2) Add the tests with a yet-another duplicate implementation of the
>    dummy device for devm.
> 3) Add the tests using the helpers from drm as they are now.
> 
> option 1):
> I like it as it would be an easy way (for now) - but I hate it as it may be
> a hard way as well. In my experience, when a driver/helper lands upstream it
> will get first few fixes quite fast - and not having a test available
> upstream when this happens is bad. Bad because it means the out-of-tree test
> may get broken, and bad because there is no easy way to test the fixes.
> 
> option 2):
> I hate it because it makes the test code more complex - and duplicates the
> kernel code which is never nice. This could be reworked later when Stephens
> work is done though.
> 
> option 3):
> It's in general not nice to use functions exported for some other
> subsystem's specific purposes. This would however keep the test code at
> minimum, while leaving the same "I swear I'll fix this later when
> dependencies have settled" - possibility as option 2) did.
> 
> Oh, in theory there is option 4) to just send out the changes I did(*) which
> pull the drm_kunit_helper_[alloc/free]_device() out of the DRM - but I guess
> that would lead some extra work to merge this later with stuff Stephen's
> series does introduce.
> 
> Any suggestions which of the options to proceed with?
> 
> (*) For those interested in seeing the result of pulling the
> drm_kunit_helper_[alloc/free]_device() out of DRM tests, below are links to
> my personal playground with following remarks:
> 1) code one finds from there may be 100% untested
> 2) code one finds there may be written just for fun, or for a very
>    specific purpose
> 3) code one finds there is generally not maintained, may be rebased, may
>    vanish or turn into rabbits or turn you into a rabbit when you wear a
>    top hat.
> 
> commits to look at there are
> https://github.com/M-Vaittinen/linux/commit/15d07e799f7c7fddc91030b16266d4a8bbaf1cc1
> https://github.com/M-Vaittinen/linux/commit/6b4c4ba38b1f838fb0074befd2ca8734604464da

My opinion on that, you should not depend on the others work if they are slow.
It might take ages for them to finish and upstream that. Why should you wait?

OTOH you may inform them with your patches that may have a chance to land before
theirs. It might motivate them to speed up their work and coordinate the outcome
that all stakeholders will be happy.

That said, I would choose option 4), i.e. provide a series where you decouple
thingy from DRM and Cc to Stephen with a cover letter note that explains why
you chosen this way and what alternatives you are open to.

-- 
With Best Regards,
Andy Shevchenko


