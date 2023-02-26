Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA466A30D1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjBZOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBZOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:53:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4E91A4A4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:30 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i3so4209103plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677422902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJVL9LTM3YR7R2xJV6pOC5vrFajMNWUdaUGoIRklN4g=;
        b=ALVQXXOfu8Q3gVhZC/7gcT/As/x0PQNyX2nqdY6UDPAFzmCXukW/onK5TzeE9pcwvk
         vXJzQkiBP+sXbTYXsw+HpB7JRRbrwmsjkOEq5DQ1S1Eac1N0S/0/DsgoqOjYjHQYnPSR
         P4R9Pfo0jggo+dcJDr8XJLDD9doWZVqghSIkea6uqcKjvoOktQF/G7VDIKPmpqIX0uaq
         CUp5L8HF8li82mResfb29HBRedCwzzg7BH3UMRf7q7wMBQ/7+ybQtKL36gQDJZu0gwHP
         FCqtYPLddEJNMwfVTwEbd49hBEqsrqinMleX5XcFcj1s7BFSCNs7Wfig3bKPX0H4mz4V
         BKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677422902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJVL9LTM3YR7R2xJV6pOC5vrFajMNWUdaUGoIRklN4g=;
        b=kx69l754ul2Sqs4Xs1g0SDtaTzNs2jNSxZqK9n+D2Zq0rrLCiVbdckVUIiuaRFhYTN
         c8QFmWshy3iFhhmzlXyLSlk/1fDoNOiHxW1+vHbc0iCpx2Dw+x4OXTXVp0ukGQ7Ne5k+
         UvS+k/AgAxDmhemEXQe8TrIZPkq5GXPe+2yQjS8UGeTOdJpV6Of0Tkv7eEIa/JVJeowc
         D/IDUbzatyVvj9Fe4I2YZ61IAo+6U8bnjnhFRtb7DREZowZN6A90cQ+HM+c9ovAbGL3G
         Cqxihy/TiyA0BK74Oj8KRH+jLbd2U0qomOvEVmdo+4hoFb32WNKseBr2FRxZqMd/znAt
         Vy5A==
X-Gm-Message-State: AO0yUKW0avX26tNNgSBfu+/wImHGDSfTj6u7rPky0oodb/epom0Yc/kc
        gxCwgvkCoE4L9SQdenslcYDjew==
X-Google-Smtp-Source: AK7set+bbch+q47tvYRNxM7CkTvsssKUNlySDXHnmC0iMbwnLjHUXiyS9TSOg6OMzWfUw8IIF2O97w==
X-Received: by 2002:a17:902:e84b:b0:19a:7439:3e98 with SMTP id t11-20020a170902e84b00b0019a74393e98mr23301977plg.4.1677422901796;
        Sun, 26 Feb 2023 06:48:21 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:21 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 2/8] mm: vmscan: make global slab shrink lockless
Date:   Sun, 26 Feb 2023 22:46:49 +0800
Message-Id: <20230226144655.79778-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker_rwsem is a global lock in shrinkers subsystem,
it is easy to cause blocking in the following cases:

a. the write lock of shrinker_rwsem was held for too long.
   For example, there are many memcgs in the system, which
   causes some paths to hold locks and traverse it for too
   long. (e.g. expand_shrinker_info())
b. the read lock of shrinker_rwsem was held for too long,
   and a writer came at this time. Then this writer will be
   forced to wait and block all subsequent readers.
   For example:
   - be scheduled when the read lock of shrinker_rwsem is
     held in do_shrink_slab()
   - some shrinker are blocked for too long. Like the case
     mentioned in the patchset[1].

Therefore, many times in history ([2],[3],[4],[5]), some
people wanted to replace shrinker_rwsem reader with SRCU,
but they all gave up because SRCU was not unconditionally
enabled.

But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
the SRCU is unconditionally enabled. So it's time to use
SRCU to protect readers who previously held shrinker_rwsem.

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
[2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
[3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
[4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
[5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 546c07ccb3bc..2a21a84d3db1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
@@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 
 	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
+	list_del_rcu(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
+	synchronize_srcu(&shrinker_srcu);
+
 	debugfs_remove_recursive(debugfs_entry);
 
 	kfree(shrinker->nr_deferred);
@@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
@@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
+	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
+				 srcu_read_lock_held(&shrinker_srcu)) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the registration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 
-	up_read(&shrinker_rwsem);
-out:
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	cond_resched();
 	return freed;
 }
-- 
2.20.1

