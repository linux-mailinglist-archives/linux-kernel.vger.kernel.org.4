Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6D70DD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEWN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjEWN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:26:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB811A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684848398; x=1716384398;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mlzsDVTQ49ZT9Ot+UB3j8Va0JllC8yQ20xKDPFFUyu0=;
  b=aaR+XTjFDtlQuSKDfNHwoq/O+x1dKQiJC4zjSFaiAcWVWbok63CLwybi
   /6H4syiWaUePyQAquaQFif1htGU/i18exiIeQyRVjc/ZHQuks/uFkBkn8
   gis/rm+XyvyjVYo32HDvSBpIq1877t9ZBzPSx7u3Et7U8hnVS4jv0YN/d
   Pzcxf23WX/ZO5p14DFPrybvF1Ke9HjONxGDXrhSL+X+xGtWmubzM1pciW
   CVwjseVNLT9KtkcMQer8uXwXFnjelZigBCkohP59+3ewAzIlEElcCcRAU
   fJFyenEj1WmBy65kz5AoJ9SdWqO+xyrRUx2Uyg9in1dYYHybWwgCGM5LK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342693227"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="342693227"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878204268"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="878204268"
Received: from chauvina-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.70])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:26:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tom Rix <trix@redhat.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, ville.syrjala@linux.intel.com,
        imre.deak@intel.com, arun.r.murthy@intel.com,
        lucas.demarchi@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] drm/i915: simplify switch to if-elseif
In-Reply-To: <20230523125116.1669057-1-trix@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230523125116.1669057-1-trix@redhat.com>
Date:   Tue, 23 May 2023 16:26:29 +0300
Message-ID: <874jo3kwl6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 23 May 2023, Tom Rix <trix@redhat.com> wrote:
> clang with W=1 reports
> drivers/gpu/drm/i915/display/intel_display.c:6012:3: error: unannotated
>   fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>                 case I915_FORMAT_MOD_X_TILED:
>                 ^
>
> Only one case and the default does anything in this switch, so it should
> be changed to an if-elseif.

Thanks for the patch.

If I wanted to fix this quickly, I'd just add the break in there.

If I wanted to fix this properly, I'd add a function
modifier_supports_async_flips() or something, and replace the switch
with:

	if (!modifier_supports_async_flips(i915, new_plane_state->hw.fb->modifier)) {
		drm_dbg_kms(&i915->drm, "[PLANE:%d:%s] Modifier does not support async flips\n",
			plane->base.base.id, plane->base.name);
		return -EINVAL;
	}

But I wouldn't just replace the switch with if-elseif. It doesn't help
with the overall feeling that intel_async_flip_check_hw() is too long.

BR,
Jani.


>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 0490c6412ab5..1f852e49fc20 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -5994,8 +5994,7 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
>  		 * Need to verify this for all gen9 platforms to enable
>  		 * this selectively if required.
>  		 */
> -		switch (new_plane_state->hw.fb->modifier) {
> -		case DRM_FORMAT_MOD_LINEAR:
> +		if (new_plane_state->hw.fb->modifier == DRM_FORMAT_MOD_LINEAR) {
>  			/*
>  			 * FIXME: Async on Linear buffer is supported on ICL as
>  			 * but with additional alignment and fbc restrictions
> @@ -6008,13 +6007,10 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
>  					    plane->base.base.id, plane->base.name);
>  				return -EINVAL;
>  			}
> -
> -		case I915_FORMAT_MOD_X_TILED:
> -		case I915_FORMAT_MOD_Y_TILED:
> -		case I915_FORMAT_MOD_Yf_TILED:
> -		case I915_FORMAT_MOD_4_TILED:
> -			break;
> -		default:
> +		} else if (!(new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_X_TILED ||
> +			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_Y_TILED ||
> +			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_Yf_TILED ||
> +			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_4_TILED)) {
>  			drm_dbg_kms(&i915->drm,
>  				    "[PLANE:%d:%s] Modifier does not support async flips\n",
>  				    plane->base.base.id, plane->base.name);

-- 
Jani Nikula, Intel Open Source Graphics Center
