Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B025BF4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIUDuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiIUDtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:49:51 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E1F5B1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:49:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQM85F._1663732183;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQM85F._1663732183)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 11:49:45 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH v1] mm/damon: add DAMON_OBJ macro
Date:   Wed, 21 Sep 2022 11:49:42 +0800
Message-Id: <20220921034942.88568-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In damon/sysfs.c file, we use 'container_of' macro to get
damon_sysfs_xxx struct instances, but i think it has a little
inconvenience, because we have to pass three arguments to
'container_of', and the codes also look a bit long, so there i add a
'DAMON_OBJ' macro, you just need to pass one arguments, then you can get
the right damon_sysfs_xxx struct instance.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/linux/damon.h |   7 ++
 mm/damon/sysfs.c      | 230 +++++++++++++++++-------------------------
 2 files changed, 102 insertions(+), 135 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e7808a84675f..a3b577677caa 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -24,6 +24,13 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
 	return l + prandom_u32_max(r - l);
 }
 
+/*
+ * Get damon_sysfs_xxx relative struct instance.
+ */
+#define DAMON_OBJ(_type) ({						\
+	const typeof(((struct _type *)0)->kobj)*__mptr = (kobj);	\
+	(struct _type *)((char *)__mptr - offsetof(struct _type, kobj)); })
+
 /**
  * struct damon_addr_range - Represents an address region of [@start, @end).
  * @start:	Start address of the region (inclusive).
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 455215a5c059..be64cd1b9e94 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -42,8 +42,7 @@ static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
 static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
+	struct damon_sysfs_ul_range *range = DAMON_OBJ(damon_sysfs_ul_range);
 
 	return sysfs_emit(buf, "%lu\n", range->min);
 }
@@ -51,8 +50,7 @@ static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
+	struct damon_sysfs_ul_range *range = DAMON_OBJ(damon_sysfs_ul_range);
 	unsigned long min;
 	int err;
 
@@ -67,8 +65,7 @@ static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
+	struct damon_sysfs_ul_range *range = DAMON_OBJ(damon_sysfs_ul_range);
 
 	return sysfs_emit(buf, "%lu\n", range->max);
 }
@@ -76,8 +73,7 @@ static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_ul_range *range = container_of(kobj,
-			struct damon_sysfs_ul_range, kobj);
+	struct damon_sysfs_ul_range *range = DAMON_OBJ(damon_sysfs_ul_range);
 	unsigned long max;
 	int err;
 
@@ -91,7 +87,7 @@ static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void damon_sysfs_ul_range_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_ul_range));
 }
 
 static struct kobj_attribute damon_sysfs_ul_range_min_attr =
@@ -134,8 +130,7 @@ static struct damon_sysfs_stats *damon_sysfs_stats_alloc(void)
 static ssize_t nr_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
+	struct damon_sysfs_stats *stats = DAMON_OBJ(damon_sysfs_stats);
 
 	return sysfs_emit(buf, "%lu\n", stats->nr_tried);
 }
@@ -143,8 +138,7 @@ static ssize_t nr_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
+	struct damon_sysfs_stats *stats = DAMON_OBJ(damon_sysfs_stats);
 
 	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
 }
@@ -152,8 +146,7 @@ static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t nr_applied_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
+	struct damon_sysfs_stats *stats = DAMON_OBJ(damon_sysfs_stats);
 
 	return sysfs_emit(buf, "%lu\n", stats->nr_applied);
 }
@@ -161,8 +154,7 @@ static ssize_t nr_applied_show(struct kobject *kobj,
 static ssize_t sz_applied_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
+	struct damon_sysfs_stats *stats = DAMON_OBJ(damon_sysfs_stats);
 
 	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
 }
@@ -170,15 +162,14 @@ static ssize_t sz_applied_show(struct kobject *kobj,
 static ssize_t qt_exceeds_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_stats *stats = container_of(kobj,
-			struct damon_sysfs_stats, kobj);
+	struct damon_sysfs_stats *stats = DAMON_OBJ(damon_sysfs_stats);
 
 	return sysfs_emit(buf, "%lu\n", stats->qt_exceeds);
 }
 
 static void damon_sysfs_stats_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_stats, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_stats));
 }
 
 static struct kobj_attribute damon_sysfs_stats_nr_tried_attr =
@@ -252,8 +243,8 @@ static const char * const damon_sysfs_wmark_metric_strs[] = {
 static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 
 	return sysfs_emit(buf, "%s\n",
 			damon_sysfs_wmark_metric_strs[watermarks->metric]);
@@ -262,8 +253,8 @@ static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 	enum damos_wmark_metric metric;
 
 	for (metric = 0; metric < NR_DAMOS_WMARK_METRICS; metric++) {
@@ -278,8 +269,8 @@ static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t interval_us_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 
 	return sysfs_emit(buf, "%lu\n", watermarks->interval_us);
 }
@@ -287,8 +278,8 @@ static ssize_t interval_us_show(struct kobject *kobj,
 static ssize_t interval_us_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 	int err = kstrtoul(buf, 0, &watermarks->interval_us);
 
 	return err ? err : count;
@@ -297,8 +288,8 @@ static ssize_t interval_us_store(struct kobject *kobj,
 static ssize_t high_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 
 	return sysfs_emit(buf, "%lu\n", watermarks->high);
 }
@@ -306,8 +297,8 @@ static ssize_t high_show(struct kobject *kobj,
 static ssize_t high_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 	int err = kstrtoul(buf, 0, &watermarks->high);
 
 	return err ? err : count;
@@ -316,8 +307,8 @@ static ssize_t high_store(struct kobject *kobj,
 static ssize_t mid_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 
 	return sysfs_emit(buf, "%lu\n", watermarks->mid);
 }
@@ -325,8 +316,8 @@ static ssize_t mid_show(struct kobject *kobj,
 static ssize_t mid_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 	int err = kstrtoul(buf, 0, &watermarks->mid);
 
 	return err ? err : count;
@@ -335,8 +326,8 @@ static ssize_t mid_store(struct kobject *kobj,
 static ssize_t low_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 
 	return sysfs_emit(buf, "%lu\n", watermarks->low);
 }
@@ -344,8 +335,8 @@ static ssize_t low_show(struct kobject *kobj,
 static ssize_t low_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
-			struct damon_sysfs_watermarks, kobj);
+	struct damon_sysfs_watermarks *watermarks =
+		DAMON_OBJ(damon_sysfs_watermarks);
 	int err = kstrtoul(buf, 0, &watermarks->low);
 
 	return err ? err : count;
@@ -353,7 +344,7 @@ static ssize_t low_store(struct kobject *kobj,
 
 static void damon_sysfs_watermarks_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_watermarks, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_watermarks));
 }
 
 static struct kobj_attribute damon_sysfs_watermarks_metric_attr =
@@ -416,8 +407,7 @@ static struct damon_sysfs_weights *damon_sysfs_weights_alloc(unsigned int sz,
 static ssize_t sz_permil_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 
 	return sysfs_emit(buf, "%u\n", weights->sz);
 }
@@ -425,8 +415,7 @@ static ssize_t sz_permil_show(struct kobject *kobj,
 static ssize_t sz_permil_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 	int err = kstrtouint(buf, 0, &weights->sz);
 
 	return err ? err : count;
@@ -435,8 +424,7 @@ static ssize_t sz_permil_store(struct kobject *kobj,
 static ssize_t nr_accesses_permil_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 
 	return sysfs_emit(buf, "%u\n", weights->nr_accesses);
 }
@@ -444,8 +432,7 @@ static ssize_t nr_accesses_permil_show(struct kobject *kobj,
 static ssize_t nr_accesses_permil_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 	int err = kstrtouint(buf, 0, &weights->nr_accesses);
 
 	return err ? err : count;
@@ -454,8 +441,7 @@ static ssize_t nr_accesses_permil_store(struct kobject *kobj,
 static ssize_t age_permil_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 
 	return sysfs_emit(buf, "%u\n", weights->age);
 }
@@ -463,8 +449,7 @@ static ssize_t age_permil_show(struct kobject *kobj,
 static ssize_t age_permil_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_weights *weights = container_of(kobj,
-			struct damon_sysfs_weights, kobj);
+	struct damon_sysfs_weights *weights = DAMON_OBJ(damon_sysfs_weights);
 	int err = kstrtouint(buf, 0, &weights->age);
 
 	return err ? err : count;
@@ -472,7 +457,7 @@ static ssize_t age_permil_store(struct kobject *kobj,
 
 static void damon_sysfs_weights_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_weights, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_weights));
 }
 
 static struct kobj_attribute damon_sysfs_weights_sz_attr =
@@ -541,8 +526,7 @@ static void damon_sysfs_quotas_rm_dirs(struct damon_sysfs_quotas *quotas)
 static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 
 	return sysfs_emit(buf, "%lu\n", quotas->ms);
 }
@@ -550,8 +534,7 @@ static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t ms_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 	int err = kstrtoul(buf, 0, &quotas->ms);
 
 	if (err)
@@ -562,8 +545,7 @@ static ssize_t ms_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t bytes_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 
 	return sysfs_emit(buf, "%lu\n", quotas->sz);
 }
@@ -571,8 +553,7 @@ static ssize_t bytes_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t bytes_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 	int err = kstrtoul(buf, 0, &quotas->sz);
 
 	if (err)
@@ -583,8 +564,7 @@ static ssize_t bytes_store(struct kobject *kobj,
 static ssize_t reset_interval_ms_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 
 	return sysfs_emit(buf, "%lu\n", quotas->reset_interval_ms);
 }
@@ -592,8 +572,7 @@ static ssize_t reset_interval_ms_show(struct kobject *kobj,
 static ssize_t reset_interval_ms_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_quotas *quotas = container_of(kobj,
-			struct damon_sysfs_quotas, kobj);
+	struct damon_sysfs_quotas *quotas = DAMON_OBJ(damon_sysfs_quotas);
 	int err = kstrtoul(buf, 0, &quotas->reset_interval_ms);
 
 	if (err)
@@ -603,7 +582,7 @@ static ssize_t reset_interval_ms_store(struct kobject *kobj,
 
 static void damon_sysfs_quotas_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_quotas, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_quotas));
 }
 
 static struct kobj_attribute damon_sysfs_quotas_ms_attr =
@@ -714,7 +693,7 @@ static void damon_sysfs_access_pattern_rm_dirs(
 
 static void damon_sysfs_access_pattern_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_access_pattern, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_access_pattern));
 }
 
 static struct attribute *damon_sysfs_access_pattern_attrs[] = {
@@ -890,8 +869,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_scheme *scheme = container_of(kobj,
-			struct damon_sysfs_scheme, kobj);
+	struct damon_sysfs_scheme *scheme = DAMON_OBJ(damon_sysfs_scheme);
 
 	return sysfs_emit(buf, "%s\n",
 			damon_sysfs_damos_action_strs[scheme->action]);
@@ -900,8 +878,7 @@ static ssize_t action_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_scheme *scheme = container_of(kobj,
-			struct damon_sysfs_scheme, kobj);
+	struct damon_sysfs_scheme *scheme = DAMON_OBJ(damon_sysfs_scheme);
 	enum damos_action action;
 
 	for (action = 0; action < NR_DAMOS_ACTIONS; action++) {
@@ -915,7 +892,7 @@ static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_scheme));
 }
 
 static struct kobj_attribute damon_sysfs_scheme_action_attr =
@@ -1008,8 +985,7 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 static ssize_t nr_schemes_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_schemes *schemes = container_of(kobj,
-			struct damon_sysfs_schemes, kobj);
+	struct damon_sysfs_schemes *schemes = DAMON_OBJ(damon_sysfs_schemes);
 
 	return sysfs_emit(buf, "%d\n", schemes->nr);
 }
@@ -1025,7 +1001,7 @@ static ssize_t nr_schemes_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
-	schemes = container_of(kobj, struct damon_sysfs_schemes, kobj);
+	schemes = DAMON_OBJ(damon_sysfs_schemes);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
@@ -1038,7 +1014,7 @@ static ssize_t nr_schemes_store(struct kobject *kobj,
 
 static void damon_sysfs_schemes_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_schemes, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_schemes));
 }
 
 static struct kobj_attribute damon_sysfs_schemes_nr_attr =
@@ -1084,8 +1060,7 @@ static struct damon_sysfs_region *damon_sysfs_region_alloc(
 static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_region *region = container_of(kobj,
-			struct damon_sysfs_region, kobj);
+	struct damon_sysfs_region *region = DAMON_OBJ(damon_sysfs_region);
 
 	return sysfs_emit(buf, "%lu\n", region->start);
 }
@@ -1093,8 +1068,7 @@ static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_region *region = container_of(kobj,
-			struct damon_sysfs_region, kobj);
+	struct damon_sysfs_region *region = DAMON_OBJ(damon_sysfs_region);
 	int err = kstrtoul(buf, 0, &region->start);
 
 	return err ? err : count;
@@ -1103,8 +1077,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_region *region = container_of(kobj,
-			struct damon_sysfs_region, kobj);
+	struct damon_sysfs_region *region = DAMON_OBJ(damon_sysfs_region);
 
 	return sysfs_emit(buf, "%lu\n", region->end);
 }
@@ -1112,8 +1085,7 @@ static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_region *region = container_of(kobj,
-			struct damon_sysfs_region, kobj);
+	struct damon_sysfs_region *region = DAMON_OBJ(damon_sysfs_region);
 	int err = kstrtoul(buf, 0, &region->end);
 
 	return err ? err : count;
@@ -1121,7 +1093,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static void damon_sysfs_region_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_region, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_region));
 }
 
 static struct kobj_attribute damon_sysfs_region_start_attr =
@@ -1211,8 +1183,7 @@ static int damon_sysfs_regions_add_dirs(struct damon_sysfs_regions *regions,
 static ssize_t nr_regions_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_regions *regions = container_of(kobj,
-			struct damon_sysfs_regions, kobj);
+	struct damon_sysfs_regions *regions = DAMON_OBJ(damon_sysfs_regions);
 
 	return sysfs_emit(buf, "%d\n", regions->nr);
 }
@@ -1228,7 +1199,7 @@ static ssize_t nr_regions_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
-	regions = container_of(kobj, struct damon_sysfs_regions, kobj);
+	regions = DAMON_OBJ(damon_sysfs_regions);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
@@ -1242,7 +1213,7 @@ static ssize_t nr_regions_store(struct kobject *kobj,
 
 static void damon_sysfs_regions_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_regions, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_regions));
 }
 
 static struct kobj_attribute damon_sysfs_regions_nr_attr =
@@ -1301,8 +1272,7 @@ static void damon_sysfs_target_rm_dirs(struct damon_sysfs_target *target)
 static ssize_t pid_target_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_target *target = container_of(kobj,
-			struct damon_sysfs_target, kobj);
+	struct damon_sysfs_target *target = DAMON_OBJ(damon_sysfs_target);
 
 	return sysfs_emit(buf, "%d\n", target->pid);
 }
@@ -1310,8 +1280,7 @@ static ssize_t pid_target_show(struct kobject *kobj,
 static ssize_t pid_target_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_target *target = container_of(kobj,
-			struct damon_sysfs_target, kobj);
+	struct damon_sysfs_target *target = DAMON_OBJ(damon_sysfs_target);
 	int err = kstrtoint(buf, 0, &target->pid);
 
 	if (err)
@@ -1321,7 +1290,7 @@ static ssize_t pid_target_store(struct kobject *kobj,
 
 static void damon_sysfs_target_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_target));
 }
 
 static struct kobj_attribute damon_sysfs_target_pid_attr =
@@ -1415,8 +1384,7 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
 static ssize_t nr_targets_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_targets *targets = container_of(kobj,
-			struct damon_sysfs_targets, kobj);
+	struct damon_sysfs_targets *targets = DAMON_OBJ(damon_sysfs_targets);
 
 	return sysfs_emit(buf, "%d\n", targets->nr);
 }
@@ -1432,7 +1400,7 @@ static ssize_t nr_targets_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
-	targets = container_of(kobj, struct damon_sysfs_targets, kobj);
+	targets = DAMON_OBJ(damon_sysfs_targets);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
@@ -1446,7 +1414,7 @@ static ssize_t nr_targets_store(struct kobject *kobj,
 
 static void damon_sysfs_targets_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_targets, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_targets));
 }
 
 static struct kobj_attribute damon_sysfs_targets_nr_attr =
@@ -1495,8 +1463,8 @@ static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
 static ssize_t sample_us_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 
 	return sysfs_emit(buf, "%lu\n", intervals->sample_us);
 }
@@ -1504,8 +1472,8 @@ static ssize_t sample_us_show(struct kobject *kobj,
 static ssize_t sample_us_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 	unsigned long us;
 	int err = kstrtoul(buf, 0, &us);
 
@@ -1519,8 +1487,8 @@ static ssize_t sample_us_store(struct kobject *kobj,
 static ssize_t aggr_us_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 
 	return sysfs_emit(buf, "%lu\n", intervals->aggr_us);
 }
@@ -1528,8 +1496,8 @@ static ssize_t aggr_us_show(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 	unsigned long us;
 	int err = kstrtoul(buf, 0, &us);
 
@@ -1543,8 +1511,8 @@ static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t update_us_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 
 	return sysfs_emit(buf, "%lu\n", intervals->update_us);
 }
@@ -1552,8 +1520,8 @@ static ssize_t update_us_show(struct kobject *kobj,
 static ssize_t update_us_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_intervals *intervals = container_of(kobj,
-			struct damon_sysfs_intervals, kobj);
+	struct damon_sysfs_intervals *intervals =
+		DAMON_OBJ(damon_sysfs_intervals);
 	unsigned long us;
 	int err = kstrtoul(buf, 0, &us);
 
@@ -1566,7 +1534,7 @@ static ssize_t update_us_store(struct kobject *kobj,
 
 static void damon_sysfs_intervals_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_intervals, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_intervals));
 }
 
 static struct kobj_attribute damon_sysfs_intervals_sample_us_attr =
@@ -1660,7 +1628,7 @@ static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 
 static void damon_sysfs_attrs_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_attrs));
 }
 
 static struct attribute *damon_sysfs_attrs_attrs[] = {
@@ -1816,8 +1784,7 @@ static ssize_t avail_operations_show(struct kobject *kobj,
 static ssize_t operations_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_context *context = container_of(kobj,
-			struct damon_sysfs_context, kobj);
+	struct damon_sysfs_context *context = DAMON_OBJ(damon_sysfs_context);
 
 	return sysfs_emit(buf, "%s\n", damon_sysfs_ops_strs[context->ops_id]);
 }
@@ -1825,8 +1792,7 @@ static ssize_t operations_show(struct kobject *kobj,
 static ssize_t operations_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
-	struct damon_sysfs_context *context = container_of(kobj,
-			struct damon_sysfs_context, kobj);
+	struct damon_sysfs_context *context = DAMON_OBJ(damon_sysfs_context);
 	enum damon_ops_id id;
 
 	for (id = 0; id < NR_DAMON_OPS; id++) {
@@ -1840,7 +1806,7 @@ static ssize_t operations_store(struct kobject *kobj,
 
 static void damon_sysfs_context_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_context));
 }
 
 static struct kobj_attribute damon_sysfs_context_avail_operations_attr =
@@ -1938,8 +1904,7 @@ static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
 static ssize_t nr_contexts_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_contexts *contexts = container_of(kobj,
-			struct damon_sysfs_contexts, kobj);
+	struct damon_sysfs_contexts *contexts = DAMON_OBJ(damon_sysfs_contexts);
 
 	return sysfs_emit(buf, "%d\n", contexts->nr);
 }
@@ -1957,7 +1922,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
 	if (nr < 0 || 1 < nr)
 		return -EINVAL;
 
-	contexts = container_of(kobj, struct damon_sysfs_contexts, kobj);
+	contexts = DAMON_OBJ(damon_sysfs_contexts);
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
 	err = damon_sysfs_contexts_add_dirs(contexts, nr);
@@ -1970,7 +1935,7 @@ static ssize_t nr_contexts_store(struct kobject *kobj,
 
 static void damon_sysfs_contexts_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_contexts, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_contexts));
 }
 
 static struct kobj_attribute damon_sysfs_contexts_nr_attr
@@ -2091,8 +2056,7 @@ static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
-			struct damon_sysfs_kdamond, kobj);
+	struct damon_sysfs_kdamond *kdamond = DAMON_OBJ(damon_sysfs_kdamond);
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 	bool running;
 
@@ -2550,8 +2514,7 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
-			struct damon_sysfs_kdamond, kobj);
+	struct damon_sysfs_kdamond *kdamond = DAMON_OBJ(damon_sysfs_kdamond);
 	enum damon_sysfs_cmd cmd;
 	ssize_t ret = -EINVAL;
 
@@ -2572,8 +2535,7 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 static ssize_t pid_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
-			struct damon_sysfs_kdamond, kobj);
+	struct damon_sysfs_kdamond *kdamond = DAMON_OBJ(damon_sysfs_kdamond);
 	struct damon_ctx *ctx;
 	int pid = -1;
 
@@ -2594,8 +2556,7 @@ static ssize_t pid_show(struct kobject *kobj,
 
 static void damon_sysfs_kdamond_release(struct kobject *kobj)
 {
-	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
-			struct damon_sysfs_kdamond, kobj);
+	struct damon_sysfs_kdamond *kdamond = DAMON_OBJ(damon_sysfs_kdamond);
 
 	if (kdamond->damon_ctx)
 		damon_destroy_ctx(kdamond->damon_ctx);
@@ -2714,8 +2675,7 @@ static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
 static ssize_t nr_kdamonds_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
-			struct damon_sysfs_kdamonds, kobj);
+	struct damon_sysfs_kdamonds *kdamonds = DAMON_OBJ(damon_sysfs_kdamonds);
 
 	return sysfs_emit(buf, "%d\n", kdamonds->nr);
 }
@@ -2732,7 +2692,7 @@ static ssize_t nr_kdamonds_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
-	kdamonds = container_of(kobj, struct damon_sysfs_kdamonds, kobj);
+	kdamonds = DAMON_OBJ(damon_sysfs_kdamonds);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
@@ -2746,7 +2706,7 @@ static ssize_t nr_kdamonds_store(struct kobject *kobj,
 
 static void damon_sysfs_kdamonds_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_kdamonds, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_kdamonds));
 }
 
 static struct kobj_attribute damon_sysfs_kdamonds_nr_attr =
@@ -2800,7 +2760,7 @@ static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
 
 static void damon_sysfs_ui_dir_release(struct kobject *kobj)
 {
-	kfree(container_of(kobj, struct damon_sysfs_ui_dir, kobj));
+	kfree(DAMON_OBJ(damon_sysfs_ui_dir));
 }
 
 static struct attribute *damon_sysfs_ui_dir_attrs[] = {
-- 
2.31.0

