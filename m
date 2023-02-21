Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4769E9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjBUVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBUVsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:48:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506515CAB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677016090; x=1708552090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4HDSVe2cjaHzxh13lU3SRWv0R26BXpO/dpA9ELNQQ3c=;
  b=VxvVBy3QtOCtqbvSpwtEqAQ/mnfSgeiuGdOmyNPsdFHcxWbYKzOTNAOi
   TljuVPJWPVXISBHVpdzHtYbdWc9uZFVWSv/ullcEsbGc5puESVbQ3pSZz
   Ry4O+4gt3r/UiGksrUhSOOPUxpBizKBedz/f24iqXTudtOGtnrBPHw4ZP
   UPCcJWVY2hHFLV25inaVrTf5JMChah5Jcl+UR/uLDBCDFvtJ7lSOAuiQP
   g7+RtDinrlXMt2GktwybxEvsP2sGBqsqRm3uMfT6rBe4WrEMGNog6G7eV
   +NQ3KF0hJSHkcMgNAaKTFNZ0PCway3EVr3YK4v+mCmIhjtebNAUgdm52K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332765046"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="332765046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 13:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="702165082"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="702165082"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by orsmga008.jf.intel.com with SMTP; 21 Feb 2023 13:48:06 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 21 Feb 2023 23:48:05 +0200
Date:   Tue, 21 Feb 2023 23:48:05 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
Message-ID: <Y/U8FcU4SXsJu1/q@intel.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
 <20230218211608.1630586-11-robdclark@gmail.com>
 <20230220110820.595cfa37@eldfell>
 <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
 <20230221104551.60d44d1c@eldfell>
 <Y/TAr64SpxO712RB@intel.com>
 <CAJs_Fx7n3QrzusdX5yD=39YZ8MzjuwZTriWz8hVxNYGHO=sJ_Q@mail.gmail.com>
 <Y/U6HKD2hbH4Sx1G@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/U6HKD2hbH4Sx1G@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 11:39:40PM +0200, Ville Syrj�l� wrote:
> On Tue, Feb 21, 2023 at 11:54:55AM -0800, Rob Clark wrote:
> > On Tue, Feb 21, 2023 at 5:01 AM Ville Syrj�l�
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Tue, Feb 21, 2023 at 10:45:51AM +0200, Pekka Paalanen wrote:
> > > > On Mon, 20 Feb 2023 07:55:41 -0800
> > > > Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > > On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, 18 Feb 2023 13:15:53 -0800
> > > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > > >
> > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > >
> > > > > > > Will be used in the next commit to set a deadline on fences that an
> > > > > > > atomic update is waiting on.
> > > > > > >
> > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++++
> > > > > > >  include/drm/drm_vblank.h     |  1 +
> > > > > > >  2 files changed, 33 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > > > > > > index 2ff31717a3de..caf25ebb34c5 100644
> > > > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > > > > > >
> > > > > > > +/**
> > > > > > > + * drm_crtc_next_vblank_time - calculate the time of the next vblank
> > > > > > > + * @crtc: the crtc for which to calculate next vblank time
> > > > > > > + * @vblanktime: pointer to time to receive the next vblank timestamp.
> > > > > > > + *
> > > > > > > + * Calculate the expected time of the next vblank based on time of previous
> > > > > > > + * vblank and frame duration
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > for VRR this targets the highest frame rate possible for the current
> > > > > > VRR mode, right?
> > > > > >
> > > > >
> > > > > It is based on vblank->framedur_ns which is in turn based on
> > > > > mode->crtc_clock.  Presumably for VRR that ends up being a maximum?
> > > >
> > > > I don't know. :-)
> > >
> > > At least for i915 this will give you the maximum frame
> > > duration.
> > >
> > > Also this does not calculate the the start of vblank, it
> > > calculates the start of active video.
> > 
> > AFAIU, vsync_end/vsync_start are in units of line, so I could do something like:
> > 
> >   vsync_lines = vblank->hwmode.vsync_end - vblank->hwmode.vsync_start;
> >   vsyncdur = ns_to_ktime(vblank->linedur_ns * vsync_lines);
> >   framedur = ns_to_ktime(vblank->framedur_ns);
> >   *vblanktime = ktime_add(*vblanktime, ktime_sub(framedur, vsyncdur));
> 
> Something like this should work:
>  vblank_start = framedur_ns * crtc_vblank_start / crtc_vtotal
>  deadline = vblanktime + vblank_start
> 
> That would be the expected time when the next start of vblank
> happens.

Except that drm_vblank_count_and_time() will give you the last
sampled timestamp, which may be long ago in the past. Would
need to add an _accurate version of that if we want to be
guaranteed a fresh sample.

-- 
Ville Syrj�l�
Intel
