Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E26B783F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCMM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCMM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:59:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE165053
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678712350; x=1710248350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ebRGYipAhkCm3eQ2Tun8VuQlWlH9eTlggyCqwLpkE4U=;
  b=M9r8S1SdZnFsTRMXMHdq16p6gqWK6FQPZvgfPnaM9Ns1PY05hTLwvgp2
   1dlx1MTrZM6kgs7hb6+Mu5vohISRN9x3RA4AMMGtOWYxav/yEdYS/Myeo
   M2Tq7pg0rWA44Tr3LRCI2jLaYrVJkW7w2sHS6E/lM0K95hJk+emRx71W2
   sl+z90S+4hutKpQ9Tb5W3+sL9rYXYZJI7ihVQI5NvSagf4DC34fZ9JKAl
   EBi8LtxdXGBoZLl6ifx+FAx3Pa16ytdq5mT3QtjYEW/ryiqtJlTBcqgwK
   1ZpBZXShmvas0iaO0HVidu68LVCT0jYDLPKyTptDHNsm26Zkm2G7VM+66
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="364799866"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="364799866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655964214"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="655964214"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.252.33.220]) ([10.252.33.220])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:58:55 -0700
Message-ID: <a07ac81c-f234-a68b-0d68-225259e534a8@linux.intel.com>
Date:   Mon, 13 Mar 2023 13:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Intel-gfx] [PATCH v6 2/2] drm/i915: add guard page to
 ggtt->error_capture
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
References: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
 <20230308-guard_error_capture-v6-2-1b5f31422563@intel.com>
From:   "Das, Nirmoy" <nirmoy.das@linux.intel.com>
In-Reply-To: <20230308-guard_error_capture-v6-2-1b5f31422563@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/2023 10:23 AM, Andrzej Hajda wrote:
> Write-combining memory allows speculative reads by CPU.
> ggtt->error_capture is WC mapped to CPU, so CPU/MMU can try
> to prefetch memory beyond the error_capture, ie it tries
> to read memory pointed by next PTE in GGTT.
> If this PTE points to invalid address DMAR errors will occur.
> This behaviour was observed on ADL and RPL platforms.
> To avoid it, guard scratch page should be added after error_capture.
> The patch fixes the most annoying issue with error capture but
> since WC reads are used also in other places there is a risk similar
> problem can affect them as well.
>
> v2:
>    - modified commit message (I hope the diagnosis is correct),
>    - added bug checks to ensure scratch is initialized on gen3 platforms.
>      CI produces strange stacktrace for it suggesting scratch[0] is NULL,
>      to be removed after resolving the issue with gen3 platforms.
> v3:
>    - removed bug checks, replaced with gen check.
> v4:
>    - change code for scratch page insertion to support all platforms,
>    - add info in commit message there could be more similar issues
> v5:
>    - check for nop_clear_range instead of gen8 (Tvrtko),
>    - re-insert scratch pages on resume (Tvrtko)
> v6:
>    - use scratch_range callback to set scratch pages (Chris)
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Acked-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/intel_ggtt.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> index 38e6f0b207fe0c..5ef7e03b11c8e6 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> @@ -572,8 +572,12 @@ static int init_ggtt(struct i915_ggtt *ggtt)
>   		 * paths, and we trust that 0 will remain reserved. However,
>   		 * the only likely reason for failure to insert is a driver
>   		 * bug, which we expect to cause other failures...
> +		 *
> +		 * Since CPU can perform speculative reads on error capture
> +		 * (write-combining allows it) add scratch page after error
> +		 * capture to avoid DMAR errors.
>   		 */
> -		ggtt->error_capture.size = I915_GTT_PAGE_SIZE;
> +		ggtt->error_capture.size = 2 * I915_GTT_PAGE_SIZE;
>   		ggtt->error_capture.color = I915_COLOR_UNEVICTABLE;
>   		if (drm_mm_reserve_node(&ggtt->vm.mm, &ggtt->error_capture))
>   			drm_mm_insert_node_in_range(&ggtt->vm.mm,
> @@ -583,11 +587,15 @@ static int init_ggtt(struct i915_ggtt *ggtt)
>   						    0, ggtt->mappable_end,
>   						    DRM_MM_INSERT_LOW);
>   	}
> -	if (drm_mm_node_allocated(&ggtt->error_capture))
> +	if (drm_mm_node_allocated(&ggtt->error_capture)) {
> +		u64 start = ggtt->error_capture.start;
> +		u64 size = ggtt->error_capture.size;
> +
> +		ggtt->vm.scratch_range(&ggtt->vm, start, size);
>   		drm_dbg(&ggtt->vm.i915->drm,
>   			"Reserved GGTT:[%llx, %llx] for use by error capture\n",
> -			ggtt->error_capture.start,
> -			ggtt->error_capture.start + ggtt->error_capture.size);
> +			start, start + size);
> +	}
>   
>   	/*
>   	 * The upper portion of the GuC address space has a sizeable hole
> @@ -1280,6 +1288,10 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
>   
>   	flush = i915_ggtt_resume_vm(&ggtt->vm);
>   
> +	if (drm_mm_node_allocated(&ggtt->error_capture))
> +		ggtt->vm.scratch_range(&ggtt->vm, ggtt->error_capture.start,
> +				       ggtt->error_capture.size);
> +
>   	ggtt->invalidate(ggtt);
>   
>   	if (flush)
>
