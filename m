Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EEA641DD9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLDQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLDQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:15:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A214085
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:15:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c13so2090866pfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svRUdELzl130u78ZHoVrQ8kLS3/B/K+fs5QOXxsPpJs=;
        b=CrJxh2mLnr2Kc1c43TsZ5hHQRYXrbNQuNpWgBlRAvtB/ZBHABi5itLHDIbZd9ExahR
         3YhQ/UvkZtGBvY2umOJvuIjTbtfwpJVuACQgmYsiIFvBCm8OMQ9nQcISiO/c1kTwDUFb
         5YK2bw4i6KPFIMryLYNRkzut5BKoOOW7855jORF73gHk67NU1Lb+PjeQX16PBo8F6vrJ
         EqCEfGdMdTesLZ0vAlCC9I/lmpri57kmdp1Jv/+R1qNOJaOEdq+bACUBpqwWHURkDW/+
         pV0OhPAxrXggkfQmCHVVuyH1zHQ+E2N0SbOEgaTovcU1BNRjQgD27KP7d1RX6X5q+7Y0
         Iwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svRUdELzl130u78ZHoVrQ8kLS3/B/K+fs5QOXxsPpJs=;
        b=K3spOxDDkbXffvk4FGRiVtI92Zgq1blhETK0QZu2DCNymFaIsiiKxrE6df58Vb9cFd
         L93skmAYrzof+pZzSZX5bAlq35wwJ/P06pkK3hgEc/4WclYvXUaEVLXECG+WwY/Khrk3
         suivZ5yHyNLSBUbjaOlEYH5T9mRgsWSM8MoliODdlOG2HkFT5Tuc2xYyjHBNo8a2Kn80
         sCEU7lQ/S56lhVjbhv8s9gTYp0wpJIVX41tWIb9mzE/FrCfDgwtsw2yCRHUYEuWMYWEG
         dOfmlxmnUkBiTL+tdf1ZbsaDleHGJ3hneYwoHhBLGw/GLy6sesdmgw9CpzyF1vSOLoHZ
         lGKQ==
X-Gm-Message-State: ANoB5plnDhIorPcwlSjXzNt08qOoh4tF3Skr2rwRVtHqqkIJ8FzAq3XB
        DnqATscC+1WZl5Szhy19vQW6Yg==
X-Google-Smtp-Source: AA0mqf697SbKrqDrxqm/6K/eBjLuuHJ5KWVPXCJa7SzwMYf019swaV3VwP+EN36vxJGvS2skm/TMSA==
X-Received: by 2002:a63:1f63:0:b0:460:ec46:3645 with SMTP id q35-20020a631f63000000b00460ec463645mr73298033pgm.92.1670170516616;
        Sun, 04 Dec 2022 08:15:16 -0800 (PST)
Received: from Tower.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b0016cf3f124e1sm9000323plh.234.2022.12.04.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 08:15:16 -0800 (PST)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH 3/3] mm: add __rcu symbol for task->mempolicy
Date:   Mon,  5 Dec 2022 00:14:32 +0800
Message-Id: <20221204161432.2149375-4-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task->mempolicy is protected by task_lock in slow path,
but there is no locking and reference in hot path for performance.
It will be difficult if other processes want to adjust it.
It is for these reasons to add __rcu symbol for task mempolicy.
There is no need to add RCU protection to vma mempolicy, which
is protected by mmap_lock.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/sched.h | 2 +-
 mm/mempolicy.c        | 9 ++++-----
 mm/slab.c             | 5 +++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..c8a297ca61ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1252,7 +1252,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_NUMA
 	/* Protected by alloc_lock: */
-	struct mempolicy		*mempolicy;
+	struct mempolicy __rcu		*mempolicy;
 	short				il_prev;
 	short				pref_node_fork;
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0feffb7ff01e..837083fff9c8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -894,8 +894,7 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
-	old = current->mempolicy;
-	current->mempolicy = new;
+	old = rcu_replace_pointer(current->mempolicy, new, true);
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
@@ -999,7 +998,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			if (err < 0)
 				goto out;
 			*policy = err;
-		} else if (pol == current->mempolicy &&
+		} else if (pol == rcu_access_pointer(current->mempolicy) &&
 				pol->mode == MPOL_INTERLEAVE) {
 			*policy = next_node_in(current->il_prev, pol->nodes);
 		} else {
@@ -2065,7 +2064,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 {
 	struct mempolicy *mempolicy;
 
-	if (!(mask && current->mempolicy))
+	if (!(mask && rcu_access_pointer(current->mempolicy)))
 		return false;
 
 	task_lock(current);
@@ -2426,7 +2425,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
 		return ERR_PTR(-ENOMEM);
 
 	/* task's mempolicy is protected by alloc_lock */
-	if (old == current->mempolicy) {
+	if (old == rcu_access_pointer(current->mempolicy)) {
 		task_lock(current);
 		*new = *old;
 		task_unlock(current);
diff --git a/mm/slab.c b/mm/slab.c
index 59c8e28f7b6a..f205869d6c36 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3052,7 +3052,7 @@ static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
 	nid_alloc = nid_here = numa_mem_id();
 	if (cpuset_do_slab_mem_spread() && (cachep->flags & SLAB_MEM_SPREAD))
 		nid_alloc = cpuset_slab_spread_node();
-	else if (current->mempolicy)
+	else if (rcu_access_pointer(current->mempolicy))
 		nid_alloc = mempolicy_slab_node();
 	if (nid_alloc != nid_here)
 		return ____cache_alloc_node(cachep, flags, nid_alloc);
@@ -3188,7 +3188,8 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 	int slab_node = numa_mem_id();
 
 	if (nodeid == NUMA_NO_NODE) {
-		if (current->mempolicy || cpuset_do_slab_mem_spread()) {
+		if (rcu_access_pointer(current->mempolicy) ||
+				cpuset_do_slab_mem_spread()) {
 			objp = alternate_node_alloc(cachep, flags);
 			if (objp)
 				goto out;
-- 
2.25.1

