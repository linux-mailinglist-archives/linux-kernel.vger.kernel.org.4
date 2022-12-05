Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C7643944
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLEXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLEXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:08:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DF1E3D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:08:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CF28B8114B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 23:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D65BC4347C;
        Mon,  5 Dec 2022 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670281716;
        bh=vSamPC5rWY7nml963lA73M1wBydbQNBybO8ofr/YpTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhojvW68fLcwzuWXDN6sV/7hfBpKIgaNH59qlCDuw8NCCROqjDuCBJTRtVo8cHcYV
         3kA/wkUQCzsWw8xLv3PKKNvGv/c+L5KdfNQsuPI3Mrd/gvaKMBLWYEDAZpIjxF0eXv
         o8+PJm5tIy3RxSvD1kMzOa8QwR2VdjGCnkBizAXKP89btwZUyOH1EOEsnZ/vGaG3Xh
         zmVHA+n23brth9vXqFjWFna5N21VR61+vjT4LBfnfh4QWzQszspH9+U9jDqR6THRQn
         4K8XfECPj9mD6GaVc9JWwGri4+T0MI0nU5MammiKvIYz6aFngSoSwArm8TGAE2g5Lh
         TnvNXGSjcRBFw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 01/11] mm/damon/core: implement damos filter
Date:   Mon,  5 Dec 2022 23:08:20 +0000
Message-Id: <20221205230830.144349-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205230830.144349-1-sj@kernel.org>
References: <20221205230830.144349-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMOS let users do system operation in a data access pattern oriented
way.  The data access pattern, which is extracted by DAMON, is somewhat
accurate more than what user space could know in many cases.  However,
in some situation, users could know something more than the kernel about
the pattern or some special requirements for some types of memory or
processes.  For example, some users would have slow swap devices and
knows latency-ciritical processes and therefore want to use DAMON-based
proactive reclamation (DAMON_RECLAIM) for only non-anonymous pages of
non-latency-critical processes.

For such restriction, users could exclude the memory regions from the
initial monitoring regions and use non-dynamic monitoring regions update
monitoring operations set including fvaddr and paddr.  They could also
adjust the DAMOS target access pattern.  For dynamically changing memory
layout and access pattern, those would be not enough.

To help the case, add an interface, namely DAMOS filters, which can be
used to avoid the DAMOS actions be applied to specific types of memory,
to DAMON kernel API (damon.h).  At the moment, it supports filtering
anonymous pages and/or specific memory cgroups in or out for each DAMOS
scheme.

Note that this commit adds only the interface to the DAMON kernel API.
The impelmentation should be made in the monitoring operations sets, and
following commits will add that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/core.c       | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 35630634d790..42cea3bf7319 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -8,6 +8,7 @@
 #ifndef _DAMON_H_
 #define _DAMON_H_
 
+#include <linux/memcontrol.h>
 #include <linux/mutex.h>
 #include <linux/time64.h>
 #include <linux/types.h>
@@ -215,6 +216,39 @@ struct damos_stat {
 	unsigned long qt_exceeds;
 };
 
+/**
+ * enum damos_filter_type - Type of memory for &struct damos_filter
+ * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
+ * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
+ */
+enum damos_filter_type {
+	DAMOS_FILTER_TYPE_ANON,
+	DAMOS_FILTER_TYPE_MEMCG,
+	NR_DAMOS_FILTER_TYPES,
+};
+
+/**
+ * struct damos_filter - DAMOS action target memory filter.
+ * @type:	Type of the page.
+ * @matching:	If the matching page should filtered out or in.
+ * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
+ * @list:	List head for siblings.
+ *
+ * Before applying the &damos->action to a memory region, DAMOS checks if each
+ * page of the region matches to this and avoid applying the action if so.
+ * Note that the check support is up to &struct damon_operations
+ * implementation.
+ */
+struct damos_filter {
+	enum damos_filter_type type;
+	bool matching;
+	union {
+		unsigned short memcg_id;
+	};
+	struct list_head list;
+};
+
 /**
  * struct damos_access_pattern - Target access pattern of the given scheme.
  * @min_sz_region:	Minimum size of target regions.
@@ -239,6 +273,7 @@ struct damos_access_pattern {
  * @action:		&damo_action to be applied to the target regions.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
@@ -254,6 +289,10 @@ struct damos_access_pattern {
  * If all schemes that registered to a &struct damon_ctx are inactive, DAMON
  * stops monitoring and just repeatedly checks the watermarks.
  *
+ * Before applying the &action to a memory region, &struct damon_operations
+ * implementation could check pages of the region and skip &action to respect
+ * &filters
+ *
  * After applying the &action to each region, &stat_count and &stat_sz is
  * updated to reflect the number of regions and total size of regions that the
  * &action is applied.
@@ -263,6 +302,7 @@ struct damos {
 	enum damos_action action;
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
+	struct list_head filters;
 	struct damos_stat stat;
 	struct list_head list;
 };
@@ -516,6 +556,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damon_for_each_scheme_safe(s, next, ctx) \
 	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
 
+#define damos_for_each_filter(f, scheme) \
+	list_for_each_entry(f, &(scheme)->filters, list)
+
+#define damos_for_each_filter_safe(f, next, scheme) \
+	list_for_each_entry_safe(f, next, &(scheme)->filters, list)
+
 #ifdef CONFIG_DAMON
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
@@ -536,6 +582,11 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
 
+struct damos_filter *damos_new_filter(enum damos_filter_type type,
+		bool matching);
+void damos_add_filter(struct damos *s, struct damos_filter *f);
+void damos_destroy_filter(struct damos_filter *f);
+
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action, struct damos_quota *quota,
 			struct damos_watermarks *wmarks);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ceec75b88ef9..1bf0654ae189 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -263,6 +263,40 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 	return 0;
 }
 
+struct damos_filter *damos_new_filter(enum damos_filter_type type,
+		bool matching)
+{
+	struct damos_filter *filter;
+
+	filter = kmalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return NULL;
+	filter->type = type;
+	filter->matching = matching;
+	return filter;
+}
+
+void damos_add_filter(struct damos *s, struct damos_filter *f)
+{
+	list_add_tail(&f->list, &s->filters);
+}
+
+static void damos_del_filter(struct damos_filter *f)
+{
+	list_del(&f->list);
+}
+
+static void damos_free_filter(struct damos_filter *f)
+{
+	kfree(f);
+}
+
+void damos_destroy_filter(struct damos_filter *f)
+{
+	damos_del_filter(f);
+	damos_free_filter(f);
+}
+
 /* initialize private fields of damos_quota and return the pointer */
 static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
 {
@@ -287,6 +321,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 		return NULL;
 	scheme->pattern = *pattern;
 	scheme->action = action;
+	INIT_LIST_HEAD(&scheme->filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
@@ -315,6 +350,10 @@ static void damon_free_scheme(struct damos *s)
 
 void damon_destroy_scheme(struct damos *s)
 {
+	struct damos_filter *f, *next;
+
+	damos_for_each_filter_safe(f, next, s)
+		damos_destroy_filter(f);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.25.1

