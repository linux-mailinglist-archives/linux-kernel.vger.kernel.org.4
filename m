Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF55F48B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJDRjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJDRid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:38:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB89FE6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664905112; x=1696441112;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=q6EpAzeaREMD6X3gyCf0BKwJue0LMO9WqhXpb/0sZyA=;
  b=FpnFHVc7o4kirI/MeYWBLIoSqCmkkh+HD0ddzYx8DTfPOKzHIvhLtR0y
   ZxwPwIhG1kIovvNeeZyJWG5UFDNhVMZsNkXoGcLUDwa7/dyttK3w83PzJ
   rWsVoFVep+tZIUv4zVWdu5Ypw2qyP0snycGuLQyc1pMcQg+nZdFxpCLmP
   C6Y+l7VEmxJx1rgsEicVgvuwEZ/BN1o9Z3DSYkQ0eV6jePcU9VqBFpG8R
   Gqwk2FIFWbZN+qw2CKqJqqs9mO6Kgz5pTa+ma3rGGE1/FGinRbkrDyrYg
   2H7vZbNzao//qsIqMRuRj5ZriPswv9gF80BpX8iiw52pfB1taJRmU1yoJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="301698183"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="301698183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 10:38:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="657211821"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="657211821"
Received: from pvarla-mobl4.gar.corp.intel.com (HELO localhost) ([10.252.39.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 10:38:27 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pablo Ceballos <pceballos@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Pablo Ceballos <pceballos@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display/lspcon: Increase LSPCON mode settle
 timeout
In-Reply-To: <20220915004601.320198-1-pceballos@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220915004601.320198-1-pceballos@google.com>
Date:   Tue, 04 Oct 2022 20:38:24 +0300
Message-ID: <87ilkzsd4f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022, Pablo Ceballos <pceballos@google.com> wrote:
> On some devices the Parade PS175 takes more than 400ms to settle in PCON
> mode.

Got any bug report with more info, or any other details to back this up?
This is kind of thin. What's the 800 ms based on?

BR,
Jani.


>
> Signed-off-by: Pablo Ceballos <pceballos@google.com>
> ---
>  drivers/gpu/drm/i915/display/intel_lspcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
> index 15d59de8810e..b4cbade13ee5 100644
> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
> @@ -166,7 +166,7 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
>  	drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
>  		    lspcon_mode_name(mode));
>  
> -	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
> +	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 800);
>  	if (current_mode != mode)
>  		drm_err(&i915->drm, "LSPCON mode hasn't settled\n");

-- 
Jani Nikula, Intel Open Source Graphics Center
