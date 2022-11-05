Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B8D61A6B3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKEBkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKEBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:40:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78420193
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:40:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f186-20020a636ac3000000b0044adaa7d347so3296512pgc.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8jkJGrxn/AkT1+zj9lg1NbIOC+/Y0zcaC/bhas2fS20=;
        b=sj1uClZYPWF9+g/Af6U4lnd/QJhXqeY3U+fGEwKz1MyD8aXjH0oZ0MZFjaSc6iuZLu
         zCdJYg8aA0oDVN58TmQ95Jm0SX7knr8iOICAk6In4Z3Zbb+Mz+b59VHuotsDCPKAf0OA
         j1gW8EYpt++wGl9NTi3NqMeFWAptSSYuZTEZsnKYNdAoVHRuLqoUY3sSQo+nDU61WdgA
         5dwYUptpKy/a2PkcHkBhFsf/CujyPzLixs3RwqOEtbLanGANqZNoBnq9b3gE+iJq+hit
         eW+6YW19QOIUUELIv4oHvt54A5yWsRzqCEr78MVJU1wSdEWEHHdGSnkICTwkbiEo7SqX
         6wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jkJGrxn/AkT1+zj9lg1NbIOC+/Y0zcaC/bhas2fS20=;
        b=wXBfHzNnofSWdpDznnS+ArJtq9BFfjbfxZgelZY6QAjbNSDAxoreV8+spc0w43xyzs
         f5RHxE3ggVzdfzGQfFNbE6bIVp58aHLb/YHInsgd9+txpXCvP61JN5GAUERJZ6JYOY/A
         WLF7w9FmKo3drFTK7mLqu0CtVTS5vHSx9vtxAWXh8fusQf0ClFHj92y6MGZgxEggHyi4
         3XDzg3W2pSWaGMMMYbb7A0uLpj+s5JJO7pZl9QrYDEpi3vZoYhYV0icTJemzAJ13h5v0
         j6kHbRMNZMk3iPBPygYy16Ib69YGEUvxxWeHmjPQcK9j6udOPJktRKS6mr0OubWlYiUI
         iD3w==
X-Gm-Message-State: ANoB5pmcsY2EkP9V82lnQCTFF2hWMNgsNlvZ5T8c/V/05XkdlIbnQv06
        9tdZKP3oOY5ZKE5wEe4tliqyfDrwAbIVmQ==
X-Google-Smtp-Source: AA0mqf6jfoCQ+f91qDyQhm2aDDOkq+E3ZjTnt72QOCfo1bxzDsUFyW3esvQ31twA11J5QruAiX9io9bm22nHyA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:f291:b0:20a:eab5:cf39 with SMTP
 id fs17-20020a17090af29100b0020aeab5cf39mr99870pjb.1.1667612428036; Fri, 04
 Nov 2022 18:40:28 -0700 (PDT)
Date:   Sat,  5 Nov 2022 01:40:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221105014013.930636-1-shakeelb@google.com>
Subject: [PATCH] percpu_counter: add percpu_counter_sum_all interface
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
percpu_counter_sum_all() which traverses all possible CPUs.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/percpu_counter.h |  6 ++++++
 kernel/fork.c                  |  2 +-
 lib/percpu_counter.c           | 29 +++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 7 deletions(-)

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

