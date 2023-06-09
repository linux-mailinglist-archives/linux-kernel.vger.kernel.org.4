Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2734E7292CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbjFIIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbjFIIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:50 -0400
Received: from out-12.mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B273A95
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1jd6DS57tmtOuv1f+tPHUMa7LOeeEWjdKx6Y4gNtNw=;
        b=jXFgIXzLdDJojoKAItNEv34otXyCWjyar4fawUm43LXwyCFBcR8kY9Gpt4WbtUzDcH3jkd
        /70kJs6ZiU9T/QhpzSJOCDGSO1yj+OA/JWTW7Qjwmfr5MuKM15sXtrYty/nAw5lTGHgi5v
        rbaXvSWMUUp8lu38yF2ylUnJkp1peeY=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/7] Revert "mm: vmscan: hold write lock to reparent shrinker nr_deferred"
Date:   Fri,  9 Jun 2023 08:15:14 +0000
Message-Id: <20230609081518.3039120-4-qi.zheng@linux.dev>
In-Reply-To: <20230609081518.3039120-1-qi.zheng@linux.dev>
References: <20230609081518.3039120-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

This reverts commit b3cabea3c9153fd42fe5cb851ac58b51ea2b32b8.

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case [1], which is caused by commit f95bdb700bc6 ("mm: vmscan: make
global slab shrink lockless"). The root cause is that SRCU has to be careful
to not frequently check for SRCU read-side critical section exits. Therefore,
even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker()
has become slower.

We will try to use the refcount+RCU method [2] proposed by Dave Chinner
to continue to re-implement the lockless slab shrink. Because there will
be other readers after reverting the shrinker_srcu related changes, so
it is better to restore to hold read lock to reparent shrinker nr_deferred.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[2]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305230837.db2c233f-yujie.liu@intel.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0ba0e1180f3f..d1d309fc3212 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -433,7 +433,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_write(&shrinker_rwsem);
+	down_read(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -442,7 +442,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_write(&shrinker_rwsem);
+	up_read(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
-- 
2.30.2

