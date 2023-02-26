Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97D6A30E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjBZOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBZOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:53:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C235278
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so3594626pjg.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCpviF+GWpW2q6LnTDjAWSvloYoZWztn7l/3EVg4xkQ=;
        b=CsO5aMnVYOQmnyjcQDWffm4ibQqMe8oamD5qA31APfwGf7gzHtJWrrI9olR/qCLH3m
         +Dg9XEOXL03hNqlNAICq5ya5pc+4BAUaxlKS89rulXGKJbAvILD5lY4IpjVkqVKRPLvh
         40gqi3qq8AOZ1mGSmaZCdTm8hikTcJ9NRlhGcNGYHgwL8+XrC0lLnzZo9UmwdvnTP54e
         eUYL2ktptCc5CxNqWcNGg2KrPSG53OlDew6ZxZjtTpBl8B2IbscuG/h4GalyWHIQrMzw
         3OBbkZBqaEHnKb1ujMBfyfX5Hxby7rTMu2I2Ehi1U62/G1skp5O5yL+5jSowBJMa0FAX
         IEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCpviF+GWpW2q6LnTDjAWSvloYoZWztn7l/3EVg4xkQ=;
        b=mrCCfqqu93S3EXxAvrWxSDkhl6NF85GhSsMMj9vhz+0FhMc37WrvMNUVfYN2NZ8+vw
         o1/K6GG+x+4199CnRuukfCOwvwyMMBkbgGUMfEQzfkUEJCwysq2MyyBufBJxmt509uOM
         BLQhY/IXOEjqktk10+YAdelrH+xj6ddtCpBqj7sbvMDfQgg3XmeBE5qSgFEmYm+sX1pi
         fILHmI3gArL9FIGTTDAW7VdnCdIxX6Oj2et0bNaJD9Q0ZKryFfn2tiQgPIeK2GUbjqy/
         5XwK+pr4aIDzFBpzrQE4gFCG/fV6o2y6PAUN0D+XzBOBLqkvCuWEjIJP9A48p2Q0Roag
         lotA==
X-Gm-Message-State: AO0yUKXOPTaAiWl6OIJ5uZW2pqpvG4T2KIsjNgWS/KWiU54DvVvBIeOf
        vFBsGAdqbc7u62Ny89pfXSlSsg==
X-Google-Smtp-Source: AK7set+c04U6J0wwMClaGVyTvpOvZFG7I93CD+bD7JQJKcXtMBNQuebr82PnrpOoKfjQ0YfQoyG7og==
X-Received: by 2002:a17:902:ab0c:b0:19a:b1ac:45d4 with SMTP id ik12-20020a170902ab0c00b0019ab1ac45d4mr23569774plb.3.1677422913584;
        Sun, 26 Feb 2023 06:48:33 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:33 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 4/8] mm: vmscan: add shrinker_srcu_generation
Date:   Sun, 26 Feb 2023 22:46:51 +0800
Message-Id: <20230226144655.79778-5-zhengqi.arch@bytedance.com>
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
index 490764f8e085..99e852c0ab9e 100644
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

