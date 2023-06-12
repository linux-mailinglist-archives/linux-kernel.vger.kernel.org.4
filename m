Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99D72C61B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbjFLNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbjFLNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:36:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0610A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E30BA61562
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F1AC433D2;
        Mon, 12 Jun 2023 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686576946;
        bh=qAGctGPmTEGb8Q322023xH/8ic4A2qSPM1FKoiXCBSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvDxDyruXr+m7Nhq2DHbE0eMq5Bv0/Vs2UIxhO1PWnbg0RpNbROQQ5QB/y1lEB1nt
         ZL1O4J8dEmi33KST4wq8FgbUVFfzUMR6n3Z3R1GTC4IyWFW00ncK7P51eA08JXQPze
         Zp4+Te3auFeleRBfNrA0AX+fzfh1CHJ3EsEq6/Wt0UQfsyFPxI3bpRPyCW8dShDV4v
         AOWIm/TJhAPQ4S9N56JhjTxGWe71+OEYKlxPdyW2zPQCcAcgtjnx6CZUQqOXsD/dJb
         IoMN2TehnUo8DvHbJvllWjDXLgB252JvWBVLkyeBVog4bKehA2aflV1oxP5+W+PYH1
         tk1qIdNsos5hA==
Date:   Mon, 12 Jun 2023 15:35:42 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gmch: avoid unused variable warning
Message-ID: <20230612133542.knm4edwlk2nhfboj@intel.intel>
References: <20230612124408.521325-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612124408.521325-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 12, 2023 at 02:43:59PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PNP is disabled, the mchbar_addr variable is only written but
> not read:
> 
> drivers/gpu/drm/i915/soc/intel_gmch.c: In function 'intel_alloc_mchbar_resource':
> drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: error: variable 'mchbar_addr' set but not used [-Werror=unused-but-set-variable]
>    41 |         u64 mchbar_addr;
>       |             ^~~~~~~~~~~
> 
> No idea why this showed up now, but it's easy to fix by changing the #ifdef to
> an IS_ENABLED() check that the compiler can see through.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

> ---
> I saw this last week already, so it's likely that someone else already sent
> a fix for it.
> 
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
>  
>  	/* Get some space for it */
>  	i915->gmch.mch_res.name = "i915 MCHBAR";
> -- 
> 2.39.2
> 
