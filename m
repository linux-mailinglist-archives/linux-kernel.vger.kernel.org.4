Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A236B9BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCNQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCNQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:41:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DFD32B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678812086; x=1710348086;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Kavj2ZC1tyLBPrTUaz3HxM6qfeVURMkk0MyVlbxYicg=;
  b=THoyKBy975J0oUXlHFT6/h5x4hc2cJsQXvX5ShBWqAevukEVvnAOAL1O
   cXTbRLow1f0vWwqM9yDAxAVxviEMgpxvqbRTfI5wjlxEPgEQvvjSkudch
   5GMIMHOlt9NO2S7mRdJgneod8aX0coYEe6/BJLOPOP8SB3sx00uFlxfKs
   W2eWAfj61hRzQF8Af3s7cvP/hKmzaXHSJ/aEVPdM3tWSH5jVZcFghYhKw
   7czzrWUpLTP6Wto4NuU/IL3DkbujVafhDaiTxPHCV9G+amT8sjWhQOQS3
   QSB7Yni8Vwt62NDgab6YSN6g6OZEven0LejQTGaU2Fkm1uHzfLhHaCQrl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="402345866"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="402345866"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768163491"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768163491"
Received: from ideak-desk.fi.intel.com ([10.237.72.58])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:41:22 -0700
Date:   Tue, 14 Mar 2023 18:41:18 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/opregion: add missing intel_opregion_cleanup()
 dummy
Message-ID: <ZBCjrsFd7PkWnBm/@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20230314162523.631652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314162523.631652-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 05:25:18PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When ACPI is disabled, i915 fails to build because of a missing
> declaration:

Hi Arnd,

thanks for catching this, I sent the same after the lkp note about the
build failure:

https://lore.kernel.org/intel-gfx/3238742c-0c57-b8cf-11fe-fd4a57979049@linux.intel.com/T/#me164308b49e975efb8d760e07a5ec9f4489916b9

--Imre

> 
> drivers/gpu/drm/i915/i915_driver.c: In function 'i915_driver_hw_probe':
> drivers/gpu/drm/i915/i915_driver.c:556:9: error: implicit declaration of function 'intel_opregion_cleanup'; did you mean 'intel_opregion_setup'? [-Werror=implicit-function-declaration]
>   556 |         intel_opregion_cleanup(dev_priv);
> 
> Add another empty dummy helper next to intel_opregion_setup().
> 
> Fixes: 3e226e4a2180 ("drm/i915/opregion: Cleanup opregion after errors during driver loading")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/display/intel_opregion.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_opregion.h b/drivers/gpu/drm/i915/display/intel_opregion.h
> index 181eb3e9abbf..fd2ea8ef0fa2 100644
> --- a/drivers/gpu/drm/i915/display/intel_opregion.h
> +++ b/drivers/gpu/drm/i915/display/intel_opregion.h
> @@ -86,6 +86,10 @@ static inline int intel_opregion_setup(struct drm_i915_private *dev_priv)
>  	return 0;
>  }
>  
> +static inline void intel_opregion_cleanup(struct drm_i915_private *i915)
> +{
> +}
> +
>  static inline void intel_opregion_register(struct drm_i915_private *dev_priv)
>  {
>  }
> -- 
> 2.39.2
> 
