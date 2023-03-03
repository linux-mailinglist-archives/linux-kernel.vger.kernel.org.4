Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662846A9A52
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjCCPMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCCPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:12:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D323663
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677856368; x=1709392368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kv/2u+AxnRb6ByO4K+QjwzwQ655JUAxB5Rp+xDVDXyA=;
  b=B3tmRgQEOYhjHNspW13KiLKict6EAXXXED7Tq0kmqKpD4PyMxmpOL4WJ
   39NnIaZ+YeMis35ITpWWHu0Jacmr1AtTcvugYtSWwKahkPGmdoC0Hd/kL
   1evId58NQVmFx5nFGuOESdCtRDYncrU8Oxse6FMO0BDnBV9UBylSMvDQj
   ksBYEFluiYkat7k9XgS3jH7nsv5ASthRzb+Ym3wXSf9t7Lo+CNIfGKboI
   oerEefeU8cK/lsGNKooiaXmBIGRQI1g7to9l01yaWQc3Dsn7xRgpKTs2O
   oOUxgD9QnFZMOfGnigT/ukwmWY10WvcgP0FN9yBf1eiaDGRj6ffE5t7HH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="323358311"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="323358311"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="744274704"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="744274704"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga004.fm.intel.com with SMTP; 03 Mar 2023 07:12:43 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 03 Mar 2023 17:12:42 +0200
Date:   Fri, 3 Mar 2023 17:12:42 +0200
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
Message-ID: <ZAIOaiogeUhhNVfo@intel.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
 <20230302235356.3148279-12-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302235356.3148279-12-robdclark@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:53:33PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> the next vblank time, and inform the fence(s) of that deadline.
> 
> v2: Comment typo fix (danvet)
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index d579fd8f7cb8..d8ee98ce2fc5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1511,6 +1511,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
>  
> +/*
> + * For atomic updates which touch just a single CRTC, calculate the time of the
> + * next vblank, and inform all the fences of the deadline.
> + */
> +static void set_fence_deadline(struct drm_device *dev,
> +			       struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc, *wait_crtc = NULL;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_plane *plane;
> +	struct drm_plane_state *new_plane_state;
> +	ktime_t vbltime;
> +	int i;
> +
> +	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> +		if (wait_crtc)
> +			return;
> +		wait_crtc = crtc;
> +	}
> +
> +	/* If no CRTCs updated, then nothing to do: */
> +	if (!wait_crtc)
> +		return;

Is there an actual point in limiting this to single crtc updates?
That immediately excludes tiled displays/etc.

Handling an arbitrary number of crtcs shouldn't really be a lot
more complicated should it?

> +
> +	if (drm_crtc_next_vblank_start(wait_crtc, &vbltime))
> +		return;
> +
> +	for_each_new_plane_in_state (state, plane, new_plane_state, i) {
> +		if (!new_plane_state->fence)
> +			continue;
> +		dma_fence_set_deadline(new_plane_state->fence, vbltime);
> +	}
> +}
> +
>  /**
>   * drm_atomic_helper_wait_for_fences - wait for fences stashed in plane state
>   * @dev: DRM device
> @@ -1540,6 +1574,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
>  	struct drm_plane_state *new_plane_state;
>  	int i, ret;
>  
> +	set_fence_deadline(dev, state);
> +
>  	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
>  		if (!new_plane_state->fence)
>  			continue;
> -- 
> 2.39.1

-- 
Ville Syrjälä
Intel
