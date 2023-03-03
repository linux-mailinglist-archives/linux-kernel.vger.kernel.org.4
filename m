Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842F96A9A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCCPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCCPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:20:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631935599;
        Fri,  3 Mar 2023 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677856810; x=1709392810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jxfoKhZctFeAgg5bNNOJh9ngGIHvIiP4e7+MeSFwFSM=;
  b=mWfuHW6K1rdysvJmRj/OyaRfz1NsC1cipkvrjTE+pA4R1wA9UBXeWYKm
   3r40VmbA1u9WDqGW7yXrkr71L0z1DArp82ljswCh7J0L42Z3TlKprG4j/
   RakwhK+e47eUGU3FoYnJRfFFvnfFx6oU/hNErq+f55zg6HdInkshxrORC
   NnT+agJJ6dwQQUh2YHsiVtaVtTxMnjVMYfsgUw/fv+QnIgLGmFRavNJGO
   VeZvI8vn2L+iAUcpXm67dJx7QJhDUVfRc2fVlqoG7vNJwd8VO8qDEDyh1
   wGKVvIQ3uw8zLHJ9RtpoRnwKzGBoJApOYdNiRSdIOv+B8tTdvQBJd7Eh2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="421336278"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="421336278"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="764457624"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="764457624"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by FMSMGA003.fm.intel.com with SMTP; 03 Mar 2023 07:19:40 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 03 Mar 2023 17:19:40 +0200
Date:   Fri, 3 Mar 2023 17:19:40 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
Message-ID: <ZAIQDBD+HPbQA5sr@intel.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com>
 <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
 <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
 <ZAILc/fxzBqLv1OF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAILc/fxzBqLv1OF@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 05:00:03PM +0200, Ville Syrjälä wrote:
> On Fri, Mar 03, 2023 at 06:48:43AM -0800, Rob Clark wrote:
> > On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
> > <tvrtko.ursulin@linux.intel.com> wrote:
> > >
> > >
> > > On 03/03/2023 03:21, Rodrigo Vivi wrote:
> > > > On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> > > >> From: Rob Clark <robdclark@chromium.org>
> > > >>
> > > >
> > > > missing some wording here...
> > > >
> > > >> v2: rebase
> > > >>
> > > >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > >> ---
> > > >>   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> > > >>   1 file changed, 20 insertions(+)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> > > >> index 7503dcb9043b..44491e7e214c 100644
> > > >> --- a/drivers/gpu/drm/i915/i915_request.c
> > > >> +++ b/drivers/gpu/drm/i915/i915_request.c
> > > >> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
> > > >>      return i915_request_enable_breadcrumb(to_request(fence));
> > > >>   }
> > > >>
> > > >> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> > > >> +{
> > > >> +    struct i915_request *rq = to_request(fence);
> > > >> +
> > > >> +    if (i915_request_completed(rq))
> > > >> +            return;
> > > >> +
> > > >> +    if (i915_request_started(rq))
> > > >> +            return;
> > > >
> > > > why do we skip the boost if already started?
> > > > don't we want to boost the freq anyway?
> > >
> > > I'd wager Rob is just copying the current i915 wait boost logic.
> > 
> > Yup, and probably incorrectly.. Matt reported fewer boosts/sec
> > compared to your RFC, this could be the bug
> 
> I don't think i915 calls drm_atomic_helper_wait_for_fences()
> so that could explain something.

Oh, I guess this wasn't even supposed to take over the current 
display boost stuff since you didn't remove the old one.

The current one just boosts after a missed vblank. The deadline
could use your timer approach I suppose and boost already a bit
earlier in the hopes of not missing the vblank.

-- 
Ville Syrjälä
Intel
