Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466BD60BDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJXWld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiJXWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422B65E8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB4B615B9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5339C433B5;
        Mon, 24 Oct 2022 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644569;
        bh=ToGxVn5DgkZtjVMi4IGaA+ZXlJgYyh7RCq47o6e6Bdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSzy9SJ0dwZ69SDES5dYIVzSTUayn4yv8SDwn3IaJf/ABaUHGdh4f4jGjqv8cVWzD
         Yk1PyK4+OE9EJR8TcwLDAy5+nqT82hdT9S+/vCMlHuorkE+Y1Ns7qRd/qBDpGujUDI
         F4m5W5o4vy96+Q5vmBGLGAfpXnhWVfm+0CJBW3T1cuvf+PqqJEkNTUlgTj+FqjObDN
         2GXiHaGWExkIdPnsJMCeyD6rEWMdOzlwdbs7G3neaoWXRWxUe/1ysjGra8pf1JbCl5
         aRs/0AOYQpQSLSZHjsnUo/UYIkO/S5rSW4D0ELTlfXd2xzLORWwAqUEbhLfm8/jbPQ
         tUx0sed/3Olqw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH 07/11] mm/damon/sysfs: move sysfs_lock to common module
Date:   Mon, 24 Oct 2022 20:49:15 +0000
Message-Id: <20221024204919.18524-8-sj@kernel.org>
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

DAMON sysfs interface is implemented in a single file, sysfs.c, which
has about 2,800 lines of code.  As the interface is hierarchical and
some of the code can be reused by different hierarchies, it would make
more sense to split out the implementation into common parts and
different parts in multiple files.  As the beginning of the work, create
files for common code and move the global mutex for directories
modifications protection into the new file.

Signed-off-by: SeongJae Park <sj@kernel.org>
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

