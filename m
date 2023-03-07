Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEF6AD7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCGG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCGG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E288D8D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:56:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c4so7447508pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlfbC5hLUOyZ5eiKWKe3FNliR+/5Zth66owFIX3duxQ=;
        b=j8xEkJaYof6JnjV2P0RsveJBbsnpcn9RY4V+ifKMT79Be93zvpgebNY5nSfWdFD0NU
         1JW1AYTHaO+N+RFx2VLXc9tAFRn/DsFZYM5L65TiSMr1hMRgmru3xvORasp/75YD6J/y
         rGn2vVrH8HJoacjH3PbF9GnOpdyo3gX0mQEUZgRXnTBovRgY8MVxTw8BI9uz52Q/LQHG
         E2dcdZEf3BV3Hh0v3X7btzqm0okyXgWthyJJzVeextpZ9F1g0oAYjtHaaqZ/iEWplil2
         10Sb5xodkY2XripisufbYdb8ro/zRPnyPWGLDA9/6bcUB7x768fm0jxge+41ve9sBsI8
         3UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlfbC5hLUOyZ5eiKWKe3FNliR+/5Zth66owFIX3duxQ=;
        b=fjP0dCIu/84us1lEdw/SflpGfLuJnx93KGDJG4qUK2B1FjlmT5LjXAphpK0Gajd+jH
         7BedkZtDo0VxDWTk0gAlRqfpbnXOMllXFHjuBTHUwofJEBqhwQszlppp4IkKJ1O06Dmt
         YcocLFosrxX5d0WpdOTJrt2EUiMR8sdG1AqHVzyTxMWPWg/r9/bgekEg15z3duY99G6p
         G0kpie5vGBLea7HFIo7oCBT5MSvQHKS+cIX24G/scT1JoQ9P5AiaTX6tPn/8JNyDaJLU
         GjMYRrJngZ/Sfwu2+19bSHYZ6MfkWKRv7F+xv4eX262zIY84mPYfPGmCgkbra4Hs/2gE
         iCiw==
X-Gm-Message-State: AO0yUKUQBODxZg1lfwOldqPIjN4TlkZ++jyj9/uRzC1mDK2vudsb+Ugz
        g1+/7LXw9iz2uJoimMwU9Um/yg==
X-Google-Smtp-Source: AK7set9MiEUf3QenLOBMQ3cdZKmZL5CffIDhT1D/uEa1g/R5V5cbMebfmciE6mPU6pFS2nArJyvZ4A==
X-Received: by 2002:a05:6a00:4087:b0:5d1:f76:d1d7 with SMTP id bw7-20020a056a00408700b005d10f76d1d7mr14022848pfb.1.1678172211105;
        Mon, 06 Mar 2023 22:56:51 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:50 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 4/8] mm: vmscan: add shrinker_srcu_generation
Date:   Tue,  7 Mar 2023 14:56:01 +0800
Message-Id: <20230307065605.58209-5-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

After we make slab shrink lockless with SRCU, the longest
sleep unregister_shrinker() will be a sleep waiting for
all do_shrink_slab() calls.

To aviod long unbreakable action in the unregister_shrinker(),
add shrinker_srcu_generation to restore a check similar to the
rwsem_is_contendent() check that we had before.

And for memcg slab shrink, we unlock SRCU and continue
iterations from the next shrinker id.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1de9bc3e5aa2..9a5a3da5c8b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 DEFINE_SRCU(shrinker_srcu);
+static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
 	debugfs_remove_recursive(debugfs_entry);
@@ -803,6 +805,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
@@ -912,18 +915,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int srcu_idx;
-	int i;
+	int srcu_idx, generation;
+	int i = 0;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
+again:
 	srcu_idx = srcu_read_lock(&shrinker_srcu);
 	info = shrinker_info_srcu(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, info->map_nr_max) {
+	generation = atomic_read(&shrinker_srcu_generation);
+	for_each_set_bit_from(i, info->map, info->map_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -969,6 +974,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
+		if (atomic_read(&shrinker_srcu_generation) != generation) {
+			srcu_read_unlock(&shrinker_srcu, srcu_idx);
+			i++;
+			goto again;
+		}
 	}
 unlock:
 	srcu_read_unlock(&shrinker_srcu, srcu_idx);
@@ -1008,7 +1018,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
-	int srcu_idx;
+	int srcu_idx, generation;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1022,6 +1032,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 
 	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
+	generation = atomic_read(&shrinker_srcu_generation);
 	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
 				 srcu_read_lock_held(&shrinker_srcu)) {
 		struct shrink_control sc = {
@@ -1034,6 +1045,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
+
+		if (atomic_read(&shrinker_srcu_generation) != generation) {
+			freed = freed ? : 1;
+			break;
+		}
 	}
 
 	srcu_read_unlock(&shrinker_srcu, srcu_idx);
-- 
2.20.1

