Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11F70A155
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjESVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjESVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7491711
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC92865B14
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:09:48 +0000 (UTC)
Received: from rdvivi-mobl4 (unknown [192.55.55.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D1892C433D2;
        Fri, 19 May 2023 21:09:45 +0000 (UTC)
Date:   Fri, 19 May 2023 17:09:43 -0400
From:   Rodrigo Vivi <rodrigo.vivi@kernel.org>
To:     Cong Liu <liucong2@kylinos.cn>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/i915: Fix memory leaks in function live_nop_switch
Message-ID: <ZGfll+nLPL2L6Zyz@rdvivi-mobl4>
References: <20230508085016.437836-1-liucong2@kylinos.cn>
 <20230517050204.4111874-1-liucong2@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517050204.4111874-1-liucong2@kylinos.cn>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 01:02:03PM +0800, Cong Liu wrote:
> Be sure to properly free the allocated memory before exiting
> the live_nop_switch function.
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

pushed, thanks for the patch

> ---
>  .../gpu/drm/i915/gem/selftests/i915_gem_context.c  | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> index a81fa6a20f5a..2fb125d0cb5e 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
> @@ -66,7 +66,7 @@ static int live_nop_switch(void *arg)
>  		ctx[n] = live_context(i915, file);
>  		if (IS_ERR(ctx[n])) {
>  			err = PTR_ERR(ctx[n]);
> -			goto out_file;
> +			goto out_ctx;
>  		}
>  	}
>  
> @@ -82,7 +82,7 @@ static int live_nop_switch(void *arg)
>  			this = igt_request_alloc(ctx[n], engine);
>  			if (IS_ERR(this)) {
>  				err = PTR_ERR(this);
> -				goto out_file;
> +				goto out_ctx;
>  			}
>  			if (rq) {
>  				i915_request_await_dma_fence(this, &rq->fence);
> @@ -96,7 +96,7 @@ static int live_nop_switch(void *arg)
>  			intel_gt_set_wedged(to_gt(i915));
>  			i915_request_put(rq);
>  			err = -EIO;
> -			goto out_file;
> +			goto out_ctx;
>  		}
>  		i915_request_put(rq);
>  
> @@ -107,7 +107,7 @@ static int live_nop_switch(void *arg)
>  
>  		err = igt_live_test_begin(&t, i915, __func__, engine->name);
>  		if (err)
> -			goto out_file;
> +			goto out_ctx;
>  
>  		end_time = jiffies + i915_selftest.timeout_jiffies;
>  		for_each_prime_number_from(prime, 2, 8192) {
> @@ -120,7 +120,7 @@ static int live_nop_switch(void *arg)
>  				this = igt_request_alloc(ctx[n % nctx], engine);
>  				if (IS_ERR(this)) {
>  					err = PTR_ERR(this);
> -					goto out_file;
> +					goto out_ctx;
>  				}
>  
>  				if (rq) { /* Force submission order */
> @@ -165,7 +165,7 @@ static int live_nop_switch(void *arg)
>  
>  		err = igt_live_test_end(&t);
>  		if (err)
> -			goto out_file;
> +			goto out_ctx;
>  
>  		pr_info("Switch latencies on %s: 1 = %lluns, %lu = %lluns\n",
>  			engine->name,
> @@ -173,6 +173,8 @@ static int live_nop_switch(void *arg)
>  			prime - 1, div64_u64(ktime_to_ns(times[1]), prime - 1));
>  	}
>  
> +out_ctx:
> +	kfree(ctx);
>  out_file:
>  	fput(file);
>  	return err;
> -- 
> 2.34.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
