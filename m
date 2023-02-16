Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA33F69A21C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBPXKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPXKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:10:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA637F20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:09:58 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB13A66021BB;
        Thu, 16 Feb 2023 23:09:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676588997;
        bh=eJ31KjQvfQ1OAUYYt2ngpiSKt3yk0pd1vQYJrvXlQMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drPUZkvM1cTe3zfqASEwhAq9wlIuEQsSzLLIfL5qT2oxH/SQ0Bfrei/mCstanGeLK
         cJYU0TNIFgJXWmHPvm/YbM2Xx8LuaVWuFguMhmQ4jPpbXPdEF2dTdyxXX8vt5glsgX
         lP6ejH5vqDDT9UnIqfdc+1FM+4mUaJxwurG6EOLNUFp4omIvej9iH0O8EFdxXaacvP
         cMw4nvB7aZxGViBHxO7H0hYMt7qD8puLPMM06aPp4AFI81rqZBXNi9wkZDasbLHh4u
         SlbU0kG/t+5g49Y6kgzqsudtvkg85pDbcHy6O/NcpNhXqd25D9uYm9F1LFZjCd+iPc
         OGL8CFg4/kTkQ==
Date:   Thu, 16 Feb 2023 18:09:46 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: Drop device lock before
 drm_helper_hpd_irq_event()
Message-ID: <20230216230946.g3ojtx7na3smogbx@notapiano>
References: <20230116072234.3970768-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116072234.3970768-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 16, 2023 at 03:22:34PM +0800, Chen-Yu Tsai wrote:
> The device lock is used to serialize the low level power sequencing
> operations. Since drm_helper_hpd_irq_event() could end up calling
> .atomic_enable, which also calls power sequencing functions through
> runtime PM, this results in a real deadlock. This was observed on an
> MT8192-based Chromebook's external display (with appropriate patches [1]
> and DT changes applied).
> 
> Move the drm_helper_hpd_irq_event() call outside of the lock range. The
> lock only needs to be held so that the device status can be read back.
> This is the bare minimum change to avoid the deadlock. The lock could
> be dropped completely and have pm_runtime_get_if_in_use() increase the
> reference count, but this is not the same as pm_runtime_suspended().
> This also causes the internal display of the same device to not
> function correctly. Both the internal and external display of said
> device each use one anx7625 bridge.
> 
> [1] https://lore.kernel.org/dri-devel/20230112042104.4107253-1-treapking@chromium.org/
> 
> Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> FWIW I'm aware that this driver could be refactored a lot better.
> The work function might be simplified and merged into the threaded
> interrupt handler. The .detect op should be reading the HPD state
> from the hardware, not some cached state.
> 
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 7e1fb93a6ce4..bf1770b79bba 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1597,18 +1597,17 @@ static void anx7625_work_func(struct work_struct *work)
>  
>  	mutex_lock(&ctx->lock);
>  
> -	if (pm_runtime_suspended(&ctx->client->dev))
> -		goto unlock;
> +	if (pm_runtime_suspended(&ctx->client->dev)) {
> +		mutex_unlock(&ctx->lock);
> +		return;
> +	}
>  
>  	event = anx7625_hpd_change_detect(ctx);
> -	if (event < 0)

Are you intentionally dropping this early-return on error?

> -		goto unlock;
> +
> +	mutex_unlock(&ctx->lock);
>  
>  	if (ctx->bridge_attached)
>  		drm_helper_hpd_irq_event(ctx->bridge.dev);
> -
> -unlock:
> -	mutex_unlock(&ctx->lock);
>  }
>  
>  static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
