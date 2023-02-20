Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311269D0E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjBTPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBTPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:46:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6751F5F6;
        Mon, 20 Feb 2023 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676908005; x=1708444005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k4wfezK6AXjJRKoJw8o50JWi2ZFodNHQ5z5zxhTGtJs=;
  b=RSt7vl7LYanMhiuMHhRXWj+ToqaJ+D0UAKKyHn9siWvdDML9iUK/M5+b
   ZQkTqXEE1MxfDIyJbPukvG7e2sBVUc6wrKSQvQVtIhOk6mE/Oarzys8Kk
   qxUH3h/Y5g6opaRqRecuGlrXWCNeGuHVzIvQUGtDQuoQPtrcYbICjWtSB
   c/Vg/4CUgzR5Lin1SPAjGQb5rBD/nwbVGatI8INjChzg9HgqtP2cEmFZr
   w7ns4HdSwUuv9SB0UHpuzRKKeNsD1v0CqcAqB2fEGZxszcZZxOPZs5wui
   Va59yU2aisZDSdAtZ2kiMzdKnlv61mamoAuQBXzuUJFUh65jPAmv/nXUM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312060018"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="312060018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:46:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="916897293"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="916897293"
Received: from mochoamo-mobl.ger.corp.intel.com (HELO [10.213.211.126]) ([10.213.211.126])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 07:46:41 -0800
Message-ID: <2716c108-0486-6e27-77e2-efd1fa350f04@linux.intel.com>
Date:   Mon, 20 Feb 2023 15:46:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 14/14] drm/i915: Add deadline based boost support
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        intel-gfx@lists.freedesktop.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <20230218211608.1630586-1-robdclark@gmail.com>
 <20230218211608.1630586-15-robdclark@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230218211608.1630586-15-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2023 21:15, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> 
> This should probably be re-written by someone who knows the i915
> request/timeline stuff better, to deal with non-immediate deadlines.
> But as-is I think this should be enough to handle the case where
> we want syncobj waits to trigger boost.

Yeah, there are endless possibilities. :) But I think it is effectively 
similar enough to current waitboosting (when waits are done using the 
i915 specific ioctl). So as a first step I'll try to organize some 
internal power and performance testing, at least Chromebook focused, to 
see if modern userspace (syncobj based) even benefits and does not by 
some chance regress over the board.

Regards,

Tvrtko

> 
>   drivers/gpu/drm/i915/i915_driver.c  |  2 +-
>   drivers/gpu/drm/i915/i915_request.c | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index cf1c0970ecb4..bd40b7bcb38a 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1781,7 +1781,7 @@ static const struct drm_driver i915_drm_driver = {
>   	.driver_features =
>   	    DRIVER_GEM |
>   	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
> -	    DRIVER_SYNCOBJ_TIMELINE,
> +	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_SYNCOBJ_DEADLINE,
>   	.release = i915_driver_release,
>   	.open = i915_driver_open,
>   	.lastclose = i915_driver_lastclose,
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index 7503dcb9043b..44491e7e214c 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -97,6 +97,25 @@ static bool i915_fence_enable_signaling(struct dma_fence *fence)
>   	return i915_request_enable_breadcrumb(to_request(fence));
>   }
>   
> +static void i915_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
> +{
> +	struct i915_request *rq = to_request(fence);
> +
> +	if (i915_request_completed(rq))
> +		return;
> +
> +	if (i915_request_started(rq))
> +		return;
> +
> +	/*
> +	 * TODO something more clever for deadlines that are in the
> +	 * future.  I think probably track the nearest deadline in
> +	 * rq->timeline and set timer to trigger boost accordingly?
> +	 */
> +
> +	intel_rps_boost(rq);
> +}
> +
>   static signed long i915_fence_wait(struct dma_fence *fence,
>   				   bool interruptible,
>   				   signed long timeout)
> @@ -182,6 +201,7 @@ const struct dma_fence_ops i915_fence_ops = {
>   	.signaled = i915_fence_signaled,
>   	.wait = i915_fence_wait,
>   	.release = i915_fence_release,
> +	.set_deadline = i915_fence_set_deadline,
>   };
>   
>   static void irq_execute_cb(struct irq_work *wrk)
