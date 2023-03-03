Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F196A95EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCCLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCLV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:21:27 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2131422E;
        Fri,  3 Mar 2023 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677842486; x=1709378486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIS4YXxfvhSvuWWlxBQDqx765nVMX13XptcoF4Uarg8=;
  b=SBYipsW9h6oVdBvnIeqvZX9/K5Q33wJfcshEEIiUSs3Xswdpjj/+kt5X
   Tx9o+kd/HWXSstAOkycdOCchZM8B/PBOqt+ymoEgK2WYN1N0IywdN3C+B
   O4ga0t2hDlE7Xcmnwu5Kiwfbvi67Z6i0vwzgUt1fACANIoFGxWxziShkc
   ldRyGGo1U9uFa7bw5UgS0dohR6j5HY1kVrc5aah03NsbvxSxwtfzTzOcr
   tiZQREkbc3p+KBEYuOCrSeZ3dyf4t+zOM4jLHiYxE9/cce/go+pKMjKhr
   TUukwHTuMRZEeQtqtP61cMOlhxZUfCCsl2Sb93mVAxia7Bms/EkdwQJlh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421293856"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="421293856"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 03:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="799204882"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="799204882"
Received: from mavainol-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.57.100])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 03:21:20 -0800
Date:   Fri, 3 Mar 2023 12:21:17 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        intel-gfx@lists.freedesktop.org,
        Christian =?iso-8859-15?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-15?Q?D=E4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Intel-gfx] [PATCH v9 15/15] drm/i915: Add deadline based boost
 support
Message-ID: <ZAHYLUAf2e4PyRdT@ashyti-mobl2.lan>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com>
 <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:58:36AM +0000, Tvrtko Ursulin wrote:
> 
> On 03/03/2023 03:21, Rodrigo Vivi wrote:
> > On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > > 
> > 
> > missing some wording here...
> > 
> > > v2: rebase
> > > 
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> > > index 7503dcb9043b..44491e7e214c 100644
> > > --- a/drivers/gpu/drm/i915/i915_request.c
> > > +++ b/drivers/gpu/drm/i915/i915_request.c
> > > @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
> > >   	return i915_request_enable_breadcrumb(to_request(fence));
> > >   }
> > > +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> > > +{
> > > +	struct i915_request *rq = to_request(fence);
> > > +
> > > +	if (i915_request_completed(rq))
> > > +		return;
> > > +
> > > +	if (i915_request_started(rq))
> > > +		return;
> > 
> > why do we skip the boost if already started?
> > don't we want to boost the freq anyway?
> 
> I'd wager Rob is just copying the current i915 wait boost logic.
> 
> > > +
> > > +	/*
> > > +	 * TODO something more clever for deadlines that are in the
> > > +	 * future.  I think probably track the nearest deadline in
> > > +	 * rq->timeline and set timer to trigger boost accordingly?
> > > +	 */
> > 
> > I'm afraid it will be very hard to find some heuristics of what's
> > late enough for the boost no?
> > I mean, how early to boost the freq on an upcoming deadline for the
> > timer?
> 
> We can off load this patch from Rob and deal with it separately, or after
> the fact?
> 
> It's a half solution without a smarter scheduler too. Like https://lore.kernel.org/all/20210208105236.28498-10-chris@chris-wilson.co.uk/,
> or if GuC plans to do something like that at any point.

Indeed, we already have the deadline implementation (and not just
that), we just need to have some willingness to apply it.

Andi

> Or bump the priority too if deadline is looming?
> 
> IMO it is not very effective to fiddle with the heuristic on an ad-hoc
> basis. For instance I have a new heuristics which improves the problematic
> OpenCL cases for further 5% (relative to the current waitboost improvement
> from adding missing syncobj waitboost). But I can't really test properly for
> regressions over platforms, stacks, workloads.. :(
> 
> Regards,
> 
> Tvrtko
> 
> > 
> > > +
> > > +	intel_rps_boost(rq);
> > > +}
> > > +
> > >   static signed long i915_fence_wait(struct dma_fence *fence,
> > >   				   bool interruptible,
> > >   				   signed long timeout)
> > > @@ -182,6 +201,7 @@ const struct dma_fence_ops i915_fence_ops = {
> > >   	.signaled = i915_fence_signaled,
> > >   	.wait = i915_fence_wait,
> > >   	.release = i915_fence_release,
> > > +	.set_deadline = i915_fence_set_deadline,
> > >   };
> > >   static void irq_execute_cb(struct irq_work *wrk)
> > > -- 
> > > 2.39.1
> > > 
