Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291D69C782
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjBTJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBTJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6659E1040A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u17so678257plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676884624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSu6LoDi3bt+On14RPrDb/428OOXZNPo77LIFm1Bi28=;
        b=neiTcExIi57fl2R7QOvc3r3ELyzAtnMxW9GBNNCltkuMHmkXl5ZK+7Q0xCR6QpS+bt
         hP0XX6ZlR6iZxJOKblWlpeGKlK0XFXTJ6YTh8xf01BgvCpVSzBAdsU1eNWAu/zmWpkI3
         9p1TCdObRxhi5YMuGSLQ1T3HSRXNro+TSsI76hsUHs5DW20YstK9espDPHnwdEXtao3l
         lajZuuPnoZK/Rm/vt/YViwwLTzZW/RtdXkdVPp+DvpozOWqhFL7zaeOqjL7CkS5IB/Uq
         XEBgboArtxfsBttqiHviM+ZB06ohsgBSRsBrlb3EsBlg+YZoeTyyZ3T9K3z2UfsI7PLd
         kbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676884624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSu6LoDi3bt+On14RPrDb/428OOXZNPo77LIFm1Bi28=;
        b=lWlbCcn+OqhK8MU6bYfP91TQ0BYoHIiFYrS/F6e/PCrJli3JxO2GgbIrXR/umFGk/r
         Xpkfe1wqAVzpV0lYI9W2+FCf7YskgR+1GttngZ2OnePEdtTHBXdNvUHwxcM1AVTRUibA
         zE+h6H40wdYrnsHtwG9B2Exh+sTzXs+T3Wp9StrajjQqk5VBGbeSrtkUOwLprX7gk8xJ
         dJphTIr5TypqLhCXjY/btJPxhrP1MTBxIRZ7n/TFO0FyckUlIkWOvFk9bur22t9Ro62z
         jCJsp3q/8rUrRLG1EPxrq8tOIDuAyn1SMi4eEOQJn7jFaj7sQ6PjOzrzWtmrx+UAI+Bo
         Pxag==
X-Gm-Message-State: AO0yUKWOsgSfhDsIMVxSU9rCrCx2nJEE0it8KaR+kPLaIGQwXCe0xH9U
        LZyHBTC0Vk60rFVKIOFaiVTQlw==
X-Google-Smtp-Source: AK7set/Qfx+rPSFCLub0/LUO6j0gUaT7gq5PlaRfKArK9fwOowwRmHnhYd2zrA9jqT1wfk9fQyhMBA==
X-Received: by 2002:a17:90a:bf0d:b0:233:a836:15f4 with SMTP id c13-20020a17090abf0d00b00233a83615f4mr528696pjs.1.1676884623852;
        Mon, 20 Feb 2023 01:17:03 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id fs13-20020a17090af28d00b002339195a47bsm432382pjb.53.2023.02.20.01.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:17:03 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     tkhai@ya.ru, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/5] mm: vmscan: make global slab shrink lockless
Date:   Mon, 20 Feb 2023 17:16:33 +0800
Message-Id: <20230220091637.64865-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
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
index 9c1c5e8b24b8..95a3d6ddc6c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -699,7 +700,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
@@ -753,13 +754,15 @@ void unregister_shrinker(struct shrinker *shrinker)
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
@@ -779,6 +782,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
@@ -989,6 +993,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
+	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1000,10 +1005,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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
@@ -1014,19 +1019,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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

