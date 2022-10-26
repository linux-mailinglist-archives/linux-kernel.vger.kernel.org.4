Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0235160EBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiJZXAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiJZXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17227CD6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 092AD620C8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154F0C4347C;
        Wed, 26 Oct 2022 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825193;
        bh=LA5eSTlkkTuiqSOiZ/+/4cpBqjOUioigu0cyIQgAlG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdx99LlUzYMWJi74isWfMCDiXyKcMKzijAHikjv0jWN8tI7zmyTSk1qW93l74h7Lb
         hsze/eZTlUpzQ62rz+WlvSlBzeG41W0gpPTx1sZznMrvnYEctzRT4zEukhbOkox3C0
         pQXbJ+Lcjlkfoo4DgHEmsNEg0RIWmJqmyqJehfjkcZKOySeSyjy6zYBU9p7OR/tAut
         Co/Mk7lwUXr8bg8A5h3Eca1kBzGeOlkpjSHBazNz9OzYx95ewoCNEBMbxEhnTGfjYz
         YEY8vXwy8jF9sDchZoVxNkA8Z2lgzPn/OxCyvhVJPWDyEbtXe0Maj+O9ZPWlEwBBRv
         P+DCd2ogTB6IA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 07/12] mm/damon/sysfs: move sysfs_lock to common module
Date:   Wed, 26 Oct 2022 22:59:38 +0000
Message-Id: <20221026225943.100429-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026225943.100429-1-sj@kernel.org>
References: <20221026225943.100429-1-sj@kernel.org>
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

DAMON sysfs interface is implemented in a single file, sysfs.c, which has
about 2,800 lines of code.  As the interface is hierarchical and some of
the code can be reused by different hierarchies, it would make more sense
to split out the implementation into common parts and different parts in
multiple files.  As the beginning of the work, create files for common
code and move the global mutex for directories modifications protection
into the new file.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/Makefile       |  2 +-
 mm/damon/sysfs-common.c | 11 +++++++++++
 mm/damon/sysfs-common.h | 11 +++++++++++
 mm/damon/sysfs.c        |  4 +---
 4 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 3e6b8ad73858..f8d535a6253b 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -3,7 +3,7 @@
 obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
-obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
+obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= lru_sort.o
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
new file mode 100644
index 000000000000..9dc743868d5b
--- /dev/null
+++ b/mm/damon/sysfs-common.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Primitives for DAMON Sysfs Interface
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include "sysfs-common.h"
+
+DEFINE_MUTEX(damon_sysfs_lock);
+
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
new file mode 100644
index 000000000000..745a918b94f5
--- /dev/null
+++ b/mm/damon/sysfs-common.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Primitives for DAMON Sysfs Interface
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/damon.h>
+#include <linux/kobject.h>
+
+extern struct mutex damon_sysfs_lock;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e8bd7367d15b..0f3f06d8dae7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -5,13 +5,11 @@
  * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
  */
 
-#include <linux/damon.h>
-#include <linux/kobject.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-static DEFINE_MUTEX(damon_sysfs_lock);
+#include "sysfs-common.h"
 
 /*
  * unsigned long range directory
-- 
2.25.1

