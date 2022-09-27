Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0646F5EC436
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiI0NUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiI0NTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:19:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C41A81C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:17:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f20so13154895edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=In1vsB/Xjfh9ZnfNvqM8dWCAty6NwecZWkJggwcWzrI=;
        b=MPWNC1rEjW7iV+yNpMgr+SzEHDVYyrzeSE/RS9EgXzVVBXCdqcy9R2rn7oMTdIv5kW
         9t8PCuiUQ6MZ6NdTKOIpVMTdkq4MaHiSsrCvHsfoaUwLYTfW7hSAPWTz7SLkL0SF4W6i
         5hasBut3NxwqG7HNMPfj/d1P2zT2pg5JVg0cdYPyokTTZ9VHIJ/ZuZdr3L00Y9hKiatJ
         rOZ9lk7HlOUHhPvXYNZB0uHX3uHMtZo+KQKWGPwEAsSKqdsotTE/sfWDJ1Uv65cFJKso
         kw4h/iMz5kr5xoi0l2bwMUGpj+3MgZGceQZve1+G1pnyEmwoBO84TTOuUzNdOt8H5x9M
         /9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=In1vsB/Xjfh9ZnfNvqM8dWCAty6NwecZWkJggwcWzrI=;
        b=r8m//PyLiL9whpVjeWBcbIGnkXXxfbnIMmhc+SEugco73hJI270YmyMkpbe6YWug0/
         ITzILlFqSUnuv5OyP2F0kI97/SFWb5MqSinsYB6AO9B5U9RoiWOdoq8ZqA3TQF+WAUKV
         Z2rgAiJySnvOtScSXjezHOJ/8T+e+SBYDQOlr8yeIx45xDTnuMYw02r4yuH6DPeLHg4S
         ZZQ55ysimIZFRv7n3cpgFr5hyH8xJFD+EjnMks6G1bAErDaKJaJtrYUnKzMqceWDh5WV
         bVWKYre9tWmmE/x3C2sThjFGvVL2iVjAKrSNd0L7zYC2KrxOZ8gnb8yS7fiNc1DVYj7d
         4BAw==
X-Gm-Message-State: ACrzQf3eQXqsWgPoOLLkcD2dtcwcUzKc8rwvR3dTlLD7VYlXQ/hAbOgy
        fQBl1M/kvoHmabJPPlIDlYvozw==
X-Google-Smtp-Source: AMsMyM70B36DrxzZchpp1McX0IFVOUt/Lxru8O6Pu+f9ZlH/RHOKYouT7tKEvgOLgcC3fVCCwkzY6A==
X-Received: by 2002:aa7:cc8a:0:b0:446:7668:2969 with SMTP id p10-20020aa7cc8a000000b0044676682969mr27808864edt.206.1664284638152;
        Tue, 27 Sep 2022 06:17:18 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0077fbef08212sm100359ejx.22.2022.09.27.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:17:17 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:17:10 +0200
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
Subject: Re: [PATCH mm 3/3] kasan: migrate workqueue_uaf test to kunit
Message-ID: <YzL31u9qOOPRVVHM@elver.google.com>
References: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
 <2815073f2be37e554f7f0fd7b1d10e9742be6ce3.1664044241.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2815073f2be37e554f7f0fd7b1d10e9742be6ce3.1664044241.git.andreyknvl@google.com>
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
> Migrate the workqueue_uaf test to the KUnit framework.
> 
> Initially, this test was intended to check that Generic KASAN prints
> auxiliary stack traces for workqueues. Nevertheless, the test is enabled
> for all modes to make that KASAN reports bad accesses in the tested
> scenario.
> 
> The presence of auxiliary stack traces for the Generic mode needs to be
> inspected manually.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan_test.c        | 40 +++++++++++++++++++++++++++++-------
>  mm/kasan/kasan_test_module.c | 30 ---------------------------
>  2 files changed, 33 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 005776325e20..71cb402c404f 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1134,6 +1134,14 @@ static void kmalloc_double_kzfree(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
>  }
>  
> +/*
> + * The two tests below check that Generic KASAN prints auxiliary stack traces
> + * for RCU callbacks and workqueues. The reports need to be inspected manually.
> + *
> + * These tests are still enabled for other KASAN modes to make sure that all
> + * modes report bad accesses in tested scenarios.
> + */
> +
>  static struct kasan_rcu_info {
>  	int i;
>  	struct rcu_head rcu;
> @@ -1148,13 +1156,6 @@ static void rcu_uaf_reclaim(struct rcu_head *rp)
>  	((volatile struct kasan_rcu_info *)fp)->i;
>  }
>  
> -/*
> - * Check that Generic KASAN prints auxiliary stack traces for RCU callbacks.
> - * The report needs to be inspected manually.
> - *
> - * This test is still enabled for other KASAN modes to make sure that all modes
> - * report bad accesses in tested scenarios.
> - */
>  static void rcu_uaf(struct kunit *test)
>  {
>  	struct kasan_rcu_info *ptr;
> @@ -1170,6 +1171,30 @@ static void rcu_uaf(struct kunit *test)
>  		rcu_barrier());
>  }
>  
> +static void workqueue_uaf_work(struct work_struct *work)
> +{
> +	kfree(work);
> +}
> +
> +static void workqueue_uaf(struct kunit *test)
> +{
> +	struct workqueue_struct *workqueue;
> +	struct work_struct *work;
> +
> +	workqueue = create_workqueue("kasan_workqueue_test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, workqueue);
> +
> +	work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
> +
> +	INIT_WORK(work, workqueue_uaf_work);
> +	queue_work(workqueue, work);
> +	destroy_workqueue(workqueue);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test,
> +		((volatile struct work_struct *)work)->data);
> +}
> +
>  static void vmalloc_helpers_tags(struct kunit *test)
>  {
>  	void *ptr;
> @@ -1502,6 +1527,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_bitops_tags),
>  	KUNIT_CASE(kmalloc_double_kzfree),
>  	KUNIT_CASE(rcu_uaf),
> +	KUNIT_CASE(workqueue_uaf),
>  	KUNIT_CASE(vmalloc_helpers_tags),
>  	KUNIT_CASE(vmalloc_oob),
>  	KUNIT_CASE(vmap_tags),
> diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
> index 4688cbcd722d..7be7bed456ef 100644
> --- a/mm/kasan/kasan_test_module.c
> +++ b/mm/kasan/kasan_test_module.c
> @@ -62,35 +62,6 @@ static noinline void __init copy_user_test(void)
>  	kfree(kmem);
>  }
>  
> -static noinline void __init kasan_workqueue_work(struct work_struct *work)
> -{
> -	kfree(work);
> -}
> -
> -static noinline void __init kasan_workqueue_uaf(void)
> -{
> -	struct workqueue_struct *workqueue;
> -	struct work_struct *work;
> -
> -	workqueue = create_workqueue("kasan_wq_test");
> -	if (!workqueue) {
> -		pr_err("Allocation failed\n");
> -		return;
> -	}
> -	work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
> -	if (!work) {
> -		pr_err("Allocation failed\n");
> -		return;
> -	}
> -
> -	INIT_WORK(work, kasan_workqueue_work);
> -	queue_work(workqueue, work);
> -	destroy_workqueue(workqueue);
> -
> -	pr_info("use-after-free on workqueue\n");
> -	((volatile struct work_struct *)work)->data;
> -}
> -
>  static int __init test_kasan_module_init(void)
>  {
>  	/*
> @@ -101,7 +72,6 @@ static int __init test_kasan_module_init(void)
>  	bool multishot = kasan_save_enable_multi_shot();
>  
>  	copy_user_test();
> -	kasan_workqueue_uaf();
>  
>  	kasan_restore_multi_shot(multishot);
>  	return -EAGAIN;
> -- 
> 2.25.1
