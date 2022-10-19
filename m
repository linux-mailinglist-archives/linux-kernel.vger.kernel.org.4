Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7A6036EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJSAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJSANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC7DB75A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 868926173C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC88C43145;
        Wed, 19 Oct 2022 00:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138411;
        bh=jvgf08yBI8ePR8FzsdaZnvtYLZ9NFbdZWXB5GWOxhUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3ZfaQaDRuteYZm9OzMTS+xZHO7+OrRNPkmT9BRMK2HGc7NHrZ4piTrcTe5/RSHE1
         Z33rK5FIxCBHI34nJOGZM4ZB+6BttNJ8BacCUNJq6X3OkXPLU7hLW3FjDT+Sn5rL2I
         Jfg8mfacMRtFVfr03f1bwUU7IdrjoXgVz5nymFo+goUssKfTAu6bTj9yV2VDqA0NBn
         na55b8F4o9kglm3S4V5pxNB44hVkiw1/GW2KklPwQbVG68C3M/OWT5Hoc7EhOVmzJc
         tfAUHHiooKZf2uzSUtjjZWPqWzoKZYnUMGHQP18L07IFQUNoinP0gmZPNz028WnSww
         CWfA6gDoAMysQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/18] mm/damon/sysfs-schemes: implement scheme region directory
Date:   Wed, 19 Oct 2022 00:13:13 +0000
Message-Id: <20221019001317.104270-15-sj@kernel.org>
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

Implement code for each region directory under 'tried_regions' directory
of each scheme directory.  This directory will provide the address
range, the monitored access frequency ('nr_accesses'), and the age of
each DAMON region that corresponding DAMON-based operation scheme has
tried to be applied.  Note that this commit doesn't implement the code
for filling the data but the sysfs directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 123 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index f9714ac62565..1a8ab6341bf1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -9,18 +9,138 @@
 
 #include "sysfs-common.h"
 
+/*
+ * scheme region directory
+ */
+
+struct damon_sysfs_scheme_region {
+	struct kobject kobj;
+	struct damon_addr_range ar;
+	unsigned int nr_accesses;
+	unsigned int age;
+	struct list_head list;
+};
+
+static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
+		struct damon_region *region)
+{
+	struct damon_sysfs_scheme_region *sysfs_region = kmalloc(
+			sizeof(*sysfs_region), GFP_KERNEL);
+
+	if (!sysfs_region)
+		return NULL;
+	sysfs_region->kobj = (struct kobject){};
+	sysfs_region->ar = region->ar;
+	sysfs_region->nr_accesses = region->nr_accesses;
+	sysfs_region->age = region->age;
+	INIT_LIST_HEAD(&sysfs_region->list);
+	return sysfs_region;
+}
+
+static ssize_t start_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	return sysfs_emit(buf, "%lu\n", region->ar.start);
+}
+
+static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	return sysfs_emit(buf, "%lu\n", region->ar.end);
+}
+
+static ssize_t nr_accesses_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	return sysfs_emit(buf, "%u\n", region->nr_accesses);
+}
+
+static ssize_t age_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	return sysfs_emit(buf, "%u\n", region->age);
+}
+
+static void damon_sysfs_scheme_region_release(struct kobject *kobj)
+{
+	struct damon_sysfs_scheme_region *region = container_of(kobj,
+			struct damon_sysfs_scheme_region, kobj);
+
+	list_del(&region->list);
+	kfree(region);
+}
+
+static struct kobj_attribute damon_sysfs_scheme_region_start_attr =
+		__ATTR_RO_MODE(start, 0400);
+
+static struct kobj_attribute damon_sysfs_scheme_region_end_attr =
+		__ATTR_RO_MODE(end, 0400);
+
+static struct kobj_attribute damon_sysfs_scheme_region_nr_accesses_attr =
+		__ATTR_RO_MODE(nr_accesses, 0400);
+
+static struct kobj_attribute damon_sysfs_scheme_region_age_attr =
+		__ATTR_RO_MODE(age, 0400);
+
+static struct attribute *damon_sysfs_scheme_region_attrs[] = {
+	&damon_sysfs_scheme_region_start_attr.attr,
+	&damon_sysfs_scheme_region_end_attr.attr,
+	&damon_sysfs_scheme_region_nr_accesses_attr.attr,
+	&damon_sysfs_scheme_region_age_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme_region);
+
+static struct kobj_type damon_sysfs_scheme_region_ktype = {
+	.release = damon_sysfs_scheme_region_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_region_groups,
+};
+
 /*
  * scheme regions directory
  */
 
 struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
+	struct list_head regions_list;
+	int nr_regions;
 };
 
 static struct damon_sysfs_scheme_regions *
 damon_sysfs_scheme_regions_alloc(void)
 {
-	return kzalloc(sizeof(struct damon_sysfs_scheme_regions), GFP_KERNEL);
+	struct damon_sysfs_scheme_regions *regions = kmalloc(sizeof(*regions),
+			GFP_KERNEL);
+
+	regions->kobj = (struct kobject){};
+	INIT_LIST_HEAD(&regions->regions_list);
+	regions->nr_regions = 0;
+	return regions;
+}
+
+static void damon_sysfs_scheme_regions_rm_dirs(
+		struct damon_sysfs_scheme_regions *regions)
+{
+	struct damon_sysfs_scheme_region *r, *next;
+
+	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
+		/* release function deletes it from the list */
+		kobject_put(&r->kobj);
+		regions->nr_regions--;
+	}
 }
 
 static void damon_sysfs_scheme_regions_release(struct kobject *kobj)
@@ -837,6 +957,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
 	kobject_put(&scheme->stats->kobj);
+	damon_sysfs_scheme_regions_rm_dirs(scheme->tried_regions);
 	kobject_put(&scheme->tried_regions->kobj);
 }
 
-- 
2.25.1

