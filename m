Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A106A0A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjBWN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:03 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEAE28863
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q11so13162713plx.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmBjkO7XqRgvyMtVzOfBB5ntqP3V7YsqXGlIu6MjJGc=;
        b=HuKGyT5g9HX+trnuB9PFEZiZQnLZwCXwzriYOLJXDNbiFiIZPICp1ljy4qSOgSab2I
         NMzsv7Vmj7E/5NMfLc1BWIKOnCxL+BzoZpgKcnJYEltjWlGXo0fOwx9C6Pu3NsN9u46U
         Kv3wFXahyCB63qXHH0daVyjbjFbiPIcvdexuFVwLoVsLDYQ5kqjx3EO/D+d1pxqe6zU/
         RO8l29x25cF9n7jVV5kbIhqnom267s/kJXkRQI4UJegeb5b/0C073tGKMlhkXpxOhbeS
         ztqiE80MiB/pXo60Z+CGiUXjkhVqipIt+okmhgJTC36MafGn2SoK2Bm4TUXoufO3abiD
         loIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmBjkO7XqRgvyMtVzOfBB5ntqP3V7YsqXGlIu6MjJGc=;
        b=rk2TBmhHxJp5KdzLl6xgOmcKylIT/gjG+WIj71AA3K7iOjYV6G5z88ZMkoGO7addzn
         eZSGQCG2kVqfE/3NNvdQt3k7WI0AJNLV4oQPFr1+WxojBBh651rpa6numZUUOTv4Eau2
         UOCrO6SAYF3I4b+vMpjNF3Kb6wxUsnHRBc8TV3obdCVOBIBW2b+fPBPSW1mEoGHVuslI
         7zyXfyss8494kzL6wvRfdG+UzEO/fw+NdIKyNc2pOCflgazN5AxL0w4soPaC3NLuZXbc
         YVZGcEjWXJ2TrZQ7yNYEdzZ8y7zTLFFUH7PpCigo7GAxhUUFIEk9P/N1+3HzFYmWjHim
         /KNQ==
X-Gm-Message-State: AO0yUKXcx4IYDeURbWfYPfLTQJi/zuKGi9Z7EbFQUQr8QIvEGR9WJDCy
        mGce8ElgEcbL/8CCObIUa3hiNg==
X-Google-Smtp-Source: AK7set/Rzr6xcsH9ySEoci9FlTvKdtpASQ4i1a9Z/tDDR2gcVSm1DDUdIYED6NggeEbWXrwoEk7f6g==
X-Received: by 2002:a05:6a20:7f9c:b0:cc:4118:65c4 with SMTP id d28-20020a056a207f9c00b000cc411865c4mr889206pzj.5.1677158881203;
        Thu, 23 Feb 2023 05:28:01 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:00 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Date:   Thu, 23 Feb 2023 21:27:20 +0800
Message-Id: <20230223132725.11685-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
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
index 9f895ca6216c..02987a6f95d1 100644
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

