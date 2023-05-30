Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09671691A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjE3QWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjE3QV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:21:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C313C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:21:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b0314f057cso20825215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463715; x=1688055715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/WBtGzBcsO34AYbOMyFXDghwkOVFx66YphlIfOblWg=;
        b=H+oNAVDf06d8gfWS/ueuFsRlVJTJWp3TvWHjC/HwSply/gryn+bKivg61AiFR6E2aj
         O2HVh3cAIIATR30eJia+jDxgsvPqfrjlFCGPcbYPq96S7Tyff2u2T6DbyCwhFp7jjRdG
         AOYIyNMjalsZX9lTKjpEr0DxRKLZniD0xUWj2vg8e3RM3ZjYpI/hdmeG9XKQw9ud4fW5
         XQIOtK6N4jUJr+oFy+puEuHpzbHVDeBZh71hz7RTYp3ZAHQx9o3hBL+CmdQfzFVzS6U5
         GvskRPwYSR8DmR8El1kBVTD7jhARzkHbTp9wAAMe7q9hNo2fKRSIj6iymw0IX7xJqbtD
         KMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463715; x=1688055715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/WBtGzBcsO34AYbOMyFXDghwkOVFx66YphlIfOblWg=;
        b=QEww1EK7PcCsj8NzAc6452+Y8IPC56QB66uHwLeukXGkx5KMVuFlpRgJvvkkyFzKLC
         dqly8lHuKmDdr10SQoGKQLECAgMd9a7q6ZDuunrfrFjqU5YFdqM3hHmZU1VrqbPrvFTo
         iwaEkB3LlUXzqfaOYoGBtxeGdL01vM6pBwu8ZxiEbtmnzNJytWhPXqnaa7mVkpPfPvp0
         7We/iUBVKHaQnwKzfABGQ5vPphMa+OhMw/Y3YihcgAYZkl8+/hcEuLEWdGUYkItz38Jt
         gGIg3adFL1FCZPPR+8VIKKDJncPwFoIbuaaw49JNVhvVI4yu3tKNpgwx0Jts+Ysvl/a5
         c/xg==
X-Gm-Message-State: AC+VfDy3Zq9a7YLBM9x/dBYvmb6BqO9lKBFizOdLRW1xQohX3MT1zwQ4
        KaT5ZdeSdNjhdNuCgVkOCHQ=
X-Google-Smtp-Source: ACHHUZ4wIBrz7z1GLUlZDavbbGlwP8PKAGax8z3iOvcuXCkTM4/ECdwkSo6366Osgjy18g/g1Ode4A==
X-Received: by 2002:a17:902:e543:b0:1b0:49e1:6dc4 with SMTP id n3-20020a170902e54300b001b049e16dc4mr3220345plf.56.1685463714705;
        Tue, 30 May 2023 09:21:54 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001b04aee1f99sm3593171plb.228.2023.05.30.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:21:54 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        kernel-team@meta.com
Subject: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Date:   Tue, 30 May 2023 09:21:53 -0700
Message-Id: <20230530162153.836565-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before storing a page, zswap first checks if the number of stored pages
exceeds the limit specified by memory.zswap.max, for each cgroup in the
hierarchy. If this limit is reached or exceeded, then zswap shrinking is
triggered and short-circuits the store attempt.

However, if memory.zswap.max = 0 for a cgroup, no amount of writeback
will allow future store attempts from processes in this cgroup to
succeed. Furthermore, this create a pathological behavior in a system
where some cgroups have memory.zswap.max = 0 and some do not: the
processes in the former cgroups, under memory pressure, will evict pages
stored by the latter continually, until the need for swap ceases or the
pool becomes empty.

As a result of this, we observe a disproportionate amount of zswap
writeback and a perpetually small zswap pool in our experiments, even
though the pool limit is never hit.

This patch fixes the issue by rejecting zswap store attempt without
shrinking the pool when memory.zswap.max is 0.

Fixes: f4840ccfca25 ("zswap: memcg accounting")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h | 6 +++---
 mm/memcontrol.c            | 8 ++++----
 mm/zswap.c                 | 9 +++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 222d7370134c..507bed3a28b0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
+int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
 #else
-static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
-	return true;
+	return 0;
 }
 static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
 					   size_t size)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..09aad0e6f2ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] = {
  * spending cycles on compression when there is already no room left
  * or zswap is disabled altogether somewhere in the hierarchy.
  */
-bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
+int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
 	struct mem_cgroup *memcg, *original_memcg;
-	bool ret = true;
+	int ret = 0;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
@@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 		if (max == PAGE_COUNTER_MAX)
 			continue;
 		if (max == 0) {
-			ret = false;
+			ret = -ENODEV;
 			break;
 		}
 
@@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
-		ret = false;
+		ret = -ENOMEM;
 		break;
 	}
 	mem_cgroup_put(original_memcg);
diff --git a/mm/zswap.c b/mm/zswap.c
index 59da2a415fbb..7b13dc865438 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	objcg = get_obj_cgroup_from_page(page);
-	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto shrink;
+	if (objcg) {
+		ret = obj_cgroup_may_zswap(objcg);
+		if (ret == -ENODEV)
+			goto reject;
+		if (ret == -ENOMEM)
+			goto shrink;
+	}
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
-- 
2.34.1

