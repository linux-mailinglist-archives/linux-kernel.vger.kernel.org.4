Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5DB6D0934
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC3PNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjC3PNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:13:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B1CC3E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680189137; x=1711725137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIlJIKmawjiuh4ucrdQ+vsmcGMGV9Kboz0XfNJU9b40=;
  b=E0UM1RndT5gGkmNzk418+9YrPj3qyPbWkhnms90d7utnsvW/gDJTXeik
   OPR2t2EYaq0kmLkoISK0yaCeI+OT4b/P892i/ZiZe6K8kyTRn8uXvOksF
   Ek1OE/QtdVE1Hoz7KdT+2qSn7PiW2JGQ+nunNV9z0NASb/6iZwKb+D2qR
   cK1PefbDmF9LtP5lSLIjHndKeUaxBtUEKO2StXs4xH68V9uiJoYCNChDV
   hQhzQu9Of9UVcH4b06oPhZZu/1x8itDFOSMgHnQxlxoorFZ+Ts6us0eAW
   lwLyNKUPcWxiVXWU4Q6TForRkadZJ+9q0glQyasdYmmxJ4mR30SxVrs9w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320846841"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="320846841"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="828370914"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="828370914"
Received: from bjmcgrat-mobl.amr.corp.intel.com (HELO [10.213.215.205]) ([10.213.215.205])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 08:10:39 -0700
Message-ID: <8c9e6931-e445-4df6-90e5-b648a3fa1b3b@linux.intel.com>
Date:   Thu, 30 Mar 2023 16:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/i915/gt: Hold a wakeref for the active VM
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20230330-hold_wakeref_for_active_vm-v1-1-baca712692f6@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230330-hold_wakeref_for_active_vm-v1-1-baca712692f6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/03/2023 15:35, Andrzej Hajda wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> There may be a disconnect between the GT used by the engine and the GT
> used for the VM, requiring us to hold a wakeref on both while the GPU is
> active with this request.

Presumably this is for MTL? "drm/i1915/mtl: ..." ?

> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> [ahajda: removed not-yet-upstremed wakeref tracking bits]
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/intel_context.h   | 15 +++++++++++----
>   drivers/gpu/drm/i915/gt/intel_engine_pm.c |  3 +++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
> index 0a8d553da3f439..48f888c3da083b 100644
> --- a/drivers/gpu/drm/i915/gt/intel_context.h
> +++ b/drivers/gpu/drm/i915/gt/intel_context.h
> @@ -14,6 +14,7 @@
>   #include "i915_drv.h"
>   #include "intel_context_types.h"
>   #include "intel_engine_types.h"
> +#include "intel_gt_pm.h"
>   #include "intel_ring_types.h"
>   #include "intel_timeline_types.h"
>   #include "i915_trace.h"
> @@ -207,8 +208,11 @@ void intel_context_exit_engine(struct intel_context *ce);
>   static inline void intel_context_enter(struct intel_context *ce)
>   {
>   	lockdep_assert_held(&ce->timeline->mutex);
> -	if (!ce->active_count++)
> -		ce->ops->enter(ce);
> +	if (ce->active_count++)
> +		return;
> +
> +	ce->ops->enter(ce);
> +	intel_gt_pm_get(ce->vm->gt);
>   }
>   
>   static inline void intel_context_mark_active(struct intel_context *ce)
> @@ -222,8 +226,11 @@ static inline void intel_context_exit(struct intel_context *ce)
>   {
>   	lockdep_assert_held(&ce->timeline->mutex);
>   	GEM_BUG_ON(!ce->active_count);
> -	if (!--ce->active_count)
> -		ce->ops->exit(ce);
> +	if (--ce->active_count)
> +		return;
> +
> +	intel_gt_pm_put_async(ce->vm->gt);
> +	ce->ops->exit(ce);

Above too are balance and plausible - media tile engine vs root tile VM, 
although at the moment it escapes me what exactly would go bad, like 
what gets powered down which is then access by the executing request and 
fails how?

>   }
>   
>   static inline struct intel_context *intel_context_get(struct intel_context *ce)
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> index e971b153fda976..ac0566c5e99e17 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
> @@ -114,6 +114,9 @@ __queue_and_release_pm(struct i915_request *rq,
>   
>   	ENGINE_TRACE(engine, "parking\n");
>   
> +	GEM_BUG_ON(rq->context->active_count != 1);
> +	__intel_gt_pm_get(engine->gt);
> +

But this one I don't immediately get. Above we have get and put which is 
balanced - fine, but where is this extra get coming from, who will put 
it and where?

Regards,

Tvrtko

>   	/*
>   	 * We have to serialise all potential retirement paths with our
>   	 * submission, as we don't want to underflow either the
> 
> ---
> base-commit: 3385d6482cd60f2a0bbb0fa97b70ae7dbba4f95c
> change-id: 20230330-hold_wakeref_for_active_vm-7f013a449ef3
> 
> Best regards,
