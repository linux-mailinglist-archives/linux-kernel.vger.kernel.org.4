Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB44B6D0E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjC3TSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjC3TSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A554FF27
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:15 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gj9-20020a17090b108900b0024038c818a0so6245240pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjUVlGzaNGh8M5BDppplh7Z2E1z5drNgoNePIuD8ZZo=;
        b=EVT1tk0hlY3K/RTYvcQHMKPpwQPVXOnpdSgQM68BKQtZmfmON2APgqvMOvMMFyRoss
         Dmd2H4VUZwWGIfs6kzYLS/yY0LBdZ4oH1VkvSRWDGcSOJqUREz+4yAA6vO0jGdRbUllx
         xh0AWez/MaDxogJM7rwIORKSy2FNGdepATzkqraYhiO3RCB8HnWcqe3zSlq35IxkzxtC
         FV1PJ6neoxu760xZAlTGk8nkupYvKz5UcVjEtp57Ggrbl9Lds+WScYdzag5BG/1gW5Yv
         DUw8gcccaLuVJ49JXssrnmfFrYddyvv++tF0t2hffuUaTqszDGsJ7ZLQoChqmjJGkrqP
         YfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjUVlGzaNGh8M5BDppplh7Z2E1z5drNgoNePIuD8ZZo=;
        b=wFKZaBWFVlwqnl1xgLnVYnQFYNV61omOeeL/TJs6n0bz0XiVh3BIn4wKUsgMoEzTix
         5/dDCf9PP7rSw8aQjkO475/iXDa1FBnNNwHdTjARoF6d4AVnw2c5fdl4oLtI8Bxtbbm0
         i4rqiQggSz/5aZftLaAe07+2iEUj47gLmAywSFoF3CvEUGRIoR3k0tK4b/+kS1/PrnR3
         GmNIiW6ZYtHyE+jN1F6tXqe5mYx+FUXC1XVkSfZnDxKWx6Q8BpdHZcZxZROO3m+HPzU8
         p2HAnx1QhRJk4rlN68eK1GLnkCsfvNaYNcZ0qRuYypK+w4mVPl41xvzwfl7Sk6F6XlNN
         IPoA==
X-Gm-Message-State: AAQBX9cPbz6Guvz7+jsW28PrGQDpNAE1yK2PcLUG6niOBMygq+JBDHX2
        X2Z+L+sA/Z4Ebn1QH1rn9pmeU5HyVXZ/i2p0
X-Google-Smtp-Source: AKy350YjU2Y2MgqNkqgZoIOPOW0+HOYv1MqQ0pV2FUPZVEGY798zCaQjIBhDtJyF0YZxiEsyw9QKlZMU8q/qm34J
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:6b44:b0:1a2:6e4d:7832 with SMTP
 id g4-20020a1709026b4400b001a26e4d7832mr2680127plt.1.1680203894775; Thu, 30
 Mar 2023 12:18:14 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:59 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-7-yosryahmed@google.com>
Subject: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in workingset_refault()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In workingset_refault(), we call
mem_cgroup_flush_stats_atomic_ratelimited() to read accurate stats
within an RCU read section and with sleeping disallowed. Move the
call above the RCU read section to make it non-atomic.

Flushing is an expensive operation that scales with the number of cpus
and the number of cgroups in the system, so avoid doing it atomically
where possible.

Since workingset_refault() is the only caller of
mem_cgroup_flush_stats_atomic_ratelimited(), just make it non-atomic,
and rename it to mem_cgroup_flush_stats_ratelimited().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 4 ++--
 mm/workingset.c            | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b424ba3ebd09..a4bc3910a2eb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1038,7 +1038,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 void mem_cgroup_flush_stats(void);
 void mem_cgroup_flush_stats_atomic(void);
-void mem_cgroup_flush_stats_atomic_ratelimited(void);
+void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1540,7 +1540,7 @@ static inline void mem_cgroup_flush_stats_atomic(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_atomic_ratelimited(void)
+static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a2ce3aa10d94..361c0bbf7283 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -673,10 +673,10 @@ void mem_cgroup_flush_stats_atomic(void)
 		do_flush_stats(true);
 }
 
-void mem_cgroup_flush_stats_atomic_ratelimited(void)
+void mem_cgroup_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats_atomic();
+		mem_cgroup_flush_stats();
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
diff --git a/mm/workingset.c b/mm/workingset.c
index dab0c362b9e3..3025beee9b34 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -406,6 +406,9 @@ void workingset_refault(struct folio *folio, void *shadow)
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
 	eviction <<= bucket_order;
 
+	/* Flush stats (and potentially sleep) before holding RCU read lock */
+	mem_cgroup_flush_stats_ratelimited();
+
 	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
@@ -461,8 +464,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
-
-	mem_cgroup_flush_stats_atomic_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog

