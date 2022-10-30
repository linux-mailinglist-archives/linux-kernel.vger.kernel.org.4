Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C56126F9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3C7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3C7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:59:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C38C7C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:59:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z14so11431549wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 19:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViUX7nS+sMEeCyJpGqlawogkGghwNa0jyE1+CkQUpdc=;
        b=qQ6rDtl8YogRVAxKyJvgUzMif7w/ZB2i3g7mK+pw6pYRNgxQTUsMyj8nPdMXEeXzLF
         PXLS4IoVwFNta7RCuAAUYM1Ms2+nJyNo0HafTdH0SA83mBdA4RPJuPtXTKY/5D56dVm3
         HTSR+mBo3ZX9sBybbjBm56aRQkVg+vUxgvp8xn9lOrdS6+9rPBME/OLt56ykODryouhU
         DvDiQIC2IdYP+AOyBKmJLgWIHtjKzfAqJECgL9kMvSaX3dzv4+FwRH/p9XR3/oQPgsYe
         OEq6CtMEWDtIV8n8lq526UsStYYB1l593S4s+aat/PW1A4HZzfUdkNM6NHqcL6RpkPNk
         awpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViUX7nS+sMEeCyJpGqlawogkGghwNa0jyE1+CkQUpdc=;
        b=am3hP4cRSVHroGvaIWKU7+XyMku9hZa0sgXY9kN5PcbJD203D5WqMlm1kc1QI/6ojM
         KWPQQV0rldBOWD86zLv6rPWxVNoNCZfp0NoZEmQqmQPxRI3zPKuk9BQ2sltpzQPXvJD+
         I1PeSDOUwaOd1peq27lOieJL059zVZ3hMkIPHDdYUj93kw92kLK4DGj9vXL+b6DyYa8s
         A1GKlHAXp1FS6pZSod/XXSNOTJ2mMNYAvsqZcaNzKw0zxrAp4pjXm8fP/YgXKiMBL3xY
         oaKaPn8RUtVdg+jffKB369tlYP+CyEVQ847ugXxK02UyfGtqMD0saUWLWmVYW2eCLecl
         orCg==
X-Gm-Message-State: ACrzQf11qtFl3Wela4Zp+n9viqnvpoX7UVfeqwQ7ACn6HQQDURQakEqD
        4v1uqQuf2VCKqJ8dOzyfTYjBJQ==
X-Google-Smtp-Source: AMsMyM54r0IkR1bAn7ogIWoE8ouh6q0niMwfywhXqgvr4+7MeQo9sj+BwsUXkU9LbOWcYLnPZDWybg==
X-Received: by 2002:adf:d1c4:0:b0:230:7771:f618 with SMTP id b4-20020adfd1c4000000b002307771f618mr3541746wrd.203.1667098770552;
        Sat, 29 Oct 2022 19:59:30 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:a6f7:9df9:f4cc:97c1])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003b31c560a0csm3240628wmb.12.2022.10.29.19.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 19:59:29 -0700 (PDT)
Date:   Sun, 30 Oct 2022 03:59:22 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] kasan: allow sampling page_alloc allocations for HW_TAGS
Message-ID: <Y13oij+hiJgQ9BXj@elver.google.com>
References: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:10PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new boot parameter called kasan.page_alloc.sample, which makes
> Hardware Tag-Based KASAN tag only every Nth page_alloc allocation.
> 
> As Hardware Tag-Based KASAN is intended to be used in production, its
> performance impact is crucial. As page_alloc allocations tend to be big,
> tagging and checking all such allocations introduces a significant
> slowdown in some testing scenarios. The new flag allows to alleviate
> that slowdown.
> 
> Enabling page_alloc sampling has a downside: KASAN will miss bad accesses
> to a page_alloc allocation that has not been tagged.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  Documentation/dev-tools/kasan.rst |  4 +++
>  include/linux/kasan.h             |  7 ++---
>  mm/kasan/common.c                 |  9 +++++--
>  mm/kasan/hw_tags.c                | 26 +++++++++++++++++++
>  mm/kasan/kasan.h                  | 15 +++++++++++
>  mm/page_alloc.c                   | 43 +++++++++++++++++++++----------
>  6 files changed, 85 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 5c93ab915049..bd97301845ef 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -140,6 +140,10 @@ disabling KASAN altogether or controlling its features:
>  - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
>    allocations (default: ``on``).
>  
> +- ``kasan.page_alloc.sample=<sampling frequency>`` makes KASAN tag only

Frequency is number of samples per frame (unit time, or if used
non-temporally like here, population size).

[1] https://en.wikipedia.org/wiki/Systematic_sampling

You're using it as an interval, so I'd just replace uses of frequency
with "interval" appropriately here and elsewhere.

> +  every Nth page_alloc allocation, where N is the value of the parameter
> +  (default: ``1``).
> +
>  Error reports
>  ~~~~~~~~~~~~~
>  
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d811b3d7d2a1..d45d45dfd007 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -120,12 +120,13 @@ static __always_inline void kasan_poison_pages(struct page *page,
>  		__kasan_poison_pages(page, order, init);
>  }
>  
> -void __kasan_unpoison_pages(struct page *page, unsigned int order, bool init);
> -static __always_inline void kasan_unpoison_pages(struct page *page,
> +bool __kasan_unpoison_pages(struct page *page, unsigned int order, bool init);
> +static __always_inline bool kasan_unpoison_pages(struct page *page,
>  						 unsigned int order, bool init)
>  {
>  	if (kasan_enabled())
> -		__kasan_unpoison_pages(page, order, init);
> +		return __kasan_unpoison_pages(page, order, init);
> +	return false;
>  }
>  
>  void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 833bf2cfd2a3..1f30080a7a4c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -95,19 +95,24 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>  
> -void __kasan_unpoison_pages(struct page *page, unsigned int order, bool init)
> +bool __kasan_unpoison_pages(struct page *page, unsigned int order, bool init)
>  {
>  	u8 tag;
>  	unsigned long i;
>  
>  	if (unlikely(PageHighMem(page)))
> -		return;
> +		return false;
> +
> +	if (!kasan_sample_page_alloc())
> +		return false;
>  
>  	tag = kasan_random_tag();
>  	kasan_unpoison(set_tag(page_address(page), tag),
>  		       PAGE_SIZE << order, init);
>  	for (i = 0; i < (1 << order); i++)
>  		page_kasan_tag_set(page + i, tag);
> +
> +	return true;
>  }
>  
>  void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index b22c4f461cb0..aa3b5a080297 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -59,6 +59,11 @@ EXPORT_SYMBOL_GPL(kasan_mode);
>  /* Whether to enable vmalloc tagging. */
>  DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
>  
> +/* Frequency of page_alloc allocation poisoning. */
> +unsigned long kasan_page_alloc_sample = 1;
> +
> +DEFINE_PER_CPU(unsigned long, kasan_page_alloc_count);
> +
>  /* kasan=off/on */
>  static int __init early_kasan_flag(char *arg)
>  {
> @@ -122,6 +127,27 @@ static inline const char *kasan_mode_info(void)
>  		return "sync";
>  }
>  
> +/* kasan.page_alloc.sample=<sampling frequency> */
> +static int __init early_kasan_flag_page_alloc_sample(char *arg)
> +{
> +	int rv;
> +
> +	if (!arg)
> +		return -EINVAL;
> +
> +	rv = kstrtoul(arg, 0, &kasan_page_alloc_sample);
> +	if (rv)
> +		return rv;
> +
> +	if (!kasan_page_alloc_sample) {
> +		kasan_page_alloc_sample = 1;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +early_param("kasan.page_alloc.sample", early_kasan_flag_page_alloc_sample);
> +
>  /*
>   * kasan_init_hw_tags_cpu() is called for each CPU.
>   * Not marked as __init as a CPU can be hot-plugged after boot.
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index abbcc1b0eec5..ee67eb35f4a7 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -42,6 +42,9 @@ enum kasan_mode {
>  
>  extern enum kasan_mode kasan_mode __ro_after_init;
>  
> +extern unsigned long kasan_page_alloc_sample;
> +DECLARE_PER_CPU(unsigned long, kasan_page_alloc_count);
> +
>  static inline bool kasan_vmalloc_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_vmalloc);
> @@ -57,6 +60,13 @@ static inline bool kasan_sync_fault_possible(void)
>  	return kasan_mode == KASAN_MODE_SYNC || kasan_mode == KASAN_MODE_ASYMM;
>  }
>  
> +static inline bool kasan_sample_page_alloc(void)
> +{
> +	unsigned long *count = this_cpu_ptr(&kasan_page_alloc_count);

this_cpu_inc_return()

without it, you need to ensure preemption is disabled around here.

> +
> +	return (*count)++ % kasan_page_alloc_sample == 0;

Doing '%' is a potentially costly operation if called in a fast-path.

We can generate better code with (rename 'count' -> 'skip'):

	long skip_next = this_cpu_dec_return(kasan_page_alloc_skip);

	if (skip_next < 0) {
		this_cpu_write(kasan_page_alloc_skip, kasan_page_alloc_sample - 1);
		return true;
	}

	return false;

Important is also to switch the counter to a 'long', otherwise you'd
have to pre-initialize all of them to something non-zero to avoid wrap.
