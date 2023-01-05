Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A265F091
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjAEPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjAEPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:52:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E491B9E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672933935; x=1704469935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07rEmud9u3v4yR1dxZqrmwXHFiO37KqMuantmUAu7Fw=;
  b=fBgJwvVavrCZOmYXQzkyrD33Zbw2yRs5RakNXc99lE1WK/zGfWN8rucJ
   piQ9xvtyk9/b0KqcVu5N8RN4S4hI8x0bQy3VNVy2Wv/fDwJ0QlqHJE+Xr
   RVocggmj6P33lwjV8DJ8b3BnQoctjaQuXwnkbk4AQuYqgpTwb9ubahPJR
   9P266KylCmCSi8U8CxalI2TssfI5q3eoLIGR5a7swF8WeiRG9qFJa2Pv9
   45GPJVoDPkfZHJ4pTw6zpp9ci9F2Twv8b/7QLlQk7R5VmIlSPnePGG5Cs
   acura4e+/s08d5CMHwobiJHpnlg/XEXlgSWU9GxfCtCJtfVC8i+71Lyl2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349453825"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="349453825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:52:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655622313"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="655622313"
Received: from dgomm-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.43.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:52:08 -0800
Date:   Thu, 5 Jan 2023 16:52:05 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        katrinzhou <katrinzhou@tencent.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        "open list:INTEL DRM DRIVERS" <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Fix potential context UAFs
Message-ID: <Y7byJa9VZyKO2gnT@ashyti-mobl2.lan>
References: <20230103234948.1218393-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103234948.1218393-1-robdclark@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jan 03, 2023 at 03:49:46PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> gem_context_register() makes the context visible to userspace, and which
> point a separate thread can trigger the I915_GEM_CONTEXT_DESTROY ioctl.
> So we need to ensure that nothing uses the ctx ptr after this.  And we
> need to ensure that adding the ctx to the xarray is the *last* thing
> that gem_context_register() does with the ctx pointer.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

I also agree with Tvrtko that we should add Stable: and Fixes:.

One little thing, "user after free" is clearer that UAF :)

Thanks,
Andi

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 24 +++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 7f2831efc798..6250de9b9196 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1688,6 +1688,10 @@ void i915_gem_init__contexts(struct drm_i915_private *i915)
>  	init_contexts(&i915->gem.contexts);
>  }
>  
> +/*
> + * Note that this implicitly consumes the ctx reference, by placing
> + * the ctx in the context_xa.
> + */
>  static void gem_context_register(struct i915_gem_context *ctx,
>  				 struct drm_i915_file_private *fpriv,
>  				 u32 id)
> @@ -1703,10 +1707,6 @@ static void gem_context_register(struct i915_gem_context *ctx,
>  	snprintf(ctx->name, sizeof(ctx->name), "%s[%d]",
>  		 current->comm, pid_nr(ctx->pid));
>  
> -	/* And finally expose ourselves to userspace via the idr */
> -	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
> -	WARN_ON(old);
> -
>  	spin_lock(&ctx->client->ctx_lock);
>  	list_add_tail_rcu(&ctx->client_link, &ctx->client->ctx_list);
>  	spin_unlock(&ctx->client->ctx_lock);
> @@ -1714,6 +1714,10 @@ static void gem_context_register(struct i915_gem_context *ctx,
>  	spin_lock(&i915->gem.contexts.lock);
>  	list_add_tail(&ctx->link, &i915->gem.contexts.list);
>  	spin_unlock(&i915->gem.contexts.lock);
> +
> +	/* And finally expose ourselves to userspace via the idr */
> +	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
> +	WARN_ON(old);
>  }
>  
>  int i915_gem_context_open(struct drm_i915_private *i915,
> @@ -2199,14 +2203,22 @@ finalize_create_context_locked(struct drm_i915_file_private *file_priv,
>  	if (IS_ERR(ctx))
>  		return ctx;
>  
> +	/*
> +	 * One for the xarray and one for the caller.  We need to grab
> +	 * the reference *prior* to making the ctx visble to userspace
> +	 * in gem_context_register(), as at any point after that
> +	 * userspace can try to race us with another thread destroying
> +	 * the context under our feet.
> +	 */
> +	i915_gem_context_get(ctx);
> +
>  	gem_context_register(ctx, file_priv, id);
>  
>  	old = xa_erase(&file_priv->proto_context_xa, id);
>  	GEM_BUG_ON(old != pc);
>  	proto_context_close(file_priv->dev_priv, pc);
>  
> -	/* One for the xarray and one for the caller */
> -	return i915_gem_context_get(ctx);
> +	return ctx;
>  }
>  
>  struct i915_gem_context *
> -- 
> 2.38.1
