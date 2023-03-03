Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AC6A9B32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjCCPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCCPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:52:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F6EFBA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677858728; x=1709394728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lsRjo7yTXyKCofFwzcN0jbA0ArTfH/fumplb/rfEDjk=;
  b=d8JDpKdzfQkFLHouzaqxLRot9sroMjcM95SIE1kq+o02cTRQ/JObU9fJ
   6D2M9VsrWdAPLY+IXbEJ9xTlD32hn83OnZMBcUbOWjZzDv4pQdzX65Z1O
   MatLcl7QoJ9sKsUBeP+Gqv6ZLoBNi3qpjyuQrYCM0+UqlMkH5yRbN3lSj
   SslPDKIMy/Yb+XMQRc/dkWHZp2H/aEqkvqzYLe7BnmPQKsT+HtOGnlgDU
   OaWxtVY2yXBs78AnIQ6FcmEITC62Ei9bYHFPHmYz6LPD+IEmO5IDrMpgt
   mISRjP+Ujz3nH3AvlPAfKeklF/7P0jP/4uZUK3AdJEcmL8PFQJtnb0EnX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="318896434"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="318896434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818509745"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="818509745"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga001.fm.intel.com with SMTP; 03 Mar 2023 07:52:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 03 Mar 2023 17:52:02 +0200
Date:   Fri, 3 Mar 2023 17:52:02 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v9 11/15] drm/atomic-helper: Set fence deadline for vblank
Message-ID: <ZAIXonf7orksoFhb@intel.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-12-robdclark@gmail.com>
 <ZAIOaiogeUhhNVfo@intel.com>
 <CAF6AEGuL+B6sR2=7MFvqT0zfsgraoOdzAJBF=Ke1ce1umYh4Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGuL+B6sR2=7MFvqT0zfsgraoOdzAJBF=Ke1ce1umYh4Xw@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:45:05AM -0800, Rob Clark wrote:
> On Fri, Mar 3, 2023 at 7:12 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 03:53:33PM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> > > the next vblank time, and inform the fence(s) of that deadline.
> > >
> > > v2: Comment typo fix (danvet)
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index d579fd8f7cb8..d8ee98ce2fc5 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -1511,6 +1511,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> > >  }
> > >  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> > >
> > > +/*
> > > + * For atomic updates which touch just a single CRTC, calculate the time of the
> > > + * next vblank, and inform all the fences of the deadline.
> > > + */
> > > +static void set_fence_deadline(struct drm_device *dev,
> > > +                            struct drm_atomic_state *state)
> > > +{
> > > +     struct drm_crtc *crtc, *wait_crtc = NULL;
> > > +     struct drm_crtc_state *new_crtc_state;
> > > +     struct drm_plane *plane;
> > > +     struct drm_plane_state *new_plane_state;
> > > +     ktime_t vbltime;
> > > +     int i;
> > > +
> > > +     for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> > > +             if (wait_crtc)
> > > +                     return;
> > > +             wait_crtc = crtc;
> > > +     }
> > > +
> > > +     /* If no CRTCs updated, then nothing to do: */
> > > +     if (!wait_crtc)
> > > +             return;
> >
> > Is there an actual point in limiting this to single crtc updates?
> > That immediately excludes tiled displays/etc.
> >
> > Handling an arbitrary number of crtcs shouldn't really be a lot
> > more complicated should it?
> 
> I guess I could find the soonest upcoming vblank of all the CRTCs and
> use that as the deadline?

Yeah, that seems reasonable. The flips are supposed to happen
atomically (if possible) anyway so collapsing the thing to
a single deadline for all makes sense to me.

-- 
Ville Syrjälä
Intel
