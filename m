Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69C73D930
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFZIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFZIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:09:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1EBE74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687766982; x=1719302982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+lr7gWkrUK24BQPjHF38fYVzI+XtiPSL5/A2F9B/bVc=;
  b=nPWDQ7/Zm0DBqqcv3crUARjCwlKAitfjzGQHBUvpwnUhzpuaGqfkNROv
   DjZn2ikVhckSHTo899HhU8zqO76Kith7dvFw8kxWBIpOfoSUhuIdir7wb
   lBoIhsIK3y+Ep7wDA5OZQpKA7O9VuDpqzql9HflWLWz7oSQBjqrnQ2qsf
   evdE44zC5pRFloDxj/dtfd4KFmHCwcSsOLWOjekYNYxkwdQ/vUhkU9yPG
   vhMTNiPJWNO+8YEFOIDuyyfnBeeTEljYZS+ajgNPrc7aNEtsgO8S/h0d8
   Ni0j7AqD6xf3Yjg0AKMD4YTmDbeyfpuok6fS/AxELZKwehl7q+FkYEjB1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447588949"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447588949"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860596455"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860596455"
Received: from csteeb-mobl2.ger.corp.intel.com (HELO intel.com) ([10.251.217.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:09:24 -0700
Date:   Mon, 26 Jun 2023 10:09:15 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] i915: avoid unused-but-set-variable warning
Message-ID: <ZJlHq30vUxVuv/Qh@ashyti-mobl2.lan>
References: <20230622101848.3482277-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622101848.3482277-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jun 22, 2023 at 12:18:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mchbar_addr variable is only used inside of an #ifdef:
> 
> drivers/gpu/drm/i915/soc/intel_gmch.c:41:6: error: variable 'mchbar_addr' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Change this to an IS_ENABLED() check to let the compiler see how
> it's used and no longer warn about it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/soc/intel_gmch.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/soc/intel_gmch.c b/drivers/gpu/drm/i915/soc/intel_gmch.c
> index 6d0204942f7a5..49c7fb16e934f 100644
> --- a/drivers/gpu/drm/i915/soc/intel_gmch.c
> +++ b/drivers/gpu/drm/i915/soc/intel_gmch.c
> @@ -47,11 +47,9 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
>  	mchbar_addr = ((u64)temp_hi << 32) | temp_lo;
>  
>  	/* If ACPI doesn't have it, assume we need to allocate it ourselves */
> -#ifdef CONFIG_PNP
> -	if (mchbar_addr &&
> +	if (IS_ENABLED(CONFIG_PNP) && mchbar_addr &&
>  	    pnp_range_reserved(mchbar_addr, mchbar_addr + MCHBAR_SIZE))
>  		return 0;
> -#endif

you actually already sent this same patch[*] and I did push it in
drm-intel-next.

Andi

[*] https://patchwork.freedesktop.org/patch/542054/

>  
>  	/* Get some space for it */
>  	i915->gmch.mch_res.name = "i915 MCHBAR";
> -- 
> 2.39.2
