Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84270A1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjESVlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:41:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3661B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684532494; x=1716068494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YAFT8fMrl0VSOoxAls3ESDXviySfbeFgHcFQlHgN72Q=;
  b=nt9KyCSarmE7/O39oeIVlYjVZbl41o/vEZU+OzTN4Qkvo5eB9VbmNll4
   VUL7Y4YWNYjsQFJ+QWItCs95mFVaTn6sfLUqPHQYhJ9c7BqBFRF9cyhos
   lvs74LwP1AO5XIe2cHvLEOKKxOU70nXb6LnHOoy1hmQvefmsvbVr6QxLm
   Vlnz9BkmMSmesSieKeBxpIl4CHOX4FdeFwEyIqHihTXr9e9zVSQSftHIW
   FdlRdxTwtFO1c1ATAnftOP8Yw4O0m0TzX63TjjfEZEBioRcnZFaYJ0X8I
   ry0ym9qGZfXmrAJzof1r8KBNFVfemhIEL1KZJBHjs7ebLZS0q0SJ5TW5g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="341938792"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="341938792"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 14:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="814876993"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="814876993"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2023 14:41:32 -0700
Date:   Fri, 19 May 2023 14:44:30 -0700
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
Message-ID: <20230519214430.GA3116@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <b49e241d3ea8c679b81134e22c908ca64aeca18c.camel@redhat.com>
 <20230511000058.GD18514@ranerica-svr.sc.intel.com>
 <9020807789b70db0d84d142cbfed2bd8868f366a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9020807789b70db0d84d142cbfed2bd8868f366a.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 03:55:18PM -0400, Radu Rendec wrote:
> On Wed, 2023-05-10 at 17:00 -0700, Ricardo Neri wrote:
> > On Wed, May 10, 2023 at 04:44:49PM -0400, Radu Rendec wrote:
> > > On Wed, 2023-05-10 at 12:12 -0700, Ricardo Neri wrote:
> > > > On Wed, Apr 12, 2023 at 02:57:57PM -0400, Radu Rendec wrote:
> > > > > This patch gives architecture specific code the ability to initialize
> > > > > the cache level and allocate cacheinfo memory early, when cache level
> > > > > initialization runs on the primary CPU for all possible CPUs.
> > > [cut]
> > > > > -int detect_cache_attributes(unsigned int cpu)
> > > > > +static inline int init_level_allocate_ci(unsigned int cpu)
> > > > >  {
> > > > > -       int ret;
> > > > > +       unsigned int early_leaves = cache_leaves(cpu);
> > > > >  
> > > > >         /* Since early initialization/allocation of the cacheinfo is allowed
> > > > >          * via fetch_cache_info() and this also gets called as CPU hotplug
> > > > >          * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
> > > > >          * as it will happen only once (the cacheinfo memory is never freed).
> > > > > -        * Just populate the cacheinfo.
> > > > > +        * Just populate the cacheinfo. However, if the cacheinfo has been
> > > > > +        * allocated early through the arch-specific early_cache_level() call,
> > > > > +        * there is a chance the info is wrong (this can happen on arm64). In
> > > > > +        * that case, call init_cache_level() anyway to give the arch-specific
> > > > > +        * code a chance to make things right.
> > > > >          */
> > > > > -       if (per_cpu_cacheinfo(cpu))
> > > > > -               goto populate_leaves;
> > > > > +       if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
> > > > > +               return 0;
> > > > >  
> > > > >         if (init_cache_level(cpu) || !cache_leaves(cpu))
> > > > >                 return -ENOENT;
> > > > >  
> > > > > -       ret = allocate_cache_info(cpu);
> > > > > +       /*
> > > > > +        * Now that we have properly initialized the cache level info, make
> > > > > +        * sure we don't try to do that again the next time we are called
> > > > > +        * (e.g. as CPU hotplug callbacks).
> > > > > +        */
> > > > > +       ci_cacheinfo(cpu)->early_ci_levels = false;
> > > > > +
> > > > > +       if (cache_leaves(cpu) <= early_leaves)
> > > > > +               return 0;
> > > > > +
> > > > 
> > > > I had posted a patchset[1] for x86 that initializes
> > > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > > > 
> > > > This means that early_leaves and a late cache_leaves() are equal but
> > > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > > > fetch_cache_info().
> > > > 
> > > > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > > > take care of the case in which early and late cache leaves remain the same:
> > > > 
> > > > -       if (cache_leaves(cpu) <= early_leaves)
> > > > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > > > 
> > > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > > > last_level_cache_is_valid().
> > > > 
> > > > I can post a patch with this fix if it makes sense.
> > > > 
> > > > [1]. https://lore.kernel.org/all/20230424001956.21434-3-ricardo.neri-calderon@linux.intel.com/
> > > 
> > > Thanks for bringing this to my attention. I need to run some tests on
> > > x86 (I did all that work/testing on arm64) and wrap my head around it.
> > > 
> > > While I don't see any problem with the fix you're proposing, I'm afraid
> > > it may circle back to the other problem I tried to fix initially. Have
> > > you tested this on an RT kernel by any chance?
> > 
> > That is a good point. I did not test on an RT kernel. I'll try that.
> 
> It looks like the flow is much simpler on x86: detect_cache_attributes()
> is called only once for each CPU, and it's called in kthread context.
> 
> I haven't tested on an RT kernel but I think it should be fine. I put a
> msleep() there and saw no issues, which means kmalloc() on RT should be
> fine as well.

I booted the realtime kernel [3] with CONFIG_PREEMPT_RT and did not observe
the BUG splat. I tried before your patchset. Were you able to reproduce on
x86? Also, I was not able to reproduce the BUG splat after your changes +
[1] + my earlier suggested patch in this thread.

> 
> > > I'm thinking that if we end up in init_level_allocate_ci() without the
> > > cacheinfo memory having been allocated earlier, we're up for a "BUG"
> > > splat on RT kernels.
> > > 
> > > If early_leaves has the right value at that point, the cacheinfo memory
> > > should be allocated early (on the primary CPU), so perhaps there's a
> > > different problem somewhere else.
> > 
> > That can work for x86, IMO. Not sure about other archs. As you mention,
> > other archs still want the chance to correct the early cache info.
> 
> You're right. I got confused for a moment because I was used to the
> arm64 flow. On x86, there is no "early" cache info per se because, as I
> already mentioned, detect_cache_attributes() is called only once for
> each CPU.

Indeed.

> 
> I was intrigued about how this worked without your changes, and I
> looked closer. Between the initialization of the early_leaves variable
> at the beginning of init_level_allocate_ci() and the comparison of
> cache_leaves(cpu) and early_leaves, init_cache_level() gets called.
> Before your changes, (struct cpu_cacheinfo).num_leaves was initialized
> to 0 and then changed in init_cache_level(). That way, early_leaves
> ended up as 0, which made the comparison evaluate to false.

Yes my changes aim to use (struct cpu_cacheinfo).num_leaves directly.

> 
> At this point I think the patch you proposed is the right way to fix
> this. I don't see any reason why it would interfere with other archs
> that really use early allocation. This new patch should probably be
> added to your series, since otherwise your other patches would
> basically "introduce" a null-pointer deref.
> 
> My only suggestion would be to add a short comment before the
> comparison, to explain that on x86 detect_cache_attributes() is called
> only once for each CPU and so early allocation is not possible but
> (struct cpu_cacheinfo).num_leaves is already initialized by the time
> detect_cache_attributes() is called.

Thank you very much for your help!

BR,
Ricardo
