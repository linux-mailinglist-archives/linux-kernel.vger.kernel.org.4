Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A15618C64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKCXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:02:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64A1EEDA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:02:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221103230230euoutp02da5ced3ccc8441793e3447619fc723ea~kNXfbt2R62473224732euoutp02J
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:02:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221103230230euoutp02da5ced3ccc8441793e3447619fc723ea~kNXfbt2R62473224732euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667516550;
        bh=GgmDiNIKp8jFyJidlrez4FYexY7EQaf+jMXza+lnTLQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=BFxQRxjw1XKU0YAE+AFN6OW1VMF/Hz5UbOfdeRKzhNyAetnYkPc2DVHj1TdmOEtgc
         auicKEkjW+BZoW9YcyxgqOtK8YDmq8n2LdgicAtn/ETwFt8OavT3fvE2lff+mqBd0Y
         OMYm72bEMdSCpfdDqYgS9dcrs46189GJVaCDoNN4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221103230230eucas1p2b5795555b7c9466295afb2520b2e4049~kNXfQgzYO3136331363eucas1p2B;
        Thu,  3 Nov 2022 23:02:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.15.29727.68844636; Thu,  3
        Nov 2022 23:02:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221103230230eucas1p115f8b914489b768b67b8b8fb3c315922~kNXesscxN2595125951eucas1p1t;
        Thu,  3 Nov 2022 23:02:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221103230230eusmtrp1bff8f917010ae6e713cde4899aa6fe3a~kNXesEPiw0465204652eusmtrp1j;
        Thu,  3 Nov 2022 23:02:30 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-48-6364488637dc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.0D.10862.68844636; Thu,  3
        Nov 2022 23:02:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221103230229eusmtip1724124d991ad515d555f77e466f950b1~kNXeYf88S1884018840eusmtip1-;
        Thu,  3 Nov 2022 23:02:29 +0000 (GMT)
Message-ID: <38797f54-3287-496f-a65e-755c1f025e0a@samsung.com>
Date:   Fri, 4 Nov 2022 00:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221103171407.ydubp43x7tzahriq@google.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fO5lGbnObtaXadYjRsuorSLEuKGtGHoCLppmM7mDhvm7M7
        WZKmFW6apkNzYbaa4mjFMiPL1ZwiSN5CzcyY4CVHOSVyYuV2uvjt9/yf//M+F14C4+QxuURS
        aiYlTxXLeCwv3NQy27EhVySVRFjMwZEVhjpWZHdjBStyqO4XM7L5/Re0CxdpjUqR0VHkIWot
        m8NF08ZVB/FjXtullCwpi5KHxyR4ne6YrmWkv4o6+8MwzMhGI4ICRBBAbgZNS1wB8iI45EME
        5c67TDqYQVDaUYjTwTSCku965t+K4rJMWtch+KZyLJg8F4IpBG2P/V3MJmPg5mwVy8U4GQJX
        xm5htL4M2spH3H5/Ugovbpjc7EvuhpaaEjdjZCAMjFQxXOxHhsK0rgjRuhjmSwweLmaRQiiw
        F7jf9ySjYKYpF6M9q+GZvQJzDQfkawJUxk53Asg9cKth2INmX5iwPv3DK6C9+CZOF+Qh0M59
        YtCBCkH26ACiXdEw2OFkudbHyPVgaAyn5Vjora/E6av4QJ99GT2EDxSZ7mC0zIbruRzaHQoa
        a/2/ts3vujAV4mkWnUWzaH3NonU0//tqEa5HgZRSkZJIKYSp1BmBQpyiUKYmCiRpKUa08Ffa
        f1odDahyYkpgRgwCmREQGM+P7TBJJBy2VHzuPCVPi5crZZTCjIIInBfIZpXxJRwyUZxJJVNU
        OiX/m2UQntxsxpLkmIwdg+J+2ezxi1M1eN/dlepTV5OacvJxywe7D7Oyuud8y1bT2tvnWn/c
        60QPgvuwd9y9/SYsT3Cvj6qJH6396r0x385fvvJzkHdhY+zD7ksZnfn3+dVadVj6be5k0MDl
        r4U1xZYeXZK0a4vBmqOaKr/20mbbdVCNujNOktLA9f0T6w6YA1j7xoZ8J2YOWeZ56p7oJwZH
        cqmQ8dzybNtO55LeNegaU/tGueXtDnvO5AVZwFa1pjpOnz/prEsIyfqo21+1m+t5VIdmQmeP
        VZ9M0Dd01/oqg5vbS21H+NtPLJ0UgE0zULrGozE2azxief2js2HC/ZvGbf7OwwF7ebjitFjI
        x+QK8W8A5kHlmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7ptHinJBnemslrMWb+GzeLyrjls
        FvfW/Ge1OHjtNaMDi8eCTaUemz5NYvc4MeM3i8fnTXIBLFF6NkX5pSWpChn5xSW2StGGFkZ6
        hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gec+r2Yq2G9Z8WP9A6YGxid6XYwcHBIC
        JhKTZ5R0MXJxCAksZZR4PPkeYxcjJ1BcRuLktAZWCFtY4s+1LjaIoveMEg/6TrCBJHgF7CR6
        fs4Hs1kEVCQaX/QyQ8QFJU7OfMICskBUIEXi27k6kLCwgLPEsaVTWUBsZgFxiVtP5jOB2CIC
        ahKfl09ihIgnSvT2fAbbKyTwiVGi4SdYDZuAoUTX2y6wVZwClhJf9rUxQ9SbSXRt7YLqlZfY
        /nYO8wRGoVlIrpiFZN0sJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERhH2479
        3LKDceWrj3qHGJk4GA8xSnAwK4nwftqWnCzEm5JYWZValB9fVJqTWnyI0RQYFBOZpUST84GR
        nFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwNQ0mW/Z0xeRO087
        eF8qtFScwvlB+NysYKvDWRdOGYeF/e9/dyJwbdLGpuU+eUYTVJM7bmyZ67f0p7fztvoM898+
        Gqtn7/iVJ6+v8kRyYXTCMcbHB5sbZn1rqwj+OW/S03zJzsuGb6oUE4/+kDc4eGH+818Oy5IE
        PJ57vdwwz6Lko1/dd+ONL/QCr9x5sXT2La937vMD5ZI6PvdMddiYFtnQHTozcO++30lVb+Wt
        r50XrFBetFXxYrePpmSEhkzfjtmrWSrrBaQbLqScVnqfHuhlvc1t6e0YIxOb63pCf+e8ulxk
        ccDU1OnjTZHUxCyrtId1fP0//G9UynCeOPPBRuCLQ86ZO0lewer3H82NNVFiKc5INNRiLipO
        BABva52GLAMAAA==
X-CMS-MailID: 20221103230230eucas1p115f8b914489b768b67b8b8fb3c315922
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd
References: <20221024052841.3291983-1-shakeelb@google.com>
        <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
        <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com>
        <20221103171407.ydubp43x7tzahriq@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03.11.2022 18:14, Shakeel Butt wrote:
> On Wed, Nov 02, 2022 at 10:09:57PM +0100, Marek Szyprowski wrote:
>> On 24.10.2022 07:28, Shakeel Butt wrote:
>>> Currently mm_struct maintains rss_stats which are updated on page fault
>>> and the unmapping codepaths. For page fault codepath the updates are
>>> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
>>> The reason for caching is performance for multithreaded applications
>>> otherwise the rss_stats updates may become hotspot for such
>>> applications.
>>>
>>> However this optimization comes with the cost of error margin in the rss
>>> stats. The rss_stats for applications with large number of threads can
>>> be very skewed. At worst the error margin is (nr_threads * 64) and we
>>> have a lot of applications with 100s of threads, so the error margin can
>>> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
>>>
>>> Recently we started seeing the unbounded errors for rss_stats for
>>> specific applications which use TCP rx0cp. It seems like
>>> vm_insert_pages() codepath does not sync rss_stats at all.
>>>
>>> This patch converts the rss_stats into percpu_counter to convert the
>>> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
>>> However this conversion enable us to get the accurate stats for
>>> situations where accuracy is more important than the cpu cost. Though
>>> this patch does not make such tradeoffs.
>>>
>>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> This patch landed recently in linux-next as commit d59f19a7a068 ("mm:
>> convert mm's rss stats into percpu_counter"). Unfortunately it causes a
>> regression on my test systems. I've noticed that it triggers a 'BUG: Bad
>> rss-counter state' warning from time to time for random processes. This
>> is somehow related to CPU hot-plug and/or system suspend/resume. The
>> easiest way to reproduce this issue (although not always) on my test
>> systems (ARM or ARM64 based) is to run the following commands:
>>
>> root@target:~# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0
>>   >$i/online;
>> BUG: Bad rss-counter state mm:f04c7160 type:MM_FILEPAGES val:1
>> BUG: Bad rss-counter state mm:50f1f502 type:MM_FILEPAGES val:2
>> BUG: Bad rss-counter state mm:50f1f502 type:MM_ANONPAGES val:15
>> BUG: Bad rss-counter state mm:63660fd0 type:MM_FILEPAGES val:2
>> BUG: Bad rss-counter state mm:63660fd0 type:MM_ANONPAGES val:15
>>
>> Let me know if I can help debugging this somehow or testing a fix.
>>
> Hi Marek,
>
> Thanks for the report. It seems like there is a race between
> for_each_online_cpu() in __percpu_counter_sum() and
> percpu_counter_cpu_dead()/cpu-offlining. Normally this race is fine for
> percpu_counter users but for check_mm() is not happy with this race. Can
> you please try the following patch:
>
>
> From: Shakeel Butt <shakeelb@google.com>
> Date: Thu, 3 Nov 2022 06:05:13 +0000
> Subject: [PATCH] mm: percpu_counter: use race free percpu_counter sum
>   interface
>
> percpu_counter_sum can race with cpu offlining. Add a new interface
> which does not race with it and use that for check_mm().
> ---
>   include/linux/percpu_counter.h | 11 +++++++++++
>   kernel/fork.c                  |  2 +-
>   lib/percpu_counter.c           | 24 ++++++++++++++++++------
>   3 files changed, 30 insertions(+), 7 deletions(-)


Yes, this seems to fix the issue I've reported. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index bde6c4c1f405..3070c1043acf 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -45,6 +45,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>   void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>   			      s32 batch);
>   s64 __percpu_counter_sum(struct percpu_counter *fbc);
> +s64 __percpu_counter_sum_all(struct percpu_counter *fbc);
>   int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
>   void percpu_counter_sync(struct percpu_counter *fbc);
>   
> @@ -85,6 +86,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
>   	return __percpu_counter_sum(fbc);
>   }
>   
> +static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_all(fbc);
> +}
> +
>   static inline s64 percpu_counter_read(struct percpu_counter *fbc)
>   {
>   	return fbc->count;
> @@ -193,6 +199,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
>   	return percpu_counter_read(fbc);
>   }
>   
> +static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
> +{
> +	return percpu_counter_read(fbc);
> +}
> +
>   static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
>   {
>   	return true;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9c32f593ef11..7d6f510cf397 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
>   			 "Please make sure 'struct resident_page_types[]' is updated as well");
>   
>   	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
> +		long x = percpu_counter_sum_all(&mm->rss_stat[i]);
>   
>   		if (unlikely(x))
>   			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index ed610b75dc32..f26a1a5df399 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -117,11 +117,8 @@ void percpu_counter_sync(struct percpu_counter *fbc)
>   }
>   EXPORT_SYMBOL(percpu_counter_sync);
>   
> -/*
> - * Add up all the per-cpu counts, return the result.  This is a more accurate
> - * but much slower version of percpu_counter_read_positive()
> - */
> -s64 __percpu_counter_sum(struct percpu_counter *fbc)
> +static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
> +			      const struct cpumask *cpu_mask)
>   {
>   	s64 ret;
>   	int cpu;
> @@ -129,15 +126,30 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>   
>   	raw_spin_lock_irqsave(&fbc->lock, flags);
>   	ret = fbc->count;
> -	for_each_online_cpu(cpu) {
> +	for_each_cpu(cpu, cpu_mask) {
>   		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
>   		ret += *pcount;
>   	}
>   	raw_spin_unlock_irqrestore(&fbc->lock, flags);
>   	return ret;
>   }
> +
> +/*
> + * Add up all the per-cpu counts, return the result.  This is a more accurate
> + * but much slower version of percpu_counter_read_positive()
> + */
> +s64 __percpu_counter_sum(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_mask(fbc, cpu_online_mask);
> +}
>   EXPORT_SYMBOL(__percpu_counter_sum);
>   
> +s64 __percpu_counter_sum_all(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
> +}
> +EXPORT_SYMBOL(__percpu_counter_sum_all);
> +
>   int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
>   			  struct lock_class_key *key)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

