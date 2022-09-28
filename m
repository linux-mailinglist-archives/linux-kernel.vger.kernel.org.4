Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459995EE0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiI1PkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiI1Pjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:39:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD1DF08;
        Wed, 28 Sep 2022 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379589; x=1695915589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAUIZLpTyj/ZX3LEvzVPZ1liL0Ds5mnTQ9SqqagZXCE=;
  b=UGKm1mAKrZyjDd214srsFAQq+JXeHs5QWC5s2p06xHmKq3KzD5/IFEL8
   /YcqIdp+IcbkUOnfvV2R39oFn9vV2gxgP7WgwtciU3zlgMd2D04u5nEY/
   eQp9gPfcK2ppoU5+rxSTLDG/0+i18c0NBbDCTTHiVYSbLSMRUthXvic9v
   hqMD6PA+M7krwWIKAB9KqqXyG2CT3rtMonq9bqfjPyk7yhpeFYPtMRgzq
   7WkdHgo61vLMgmm3KdUH2aF7FYq0HQNoNHTJpuVaOQfK3DMq093bI40L4
   fSPq03Ic+znACAa4vytxziUlvHrjecsLepMwPTsU8vjqRySBOw5lRT6aL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="328002839"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="328002839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="617250617"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="617250617"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2022 08:39:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odZA2-0090AC-05;
        Wed, 28 Sep 2022 18:39:46 +0300
Date:   Wed, 28 Sep 2022 18:39:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Replace sprintf() with sysfs_emit()
Message-ID: <YzRqwUJeZjxCaDrF@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-3-andriy.shevchenko@linux.intel.com>
 <YzQ9+Wzhfnila1s3@orome>
 <YzRO0xrzlrHAYdaI@smile.fi.intel.com>
 <YzRS+VIBK1AiysEN@smile.fi.intel.com>
 <YzRmJ3mBKf+cvy5T@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRmJ3mBKf+cvy5T@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:20:07PM +0200, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 04:58:17PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 28, 2022 at 04:40:35PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 28, 2022 at 02:28:41PM +0200, Thierry Reding wrote:
> > > > On Fri, Aug 26, 2022 at 08:07:15PM +0300, Andy Shevchenko wrote:
> > > > > For sysfs outputs, it's safer to use a new helper, sysfs_emit(),
> > > > > instead of the raw sprintf() & co. This patch replaces such a
> > > > > sprintf() call straightforwardly with the new helper.
> > > 
> > > > How exactly is sysfs_emit() safer here? In all of these cases, the
> > > > values that sprintf() writes are the only values that are written into
> > > > the buffer and we know that none of them exceed PAGE_SIZE. So the
> > > > additional checks that sysfs_emit() performs are useless.
> > > 
> > > This is a recommended way to use sysfs_emit() mentioned in Documentation.
> > > Care to fix documentation?
> > 
> > For your convenience, Documentation/filesystems/sysfs.rst says:
> > 
> > - show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> >   the value to be returned to user space.
> 
> Took some digging to find enough information to convince me. Again, the
> commit message says that sysfs_emit() is safer, but that's a bad reason
> in this case because these cases are fine. The sprintf() calls that this
> replaces aren't unbound and we're not appending to an existing seq_buf,
> so nothing to worry on that front.
> 
> I think the better argument for broadly applying this is to specifically
> distinguish the sysfs sprintf() calls from others so that they can be
> auditioned better and perhaps help with the documentation[0].
> 
> Do you mind if I apply this with a reworded documentation?

I do not mind, go ahead with it.
Thank you!

> Thierry
> 
> [0]: https://lore.kernel.org/all/20200930115740.GA1611809@kroah.com/

-- 
With Best Regards,
Andy Shevchenko


