Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B36036EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJSAOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiJSANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F4DB765
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D78AB821A0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A738C4347C;
        Wed, 19 Oct 2022 00:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138410;
        bh=AYRUEPWmnrbb3UjWU6mJ6oFw+/7zb9HwAVYUvU0K9Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxQwBPHxbdarzIfYMc17tRsx59dDKpfGnxV67eh+k1ztPQqR3xSngO8+wjKwxZ3Tz
         M8iu2aYc2Fhsv7IPrCxZ3Ri5DFIN294auChX/jP2PzJas9EPYTxQlxM10ggtzVUVr8
         R+pRxmNrpNEL3cQoNmIlFrbBJZ7lRhxIiQ7nVw6YkVGlxmrVS6U/+gvQ3FWbQMuPbT
         QFve0EZF+U8CWHaO4UUXG/9VIlErmUqnCd5OkIJZIHmf5cKduZLYSnIdKnLGhjWDcR
         WpocNOfr6J3U7Gl6ZjHND2H6cxq3aukPuVyRD+CzInTTshnSgBKo2QEzSfYCf1ms4b
         30CRYtzyE4nWQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: [RFC PATCH 12/18] mm/damon/sysfs: move schemes directory implementation to separate module
Date:   Wed, 19 Oct 2022 00:13:11 +0000
Message-Id: <20221019001317.104270-13-sj@kernel.org>
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

DAMON sysfs interface for 'schemes' directory is implemented using about
thousand lines of code.  It has no strong dependency with other parts of
its file, so split it out to another file for better code management.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Makefile        |    2 +-
 mm/damon/sysfs-common.h  |   22 +
 mm/damon/sysfs-schemes.c | 1022 ++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c         | 1018 -------------------------------------
 4 files changed, 1045 insertions(+), 1019 deletions(-)
 create mode 100644 mm/damon/sysfs-schemes.c

diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 50d6b2ab3956..f7add3f4aa79 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -3,7 +3,7 @@
 obj-y				:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
 obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
-obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs.o
+obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 56e6a99e353b..4626b2784404 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -22,3 +22,25 @@ struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
 void damon_sysfs_ul_range_release(struct kobject *kobj);
 
 extern struct kobj_type damon_sysfs_ul_range_ktype;
+
+/*
+ * schemes directory
+ */
+
+struct damon_sysfs_schemes {
+	struct kobject kobj;
+	struct damon_sysfs_scheme **schemes_arr;
+	int nr;
+};
+
+struct damon_sysfs_schemes *damon_sysfs_schemes_alloc(void);
+void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes);
+
+extern struct kobj_type damon_sysfs_schemes_ktype;
+
+int damon_sysfs_set_schemes(struct damon_ctx *ctx,
+		struct damon_sysfs_schemes *sysfs_schemes);
+
+void damon_sysfs_schemes_update_stats(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
new file mode 100644
index 000000000000..7ea4bcce90cb
--- /dev/null
+++ b/mm/damon/sysfs-schemes.c
@@ -0,0 +1,1022 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON sysfs Interface
+ *
+ * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
+ */
+
+#include <linux/slab.h>
+
+#include "sysfs-common.h"
+
+/*
+ * schemes/stats directory
+ */
+
+struct damon_sysfs_stats {
+	struct kobject kobj;
+	unsigned long nr_tried;
+	unsigned long sz_tried;
+	unsigned long nr_applied;
+	unsigned long sz_applied;
+	unsigned long qt_exceeds;
+};
+
+static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_stats), GFP_KERNEL);
+}
+
+static ssize_t nr_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->nr_tried);
+}
+
+static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
+}
+
+static ssize_t nr_applied_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->nr_applied);
+}
+
+static ssize_t sz_applied_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
+}
+
+static ssize_t qt_exceeds_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_stats *stats = container_of(kobj,
+			struct damon_sysfs_stats, kobj);
+
+	return sysfs_emit(buf, "%lu\n", stats->qt_exceeds);
+}
+
+static void damon_sysfs_stats_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_stats_nr_tried_attr =
+		__ATTR_RO_MODE(nr_tried, 0400);
+
+static struct kobj_attribute damon_sysfs_stats_sz_tried_attr =
+		__ATTR_RO_MODE(sz_tried, 0400);
+
+static struct kobj_attribute damon_sysfs_stats_nr_applied_attr =
+		__ATTR_RO_MODE(nr_applied, 0400);
+
+static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
+		__ATTR_RO_MODE(sz_applied, 0400);
+
+static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
+		__ATTR_RO_MODE(qt_exceeds, 0400);
+
+static struct attribute *damon_sysfs_stats_attrs[] = {
+	&damon_sysfs_stats_nr_tried_attr.attr,
+	&damon_sysfs_stats_sz_tried_attr.attr,
+	&damon_sysfs_stats_nr_applied_attr.attr,
+	&damon_sysfs_stats_sz_applied_attr.attr,
+	&damon_sysfs_stats_qt_exceeds_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_stats);
+
+static struct kobj_type damon_sysfs_stats_ktype = {
+	.release = damon_sysfs_stats_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_stats_groups,
+};
+
+/*
+ * watermarks directory
+ */
+
+struct damon_sysfs_watermarks {
+	struct kobject kobj;
+	enum damos_wmark_metric metric;
+	unsigned long interval_us;
+	unsigned long high;
+	unsigned long mid;
+	unsigned long low;
+};
+
+static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
+		enum damos_wmark_metric metric, unsigned long interval_us,
+		unsigned long high, unsigned long mid, unsigned long low)
+{
+	struct damon_sysfs_watermarks *watermarks = kmalloc(
+			sizeof(*watermarks), GFP_KERNEL);
+
+	if (!watermarks)
+		return NULL;
+	watermarks->kobj = (struct kobject){};
+	watermarks->metric = metric;
+	watermarks->interval_us = interval_us;
+	watermarks->high = high;
+	watermarks->mid = mid;
+	watermarks->low = low;
+	return watermarks;
+}
+
+/* Should match with enum damos_wmark_metric */
+static const char * const damon_sysfs_wmark_metric_strs[] = {
+	"none",
+	"free_mem_rate",
+};
+
+static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_wmark_metric_strs[watermarks->metric]);
+}
+
+static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	enum damos_wmark_metric metric;
+
+	for (metric = 0; metric < NR_DAMOS_WMARK_METRICS; metric++) {
+		if (sysfs_streq(buf, damon_sysfs_wmark_metric_strs[metric])) {
+			watermarks->metric = metric;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static ssize_t interval_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->interval_us);
+}
+
+static ssize_t interval_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->interval_us);
+
+	return err ? err : count;
+}
+
+static ssize_t high_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->high);
+}
+
+static ssize_t high_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->high);
+
+	return err ? err : count;
+}
+
+static ssize_t mid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->mid);
+}
+
+static ssize_t mid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->mid);
+
+	return err ? err : count;
+}
+
+static ssize_t low_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%lu\n", watermarks->low);
+}
+
+static ssize_t low_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoul(buf, 0, &watermarks->low);
+
+	return err ? err : count;
+}
+
+static void damon_sysfs_watermarks_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_watermarks, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_watermarks_metric_attr =
+		__ATTR_RW_MODE(metric, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_interval_us_attr =
+		__ATTR_RW_MODE(interval_us, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_high_attr =
+		__ATTR_RW_MODE(high, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_mid_attr =
+		__ATTR_RW_MODE(mid, 0600);
+
+static struct kobj_attribute damon_sysfs_watermarks_low_attr =
+		__ATTR_RW_MODE(low, 0600);
+
+static struct attribute *damon_sysfs_watermarks_attrs[] = {
+	&damon_sysfs_watermarks_metric_attr.attr,
+	&damon_sysfs_watermarks_interval_us_attr.attr,
+	&damon_sysfs_watermarks_high_attr.attr,
+	&damon_sysfs_watermarks_mid_attr.attr,
+	&damon_sysfs_watermarks_low_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_watermarks);
+
+static struct kobj_type damon_sysfs_watermarks_ktype = {
+	.release = damon_sysfs_watermarks_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_watermarks_groups,
+};
+
+/*
+ * scheme/weights directory
+ */
+
+struct damon_sysfs_weights {
+	struct kobject kobj;
+	unsigned int sz;
+	unsigned int nr_accesses;
+	unsigned int age;
+};
+
+static struct damon_sysfs_weights *damon_sysfs_weights_alloc(unsigned int sz,
+		unsigned int nr_accesses, unsigned int age)
+{
+	struct damon_sysfs_weights *weights = kmalloc(sizeof(*weights),
+			GFP_KERNEL);
+
+	if (!weights)
+		return NULL;
+	weights->kobj = (struct kobject){};
+	weights->sz = sz;
+	weights->nr_accesses = nr_accesses;
+	weights->age = age;
+	return weights;
+}
+
+static ssize_t sz_permil_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->sz);
+}
+
+static ssize_t sz_permil_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->sz);
+
+	return err ? err : count;
+}
+
+static ssize_t nr_accesses_permil_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->nr_accesses);
+}
+
+static ssize_t nr_accesses_permil_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->nr_accesses);
+
+	return err ? err : count;
+}
+
+static ssize_t age_permil_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+
+	return sysfs_emit(buf, "%u\n", weights->age);
+}
+
+static ssize_t age_permil_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_weights *weights = container_of(kobj,
+			struct damon_sysfs_weights, kobj);
+	int err = kstrtouint(buf, 0, &weights->age);
+
+	return err ? err : count;
+}
+
+static void damon_sysfs_weights_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_weights, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_weights_sz_attr =
+		__ATTR_RW_MODE(sz_permil, 0600);
+
+static struct kobj_attribute damon_sysfs_weights_nr_accesses_attr =
+		__ATTR_RW_MODE(nr_accesses_permil, 0600);
+
+static struct kobj_attribute damon_sysfs_weights_age_attr =
+		__ATTR_RW_MODE(age_permil, 0600);
+
+static struct attribute *damon_sysfs_weights_attrs[] = {
+	&damon_sysfs_weights_sz_attr.attr,
+	&damon_sysfs_weights_nr_accesses_attr.attr,
+	&damon_sysfs_weights_age_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_weights);
+
+static struct kobj_type damon_sysfs_weights_ktype = {
+	.release = damon_sysfs_weights_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_weights_groups,
+};
+
+/*
+ * quotas directory
+ */
+
+struct damon_sysfs_quotas {
+	struct kobject kobj;
+	struct damon_sysfs_weights *weights;
+	unsigned long ms;
+	unsigned long sz;
+	unsigned long reset_interval_ms;
+};
+
+static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_quotas), GFP_KERNEL);
+}
+
+static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
+{
+	struct damon_sysfs_weights *weights;
+	int err;
+
+	weights = damon_sysfs_weights_alloc(0, 0, 0);
+	if (!weights)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&weights->kobj, &damon_sysfs_weights_ktype,
+			&quotas->kobj, "weights");
+	if (err)
+		kobject_put(&weights->kobj);
+	else
+		quotas->weights = weights;
+	return err;
+}
+
+static void damon_sysfs_quotas_rm_dirs(struct damon_sysfs_quotas *quotas)
+{
+	kobject_put(&quotas->weights->kobj);
+}
+
+static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->ms);
+}
+
+static ssize_t ms_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->ms);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t bytes_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->sz);
+}
+
+static ssize_t bytes_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->sz);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t reset_interval_ms_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+
+	return sysfs_emit(buf, "%lu\n", quotas->reset_interval_ms);
+}
+
+static ssize_t reset_interval_ms_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_quotas *quotas = container_of(kobj,
+			struct damon_sysfs_quotas, kobj);
+	int err = kstrtoul(buf, 0, &quotas->reset_interval_ms);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
+static void damon_sysfs_quotas_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_quotas_ms_attr =
+		__ATTR_RW_MODE(ms, 0600);
+
+static struct kobj_attribute damon_sysfs_quotas_sz_attr =
+		__ATTR_RW_MODE(bytes, 0600);
+
+static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
+		__ATTR_RW_MODE(reset_interval_ms, 0600);
+
+static struct attribute *damon_sysfs_quotas_attrs[] = {
+	&damon_sysfs_quotas_ms_attr.attr,
+	&damon_sysfs_quotas_sz_attr.attr,
+	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_quotas);
+
+static struct kobj_type damon_sysfs_quotas_ktype = {
+	.release = damon_sysfs_quotas_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_quotas_groups,
+};
+
+/*
+ * access_pattern directory
+ */
+
+struct damon_sysfs_access_pattern {
+	struct kobject kobj;
+	struct damon_sysfs_ul_range *sz;
+	struct damon_sysfs_ul_range *nr_accesses;
+	struct damon_sysfs_ul_range *age;
+};
+
+static
+struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
+{
+	struct damon_sysfs_access_pattern *access_pattern =
+		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
+
+	if (!access_pattern)
+		return NULL;
+	access_pattern->kobj = (struct kobject){};
+	return access_pattern;
+}
+
+static int damon_sysfs_access_pattern_add_range_dir(
+		struct damon_sysfs_access_pattern *access_pattern,
+		struct damon_sysfs_ul_range **range_dir_ptr,
+		char *name)
+{
+	struct damon_sysfs_ul_range *range = damon_sysfs_ul_range_alloc(0, 0);
+	int err;
+
+	if (!range)
+		return -ENOMEM;
+	err = kobject_init_and_add(&range->kobj, &damon_sysfs_ul_range_ktype,
+			&access_pattern->kobj, name);
+	if (err)
+		kobject_put(&range->kobj);
+	else
+		*range_dir_ptr = range;
+	return err;
+}
+
+static int damon_sysfs_access_pattern_add_dirs(
+		struct damon_sysfs_access_pattern *access_pattern)
+{
+	int err;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->sz, "sz");
+	if (err)
+		goto put_sz_out;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->nr_accesses, "nr_accesses");
+	if (err)
+		goto put_nr_accesses_sz_out;
+
+	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
+			&access_pattern->age, "age");
+	if (err)
+		goto put_age_nr_accesses_sz_out;
+	return 0;
+
+put_age_nr_accesses_sz_out:
+	kobject_put(&access_pattern->age->kobj);
+	access_pattern->age = NULL;
+put_nr_accesses_sz_out:
+	kobject_put(&access_pattern->nr_accesses->kobj);
+	access_pattern->nr_accesses = NULL;
+put_sz_out:
+	kobject_put(&access_pattern->sz->kobj);
+	access_pattern->sz = NULL;
+	return err;
+}
+
+static void damon_sysfs_access_pattern_rm_dirs(
+		struct damon_sysfs_access_pattern *access_pattern)
+{
+	kobject_put(&access_pattern->sz->kobj);
+	kobject_put(&access_pattern->nr_accesses->kobj);
+	kobject_put(&access_pattern->age->kobj);
+}
+
+static void damon_sysfs_access_pattern_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_access_pattern, kobj));
+}
+
+static struct attribute *damon_sysfs_access_pattern_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_access_pattern);
+
+static struct kobj_type damon_sysfs_access_pattern_ktype = {
+	.release = damon_sysfs_access_pattern_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_access_pattern_groups,
+};
+
+/*
+ * scheme directory
+ */
+
+struct damon_sysfs_scheme {
+	struct kobject kobj;
+	enum damos_action action;
+	struct damon_sysfs_access_pattern *access_pattern;
+	struct damon_sysfs_quotas *quotas;
+	struct damon_sysfs_watermarks *watermarks;
+	struct damon_sysfs_stats *stats;
+};
+
+/* This should match with enum damos_action */
+static const char * const damon_sysfs_damos_action_strs[] = {
+	"willneed",
+	"cold",
+	"pageout",
+	"hugepage",
+	"nohugepage",
+	"lru_prio",
+	"lru_deprio",
+	"stat",
+};
+
+static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
+		enum damos_action action)
+{
+	struct damon_sysfs_scheme *scheme = kmalloc(sizeof(*scheme),
+				GFP_KERNEL);
+
+	if (!scheme)
+		return NULL;
+	scheme->kobj = (struct kobject){};
+	scheme->action = action;
+	return scheme;
+}
+
+static int damon_sysfs_scheme_set_access_pattern(
+		struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_access_pattern *access_pattern;
+	int err;
+
+	access_pattern = damon_sysfs_access_pattern_alloc();
+	if (!access_pattern)
+		return -ENOMEM;
+	err = kobject_init_and_add(&access_pattern->kobj,
+			&damon_sysfs_access_pattern_ktype, &scheme->kobj,
+			"access_pattern");
+	if (err)
+		goto out;
+	err = damon_sysfs_access_pattern_add_dirs(access_pattern);
+	if (err)
+		goto out;
+	scheme->access_pattern = access_pattern;
+	return 0;
+
+out:
+	kobject_put(&access_pattern->kobj);
+	return err;
+}
+
+static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_quotas *quotas = damon_sysfs_quotas_alloc();
+	int err;
+
+	if (!quotas)
+		return -ENOMEM;
+	err = kobject_init_and_add(&quotas->kobj, &damon_sysfs_quotas_ktype,
+			&scheme->kobj, "quotas");
+	if (err)
+		goto out;
+	err = damon_sysfs_quotas_add_dirs(quotas);
+	if (err)
+		goto out;
+	scheme->quotas = quotas;
+	return 0;
+
+out:
+	kobject_put(&quotas->kobj);
+	return err;
+}
+
+static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_watermarks *watermarks =
+		damon_sysfs_watermarks_alloc(DAMOS_WMARK_NONE, 0, 0, 0, 0);
+	int err;
+
+	if (!watermarks)
+		return -ENOMEM;
+	err = kobject_init_and_add(&watermarks->kobj,
+			&damon_sysfs_watermarks_ktype, &scheme->kobj,
+			"watermarks");
+	if (err)
+		kobject_put(&watermarks->kobj);
+	else
+		scheme->watermarks = watermarks;
+	return err;
+}
+
+static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_stats *stats = damon_sysfs_stats_alloc();
+	int err;
+
+	if (!stats)
+		return -ENOMEM;
+	err = kobject_init_and_add(&stats->kobj, &damon_sysfs_stats_ktype,
+			&scheme->kobj, "stats");
+	if (err)
+		kobject_put(&stats->kobj);
+	else
+		scheme->stats = stats;
+	return err;
+}
+
+static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
+{
+	int err;
+
+	err = damon_sysfs_scheme_set_access_pattern(scheme);
+	if (err)
+		return err;
+	err = damon_sysfs_scheme_set_quotas(scheme);
+	if (err)
+		goto put_access_pattern_out;
+	err = damon_sysfs_scheme_set_watermarks(scheme);
+	if (err)
+		goto put_quotas_access_pattern_out;
+	err = damon_sysfs_scheme_set_stats(scheme);
+	if (err)
+		goto put_watermarks_quotas_access_pattern_out;
+	return 0;
+
+put_watermarks_quotas_access_pattern_out:
+	kobject_put(&scheme->watermarks->kobj);
+	scheme->watermarks = NULL;
+put_quotas_access_pattern_out:
+	kobject_put(&scheme->quotas->kobj);
+	scheme->quotas = NULL;
+put_access_pattern_out:
+	kobject_put(&scheme->access_pattern->kobj);
+	scheme->access_pattern = NULL;
+	return err;
+}
+
+static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
+{
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
+	kobject_put(&scheme->access_pattern->kobj);
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
+	kobject_put(&scheme->quotas->kobj);
+	kobject_put(&scheme->watermarks->kobj);
+	kobject_put(&scheme->stats->kobj);
+}
+
+static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_damos_action_strs[scheme->action]);
+}
+
+static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	enum damos_action action;
+
+	for (action = 0; action < NR_DAMOS_ACTIONS; action++) {
+		if (sysfs_streq(buf, damon_sysfs_damos_action_strs[action])) {
+			scheme->action = action;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
+static void damon_sysfs_scheme_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_scheme_action_attr =
+		__ATTR_RW_MODE(action, 0600);
+
+static struct attribute *damon_sysfs_scheme_attrs[] = {
+	&damon_sysfs_scheme_action_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme);
+
+static struct kobj_type damon_sysfs_scheme_ktype = {
+	.release = damon_sysfs_scheme_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_groups,
+};
+
+/*
+ * schemes directory
+ */
+
+struct damon_sysfs_schemes *damon_sysfs_schemes_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_schemes), GFP_KERNEL);
+}
+
+void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
+{
+	struct damon_sysfs_scheme **schemes_arr = schemes->schemes_arr;
+	int i;
+
+	for (i = 0; i < schemes->nr; i++) {
+		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_put(&schemes_arr[i]->kobj);
+	}
+	schemes->nr = 0;
+	kfree(schemes_arr);
+	schemes->schemes_arr = NULL;
+}
+
+static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
+		int nr_schemes)
+{
+	struct damon_sysfs_scheme **schemes_arr, *scheme;
+	int err, i;
+
+	damon_sysfs_schemes_rm_dirs(schemes);
+	if (!nr_schemes)
+		return 0;
+
+	schemes_arr = kmalloc_array(nr_schemes, sizeof(*schemes_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!schemes_arr)
+		return -ENOMEM;
+	schemes->schemes_arr = schemes_arr;
+
+	for (i = 0; i < nr_schemes; i++) {
+		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT);
+		if (!scheme) {
+			damon_sysfs_schemes_rm_dirs(schemes);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&scheme->kobj,
+				&damon_sysfs_scheme_ktype, &schemes->kobj,
+				"%d", i);
+		if (err)
+			goto out;
+		err = damon_sysfs_scheme_add_dirs(scheme);
+		if (err)
+			goto out;
+
+		schemes_arr[i] = scheme;
+		schemes->nr++;
+	}
+	return 0;
+
+out:
+	damon_sysfs_schemes_rm_dirs(schemes);
+	kobject_put(&scheme->kobj);
+	return err;
+}
+
+static ssize_t nr_schemes_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_schemes *schemes = container_of(kobj,
+			struct damon_sysfs_schemes, kobj);
+
+	return sysfs_emit(buf, "%d\n", schemes->nr);
+}
+
+static ssize_t nr_schemes_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_schemes *schemes;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_schemes_add_dirs(schemes, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+	return count;
+}
+
+static void damon_sysfs_schemes_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_schemes, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_schemes_nr_attr =
+		__ATTR_RW_MODE(nr_schemes, 0600);
+
+static struct attribute *damon_sysfs_schemes_attrs[] = {
+	&damon_sysfs_schemes_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_schemes);
+
+struct kobj_type damon_sysfs_schemes_ktype = {
+	.release = damon_sysfs_schemes_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_schemes_groups,
+};
+
+static struct damos *damon_sysfs_mk_scheme(
+		struct damon_sysfs_scheme *sysfs_scheme)
+{
+	struct damon_sysfs_access_pattern *access_pattern =
+		sysfs_scheme->access_pattern;
+	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
+	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
+	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
+
+	struct damos_access_pattern pattern = {
+		.min_sz_region = access_pattern->sz->min,
+		.max_sz_region = access_pattern->sz->max,
+		.min_nr_accesses = access_pattern->nr_accesses->min,
+		.max_nr_accesses = access_pattern->nr_accesses->max,
+		.min_age_region = access_pattern->age->min,
+		.max_age_region = access_pattern->age->max,
+	};
+	struct damos_quota quota = {
+		.ms = sysfs_quotas->ms,
+		.sz = sysfs_quotas->sz,
+		.reset_interval = sysfs_quotas->reset_interval_ms,
+		.weight_sz = sysfs_weights->sz,
+		.weight_nr_accesses = sysfs_weights->nr_accesses,
+		.weight_age = sysfs_weights->age,
+	};
+	struct damos_watermarks wmarks = {
+		.metric = sysfs_wmarks->metric,
+		.interval = sysfs_wmarks->interval_us,
+		.high = sysfs_wmarks->high,
+		.mid = sysfs_wmarks->mid,
+		.low = sysfs_wmarks->low,
+	};
+
+	return damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+			&wmarks);
+}
+
+int damon_sysfs_set_schemes(struct damon_ctx *ctx,
+		struct damon_sysfs_schemes *sysfs_schemes)
+{
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		struct damos *scheme, *next;
+
+		scheme = damon_sysfs_mk_scheme(sysfs_schemes->schemes_arr[i]);
+		if (!scheme) {
+			damon_for_each_scheme_safe(scheme, next, ctx)
+				damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		damon_add_scheme(ctx, scheme);
+	}
+	return 0;
+}
+
+void damon_sysfs_schemes_update_stats(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_stats *sysfs_stats;
+
+		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
+		sysfs_stats->nr_tried = scheme->stat.nr_tried;
+		sysfs_stats->sz_tried = scheme->stat.sz_tried;
+		sysfs_stats->nr_applied = scheme->stat.nr_applied;
+		sysfs_stats->sz_applied = scheme->stat.sz_applied;
+		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
+	}
+}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 082c55e68e0e..284daf274b3e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -11,949 +11,6 @@
 
 #include "sysfs-common.h"
 
-/*
- * schemes/stats directory
- */
-
-struct damon_sysfs_stats {
-	struct kobject kobj;
-	unsigned long nr_tried;
-	unsigned long sz_tried;
-	unsigned long nr_applied;
-	unsigned long sz_applied;
-	unsigned long qt_exceeds;
-};
-
-static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
-{
-	return kzalloc(sizeof(struct damon_sysfs_stats), GFP_KERNEL);
-}
-
-static ssize_t nr_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
-
-	return sysfs_emit(buf, "%lu\n", stats->nr_tried);
-}
-
-static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
-
-	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
-}
-
-static ssize_t nr_applied_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
-
-	return sysfs_emit(buf, "%lu\n", stats->nr_applied);
-}
-
-static ssize_t sz_applied_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
-
-	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
-}
-
-static ssize_t qt_exceeds_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
-
-	return sysfs_emit(buf, "%lu\n", stats->qt_exceeds);
-}
-
-static void damon_sysfs_stats_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_stats_nr_tried_attr =
-		__ATTR_RO_MODE(nr_tried, 0400);
-
-static struct kobj_attribute damon_sysfs_stats_sz_tried_attr =
-		__ATTR_RO_MODE(sz_tried, 0400);
-
-static struct kobj_attribute damon_sysfs_stats_nr_applied_attr =
-		__ATTR_RO_MODE(nr_applied, 0400);
-
-static struct kobj_attribute damon_sysfs_stats_sz_applied_attr =
-		__ATTR_RO_MODE(sz_applied, 0400);
-
-static struct kobj_attribute damon_sysfs_stats_qt_exceeds_attr =
-		__ATTR_RO_MODE(qt_exceeds, 0400);
-
-static struct attribute *damon_sysfs_stats_attrs[] = {
-	&damon_sysfs_stats_nr_tried_attr.attr,
-	&damon_sysfs_stats_sz_tried_attr.attr,
-	&damon_sysfs_stats_nr_applied_attr.attr,
-	&damon_sysfs_stats_sz_applied_attr.attr,
-	&damon_sysfs_stats_qt_exceeds_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_stats);
-
-static struct kobj_type damon_sysfs_stats_ktype = {
-	.release = damon_sysfs_stats_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_stats_groups,
-};
-
-/*
- * watermarks directory
- */
-
-struct damon_sysfs_watermarks {
-	struct kobject kobj;
-	enum damos_wmark_metric metric;
-	unsigned long interval_us;
-	unsigned long high;
-	unsigned long mid;
-	unsigned long low;
-};
-
-static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
-		enum damos_wmark_metric metric, unsigned long interval_us,
-		unsigned long high, unsigned long mid, unsigned long low)
-{
-	struct damon_sysfs_watermarks *watermarks = kmalloc(
-			sizeof(*watermarks), GFP_KERNEL);
-
-	if (!watermarks)
-		return NULL;
-	watermarks->kobj = (struct kobject){};
-	watermarks->metric = metric;
-	watermarks->interval_us = interval_us;
-	watermarks->high = high;
-	watermarks->mid = mid;
-	watermarks->low = low;
-	return watermarks;
-}
-
-/* Should match with enum damos_wmark_metric */
-static const char * const damon_sysfs_wmark_metric_strs[] = {
-	"none",
-	"free_mem_rate",
-};
-
-static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-
-	return sysfs_emit(buf, "%s\n",
-			damon_sysfs_wmark_metric_strs[watermarks->metric]);
-}
-
-static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-	enum damos_wmark_metric metric;
-
-	for (metric = 0; metric < NR_DAMOS_WMARK_METRICS; metric++) {
-		if (sysfs_streq(buf, damon_sysfs_wmark_metric_strs[metric])) {
-			watermarks->metric = metric;
-			return count;
-		}
-	}
-	return -EINVAL;
-}
-
-static ssize_t interval_us_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-
-	return sysfs_emit(buf, "%lu\n", watermarks->interval_us);
-}
-
-static ssize_t interval_us_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-	int err = kstrtoul(buf, 0, &watermarks->interval_us);
-
-	return err ? err : count;
-}
-
-static ssize_t high_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-
-	return sysfs_emit(buf, "%lu\n", watermarks->high);
-}
-
-static ssize_t high_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-	int err = kstrtoul(buf, 0, &watermarks->high);
-
-	return err ? err : count;
-}
-
-static ssize_t mid_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-
-	return sysfs_emit(buf, "%lu\n", watermarks->mid);
-}
-
-static ssize_t mid_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-	int err = kstrtoul(buf, 0, &watermarks->mid);
-
-	return err ? err : count;
-}
-
-static ssize_t low_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-
-	return sysfs_emit(buf, "%lu\n", watermarks->low);
-}
-
-static ssize_t low_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
-	int err = kstrtoul(buf, 0, &watermarks->low);
-
-	return err ? err : count;
-}
-
-static void damon_sysfs_watermarks_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_watermarks, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_watermarks_metric_attr =
-		__ATTR_RW_MODE(metric, 0600);
-
-static struct kobj_attribute damon_sysfs_watermarks_interval_us_attr =
-		__ATTR_RW_MODE(interval_us, 0600);
-
-static struct kobj_attribute damon_sysfs_watermarks_high_attr =
-		__ATTR_RW_MODE(high, 0600);
-
-static struct kobj_attribute damon_sysfs_watermarks_mid_attr =
-		__ATTR_RW_MODE(mid, 0600);
-
-static struct kobj_attribute damon_sysfs_watermarks_low_attr =
-		__ATTR_RW_MODE(low, 0600);
-
-static struct attribute *damon_sysfs_watermarks_attrs[] = {
-	&damon_sysfs_watermarks_metric_attr.attr,
-	&damon_sysfs_watermarks_interval_us_attr.attr,
-	&damon_sysfs_watermarks_high_attr.attr,
-	&damon_sysfs_watermarks_mid_attr.attr,
-	&damon_sysfs_watermarks_low_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_watermarks);
-
-static struct kobj_type damon_sysfs_watermarks_ktype = {
-	.release = damon_sysfs_watermarks_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_watermarks_groups,
-};
-
-/*
- * scheme/weights directory
- */
-
-struct damon_sysfs_weights {
-	struct kobject kobj;
-	unsigned int sz;
-	unsigned int nr_accesses;
-	unsigned int age;
-};
-
-static struct damon_sysfs_weights *damon_sysfs_weights_alloc(unsigned int sz,
-		unsigned int nr_accesses, unsigned int age)
-{
-	struct damon_sysfs_weights *weights = kmalloc(sizeof(*weights),
-			GFP_KERNEL);
-
-	if (!weights)
-		return NULL;
-	weights->kobj = (struct kobject){};
-	weights->sz = sz;
-	weights->nr_accesses = nr_accesses;
-	weights->age = age;
-	return weights;
-}
-
-static ssize_t sz_permil_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-
-	return sysfs_emit(buf, "%u\n", weights->sz);
-}
-
-static ssize_t sz_permil_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-	int err = kstrtouint(buf, 0, &weights->sz);
-
-	return err ? err : count;
-}
-
-static ssize_t nr_accesses_permil_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-
-	return sysfs_emit(buf, "%u\n", weights->nr_accesses);
-}
-
-static ssize_t nr_accesses_permil_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-	int err = kstrtouint(buf, 0, &weights->nr_accesses);
-
-	return err ? err : count;
-}
-
-static ssize_t age_permil_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-
-	return sysfs_emit(buf, "%u\n", weights->age);
-}
-
-static ssize_t age_permil_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
-	int err = kstrtouint(buf, 0, &weights->age);
-
-	return err ? err : count;
-}
-
-static void damon_sysfs_weights_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_weights, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_weights_sz_attr =
-		__ATTR_RW_MODE(sz_permil, 0600);
-
-static struct kobj_attribute damon_sysfs_weights_nr_accesses_attr =
-		__ATTR_RW_MODE(nr_accesses_permil, 0600);
-
-static struct kobj_attribute damon_sysfs_weights_age_attr =
-		__ATTR_RW_MODE(age_permil, 0600);
-
-static struct attribute *damon_sysfs_weights_attrs[] = {
-	&damon_sysfs_weights_sz_attr.attr,
-	&damon_sysfs_weights_nr_accesses_attr.attr,
-	&damon_sysfs_weights_age_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_weights);
-
-static struct kobj_type damon_sysfs_weights_ktype = {
-	.release = damon_sysfs_weights_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_weights_groups,
-};
-
-/*
- * quotas directory
- */
-
-struct damon_sysfs_quotas {
-	struct kobject kobj;
-	struct damon_sysfs_weights *weights;
-	unsigned long ms;
-	unsigned long sz;
-	unsigned long reset_interval_ms;
-};
-
-static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
-{
-	return kzalloc(sizeof(struct damon_sysfs_quotas), GFP_KERNEL);
-}
-
-static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
-{
-	struct damon_sysfs_weights *weights;
-	int err;
-
-	weights = damon_sysfs_weights_alloc(0, 0, 0);
-	if (!weights)
-		return -ENOMEM;
-
-	err = kobject_init_and_add(&weights->kobj, &damon_sysfs_weights_ktype,
-			&quotas->kobj, "weights");
-	if (err)
-		kobject_put(&weights->kobj);
-	else
-		quotas->weights = weights;
-	return err;
-}
-
-static void damon_sysfs_quotas_rm_dirs(struct damon_sysfs_quotas *quotas)
-{
-	kobject_put(&quotas->weights->kobj);
-}
-
-static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-
-	return sysfs_emit(buf, "%lu\n", quotas->ms);
-}
-
-static ssize_t ms_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-	int err = kstrtoul(buf, 0, &quotas->ms);
-
-	if (err)
-		return -EINVAL;
-	return count;
-}
-
-static ssize_t bytes_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-
-	return sysfs_emit(buf, "%lu\n", quotas->sz);
-}
-
-static ssize_t bytes_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-	int err = kstrtoul(buf, 0, &quotas->sz);
-
-	if (err)
-		return -EINVAL;
-	return count;
-}
-
-static ssize_t reset_interval_ms_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-
-	return sysfs_emit(buf, "%lu\n", quotas->reset_interval_ms);
-}
-
-static ssize_t reset_interval_ms_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
-	int err = kstrtoul(buf, 0, &quotas->reset_interval_ms);
-
-	if (err)
-		return -EINVAL;
-	return count;
-}
-
-static void damon_sysfs_quotas_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_quotas_ms_attr =
-		__ATTR_RW_MODE(ms, 0600);
-
-static struct kobj_attribute damon_sysfs_quotas_sz_attr =
-		__ATTR_RW_MODE(bytes, 0600);
-
-static struct kobj_attribute damon_sysfs_quotas_reset_interval_ms_attr =
-		__ATTR_RW_MODE(reset_interval_ms, 0600);
-
-static struct attribute *damon_sysfs_quotas_attrs[] = {
-	&damon_sysfs_quotas_ms_attr.attr,
-	&damon_sysfs_quotas_sz_attr.attr,
-	&damon_sysfs_quotas_reset_interval_ms_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_quotas);
-
-static struct kobj_type damon_sysfs_quotas_ktype = {
-	.release = damon_sysfs_quotas_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_quotas_groups,
-};
-
-/*
- * access_pattern directory
- */
-
-struct damon_sysfs_access_pattern {
-	struct kobject kobj;
-	struct damon_sysfs_ul_range *sz;
-	struct damon_sysfs_ul_range *nr_accesses;
-	struct damon_sysfs_ul_range *age;
-};
-
-static
-struct damon_sysfs_access_pattern *damon_sysfs_access_pattern_alloc(void)
-{
-	struct damon_sysfs_access_pattern *access_pattern =
-		kmalloc(sizeof(*access_pattern), GFP_KERNEL);
-
-	if (!access_pattern)
-		return NULL;
-	access_pattern->kobj = (struct kobject){};
-	return access_pattern;
-}
-
-static int damon_sysfs_access_pattern_add_range_dir(
-		struct damon_sysfs_access_pattern *access_pattern,
-		struct damon_sysfs_ul_range **range_dir_ptr,
-		char *name)
-{
-	struct damon_sysfs_ul_range *range = damon_sysfs_ul_range_alloc(0, 0);
-	int err;
-
-	if (!range)
-		return -ENOMEM;
-	err = kobject_init_and_add(&range->kobj, &damon_sysfs_ul_range_ktype,
-			&access_pattern->kobj, name);
-	if (err)
-		kobject_put(&range->kobj);
-	else
-		*range_dir_ptr = range;
-	return err;
-}
-
-static int damon_sysfs_access_pattern_add_dirs(
-		struct damon_sysfs_access_pattern *access_pattern)
-{
-	int err;
-
-	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
-			&access_pattern->sz, "sz");
-	if (err)
-		goto put_sz_out;
-
-	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
-			&access_pattern->nr_accesses, "nr_accesses");
-	if (err)
-		goto put_nr_accesses_sz_out;
-
-	err = damon_sysfs_access_pattern_add_range_dir(access_pattern,
-			&access_pattern->age, "age");
-	if (err)
-		goto put_age_nr_accesses_sz_out;
-	return 0;
-
-put_age_nr_accesses_sz_out:
-	kobject_put(&access_pattern->age->kobj);
-	access_pattern->age = NULL;
-put_nr_accesses_sz_out:
-	kobject_put(&access_pattern->nr_accesses->kobj);
-	access_pattern->nr_accesses = NULL;
-put_sz_out:
-	kobject_put(&access_pattern->sz->kobj);
-	access_pattern->sz = NULL;
-	return err;
-}
-
-static void damon_sysfs_access_pattern_rm_dirs(
-		struct damon_sysfs_access_pattern *access_pattern)
-{
-	kobject_put(&access_pattern->sz->kobj);
-	kobject_put(&access_pattern->nr_accesses->kobj);
-	kobject_put(&access_pattern->age->kobj);
-}
-
-static void damon_sysfs_access_pattern_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_access_pattern, kobj));
-}
-
-static struct attribute *damon_sysfs_access_pattern_attrs[] = {
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_access_pattern);
-
-static struct kobj_type damon_sysfs_access_pattern_ktype = {
-	.release = damon_sysfs_access_pattern_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_access_pattern_groups,
-};
-
-/*
- * scheme directory
- */
-
-struct damon_sysfs_scheme {
-	struct kobject kobj;
-	enum damos_action action;
-	struct damon_sysfs_access_pattern *access_pattern;
-	struct damon_sysfs_quotas *quotas;
-	struct damon_sysfs_watermarks *watermarks;
-	struct damon_sysfs_stats *stats;
-};
-
-/* This should match with enum damos_action */
-static const char * const damon_sysfs_damos_action_strs[] = {
-	"willneed",
-	"cold",
-	"pageout",
-	"hugepage",
-	"nohugepage",
-	"lru_prio",
-	"lru_deprio",
-	"stat",
-};
-
-static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
-		enum damos_action action)
-{
-	struct damon_sysfs_scheme *scheme = kmalloc(sizeof(*scheme),
-				GFP_KERNEL);
-
-	if (!scheme)
-		return NULL;
-	scheme->kobj = (struct kobject){};
-	scheme->action = action;
-	return scheme;
-}
-
-static int damon_sysfs_scheme_set_access_pattern(
-		struct damon_sysfs_scheme *scheme)
-{
-	struct damon_sysfs_access_pattern *access_pattern;
-	int err;
-
-	access_pattern = damon_sysfs_access_pattern_alloc();
-	if (!access_pattern)
-		return -ENOMEM;
-	err = kobject_init_and_add(&access_pattern->kobj,
-			&damon_sysfs_access_pattern_ktype, &scheme->kobj,
-			"access_pattern");
-	if (err)
-		goto out;
-	err = damon_sysfs_access_pattern_add_dirs(access_pattern);
-	if (err)
-		goto out;
-	scheme->access_pattern = access_pattern;
-	return 0;
-
-out:
-	kobject_put(&access_pattern->kobj);
-	return err;
-}
-
-static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
-{
-	struct damon_sysfs_quotas *quotas = damon_sysfs_quotas_alloc();
-	int err;
-
-	if (!quotas)
-		return -ENOMEM;
-	err = kobject_init_and_add(&quotas->kobj, &damon_sysfs_quotas_ktype,
-			&scheme->kobj, "quotas");
-	if (err)
-		goto out;
-	err = damon_sysfs_quotas_add_dirs(quotas);
-	if (err)
-		goto out;
-	scheme->quotas = quotas;
-	return 0;
-
-out:
-	kobject_put(&quotas->kobj);
-	return err;
-}
-
-static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
-{
-	struct damon_sysfs_watermarks *watermarks =
-		damon_sysfs_watermarks_alloc(DAMOS_WMARK_NONE, 0, 0, 0, 0);
-	int err;
-
-	if (!watermarks)
-		return -ENOMEM;
-	err = kobject_init_and_add(&watermarks->kobj,
-			&damon_sysfs_watermarks_ktype, &scheme->kobj,
-			"watermarks");
-	if (err)
-		kobject_put(&watermarks->kobj);
-	else
-		scheme->watermarks = watermarks;
-	return err;
-}
-
-static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
-{
-	struct damon_sysfs_stats *stats = damon_sysfs_stats_alloc();
-	int err;
-
-	if (!stats)
-		return -ENOMEM;
-	err = kobject_init_and_add(&stats->kobj, &damon_sysfs_stats_ktype,
-			&scheme->kobj, "stats");
-	if (err)
-		kobject_put(&stats->kobj);
-	else
-		scheme->stats = stats;
-	return err;
-}
-
-static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
-{
-	int err;
-
-	err = damon_sysfs_scheme_set_access_pattern(scheme);
-	if (err)
-		return err;
-	err = damon_sysfs_scheme_set_quotas(scheme);
-	if (err)
-		goto put_access_pattern_out;
-	err = damon_sysfs_scheme_set_watermarks(scheme);
-	if (err)
-		goto put_quotas_access_pattern_out;
-	err = damon_sysfs_scheme_set_stats(scheme);
-	if (err)
-		goto put_watermarks_quotas_access_pattern_out;
-	return 0;
-
-put_watermarks_quotas_access_pattern_out:
-	kobject_put(&scheme->watermarks->kobj);
-	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
-	kobject_put(&scheme->quotas->kobj);
-	scheme->quotas = NULL;
-put_access_pattern_out:
-	kobject_put(&scheme->access_pattern->kobj);
-	scheme->access_pattern = NULL;
-	return err;
-}
-
-static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
-{
-	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
-	kobject_put(&scheme->access_pattern->kobj);
-	damon_sysfs_quotas_rm_dirs(scheme->quotas);
-	kobject_put(&scheme->quotas->kobj);
-	kobject_put(&scheme->watermarks->kobj);
-	kobject_put(&scheme->stats->kobj);
-}
-
-static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
-		char *buf)
-{
-	struct damon_sysfs_scheme *scheme = container_of(kobj,
-			struct damon_sysfs_scheme, kobj);
-
-	return sysfs_emit(buf, "%s\n",
-			damon_sysfs_damos_action_strs[scheme->action]);
-}
-
-static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
-		const char *buf, size_t count)
-{
-	struct damon_sysfs_scheme *scheme = container_of(kobj,
-			struct damon_sysfs_scheme, kobj);
-	enum damos_action action;
-
-	for (action = 0; action < NR_DAMOS_ACTIONS; action++) {
-		if (sysfs_streq(buf, damon_sysfs_damos_action_strs[action])) {
-			scheme->action = action;
-			return count;
-		}
-	}
-	return -EINVAL;
-}
-
-static void damon_sysfs_scheme_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_scheme_action_attr =
-		__ATTR_RW_MODE(action, 0600);
-
-static struct attribute *damon_sysfs_scheme_attrs[] = {
-	&damon_sysfs_scheme_action_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_scheme);
-
-static struct kobj_type damon_sysfs_scheme_ktype = {
-	.release = damon_sysfs_scheme_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_scheme_groups,
-};
-
-/*
- * schemes directory
- */
-
-struct damon_sysfs_schemes {
-	struct kobject kobj;
-	struct damon_sysfs_scheme **schemes_arr;
-	int nr;
-};
-
-static struct damon_sysfs_schemes *damon_sysfs_schemes_alloc(void)
-{
-	return kzalloc(sizeof(struct damon_sysfs_schemes), GFP_KERNEL);
-}
-
-static void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
-{
-	struct damon_sysfs_scheme **schemes_arr = schemes->schemes_arr;
-	int i;
-
-	for (i = 0; i < schemes->nr; i++) {
-		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
-		kobject_put(&schemes_arr[i]->kobj);
-	}
-	schemes->nr = 0;
-	kfree(schemes_arr);
-	schemes->schemes_arr = NULL;
-}
-
-static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
-		int nr_schemes)
-{
-	struct damon_sysfs_scheme **schemes_arr, *scheme;
-	int err, i;
-
-	damon_sysfs_schemes_rm_dirs(schemes);
-	if (!nr_schemes)
-		return 0;
-
-	schemes_arr = kmalloc_array(nr_schemes, sizeof(*schemes_arr),
-			GFP_KERNEL | __GFP_NOWARN);
-	if (!schemes_arr)
-		return -ENOMEM;
-	schemes->schemes_arr = schemes_arr;
-
-	for (i = 0; i < nr_schemes; i++) {
-		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT);
-		if (!scheme) {
-			damon_sysfs_schemes_rm_dirs(schemes);
-			return -ENOMEM;
-		}
-
-		err = kobject_init_and_add(&scheme->kobj,
-				&damon_sysfs_scheme_ktype, &schemes->kobj,
-				"%d", i);
-		if (err)
-			goto out;
-		err = damon_sysfs_scheme_add_dirs(scheme);
-		if (err)
-			goto out;
-
-		schemes_arr[i] = scheme;
-		schemes->nr++;
-	}
-	return 0;
-
-out:
-	damon_sysfs_schemes_rm_dirs(schemes);
-	kobject_put(&scheme->kobj);
-	return err;
-}
-
-static ssize_t nr_schemes_show(struct kobject *kobj,
-		struct kobj_attribute *attr, char *buf)
-{
-	struct damon_sysfs_schemes *schemes = container_of(kobj,
-			struct damon_sysfs_schemes, kobj);
-
-	return sysfs_emit(buf, "%d\n", schemes->nr);
-}
-
-static ssize_t nr_schemes_store(struct kobject *kobj,
-		struct kobj_attribute *attr, const char *buf, size_t count)
-{
-	struct damon_sysfs_schemes *schemes;
-	int nr, err = kstrtoint(buf, 0, &nr);
-
-	if (err)
-		return err;
-	if (nr < 0)
-		return -EINVAL;
-
-	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
-
-	if (!mutex_trylock(&damon_sysfs_lock))
-		return -EBUSY;
-	err = damon_sysfs_schemes_add_dirs(schemes, nr);
-	mutex_unlock(&damon_sysfs_lock);
-	if (err)
-		return err;
-	return count;
-}
-
-static void damon_sysfs_schemes_release(struct kobject *kobj)
-{
-	kfree(container_of(kobj, struct damon_sysfs_schemes, kobj));
-}
-
-static struct kobj_attribute damon_sysfs_schemes_nr_attr =
-		__ATTR_RW_MODE(nr_schemes, 0600);
-
-static struct attribute *damon_sysfs_schemes_attrs[] = {
-	&damon_sysfs_schemes_nr_attr.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(damon_sysfs_schemes);
-
-static struct kobj_type damon_sysfs_schemes_ktype = {
-	.release = damon_sysfs_schemes_release,
-	.sysfs_ops = &kobj_sysfs_ops,
-	.default_groups = damon_sysfs_schemes_groups,
-};
-
 /*
  * init region directory
  */
@@ -2133,62 +1190,6 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
-static struct damos *damon_sysfs_mk_scheme(
-		struct damon_sysfs_scheme *sysfs_scheme)
-{
-	struct damon_sysfs_access_pattern *access_pattern =
-		sysfs_scheme->access_pattern;
-	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
-	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
-	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
-
-	struct damos_access_pattern pattern = {
-		.min_sz_region = access_pattern->sz->min,
-		.max_sz_region = access_pattern->sz->max,
-		.min_nr_accesses = access_pattern->nr_accesses->min,
-		.max_nr_accesses = access_pattern->nr_accesses->max,
-		.min_age_region = access_pattern->age->min,
-		.max_age_region = access_pattern->age->max,
-	};
-	struct damos_quota quota = {
-		.ms = sysfs_quotas->ms,
-		.sz = sysfs_quotas->sz,
-		.reset_interval = sysfs_quotas->reset_interval_ms,
-		.weight_sz = sysfs_weights->sz,
-		.weight_nr_accesses = sysfs_weights->nr_accesses,
-		.weight_age = sysfs_weights->age,
-	};
-	struct damos_watermarks wmarks = {
-		.metric = sysfs_wmarks->metric,
-		.interval = sysfs_wmarks->interval_us,
-		.high = sysfs_wmarks->high,
-		.mid = sysfs_wmarks->mid,
-		.low = sysfs_wmarks->low,
-	};
-
-	return damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
-			&wmarks);
-}
-
-static int damon_sysfs_set_schemes(struct damon_ctx *ctx,
-		struct damon_sysfs_schemes *sysfs_schemes)
-{
-	int i;
-
-	for (i = 0; i < sysfs_schemes->nr; i++) {
-		struct damos *scheme, *next;
-
-		scheme = damon_sysfs_mk_scheme(sysfs_schemes->schemes_arr[i]);
-		if (!scheme) {
-			damon_for_each_scheme_safe(scheme, next, ctx)
-				damon_destroy_scheme(scheme);
-			return -ENOMEM;
-		}
-		damon_add_scheme(ctx, scheme);
-	}
-	return 0;
-}
-
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -2204,25 +1205,6 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->kdamond_lock);
 }
 
-static void damon_sysfs_schemes_update_stats(
-		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx)
-{
-	struct damos *scheme;
-	int schemes_idx = 0;
-
-	damon_for_each_scheme(scheme, ctx) {
-		struct damon_sysfs_stats *sysfs_stats;
-
-		sysfs_stats = sysfs_schemes->schemes_arr[schemes_idx++]->stats;
-		sysfs_stats->nr_tried = scheme->stat.nr_tried;
-		sysfs_stats->sz_tried = scheme->stat.sz_tried;
-		sysfs_stats->nr_applied = scheme->stat.nr_applied;
-		sysfs_stats->sz_applied = scheme->stat.sz_applied;
-		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
-	}
-}
-
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
  * @kdamond:	The kobject wrapper that associated to the kdamond thread.
-- 
2.25.1

