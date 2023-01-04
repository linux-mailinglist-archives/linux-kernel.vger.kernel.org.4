Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD23F65CF95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjADJeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjADJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:34:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A33D7B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672824840; x=1704360840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KPN8YqY9LSOEXrt90pYffb+Xv9BOeYf4y3o6s7PYJ+s=;
  b=A/ATrrB8Z7v9Io8KT1L2bZ9fUZ5KeJOKtaLew2T8q90CXlGQRd3GvOxW
   6JxOmuEXq8iycJg2uzkHc4+blAS3Y58k09KriGPlrBRmNSfomiBjiRUqK
   ybryz5nOZXVynbZZUDpdBoB2l00TctSdwYWbQ9t+pNAMuKAFQcBHyvAMC
   Qf4+c1r6+dq0MjVOtQXOUGx7dk9KbmkIVG9d9FYLAlg9GWLh+CEBvCCUP
   IjZrq88NUfcZT+3OMJJ/kz74ogx5/CCQmXQzTA6NLTFqpBTTVPF7oJJzm
   tBCZQAL7BAMhS3bRTkGxYflWCG9W3zjbNVyeQAi92gV0YDQGGDZTELrok
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301582481"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="301582481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:34:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743790546"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="743790546"
Received: from wfurtakx-mobl.ger.corp.intel.com (HELO [10.213.223.45]) ([10.213.223.45])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:33:56 -0800
Message-ID: <04ec647c-184e-942e-a7ed-4ba393e591b7@linux.intel.com>
Date:   Wed, 4 Jan 2023 09:33:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/i915: Fix potential context UAFs
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        katrinzhou <katrinzhou@tencent.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        "open list:INTEL DRM DRIVERS" <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230103234948.1218393-1-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230103234948.1218393-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/01/2023 23:49, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> gem_context_register() makes the context visible to userspace, and which
> point a separate thread can trigger the I915_GEM_CONTEXT_DESTROY ioctl.
> So we need to ensure that nothing uses the ctx ptr after this.  And we
> need to ensure that adding the ctx to the xarray is the *last* thing
> that gem_context_register() does with the ctx pointer.

Any backtraces from oopses or notes on how it was found to record in the commit message?

> Signed-off-by: Rob Clark <robdclark@chromium.org>

Fixes: a4c1cdd34e2c ("drm/i915/gem: Delay context creation (v3)")
References: 3aa9945a528e ("drm/i915: Separate GEM context construction and registration to userspace")
Cc: <stable@vger.kernel.org> # v5.15+

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_context.c | 24 +++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index 7f2831efc798..6250de9b9196 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1688,6 +1688,10 @@ void i915_gem_init__contexts(struct drm_i915_private *i915)
>   	init_contexts(&i915->gem.contexts);
>   }
>   
> +/*
> + * Note that this implicitly consumes the ctx reference, by placing
> + * the ctx in the context_xa.
> + */
>   static void gem_context_register(struct i915_gem_context *ctx,
>   				 struct drm_i915_file_private *fpriv,
>   				 u32 id)
> @@ -1703,10 +1707,6 @@ static void gem_context_register(struct i915_gem_context *ctx,
>   	snprintf(ctx->name, sizeof(ctx->name), "%s[%d]",
>   		 current->comm, pid_nr(ctx->pid));
>   
> -	/* And finally expose ourselves to userspace via the idr */
> -	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
> -	WARN_ON(old);
> -
>   	spin_lock(&ctx->client->ctx_lock);
>   	list_add_tail_rcu(&ctx->client_link, &ctx->client->ctx_list);
>   	spin_unlock(&ctx->client->ctx_lock);
> @@ -1714,6 +1714,10 @@ static void gem_context_register(struct i915_gem_context *ctx,
>   	spin_lock(&i915->gem.contexts.lock);
>   	list_add_tail(&ctx->link, &i915->gem.contexts.list);
>   	spin_unlock(&i915->gem.contexts.lock);
> +
> +	/* And finally expose ourselves to userspace via the idr */
> +	old = xa_store(&fpriv->context_xa, id, ctx, GFP_KERNEL);
> +	WARN_ON(old);

Have you seen that this hunk is needed or just moving it for a good measure? To be clear, it is probably best to move it even if the current placement cannot cause any problems, I am just double-checking if you had any concrete observations here while mulling over easier stable backports if we would omit it.

>   }
>   
>   int i915_gem_context_open(struct drm_i915_private *i915,
> @@ -2199,14 +2203,22 @@ finalize_create_context_locked(struct drm_i915_file_private *file_priv,
>   	if (IS_ERR(ctx))
>   		return ctx;
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
>   	gem_context_register(ctx, file_priv, id);
>   
>   	old = xa_erase(&file_priv->proto_context_xa, id);
>   	GEM_BUG_ON(old != pc);
>   	proto_context_close(file_priv->dev_priv, pc);
>   
> -	/* One for the xarray and one for the caller */
> -	return i915_gem_context_get(ctx);
> +	return ctx;

Otherwise userspace can look up a context which hasn't had it's reference count increased yep. I can add the Fixes: and Stable: tags while merging if no complaints.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko

>   }
>   
>   struct i915_gem_context *
