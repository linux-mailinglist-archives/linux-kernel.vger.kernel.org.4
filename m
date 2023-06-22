Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9173A0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFVMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:25:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E24199D;
        Thu, 22 Jun 2023 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687436712; x=1718972712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VFIhXIMBVxone3gWtsN0Ctk34JSxSUHhD8XO85Zqc1I=;
  b=AmVCj3wmH569Bd6Soedwup9+huG+6lAz0KdYXppUWoIocEGIyW3i6sSf
   VAXc8OLnaF9GmhgyfxxUvjoc6WkTxtsnD6k34+XVZN7CSoF9iyRkNchV7
   NHvtI6mjKu4ydfBh1FYT4BRB1M4ETyAzAgfFbaIOimcWlLvrgilplBUzM
   Xvd13xolFvsFN7yq06kNV2LcKjSRYROlgVPhjM8rGmiCaPGVfFEwmw0xK
   0G9Ks9lahQGuh4dcMAccXk9DRTtbJz3u66Vrxe4mUqW4P9C2GO6W5xEd1
   j+GYB6c0PtJ+6j+ZkBcw6a4TTmwbyX7PAyjTujpfyRRhP3NUKd9JfC8CR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360489511"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="360489511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="839028264"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="839028264"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.249.46.93]) ([10.249.46.93])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:25:09 -0700
Message-ID: <206f92ee-ed18-a503-6119-bc03779cd516@linux.intel.com>
Date:   Thu, 22 Jun 2023 14:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] drm/ttm: Don't leak a resource on eviction error
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230622101412.78426-1-thomas.hellstrom@linux.intel.com>
 <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
From:   Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20230622101412.78426-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/2023 12:14 PM, Thomas Hellström wrote:
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

Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 615d30c4262d..89530f2a027f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -462,14 +462,14 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>   	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>   	if (ret == -EMULTIHOP) {
>   		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
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
> +	}
> +	if (ret) {
> +		ttm_resource_free(bo, &evict_mem);
> +		if (ret != -ERESTARTSYS && ret != -EINTR)
> +			pr_err("Buffer eviction failed\n");
>   	}
>   out:
>   	return ret;
