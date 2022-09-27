Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C315EC414
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiI0NRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiI0NQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:16:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6243A495
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:16:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so20569438ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gOghRmjXnciU76OT1A5CBEYlu/dhJhD2q5qbX7Y7RKE=;
        b=WAFjLp8rur6R1phCypQM6uyHOmFoaqPWVTnLZ1DdkHNLV3XzPpC0zLI4pvBlCcLglQ
         248uCThRrKCvRpct7s5O7E6JJbjG4t0pObFQ8TcaL+kpIbXDMeHqjWu4cXbAppr2mFPg
         t3OINuwZZ3CWwh5vo4QSpeIbUPrJI4YbPf/6m8IenX1AylzglsR33mjJ3UEJo8NuWMW7
         YfGXU9fhija82zdcDTpRnq4P72eAVA6dSYdc/CAqQABKrCV1/KOh6eGkxrqKZGa/lmQP
         EeJtXq0sjiTWO+D1uJTooWxDGORg06+AW1voKk+6yOgGxCwzZfS/6Rat6+33JvGkSg/N
         0AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gOghRmjXnciU76OT1A5CBEYlu/dhJhD2q5qbX7Y7RKE=;
        b=lLMP5MTYt6D49MvwAaBVx8NwpSfE4vuhdLL1thS/QyQZfujXlIWVtHMMvFUKlkWvkW
         lAYW4x3Ewg/63EAE2zRhtIH5GOGgM0gAj0uhGX0rvDVnYEXdt8zLEdWAjc3YsritR6Cy
         1g+c51oZ1rvoCMrABNxQBtuEkoIucy/qEHhX6yIbk38Z/zP/chSoG4c6KzuWTnAWCUPb
         FmdHv+41QGytzEf4XL3YQ5witsgoygeQU5zNf+vy7/IxiWCD9Q1XosEKFbxnCxvQBzgq
         77MNoq2k2ZeyKKlbEkw056h7whTvOTyFqSLArrUNAJsngxN/oEkgZvlFhVE8AQwf0lBN
         gNfQ==
X-Gm-Message-State: ACrzQf2ZDfCAf/imJb4X8TPqDYlxsucov1afUTQFhXK2jDvtoRvdGHD0
        RVqd4ZTnr6j9ibo9N+lQzABHkA==
X-Google-Smtp-Source: AMsMyM6s23Af8VoW94bp9SYXn9ovAeDvmBwYaybrJ+VhDh2jlptgQzRxPStqowchMzz2BBAx4dnaaQ==
X-Received: by 2002:a17:906:8a6f:b0:780:96b4:d19e with SMTP id hy15-20020a1709068a6f00b0078096b4d19emr22599889ejc.624.1664284586284;
        Tue, 27 Sep 2022 06:16:26 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b004571907240asm1270416edx.36.2022.09.27.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:16:25 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:16:20 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm 2/3] kasan: migrate kasan_rcu_uaf test to kunit
Message-ID: <YzL3pIi/0vlAYCUB@elver.google.com>
References: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
 <bc3b1d29d8addd24738982c44b717fbbe6dff8e9.1664044241.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3b1d29d8addd24738982c44b717fbbe6dff8e9.1664044241.git.andreyknvl@google.com>
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

On Sat, Sep 24, 2022 at 08:31PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Migrate the kasan_rcu_uaf test to the KUnit framework.
> 
> Changes to the implementation of the test:
> 
> - Call rcu_barrier() after call_rcu() to make that the RCU callbacks get
>   triggered before the test is over.
> 
> - Cast pointer passed to rcu_dereference_protected as __rcu to get rid of
>   the Sparse warning.
> 
> - Check that KASAN prints a report via KUNIT_EXPECT_KASAN_FAIL.
> 
> Initially, this test was intended to check that Generic KASAN prints
> auxiliary stack traces for RCU objects. Nevertheless, the test is enabled
> for all modes to make that KASAN reports bad accesses in RCU callbacks.
> 
> The presence of auxiliary stack traces for the Generic mode needs to be
> inspected manually.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan_test.c        | 37 ++++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan_test_module.c | 30 -----------------------------
>  2 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 3a2886f85e69..005776325e20 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1134,6 +1134,42 @@ static void kmalloc_double_kzfree(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
>  }
>  
> +static struct kasan_rcu_info {
> +	int i;
> +	struct rcu_head rcu;
> +} *global_rcu_ptr;
> +
> +static void rcu_uaf_reclaim(struct rcu_head *rp)
> +{
> +	struct kasan_rcu_info *fp =
> +		container_of(rp, struct kasan_rcu_info, rcu);
> +
> +	kfree(fp);
> +	((volatile struct kasan_rcu_info *)fp)->i;
> +}
> +
> +/*
> + * Check that Generic KASAN prints auxiliary stack traces for RCU callbacks.
> + * The report needs to be inspected manually.
> + *
> + * This test is still enabled for other KASAN modes to make sure that all modes
> + * report bad accesses in tested scenarios.
> + */
> +static void rcu_uaf(struct kunit *test)
> +{
> +	struct kasan_rcu_info *ptr;
> +
> +	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +	global_rcu_ptr = rcu_dereference_protected(
> +				(struct kasan_rcu_info __rcu *)ptr, NULL);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test,
> +		call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> +		rcu_barrier());
> +}
> +
>  static void vmalloc_helpers_tags(struct kunit *test)
>  {
>  	void *ptr;
> @@ -1465,6 +1501,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_bitops_generic),
>  	KUNIT_CASE(kasan_bitops_tags),
>  	KUNIT_CASE(kmalloc_double_kzfree),
> +	KUNIT_CASE(rcu_uaf),
>  	KUNIT_CASE(vmalloc_helpers_tags),
>  	KUNIT_CASE(vmalloc_oob),
>  	KUNIT_CASE(vmap_tags),
> diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
> index e4ca82dc2c16..4688cbcd722d 100644
> --- a/mm/kasan/kasan_test_module.c
> +++ b/mm/kasan/kasan_test_module.c
> @@ -62,35 +62,6 @@ static noinline void __init copy_user_test(void)
>  	kfree(kmem);
>  }
>  
> -static struct kasan_rcu_info {
> -	int i;
> -	struct rcu_head rcu;
> -} *global_rcu_ptr;
> -
> -static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
> -{
> -	struct kasan_rcu_info *fp = container_of(rp,
> -						struct kasan_rcu_info, rcu);
> -
> -	kfree(fp);
> -	((volatile struct kasan_rcu_info *)fp)->i;
> -}
> -
> -static noinline void __init kasan_rcu_uaf(void)
> -{
> -	struct kasan_rcu_info *ptr;
> -
> -	pr_info("use-after-free in kasan_rcu_reclaim\n");
> -	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
> -	if (!ptr) {
> -		pr_err("Allocation failed\n");
> -		return;
> -	}
> -
> -	global_rcu_ptr = rcu_dereference_protected(ptr, NULL);
> -	call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
> -}
> -
>  static noinline void __init kasan_workqueue_work(struct work_struct *work)
>  {
>  	kfree(work);
> @@ -130,7 +101,6 @@ static int __init test_kasan_module_init(void)
>  	bool multishot = kasan_save_enable_multi_shot();
>  
>  	copy_user_test();
> -	kasan_rcu_uaf();
>  	kasan_workqueue_uaf();
>  
>  	kasan_restore_multi_shot(multishot);
> -- 
> 2.25.1
