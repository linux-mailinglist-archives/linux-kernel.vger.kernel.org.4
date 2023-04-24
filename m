Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ABB6EB0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDURkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjDURkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:40:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6312588
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:30 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b6bd2eebaso1799541b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098830; x=1684690830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xVbU1EXT3F/5uSzRhbvwRdAhlPEIhLbnGkOO/O2kc0=;
        b=VsD7UvvlQQthDrDrmrxfA+6j9bxs+fBOtiWfjPuVqKRncTMVYwHyMK7lQKw4z7d6OO
         8f3IhH6XmGqVDVmFY8Cyv6LrhOYmMlAEwO97OjVKp4EfQ7GvmXRUQBA2elyZi2HdAWT8
         tC3JhABpjBI1uwry+YoMsz8jQ+5FjhTBlcxyLfQuh9MawFFcJmVXlkCxxE83KRAGfIRN
         izUhapvRy65QRBOUgMasmNbiSkr8HJo7bR2eGmnfXoyNgGu2rdwIe+txD2JLoEKv7Tja
         ItjbWxT/dXoPWnPJUuXxJqFt3IyOH6lsotFnhAXC0TTQySKSNCNtSjYyYHqymn6WRMKQ
         FgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098830; x=1684690830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xVbU1EXT3F/5uSzRhbvwRdAhlPEIhLbnGkOO/O2kc0=;
        b=c+Wkc8tN3ZggZBxjCjd2SDX0WvLvZlsz/epZBGBlsijzeNBj+n9V4kvnIsRxxxVCFF
         /wxU+KxhazM4g8SKoPm3/kA9bnBA/zhcNvwM0ua96oDg400nTWgxKWBSZJISmtZ8cY46
         bvamz0FoTi0LHehvVGI5FnZAzX8A9dpTXMd8he+CQMUUwvZ8YzUYgq3dXppEts2exv+s
         TgvtvJNSutZY44ZCuTgdMCUzPB7vC3H8iTRoYW83f0EomN8zKV+Dk0J1gwhlm9XTDobY
         Y5UlEpXsHrSe0hphQMh8fCZOo5ShZYuHG5dLZC1Bf345TMEIGCc1vP1nE0Fa5Vboo8Oe
         e5hw==
X-Gm-Message-State: AAQBX9cedyP3EHPc7imBfgS1I98/7c/sqdePW4/mWeQVv4+Q27cCkqZu
        x35mhkEZIjEYKkXUc1mWn2mSiRod1w1/hf8Z
X-Google-Smtp-Source: AKy350a5A112WsBcfM4E2oTlYZXb/Q86xb8XlqVuh7OqAqi/kCn371in9+BxtMemeJoGBiiS6Eu5MnjLStpGGXAY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2e97:b0:62d:9bea:2a0c with
 SMTP id fd23-20020a056a002e9700b0062d9bea2a0cmr2546450pfb.4.1682098830169;
 Fri, 21 Apr 2023 10:40:30 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:19 +0000
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-5-yosryahmed@google.com>
Subject: [PATCH v5 4/5] memcg: remove mem_cgroup_flush_stats_atomic()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patches removed all callers of mem_cgroup_flush_stats_atomic().
Remove the function and simplify the code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  5 -----
 mm/memcontrol.c            | 24 +++++-------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 222d7370134c..00a88cf947e1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1038,7 +1038,6 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_atomic(void);
 void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
@@ -1537,10 +1536,6 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_atomic(void)
-{
-}
-
 static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb78bba5b4a4..eadfe371a8f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -639,7 +639,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(bool atomic)
+static void do_flush_stats(void)
 {
 	/*
 	 * We always flush the entire tree, so concurrent flushers can just
@@ -652,30 +652,16 @@ static void do_flush_stats(bool atomic)
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 
-	if (atomic)
-		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
-	else
-		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
-static bool should_flush_stats(void)
-{
-	return atomic_read(&stats_flush_threshold) > num_online_cpus();
-}
-
 void mem_cgroup_flush_stats(void)
 {
-	if (should_flush_stats())
-		do_flush_stats(false);
-}
-
-void mem_cgroup_flush_stats_atomic(void)
-{
-	if (should_flush_stats())
-		do_flush_stats(true);
+	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+		do_flush_stats();
 }
 
 void mem_cgroup_flush_stats_ratelimited(void)
@@ -690,7 +676,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Always flush here so that flushing in latency-sensitive paths is
 	 * as cheap as possible.
 	 */
-	do_flush_stats(false);
+	do_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-- 
2.40.0.634.g4ca3ef3211-goog

