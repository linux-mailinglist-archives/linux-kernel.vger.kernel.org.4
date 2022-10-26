Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640060EBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiJZXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiJZXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36027CE3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4057E620E6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A381DC433B5;
        Wed, 26 Oct 2022 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666825194;
        bh=ZOyG8YUU5cVxru2AD6VW1+1EsLz+CD3P+8BEUZMBwok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKHhq6CyP1LSndUbyVyNvrVbk8frT73Mgw1L5/bdsRPcMpjhx4cI82ziwh08BsC3t
         4d41Bog8sPNgy7/S66oVAqUjOkg8LvZrTaUw8jaUSKE4uHFEmv0EEOb9YpAYWuD+39
         sEfcVT9GPtFFcu04s+SuIdDfnC8yA9ApPnXCoGBuCjcDM5JFcoosNwRYCOGMytAfak
         AiyaYDQjSsqpE0UiWCp4jubQBbOA1dP54ET3yUMnuUfTuLR9T2Sb+IatRchA5nGQcd
         MJYqULqVWc6jtnBxLOrbSH8jlHg6ToRXRmo2O5IHWKT6QtJne3bVqAzuhOMZzLhiIy
         /bVgQGarJZT8A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 08/12] mm/damon/sysfs: move unsigned long range directory to common module
Date:   Wed, 26 Oct 2022 22:59:39 +0000
Message-Id: <20221026225943.100429-9-sj@kernel.org>
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

The implementation of unsigned long type range directories can be reused
by multiple DAMON sysfs directories including those for DAMON-based
Operation Schemes and the range of number of monitoring regions.  Move the
code into the files for DAMON sysfs common logics.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs-common.c |  96 ++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs-common.h |  13 ++++++
 mm/damon/sysfs.c        | 100 ----------------------------------------
 3 files changed, 109 insertions(+), 100 deletions(-)

diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 9dc743868d5b..52bebf242f74 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -5,7 +5,103 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/slab.h>
+
 #include "sysfs-common.h"
 
 DEFINE_MUTEX(damon_sysfs_lock);
 
+/*
+ * unsigned long range directory
+ */
+
+struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max)
+{
+	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
+			GFP_KERNEL);
+
+	if (!range)
+		return NULL;
+	range->kobj = (struct kobject){};
+	range->min = min;
+	range->max = max;
+
+	return range;
+}
+
+static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->min);
+}
+
+static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long min;
+	int err;
+
+	err = kstrtoul(buf, 0, &min);
+	if (err)
+		return err;
+
+	range->min = min;
+	return count;
+}
+
+static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+
+	return sysfs_emit(buf, "%lu\n", range->max);
+}
+
+static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_ul_range *range = container_of(kobj,
+			struct damon_sysfs_ul_range, kobj);
+	unsigned long max;
+	int err;
+
+	err = kstrtoul(buf, 0, &max);
+	if (err)
+		return err;
+
+	range->max = max;
+	return count;
+}
+
+void damon_sysfs_ul_range_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_ul_range_min_attr =
+		__ATTR_RW_MODE(min, 0600);
+
+static struct kobj_attribute damon_sysfs_ul_range_max_attr =
+		__ATTR_RW_MODE(max, 0600);
+
+static struct attribute *damon_sysfs_ul_range_attrs[] = {
+	&damon_sysfs_ul_range_min_attr.attr,
+	&damon_sysfs_ul_range_max_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
+
+struct kobj_type damon_sysfs_ul_range_ktype = {
+	.release = damon_sysfs_ul_range_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_ul_range_groups,
+};
+
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 745a918b94f5..56e6a99e353b 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -9,3 +9,16 @@
 #include <linux/kobject.h>
 
 extern struct mutex damon_sysfs_lock;
+
+struct damon_sysfs_ul_range {
+	struct kobject kobj;
+	unsigned long min;
+	unsigned long max;
+};
+
+struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
+		unsigned long min,
+		unsigned long max);
+void damon_sysfs_ul_range_release(struct kobject *kobj);
+
+extern struct kobj_type damon_sysfs_ul_range_ktype;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0f3f06d8dae7..129743292e17 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -11,106 +11,6 @@
 
 #include "sysfs-common.h"
 
-/*
- * unsigned long range directory
- */
-
-struct damon_sysfs_ul_range {
-	struct kobject kobj;
-	unsigned long min;
-	unsigned long max;
-};
-
-static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
-		unsigned long min,
-		unsigned long max)
-{
-	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
-			GFP_KERNEL);
-
-	if (!range)
-		return NULL;
-	range->kobj = (struct kobject){};
-	range->min = min;
-	range->max = max;
-
-	return range;
-}
-
-static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-
-	return sysfs_emit(buf, "%lu\n", range->min);
-}
-
-static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-	unsigned long min;
-	int err;
-
-	err = kstrtoul(buf, 0, &min);
-	if (err)
-		return err;
-
-	range->min = min;
-	return count;
-}
-
-static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-
-	return sysfs_emit(buf, "%lu\n", range->max);
-}
-
-static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
-	unsigned long max;
-	int err;
-
-	err = kstrtoul(buf, 0, &max);
-	if (err)
-		return err;
-
-	range->max = max;
-	return count;
-}
-
-static void damon_sysfs_ul_range_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_ul_range_min_attr =
-		__ATTR_RW_MODE(min, 0600);
-
-static struct kobj_attribute damon_sysfs_ul_range_max_attr =
-		__ATTR_RW_MODE(max, 0600);
-
-static struct attribute *damon_sysfs_ul_range_attrs[] = {
-	&damon_sysfs_ul_range_min_attr.attr,
-	&damon_sysfs_ul_range_max_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
-
-static struct kobj_type damon_sysfs_ul_range_ktype = {
-	.release = damon_sysfs_ul_range_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_ul_range_groups,
-};
-
 /*
  * schemes/stats directory
  */
-- 
2.25.1

