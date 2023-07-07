Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617374AA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjGGEsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGGErz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:47:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD31FEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:47:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b4748fe4so8010035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688705236; x=1691297236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEV7S2qQa9wjcpqCPZF1/IRLU/XLUimMDUCsPYYW7kI=;
        b=i9R4JehL62yeUI0J/4ssJQxvz0puzqqchTK/dmDx0jOYqynb15e1FVB9HaIbdAnBap
         I+9q1hHV+sLd0FkRPQrxa357li+iU7oRQ3ZKljZNWV3srIwdrp0BycDD7H+epgpwzfRQ
         YVWBEAsXX8PF0UhPux74/+tZUH3QnrxpBO4WdqdABk7EeoVbQxDpUwN7GkVD8PfbmKbi
         jrqdFSt13I8trb9p3hzK1fwPq4uIr0nK3BpF2FMwkbqRd5wXqzHhSxMUm3PxZ/vdQo/j
         5S8xAvzry2rY9pLS05xsu74C9bbszUTiarWjDUT6mckjYUbOG3yUlgSfPTRsN+uftCxC
         r1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688705236; x=1691297236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEV7S2qQa9wjcpqCPZF1/IRLU/XLUimMDUCsPYYW7kI=;
        b=HVHK+elDhCaXXD+UZIYbPOuuTave7+YJDXwk5MsLHVDUqioY2OaqwXj4yEy73h13vQ
         OJjCp4uOcOerBcxh7TDZTetIxOtUykIJJJtASUtSundL9i0SGXpLD86saym97AdZVNWI
         ZIo9U6f8JQMz7CW7mc5sdKyip29iwY6wMCWKGwBwsts3GQDFz8hyJGiAPePIcQdYgIwW
         csjY8DZ+cuv4iBJREguzmBG1VoHBXRqM2R3KUiwho+I6+A7MCDXeMnN73q8RaTrq5GFo
         VszV6lRLRh6T+JQBcM/edS0slnUzL59/uRIPpB4zAMBw/9DbIkyZyXmzW/ZZfbR9Bo9H
         B9Jw==
X-Gm-Message-State: ABy/qLZqS7s0J2yn/V8JJ7rcvOTsQZ6ysZO1TQQFYyRiVITWr7t4I7cW
        rKYjTPztrDTZYdCtkrbIyGrwtg==
X-Google-Smtp-Source: APBJJlEtaEiw8usJCj2cjDIpbdnmQoBl+moxhFrnsASFMEpmDxsNajjhnvllwpDNFcF/3sV84z1rXQ==
X-Received: by 2002:a17:902:7405:b0:1b8:b827:aa8e with SMTP id g5-20020a170902740500b001b8b827aa8emr3111867pll.11.1688705235754;
        Thu, 06 Jul 2023 21:47:15 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001b86deadfddsm2181858pli.264.2023.07.06.21.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:47:15 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 2/2] zram: charge the compressed RAM to the page's memcgroup
Date:   Fri,  7 Jul 2023 12:47:07 +0800
Message-Id: <20230707044707.1169285-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM is currently charged to kernel, not to
any memory cgroup. This patch can charge the pages
regardless of direct or indirect zram usage.

Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 drivers/block/zram/zram_drv.c | 43 +++++++++++++++++++++++++++++++++++
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5676e6dd5b16..770c7d58afec 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/memcontrol.h>
 
 #include "zram_drv.h"
 
@@ -135,6 +136,18 @@ static void zram_set_obj_size(struct zram *zram,
 	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
+static inline void zram_set_obj_cgroup(struct zram *zram, u32 index,
+			struct obj_cgroup *objcg)
+{
+	zram->table[index].objcg = objcg;
+}
+
+static inline struct obj_cgroup *zram_get_obj_cgroup(struct zram *zram,
+			u32 index)
+{
+	return zram->table[index].objcg;
+}
+
 static inline bool zram_allocated(struct zram *zram, u32 index)
 {
 	return zram_get_obj_size(zram, index) ||
@@ -1256,6 +1269,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
+	struct obj_cgroup *objcg;
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	zram->table[index].ac_time = 0;
@@ -1289,6 +1303,13 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	objcg = zram_get_obj_cgroup(zram, index);
+	if (objcg) {
+		obj_cgroup_uncharge_zram(objcg, zram_get_obj_size(zram, index));
+		obj_cgroup_put(objcg);
+		zram_set_obj_cgroup(zram, index, NULL);
+	}
+
 	handle = zram_get_handle(zram, index);
 	if (!handle)
 		return;
@@ -1419,6 +1440,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
+	struct obj_cgroup *objcg = NULL;
 
 	mem = kmap_atomic(page);
 	if (page_same_filled(mem, &element)) {
@@ -1494,6 +1516,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
+	objcg = get_obj_cgroup_from_page(page);
+	if (objcg && obj_cgroup_charge_zram(objcg, comp_len)) {
+		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zs_free(zram->mem_pool, handle);
+		obj_cgroup_put(objcg);
+		return -ENOMEM;
+	}
+
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	src = zstrm->buffer;
@@ -1526,6 +1556,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}  else {
 		zram_set_handle(zram, index, handle);
 		zram_set_obj_size(zram, index, comp_len);
+		zram_set_obj_cgroup(zram, index, objcg);
 	}
 	zram_slot_unlock(zram, index);
 
@@ -1581,6 +1612,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
+	struct obj_cgroup *objcg = NULL;
+	unsigned int noreclaim_flag;
 	u32 num_recomps = 0;
 	void *src, *dst;
 	int ret;
@@ -1692,11 +1725,21 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 
 	zs_unmap_object(zram->mem_pool, handle_new);
 
+	/*
+	 * Recompress will reclaim some memory, so we set the reclaim
+	 * flag in order to charge comp_len_new successfully.
+	 */
+	noreclaim_flag = memalloc_noreclaim_save();
+	objcg  = zram_get_obj_cgroup(zram, index);
+	obj_cgroup_get(objcg);
 	zram_free_page(zram, index);
+	obj_cgroup_charge_zram(objcg, GFP_KERNEL, comp_len_new);
+	zram_set_obj_cgroup(zram, index, objcg);
 	zram_set_handle(zram, index, handle_new);
 	zram_set_obj_size(zram, index, comp_len_new);
 	zram_set_priority(zram, index, prio);
 
+	memalloc_noreclaim_restore(noreclaim_flag);
 	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
 	atomic64_inc(&zram->stats.pages_stored);
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index ca7a15bd4845..959d721d5474 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -72,6 +72,7 @@ struct zram_table_entry {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
+	struct obj_cgroup *objcg;
 };
 
 struct zram_stats {
-- 
2.25.1

