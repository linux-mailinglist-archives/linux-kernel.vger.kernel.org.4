Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAA6B75FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCMLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCMLa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5D5B5D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x37so2227816pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678707003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joJBORpGAhUrTa0QaRmWtbHEppwsJHnBnzSS2GFBqpE=;
        b=gxoAK0RJLeAUG9DMQX3AJ19hEgYUC73gn5qDU+xe20VchIqQl4+4Bs8TMoR+xUoHKj
         ND9SsfWlrkOJpCkSW9SdC0rMfbp2pkoC+L+Zsl8WbNt1tGBTAG2LXwZTOyMQ1iLcCwQd
         GxK8VSLfc4QaraebduBNkUss03AkdhgD0s4yXld1S43G6GFxDxgVa30i3fDKmLe2+vsn
         L0khGXfZPxYQ4maITGQLyGizgnKgpvbt2obFC6FA/0459J8cOE4CnMELpfc1XfocweG3
         UCt1lbaasgjVAeNzd0lchgP8FL0nLDv/KuKuOjPDpVlt6/LjMfKic6NSPuZGnknpbpu6
         jdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joJBORpGAhUrTa0QaRmWtbHEppwsJHnBnzSS2GFBqpE=;
        b=DoSFHOjibqoqPPp/r0SL8YX+I0VcsqopQhiotEnSi9PpWyYkY52mxKdQ9aflGPH/1o
         OZasjuqFarBa1P4o59cIvzAxV66ldxhZy/IVjXXPcf3raf0vhHdX5DRTp3ZaUpySAqw2
         bG5HZfLjBEDPfh9wS3M923NxECHxQ++c6IdgYblangee23hQAA7XnczwQL8vVRa0qJqs
         Fm1P7yBvvHztE06DvSn8eQWWp555qlT9Cuyos5NE2YVHboRxk0dZL0UVVr58PS9nsVkw
         csOIGD12MMqk6yFDSdgm9Ux+V8jcgKcoWje8qzoFvifVCW0dk+J4zhMXwu7Pus1uI+Qn
         lXNg==
X-Gm-Message-State: AO0yUKUCUgmbsQ11bG8kWcUFojFjcpukxQgB6gFCWZ2VXJa15jZHx6/V
        15yT/nv07ctoH/HCc3d3DAbnOA==
X-Google-Smtp-Source: AK7set8YFjpOWP7oOMMANTE81hjqmcZGdje1Alhj8F/KolKsPGx7n3vdYEg4ks+PCVoaRcuIXePCBQ==
X-Received: by 2002:a05:6a00:2148:b0:606:d3d1:4cc4 with SMTP id o8-20020a056a00214800b00606d3d14cc4mr10843183pfk.3.1678707003039;
        Mon, 13 Mar 2023 04:30:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:30:02 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 4/8] mm: vmscan: add shrinker_srcu_generation
Date:   Mon, 13 Mar 2023 19:28:15 +0800
Message-Id: <20230313112819.38938-5-zhengqi.arch@bytedance.com>
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

From: Kirill Tkhai <tkhai@ya.ru>

After we make slab shrink lockless with SRCU, the longest
sleep unregister_shrinker() will be a sleep waiting for
all do_shrink_slab() calls.

To avoid long unbreakable action in the unregister_shrinker(),
add shrinker_srcu_generation to restore a check similar to the
rwsem_is_contendent() check that we had before.

And for memcg slab shrink, we unlock SRCU and continue
iterations from the next shrinker id.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vmscan.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ce7834030f75..5c2a22454320 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 DEFINE_SRCU(shrinker_srcu);
+static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -776,6 +777,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	up_write(&shrinker_rwsem);
 
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
 	debugfs_remove_recursive(debugfs_entry);
@@ -797,6 +799,7 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
@@ -906,18 +909,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -963,6 +968,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -1002,7 +1012,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
-	int srcu_idx;
+	int srcu_idx, generation;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1016,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 
 	srcu_idx = srcu_read_lock(&shrinker_srcu);
 
+	generation = atomic_read(&shrinker_srcu_generation);
 	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
 				 srcu_read_lock_held(&shrinker_srcu)) {
 		struct shrink_control sc = {
@@ -1028,6 +1039,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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

