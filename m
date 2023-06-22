Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811A73A245
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFVNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjFVNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:55:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB31994;
        Thu, 22 Jun 2023 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687442130; x=1718978130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RpQccSlwUHCOmo04t2dBa0xz+CX4hYUabFawymK3Ink=;
  b=Nfa6nAH7rNT7M3HaVQQ66twzJi6rb3SIHeOlm0Vo1cyOcU1yhep+gvmU
   y4yIIV79f9hBmg6UI1YBlA+iF+JrxqF/9xvv94pdNVoiz9U7I/uWcc5cv
   i9tvV63iIiQDAfOr5Pq/wx2/CLOZU2RRjguevMxVU2NG6rO2JugbjTPif
   3clHj6shgQNp8ZjBUwp2cKLgiAcpetRbBigHMqQcht0cWbSiwt7PgJL4L
   WvVsV6VfASCHjL9c4s7gVEUf61WhIJGTYqEwNuvbwFVQPGXOkb24Znkwf
   bQ2K+CvKz21mNq0shoqQ90I0VZjmW+4BC/Nai2WuLxMLIlUQ3i+LXJiix
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360510748"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360510748"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714921765"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="714921765"
Received: from akivisil-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.215.96])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:55:26 -0700
Date:   Thu, 22 Jun 2023 15:55:22 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 3/4] drm/ttm: Don't leak a resource on
 eviction error
Message-ID: <ZJRSyp7fT6VXpow7@ashyti-mobl2.lan>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jun 22, 2023 at 12:14:11PM +0200, Thomas Hellström wrote:
> On eviction errors other than -EMULTIHOP we were leaking a resource.
> Fix.
> 
> Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 615d30c4262d..89530f2a027f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -462,14 +462,14 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>  	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>  	if (ret == -EMULTIHOP) {
>  		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
> -		if (ret) {
> -			if (ret != -ERESTARTSYS && ret != -EINTR)
> -				pr_err("Buffer eviction failed\n");
> -			ttm_resource_free(bo, &evict_mem);
> -			goto out;
> -		}
> -		/* try and move to final place now. */
> -		goto bounce;
> +		if (!ret)
> +			/* try and move to final place now. */
> +			goto bounce;

As we are at this, can't we replace this with a while()? Goto's
used instead of a while loop are a fist in the eye...

It looks even better:

	while (1) {
		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
		if (!ret)
			break;

		if (ret == -EMULTIHOP)
			ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem,
							ctx, &hop);

		/* try again */
		if (!ret)
			continue;

		ttm_resource_free(bo, &evict_mem);
		if (ret != -ERESTARTSYS && ret != -EINTR)
			pr_err("Buffer eviction failed\n");

		break;
	}

Andi

> +	}
> +	if (ret) {
> +		ttm_resource_free(bo, &evict_mem);
> +		if (ret != -ERESTARTSYS && ret != -EINTR)
> +			pr_err("Buffer eviction failed\n");
>  	}
>  out:
>  	return ret;
> -- 
> 2.40.1
