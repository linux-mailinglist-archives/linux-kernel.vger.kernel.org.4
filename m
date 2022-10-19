Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE16036E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJSANz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJSANb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C4DAC64
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46F29B821AD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7D2C4347C;
        Wed, 19 Oct 2022 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138407;
        bh=tOOj3luO+EygOYDe7o6HDFHzEbK5aAH6Idm+S6DN7zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8CVgNK3brAMUD+ttc9PFIAJCJF15RsAnjfYfdqncoOCdrXuKGUv569s/TN+VHtHH
         WF1GwmWMLD2cixTMKMlqaTaUexsscFQeOmFv3YCA8YTioCVdZIwKl+PrfEDs3+lykd
         ZeyR0i+dpsKsYndu2BGECAuD+TI7FXiEwzXAkXZJJIXzwrB+ykqJ9PjgxZHl2vYedo
         qtmRxw+Q80/EO3o6erYGxv8mBq0Z9ehl84G4o3wYKiy1qsxuMs7i7xGoHdG9x9UQyZ
         +KSSFc8+1G6IqqsJTePgxUOv+pUz+PezWbyJaV5BRMEeZ0EhezXd1xtJYG3a9R15q3
         sQ9+2x+JMorig==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: [RFC PATCH 09/18] mm/damon/sysfs: move sysfs_lock to common module
Date:   Wed, 19 Oct 2022 00:13:08 +0000
Message-Id: <20221019001317.104270-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019001317.104270-1-sj@kernel.org>
References: <20221019001317.104270-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
more sense to split the implementation into common parts and different
parts in multiple files.  As the beginning of the work, create files for
common code and move the global mutex for directories modifications
protection into the files.

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
index a076ccd55d44..50d6b2ab3956 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -3,7 +3,7 @@
 obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
-obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
+obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
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

