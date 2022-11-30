Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6463D3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiK3K6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiK3K6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:58:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FC240A9;
        Wed, 30 Nov 2022 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669805926; x=1701341926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/9FVSCZq4+TCgRUGOAmNJp/Xjr2BQ5w3SCgXfYNnK0=;
  b=PZrnxH3J6xdGa7qDklrPdtVu0uuChBtEZOS8MvOdW0VKaYKZICP8Y57G
   edkvQ/8s2Vi/s/433GjNokMVkeUSbrpoFH3DltluZgz1KGBmDrJuYttul
   4lk9sZsVKwZXsSaK4tUxnkhXPuHRj03nn2AIb8iHRqCROsSixywV76qJD
   crOHkYHHjLxQubqQCeKbG8aVb0DCzxLkTmm51DHf357NIFzU9vBg1pwf3
   IVzn7hVegunxezL35TSfce50h7CI1bLLurmqnKFLNQk1sWSI8HdAeKsnV
   tJvG6M/nJgaOZTVV57qq6mmHHYeoiu0UMrCXTlGBFtwKrAqG6F8AbZTt1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="314059732"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="314059732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 02:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="707603264"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707603264"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 02:58:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Knb-002DuO-34;
        Wed, 30 Nov 2022 12:58:43 +0200
Date:   Wed, 30 Nov 2022 12:58:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <Y4c3YwZqFGhJZN1L@smile.fi.intel.com>
References: <20221130131854.35b58b16@canb.auug.org.au>
 <Y4c11VtMQ64W1U+i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4c11VtMQ64W1U+i@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:52:05AM +0100, Greg KH wrote:
> On Wed, Nov 30, 2022 at 01:18:54PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > drivers/xen/unpopulated-alloc.c:17:21: error: 'list_count' redeclared as different kind of symbol
> >    17 | static unsigned int list_count;
> >       |                     ^~~~~~~~~~
> > In file included from include/linux/preempt.h:11,
> >                  from include/linux/spinlock.h:56,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:7,
> >                  from drivers/xen/unpopulated-alloc.c:3:
> > include/linux/list.h:662:22: note: previous definition of 'list_count' with type 'size_t(struct list_head *)' {aka 'long unsigned int(struct list_head *)'}
> >   662 | static inline size_t list_count(struct list_head *head)
> >       |                      ^~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   a9efc04cfd05 ("i915: Move list_count() to list.h for broader use")
> > 
> > I have used the usb tree from next-20221129 for today.
> 
> Odd, there is also one in the z2ram.c code but that isn't breaking :(
> 
> Andy, I'm going to revert this series from the USB tree now, please fix
> it up and resend.

Sure. I think I will rename in my series list_count() to list_count_nodes().
This will be less invasive and should solve the issue(s).

$ git grep -n -lw list_count
drivers/block/z2ram.c
drivers/gpu/drm/i915/gt/intel_engine_cs.c
drivers/scsi/hptiop.c
drivers/scsi/hptiop.h
drivers/xen/unpopulated-alloc.c

$ git grep -n -lw list_count_nodes

-- 
With Best Regards,
Andy Shevchenko


