Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8196FE840
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjEJX6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJX6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:58:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3B30F7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683763080; x=1715299080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b7OXDhtJsKpRqFAjND/S27zC3L6XHF4gIoyXuuhGfDQ=;
  b=BUlycJzksMC5k0xWU2t9oshUvh7PLqA6CcYeRWMR7Nvd8Wckyz3gkaC6
   yTqBr/lQjoiFyG8ht2VWcEUun5sBMJK9fpJldy5+r4LVpZvFY+TCVCiCq
   aajjvfKwpxS05VVRH7y3+BQk1vThBCjd9yguZKJKQzk8JoYbZLqudas52
   ujZ7CeMg9aTM9qqEiLNDzS6N1y6mTQ1qMgi74zruEDMW90jkvSCpUbwDU
   GIk3dnE2xAKSJ5LtElzcrK6W1/YmSqGZzy0cdhFxPSdhXhAuX3dGueJY2
   OWF5B35JxAU7wfkxsA1/02BV1u9tpQdUC/+4HWlp9dZ4qysRMotfrmDZL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="334821811"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="334821811"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 16:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843699597"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="843699597"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2023 16:57:59 -0700
Date:   Wed, 10 May 2023 17:00:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230511000058.GD18514@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:44:49PM -0400, Radu Rendec wrote:
> On Wed, 2023-05-10 at 12:12 -0700, Ricardo Neri wrote:
> > On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> > > This patch gives architecture specific code the ability to initialize
> > > the cache level and allocate cacheinfo memory early, when cache level
> > > initialization runs on the primary CPU for all possible CPUs.
> [cut]
> > > -int detect_cache_attributes(unsigned int cpu)
> > > +static inline int init_level_allocate_ci(unsigned int cpu)
> > >  {
> > > -       int ret;
> > > +       unsigned int early_leaves = cache_leaves(cpu);
> > >  
> > >         /* Since early initialization/allocation of the cacheinfo is allowed
> > >          * via fetch_cache_info() and this also gets called as CPU hotplug
> > >          * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
> > >          * as it will happen only once (the cacheinfo memory is never freed).
> > > -        * Just populate the cacheinfo.
> > > +        * Just populate the cacheinfo. However, if the cacheinfo has been
> > > +        * allocated early through the arch-specific early_cache_level() call,
> > > +        * there is a chance the info is wrong (this can happen on arm64). In
> > > +        * that case, call init_cache_level() anyway to give the arch-specific
> > > +        * code a chance to make things right.
> > >          */
> > > -       if (per_cpu_cacheinfo(cpu))
> > > -               goto populate_leaves;
> > > +       if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
> > > +               return 0;
> > >  
> > >         if (init_cache_level(cpu) || !cache_leaves(cpu))
> > >                 return -ENOENT;
> > >  
> > > -       ret = allocate_cache_info(cpu);
> > > +       /*
> > > +        * Now that we have properly initialized the cache level info, make
> > > +        * sure we don't try to do that again the next time we are called
> > > +        * (e.g. as CPU hotplug callbacks).
> > > +        */
> > > +       ci_cacheinfo(cpu)->early_ci_levels = false;
> > > +
> > > +       if (cache_leaves(cpu) <= early_leaves)
> > > +               return 0;
> > > +
> > 
> > I had posted a patchset[1] for x86 that initializes
> > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > 
> > This means that early_leaves and a late cache_leaves() are equal but
> > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > fetch_cache_info().
> > 
> > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > take care of the case in which early and late cache leaves remain the same:
> > 
> > -       if (cache_leaves(cpu) <= early_leaves)
> > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > 
> > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > last_level_cache_is_valid().
> > 
> > I can post a patch with this fix if it makes sense.
> > 
> > [1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.neri-calderon@linux.intel.com/
> 
> Hi Ricardo,

Thank you very much for your quick reply!

> 
> Thanks for bringing this to my attention. I need to run some tests on
> x86 (I did all that work/testing on arm64) and wrap my head around it.
> 
> While I don't see any problem with the fix you're proposing, I'm afraid
> it may circle back to the other problem I tried to fix initially. Have
> you tested this on an RT kernel by any chance?

That is a good point. I did not test on an RT kernel. I'll try that.

> 
> I'm thinking that if we end up in init_level_allocate_ci() without the
> cacheinfo memory having been allocated earlier, we're up for a "BUG"
> splat on RT kernels.
> 
> If early_leaves has the right value at that point, the cacheinfo memory
> should be allocated early (on the primary CPU), so perhaps there's a
> different problem somewhere else.

That can work for x86, IMO. Not sure about other archs. As you mention,
other archs still want the chance to correct the early cache info.

> 
> I'll get back to you as soon as I look at this in more detail but I
> just wanted to give you a quick heads-up.

Thanks!
