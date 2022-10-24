Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1160BD76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiJXWdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJXWdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:33:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D12B9BBC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26034B8125E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE46C433D6;
        Mon, 24 Oct 2022 20:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644570;
        bh=EqlatpkaNdYuUEktVCI5+LntE+Uir1CgxHGN/I9sz6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHf61vuVWHDO8jflm6XY+Xnsxloq4pNPWgLulXZi12E0FTxFwZ5mbV4f2/jbeowuj
         vMMni2x0nAF+ylHWMo951Se91nJtcwHhrMT3YpMI7XdcXaIlL11P8MUbyRaSTF1eNU
         9AnOGD3NlNADWrh7eR54eB+1HcDJQqIVbFK/de/aiy2Y1hGFQ4kbQu/rbalsRQniwi
         zSYR0fidKYCo1ckoWcY3nqjqcswTLW71/GQj0bchQeVPQ4qsXA6+O5Njhv1aGc+peD
         O9/H5LUfUIpb3DGPKZsfBhDz36iSpEJ8SA8a+puS2/V5c67HD8pKyyTLVmpLNev0kr
         9NKxolELy7w6A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH 10/11] mm/damon/modules: deduplicate init steps for DAMON context setup
Date:   Mon, 24 Oct 2022 20:49:18 +0000
Message-Id: <20221024204919.18524-11-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024204919.18524-1-sj@kernel.org>
References: <20221024204919.18524-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON_RECLAIM and DAMON_LRU_SORT has duplicated code for DAMON context
and target initializations.  Deduplicate the part by implementing a
function for the initialization in 'modules-common.c' and using it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Makefile         |  4 ++--
 mm/damon/lru_sort.c       | 17 +++-------------
 mm/damon/modules-common.c | 42 +++++++++++++++++++++++++++++++++++++++
 mm/damon/modules-common.h |  3 +++
 mm/damon/reclaim.c        | 17 +++-------------
 5 files changed, 53 insertions(+), 30 deletions(-)
 create mode 100644 mm/damon/modules-common.c

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index f8d535a6253b..50d6b2ab3956 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
 obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
-obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
-obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
+obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
+obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index efbc2bda8b9c..a1896c5acfe9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -314,25 +314,14 @@ static int damon_lru_sort_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_lru_sort_init(void)
 {
-	ctx = damon_new_ctx();
-	if (!ctx)
-		return -ENOMEM;
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
-		damon_destroy_ctx(ctx);
-		return -EINVAL;
-	}
+	if (err)
+		return err;
 
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
 
-	target = damon_new_target();
-	if (!target) {
-		damon_destroy_ctx(ctx);
-		return -ENOMEM;
-	}
-	damon_add_target(ctx, target);
-
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
 	damon_lru_sort_initialized = true;
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
new file mode 100644
index 000000000000..b2381a8466ec
--- /dev/null
+++ b/mm/damon/modules-common.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Primitives for DAMON Modules
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#include <linux/damon.h>
+
+#include "modules-common.h"
+
+/*
+ * Allocate, set, and return a DAMON context for the physical address space.
+ * @ctxp:	Pointer to save the point to the newly created context
+ * @targetp:	Pointer to save the point to the newly created target
+ */
+int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *target;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+
+	*ctxp = ctx;
+	*targetp = target;
+	return 0;
+}
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index 5a4921851d32..f49cdb417005 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -44,3 +44,6 @@
 			0400);						\
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
+
+int damon_modules_new_paddr_ctx_target(struct damon_ctx **ctxp,
+		struct damon_target **targetp);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 162c9b1ca00f..3173f373435c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -256,25 +256,14 @@ static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
 
 static int __init damon_reclaim_init(void)
 {
-	ctx = damon_new_ctx();
-	if (!ctx)
-		return -ENOMEM;
+	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
-		damon_destroy_ctx(ctx);
-		return -EINVAL;
-	}
+	if (err)
+		return err;
 
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-	target = damon_new_target();
-	if (!target) {
-		damon_destroy_ctx(ctx);
-		return -ENOMEM;
-	}
-	damon_add_target(ctx, target);
-
 	schedule_delayed_work(&damon_reclaim_timer, 0);
 
 	damon_reclaim_initialized = true;
-- 
2.25.1

