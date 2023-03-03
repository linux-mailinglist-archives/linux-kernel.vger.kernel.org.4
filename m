Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BFA6A9A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCCPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCCPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:00:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD715F6C0;
        Fri,  3 Mar 2023 07:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677855611; x=1709391611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aNNHDRDvXG9ASjCgwJ85IwtaQ6OKdjosypIMBKJPjJ8=;
  b=WRQ68Xo5ixpBVa1bdI5ojlznhfv+Go118DWeW8ngj5kxgxJ+18pWj+g/
   T/4COXJSdBp/IWI4SghyXF4oYhQ77kwHjjVf2j9ndcSaCCf/3nqKDDPlw
   ikKcGqbkEbbmXHkB7B+KijBlkA9gv7AV5qr+Q7d5zna5McgBb+PkWyZAm
   OOktNwRmiiKnJ7K2vIHqDXQOMMIUqFUrkhfTbnv10D5cul0ljNTGCluAk
   QfUsm+jvnL/ACQcbAkmr4v7rlDyJ8BSSEdCwuLMfk5Hoss2seJX9j+KSQ
   XEacsXz0tJOC0B1eZV9WwVKKaSSnA9wV0MCBX0a2myYs31+Plr7x2500Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315458451"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="315458451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818495316"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="818495316"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga001.fm.intel.com with SMTP; 03 Mar 2023 07:00:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 03 Mar 2023 17:00:03 +0200
Date:   Fri, 3 Mar 2023 17:00:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Matt Turner <mattst88@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v9 15/15] drm/i915: Add deadline based boost support
Message-ID: <ZAILc/fxzBqLv1OF@intel.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-16-robdclark@gmail.com>
 <ZAFnqbycMleLmRe9@intel.com>
 <3bded9d7-9796-4a9b-7c11-aac994d4fdc6@linux.intel.com>
 <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGs6QYTESuwB8E9cTbv9LqQX16tz6-geeu9BCyFos9=sOA@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 06:48:43AM -0800, Rob Clark wrote:
> On Fri, Mar 3, 2023 at 1:58 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
> >
> >
> > On 03/03/2023 03:21, Rodrigo Vivi wrote:
> > > On Thu, Mar 02, 2023 at 03:53:37PM -0800, Rob Clark wrote:
> > >> From: Rob Clark <robdclark@chromium.org>
> > >>
> > >
> > > missing some wording here...
> > >
> > >> v2: rebase
> > >>
> > >> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >> ---
> > >>   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
> > >>   1 file changed, 20 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> > >> index 7503dcb9043b..44491e7e214c 100644
> > >> --- a/drivers/gpu/drm/i915/i915_request.c
> > >> +++ b/drivers/gpu/drm/i915/i915_request.c
> > >> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
> > >>      return i915_request_enable_breadcrumb(to_request(fence));
> > >>   }
> > >>
> > >> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> > >> +{
> > >> +    struct i915_request *rq = to_request(fence);
> > >> +
> > >> +    if (i915_request_completed(rq))
> > >> +            return;
> > >> +
> > >> +    if (i915_request_started(rq))
> > >> +            return;
> > >
> > > why do we skip the boost if already started?
> > > don't we want to boost the freq anyway?
> >
> > I'd wager Rob is just copying the current i915 wait boost logic.
> 
> Yup, and probably incorrectly.. Matt reported fewer boosts/sec
> compared to your RFC, this could be the bug

I don't think i915 calls drm_atomic_helper_wait_for_fences()
so that could explain something.

-- 
Ville Syrjälä
Intel
