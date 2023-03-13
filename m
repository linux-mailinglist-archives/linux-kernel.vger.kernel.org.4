Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513B6B75F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCMLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCML3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:29:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C818559EE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so11320778pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678706990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+PIjzMrqqus+vCKR4kW46vOjsCmmZLpdvQvuCO0Xe0=;
        b=LKdBuqoPZ3Eoe3IWRve5czAmJNAuSXHJEZyt6qMgQ2QWE0FfdegRHxqdr14XQLU0rx
         PsAdOS3EITkjvH5yWgAVHjIGJIgtokVqDvCFC26F4koRE2Dg75XvyXjyLjnvaxEhaWs0
         dhQ9CFD461CllT/ivbb0KEKQLcI9xDxnAgIIgqPeywEBe7ZlcK3Kpq2x4YNZJlXiWmJW
         wFSsnsQNtCw4pUPGf8nkmUQNQWO9giNg3PiXQrgZK9dUZR0DabpxIf6V5RpwknTkHH+s
         11as/+u7W1eLQqbscYrAfCE12YP+G4kZxz1LGruS5fzUaeaeMeP5o6+X9fPn1O+TsKdH
         kbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+PIjzMrqqus+vCKR4kW46vOjsCmmZLpdvQvuCO0Xe0=;
        b=FvriqHfG4WwNH44Z8cRjr2FyKqxVr0XUARuitkSFjSL8da5/5BFYocl9uHOqscBwd2
         liXp7UPGsu1JEKSaeLMDJdit18DdariIiJPjK5HsGsb4l86mAQRp+DqGITEX4nNqUz8T
         7E2hYS2hxwhdeUoelDncTp1trpRT6usWLC1Dd2cqkRnx+a3QuK5Hvzz/C6btmDxZL0RQ
         OMNXhcqcK9cJ/c8Il5mQC5pxKzkdp5zuO94We5xbWYHe4GrSLAZq0ryguq5t8XoFuWl2
         a2N37ovdHLILO2qdLTbujR49Pxd8V7cwemx/YimaflkCG2NCKOqd9gCiXLtFjB8kBIom
         nx2g==
X-Gm-Message-State: AO0yUKVPwqUmwo+93scnoD65Wf6F4k01o7p5zF/lzF5mpOlFpiOO2wDX
        MnfrcM5v4rLAY/9zTivibxAHOQ==
X-Google-Smtp-Source: AK7set9cSLNe/LRJSehPejbnqQcEtWGFrHHPC3Q/DqoKx4Ii0aTTtc55w7QWCxr0TLSi4GrfoJETMQ==
X-Received: by 2002:a05:6a20:841c:b0:c7:af88:4199 with SMTP id c28-20020a056a20841c00b000c7af884199mr17859458pzd.6.1678706990517;
        Mon, 13 Mar 2023 04:29:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:29:50 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 2/8] mm: vmscan: make global slab shrink lockless
Date:   Mon, 13 Mar 2023 19:28:13 +0800
Message-Id: <20230313112819.38938-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
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

The shrinker_rwsem is a global read-write lock in
shrinkers subsystem, which protects most operations
such as slab shrink, registration and unregistration
of shrinkers, etc. This can easily cause problems in
the following cases.

1) When the memory pressure is high and there are many
   filesystems mounted or unmounted at the same time,
   slab shrink will be affected (down_read_trylock()
   failed).

   Such as the real workload mentioned by Kirill Tkhai:

   ```
   One of the real workloads from my experience is start
   of an overcommitted node containing many starting
   containers after node crash (or many resuming containers
   after reboot for kernel update). In these cases memory
   pressure is huge, and the node goes round in long reclaim.
   ```

2) If a shrinker is blocked (such as the case mentioned
   in [1]) and a writer comes in (such as mount a fs),
   then this writer will be blocked and cause all
   subsequent shrinker-related operations to be blocked.

Even if there is no competitor when shrinking slab, there
may still be a problem. If we have a long shrinker list
and we do not reclaim enough memory with each shrinker,
then the down_read_trylock() may be called with high
frequency. Because of the poor multicore scalability of
atomic operations, this can lead to a significant drop
in IPC (instructions per cycle).

So many times in history ([2],[3],[4],[5]), some people
wanted to replace shrinker_rwsem trylock with SRCU in
the slab shrink, but all these patches were abandoned
because SRCU was not unconditionally enabled.

But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
the SRCU is unconditionally enabled. So it's time to use
SRCU to protect readers who previously held shrinker_rwsem.

This commit uses SRCU to make global slab shrink lockless,
the memcg slab shrink is handled in the subsequent patch.

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
[2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
[3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
[4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
[5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <tkhai@ya.ru>
---
 mm/vmscan.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9a2a6301052c..db2ed6e08f67 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,6 +57,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/srcu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -202,6 +203,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -700,7 +702,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
@@ -754,13 +756,15 @@ void unregister_shrinker(struct shrinker *shrinker)
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
@@ -780,6 +784,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
@@ -990,6 +995,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
+	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1001,10 +1007,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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
@@ -1015,19 +1021,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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

