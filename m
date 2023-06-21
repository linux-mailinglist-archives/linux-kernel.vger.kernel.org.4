Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F053A738E81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFUSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:21:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AB1731
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:21:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53482b44007so3099352a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687371712; x=1689963712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6Gk7g2e3myD2tH63H8qrLIHXgdsP+ERfyqwv9FmHKA=;
        b=HK8K+XVPVpHrQ1TBLWxHjZGw3WZq+6agwyY4s0A5kBhe5WzViWHXCAmvm/2c4NxEEc
         5bX6ioGxPIdLfu40Zqo087JGsSjMepJ8zBlsLsKn9h/mBfoDoN038lJ7xFP+/eEXuRlD
         oI7dse5fvt0FmTSwEGjrcu65EKDRviG72H44w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371712; x=1689963712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Gk7g2e3myD2tH63H8qrLIHXgdsP+ERfyqwv9FmHKA=;
        b=evVAuIbh58k8m+res4xdS2fYZe9hVXbsAkTp7P2UvEr2Rwz4ifx6fFUDqnKj/No9qw
         R+O9RyASOrIrAZA5ktBbMQeQN3pOlZrId1eXzvyYcVZnKl2RsDfCBWu6S59yB0CrV+KK
         fP/g0Mdy/bLr7qcgvmLneCImXIzL34q2RWiI2XGK2dsP2IgDI45oYJ+5d/P0TGv8jL8C
         utQmhe26zSyqlZfutHbb4ArLRsqfTA6x+/nxNtoswPYA62rYMbX00rU8yCr+gsPFfd5e
         C25Ft7KTN/MuPXZ9BzebhvqIGBlX7XPgs19X42FLYPBVGnuc9wykNTesr4jzZ0EVtJ3f
         Fu7A==
X-Gm-Message-State: AC+VfDy8i9s5jdPUbxBTONz0i7sxCIrO7tLbCsmYhrxXZ2Jg97Cg7t15
        ODpI47Pd7HuqjG+MJlgurc6CBQ==
X-Google-Smtp-Source: ACHHUZ6tDaappzv2ihAfQqvCVZ7H1Q+IK7vT3D+MHa4nEA5bW0z+dgmIb3VIyINlPx/1903qiPnMlQ==
X-Received: by 2002:a17:902:e745:b0:1b6:6985:ff5f with SMTP id p5-20020a170902e74500b001b66985ff5fmr7723499plf.36.1687371711957;
        Wed, 21 Jun 2023 11:21:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b001b0603829a0sm3801370plb.199.2023.06.21.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:21:51 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:21:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Jann Horn <jannh@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: Re: [PATCH v3 1/1] Randomized slab caches for kmalloc()
Message-ID: <202306211111.4E70CD6@keescook>
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 07:18:43PM +0800, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.
> 
> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
> 
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the address of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In other words, the randomness of cache selection will
> be with respect to the code address rather than time, i.e. allocations
> in different code paths would most likely pick different caches,
> although kmalloc() at each place would use the same cache copy whenever
> it is executed. In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.
> 
> Meanwhile, the static random selection is further enhanced with a
> per-boot random seed, which prevents the attacker from finding a usable
> kmalloc that happens to pick the same cache with the vulnerable
> subsystem/module by analyzing the open source code.
> 
> The overhead of performance has been tested on a 40-core x86 server by
> comparing the results of `perf bench all` between the kernels with and
> without this patch based on the latest linux-next kernel, which shows
> minor difference. A subset of benchmarks are listed below:
> 
>                 sched/  sched/  syscall/       mem/       mem/
>              messaging    pipe     basic     memcpy     memset
>                  (sec)   (sec)     (sec)   (GB/sec)   (GB/sec)
> 
> control1         0.019   5.459     0.733  15.258789  51.398026
> control2         0.019   5.439     0.730  16.009221  48.828125
> control3         0.019   5.282     0.735  16.009221  48.828125
> control_avg      0.019   5.393     0.733  15.759077  49.684759
> 
> experiment1      0.019   5.374     0.741  15.500992  46.502976
> experiment2      0.019   5.440     0.746  16.276042  51.398026
> experiment3      0.019   5.242     0.752  15.258789  51.398026
> experiment_avg   0.019   5.352     0.746  15.678608  49.766343
> 
> The overhead of memory usage was measured by executing `free` after boot
> on a QEMU VM with 1GB total memory, and as expected, it's positively
> correlated with # of cache copies:
> 
>            control  4 copies  8 copies  16 copies
> 
> total       969.8M    968.2M    968.2M     968.2M
> used         20.0M     21.9M     24.1M      26.7M
> free        936.9M    933.6M    931.4M     928.6M
> available   932.2M    928.8M    926.6M     923.9M
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I think this looks really good. Thanks for the respin! Some
nits/comments/questions below, but I think this can land and get
incrementally improved. Please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 791f7453a04f..b7a5387f0dad 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -19,6 +19,9 @@
>  #include <linux/workqueue.h>
>  #include <linux/percpu-refcount.h>
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#include <linux/hash.h>
> +#endif

I think this can just be included unconditionally, yes?

> [...]
> +extern unsigned long random_kmalloc_seed;
> +
> +static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags, unsigned long caller)
>  {
>  	/*
>  	 * The most common case is KMALLOC_NORMAL, so test for it
>  	 * with a single branch for all the relevant flags.
>  	 */
>  	if (likely((flags & KMALLOC_NOT_NORMAL_BITS) == 0))
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +		return KMALLOC_RANDOM_START + hash_64(caller ^ random_kmalloc_seed,
> +						      CONFIG_RANDOM_KMALLOC_CACHES_BITS);
> +#else
>  		return KMALLOC_NORMAL;
> +#endif

The commit log talks about having no runtime lookup, but that's not
entirely true, given this routine. And xor and a hash_64... I wonder how
expensive this is compared to some kind of constant expression that
could be computed at build time... (the xor should stay, but that's
"cheap").

>  
>  	/*
>  	 * At least one of the flags has to be set. Their priorities in
> @@ -577,7 +589,7 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  
>  		index = kmalloc_index(size);
>  		return kmalloc_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, size);
>  	}
>  	return __kmalloc(size, flags);
> @@ -593,7 +605,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
>  
>  		index = kmalloc_index(size);
>  		return kmalloc_node_trace(
> -				kmalloc_caches[kmalloc_type(flags)][index],
> +				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>  				flags, node, size);
>  	}
>  	return __kmalloc_node(size, flags, node);

The use of _RET_IP_ is generally fine here, but I wonder about some of
the allocation wrappers (like devm_kmalloc(), etc). I think those aren't
being bucketed correctly? Have you checked that?

> [...]
> @@ -776,12 +781,44 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #define KMALLOC_RCL_NAME(sz)
>  #endif
>  
> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> +#define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
> +#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
> +#if CONFIG_RANDOM_KMALLOC_CACHES_BITS >= 1
> +#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  0] = "kmalloc-random-01-" #sz,

I wonder if this name is getting too long? Should "random" be "rnd" ?
*shrug*

> [...]
> +#define KMA_RAND_16(sz) KMA_RAND_15(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-random-16-" #sz,

And if we wanted to save another character, this could be numbered 0-f,
but I defer these aesthetics to Vlastimil. :)

-Kees

-- 
Kees Cook
