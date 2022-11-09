Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC062214A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKIBUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKIBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:20:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99A5EF86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:20:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j132-20020a25238a000000b006da635e2073so1937373ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6fE8FxgLYcEMehZwA0N2DtD/pkodntXjTOaWzFjwNs=;
        b=G82DxUUKkFjF1wncsDmqTkLHk/sd6bqbbW7zwR50cMvz+RdKCgOeSxk0UULEPJJNlr
         yMFSXKPE5k0lRGeJ6fqMnnb4rJ+NU4TCxBZp5EG9ZI12XRc/trq3ERWA7PaDo+9OKeOy
         PFGL2GoKlGQsaUFuJLOzc3SJOsY49x1KRsslIVE4nBisGr9OFBwpn2SVR3y2cdyQf0sS
         van/mFWpqxXYXMlRbZpW5XE0SdzmxdYZqUhgRSjDNXTE80xPVue+l88ks6IE8eUqCjQY
         xuGJC8AmyFZeE5+GKBreMsUuXpJorjREReJishdpfBFsIK2RltclZPvJd36HgBZx9bzi
         h5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6fE8FxgLYcEMehZwA0N2DtD/pkodntXjTOaWzFjwNs=;
        b=T9vYdK8CCFCsW6wfW9fi58kgxikZ5QLDsSms099ucyWKam3mFLvKIFisuV/iy2HyQg
         z+3uERdKp5Ph/uQmaw+UlzHNQPCA+6AFaCT9D+9CRyJejwLyoX8/Mo0oIqVWrPOVP0xm
         Dyp+D1b6WB3P+Mz6qEVp2ZhTJ2FFSw8qc3aZNa8XjRQxX0VdVe8a3cLg5WCIsDomqXSn
         r9iWePPFIU24o+bJgAA0sMfhghj9MRIdJz2TdUiC3sRHBTtOfXWvo7WqjaL1/sGh1qh0
         dGio/HubftQ9WeuLoAbeXAUSHsnX2l299SV+KAGgKYaHFlqpYuj+eY7tHTkcu+p9EHrO
         qe/w==
X-Gm-Message-State: ACrzQf2Oy+GrMLnaGFohsHdKUhiJR7sDNX/+ifLeoB7+QLbR6oTLsJ3q
        eSiMtHpLUBwWtIXa2e2qVGzG+brO1pPimg==
X-Google-Smtp-Source: AMsMyM72KpCDzxmSblP6ZCKZ9EceK0P0lmfreJqtFk2a010bAeguR4EBWdc+isdNeOitpfoDrDjHc1GCOx1abg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a0d:c486:0:b0:370:2f43:e848 with SMTP id
 g128-20020a0dc486000000b003702f43e848mr54229772ywd.361.1667956814847; Tue, 08
 Nov 2022 17:20:14 -0800 (PST)
Date:   Wed,  9 Nov 2022 01:20:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109012011.881058-1-shakeelb@google.com>
Subject: [PATCH v2] percpu_counter: add percpu_counter_sum_all interface
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The percpu_counter is used for scenarios where performance is more
important than the accuracy. For percpu_counter users, who want more
accurate information in their slowpath, percpu_counter_sum is provided
which traverses all the online CPUs to accumulate the data. The reason
it only needs to traverse online CPUs is because percpu_counter does
implement CPU offline callback which syncs the local data of the
offlined CPU.

However there is a small race window between the online CPUs traversal
of percpu_counter_sum and the CPU offline callback. The offline callback
has to traverse all the percpu_counters on the system to flush the CPU
local data which can be a lot. During that time, the CPU which is going
offline has already been published as offline to all the readers. So, as
the offline callback is running, percpu_counter_sum can be called for
one counter which has some state on the CPU going offline. Since
percpu_counter_sum only traverses online CPUs, it will skip that
specific CPU and the offline callback might not have flushed the state
for that specific percpu_counter on that offlined CPU.

Normally this is not an issue because percpu_counter users can deal with
some inaccuracy for small time window. However a new user i.e. mm_struct
on the cleanup path wants to check the exact state of the percpu_counter
through check_mm(). For such users, this patch introduces
percpu_counter_sum_all() which traverses all possible CPUs and it is
used in fork.c:check_mm() to avoid the potential race.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes since v1:
- Only call percpu_counter_sum_all() if percpu_counter_sum() gives
  non-zero value in check_mm().


 include/linux/percpu_counter.h |  6 ++++++
 kernel/fork.c                  |  5 +++++
 lib/percpu_counter.c           | 29 +++++++++++++++++++++++------
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index bde6c4c1f405..a3aae8d57a42 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -45,6 +45,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
 			      s32 batch);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
+s64 percpu_counter_sum_all(struct percpu_counter *fbc);
 int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
 void percpu_counter_sync(struct percpu_counter *fbc);
 
@@ -193,6 +194,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
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
index 9c32f593ef11..9f7fe3541897 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -758,6 +758,11 @@ static void check_mm(struct mm_struct *mm)
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
 		long x = percpu_counter_sum(&mm->rss_stat[i]);
 
+		if (likely(!x))
+			continue;
+
+		/* Making sure this is not due to race with CPU offlining. */
+		x = percpu_counter_sum_all(&mm->rss_stat[i]);
 		if (unlikely(x))
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
 				 mm, resident_page_types[i], x);
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..42f729c8e56c 100644
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
@@ -129,15 +126,35 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 
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
 
+/*
+ * This is slower version of percpu_counter_sum as it traverses all possible
+ * cpus. Use this only in the cases where accurate data is needed in the
+ * presense of CPUs getting offlined.
+ */
+s64 percpu_counter_sum_all(struct percpu_counter *fbc)
+{
+	return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
+}
+EXPORT_SYMBOL(percpu_counter_sum_all);
+
 int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
 			  struct lock_class_key *key)
 {
-- 
2.38.1.431.g37b22c650d-goog

