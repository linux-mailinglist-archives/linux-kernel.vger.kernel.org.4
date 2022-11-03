Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE186185FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiKCRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiKCROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:14:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A91D0C4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:14:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-373569200ceso24062667b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4dPaNZUF+FLVyD4KDNkcedA4kyLOnqLhZHYhiV98ak=;
        b=XO1QzccCzEHSaizdJ83Md7LFtvvRxyWNQHfG62OAa45yrTp9K6XxJ3Ra+brK0cKdYU
         1SbetESIZMD4tYcwhwENH+u6njmTg4vOGG6KIL9351fkVep+FXOEwo8mZ2D5fbv8L8Wq
         DzI8Jp8FyEd7dZ9ZMo2D0tm8/la9NU2L0S9OkLGLRzMFTpJ06e2JWSmF5NJuVUyFd5cG
         ThuiUaHIG084PkuQn3c2hn5eVCmXY9QicYaasQSvLrhpAQEbyugdo2cvX274ahZphCAf
         stXvXIjXfXB1xzzE6a8aQ7mveiBjccf57fxHcAd48c95XZHdFlVBn0w+LaCH0VeRkJ+K
         oNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4dPaNZUF+FLVyD4KDNkcedA4kyLOnqLhZHYhiV98ak=;
        b=0CTnB1kWYkcWnK/cIN2kJRPu85Dv7rRkBUNVZyKiW27yxdIdTHBWB+bNzzouwaeMAU
         bRMXC7SCp5JI4oPo5LFAHadNiuG8ngNt6Ki+Gyc3G8MARwwg0K2bTsJE5StYsEJ0nS13
         JQmnpwKeF/vcaoBpAAL5bVPi1tgFGMUj3k/AaawpEVimFM/uxtCzXO2Cj7i1L9Wkil0I
         kxGntCazXxlXh1LktEny931K5/R7kAWmb19DEdYEvwONUIaPnTUSswv7pGl5T+9vBJoN
         V30/jnm5B+1Ymk+u1Uun8MKZjoxaQKp7digEiCoe8o9V23oLJYtkDL24vymbkJ53e7jt
         izwg==
X-Gm-Message-State: ACrzQf3tjpEgBKVYS1t5qp/pD0I48s9tlKnAKcmuC4uFXAzOCzgKU9Ht
        ldyRZzFVLd+lR2H0ddwU8H7GGbhFiLprrA==
X-Google-Smtp-Source: AMsMyM5LBrYoIRdr3ZeIZmYO9AkJTvHgSUQEWmasSB7+sJd5ifxB6H9vp5f0aNdYlI2gMz4DsYPjwkj9LzMQgQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a0d:f941:0:b0:35f:a7f3:a3da with SMTP id
 j62-20020a0df941000000b0035fa7f3a3damr185097ywf.69.1667495650844; Thu, 03 Nov
 2022 10:14:10 -0700 (PDT)
Date:   Thu, 3 Nov 2022 17:14:07 +0000
In-Reply-To: <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com>
Mime-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
 <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com>
Message-ID: <20221103171407.ydubp43x7tzahriq@google.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
From:   Shakeel Butt <shakeelb@google.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:09:57PM +0100, Marek Szyprowski wrote:
> Hi
> 
> On 24.10.2022 07:28, Shakeel Butt wrote:
> > Currently mm_struct maintains rss_stats which are updated on page fault
> > and the unmapping codepaths. For page fault codepath the updates are
> > cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> > The reason for caching is performance for multithreaded applications
> > otherwise the rss_stats updates may become hotspot for such
> > applications.
> >
> > However this optimization comes with the cost of error margin in the rss
> > stats. The rss_stats for applications with large number of threads can
> > be very skewed. At worst the error margin is (nr_threads * 64) and we
> > have a lot of applications with 100s of threads, so the error margin can
> > be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> >
> > Recently we started seeing the unbounded errors for rss_stats for
> > specific applications which use TCP rx0cp. It seems like
> > vm_insert_pages() codepath does not sync rss_stats at all.
> >
> > This patch converts the rss_stats into percpu_counter to convert the
> > error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> > However this conversion enable us to get the accurate stats for
> > situations where accuracy is more important than the cpu cost. Though
> > this patch does not make such tradeoffs.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 
> This patch landed recently in linux-next as commit d59f19a7a068 ("mm: 
> convert mm's rss stats into percpu_counter"). Unfortunately it causes a 
> regression on my test systems. I've noticed that it triggers a 'BUG: Bad 
> rss-counter state' warning from time to time for random processes. This 
> is somehow related to CPU hot-plug and/or system suspend/resume. The 
> easiest way to reproduce this issue (although not always) on my test 
> systems (ARM or ARM64 based) is to run the following commands:
> 
> root@target:~# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 
>  >$i/online;
> BUG: Bad rss-counter state mm:f04c7160 type:MM_FILEPAGES val:1
> BUG: Bad rss-counter state mm:50f1f502 type:MM_FILEPAGES val:2
> BUG: Bad rss-counter state mm:50f1f502 type:MM_ANONPAGES val:15
> BUG: Bad rss-counter state mm:63660fd0 type:MM_FILEPAGES val:2
> BUG: Bad rss-counter state mm:63660fd0 type:MM_ANONPAGES val:15
> 
> Let me know if I can help debugging this somehow or testing a fix.
> 

Hi Marek,

Thanks for the report. It seems like there is a race between
for_each_online_cpu() in __percpu_counter_sum() and
percpu_counter_cpu_dead()/cpu-offlining. Normally this race is fine for
percpu_counter users but for check_mm() is not happy with this race. Can
you please try the following patch:


From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 3 Nov 2022 06:05:13 +0000
Subject: [PATCH] mm: percpu_counter: use race free percpu_counter sum
 interface

percpu_counter_sum can race with cpu offlining. Add a new interface
which does not race with it and use that for check_mm().
---
 include/linux/percpu_counter.h | 11 +++++++++++
 kernel/fork.c                  |  2 +-
 lib/percpu_counter.c           | 24 ++++++++++++++++++------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index bde6c4c1f405..3070c1043acf 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -45,6 +45,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
+s64 __percpu_counter_sum_all(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
 void percpu_counter_sync(struct percpu_counter *fbc);
 
@@ -85,6 +86,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 	return __percpu_counter_sum(fbc);
 }
 
+static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum_all(fbc);
+}
+
 static inline s64 percpu_counter_read(struct percpu_counter *fbc)
 {
 	return fbc->count;
@@ -193,6 +199,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
 	return percpu_counter_read(fbc);
 }
 
+static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
+{
+	return percpu_counter_read(fbc);
+}
+
 static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 {
 	return true;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9c32f593ef11..7d6f510cf397 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
+		long x = percpu_counter_sum_all(&mm->rss_stat[i]);
 
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..f26a1a5df399 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -117,11 +117,8 @@ void percpu_counter_sync(struct percpu_counter *fbc)
 }
 EXPORT_SYMBOL(percpu_counter_sync);
 
-/*
- * Add up all the per-cpu counts, return the result.  This is a more accurate
- * but much slower version of percpu_counter_read_positive()
- */
-s64 __percpu_counter_sum(struct percpu_counter *fbc)
+static s64 __percpu_counter_sum_mask(struct percpu_counter *fbc,
+			      const struct cpumask *cpu_mask)
 {
 	s64 ret;
 	int cpu;
@@ -129,15 +126,30 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 
 	raw_spin_lock_irqsave(&fbc->lock, flags);
 	ret = fbc->count;
-	for_each_online_cpu(cpu) {
+	for_each_cpu(cpu, cpu_mask) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
 	raw_spin_unlock_irqrestore(&fbc->lock, flags);
 	return ret;
 }
+
+/*
+ * Add up all the per-cpu counts, return the result.  This is a more accurate
+ * but much slower version of percpu_counter_read_positive()
+ */
+s64 __percpu_counter_sum(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum_mask(fbc, cpu_online_mask);
+}
 EXPORT_SYMBOL(__percpu_counter_sum);
 
+s64 __percpu_counter_sum_all(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
+}
+EXPORT_SYMBOL(__percpu_counter_sum_all);
+
 int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
 			  struct lock_class_key *key)
 {
-- 
2.38.1.431.g37b22c650d-goog

