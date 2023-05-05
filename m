Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49A6F84DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjEEO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjEEO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E021992
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5D363AB9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:29:26 +0000 (UTC)
Received: from rdvivi-mobl4 (unknown [192.55.54.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDEC433D2;
        Fri,  5 May 2023 14:29:22 +0000 (UTC)
Date:   Fri, 5 May 2023 10:29:20 -0400
From:   Rodrigo Vivi <rodrigo.vivi@kernel.org>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/i915/dp: prevent potential div-by-zero
Message-ID: <ZFUSwEVKF5S8LF3A@rdvivi-mobl4>
References: <20230418140430.69902-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418140430.69902-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:04:30AM -0700, Nikita Zhandarovich wrote:
> drm_dp_dsc_sink_max_slice_count() may return 0 if something goes
> wrong on the part of the DSC sink and its DPCD register. This null
> value may be later used as a divisor in intel_dsc_compute_params(),
> which will lead to an error.
> In the unlikely event that this issue occurs, fix it by testing the
> return value of drm_dp_dsc_sink_max_slice_count() against zero.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: a4a157777c80 ("drm/i915/dp: Compute DSC pipe config in atomic check")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

and pushed.

Thanks for the patch and sorry for the delay.

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 62cbab7402e9..c1825f8f885c 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -1533,6 +1533,11 @@ int intel_dp_dsc_compute_config(struct intel_dp *intel_dp,
>  		pipe_config->dsc.slice_count =
>  			drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
>  							true);
> +		if (!pipe_config->dsc.slice_count) {
> +			drm_dbg_kms(&dev_priv->drm, "Unsupported Slice Count %d\n",
> +				    pipe_config->dsc.slice_count);
> +			return -EINVAL;
> +		}
>  	} else {
>  		u16 dsc_max_output_bpp = 0;
>  		u8 dsc_dp_slice_count;
> -- 
> 2.25.1
> 
