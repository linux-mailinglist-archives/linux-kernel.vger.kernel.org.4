Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD06363E12F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiK3UJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiK3UJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:09:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5477223
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9E861DB5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A8CC43144;
        Wed, 30 Nov 2022 20:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838984;
        bh=MpYV+KbY79xvzeBIqlzmkGgEI6XBAJRwIre/bGlDx34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7UUPXbSOHpt1n/DE7i2B73YdfoKw6GeVPStCb2hI8OyKJj6Vv0MkCFL7ZAkpbl6U
         ltLoStwxzZAKS66k9PC9EatWya0KWK28TnizMGZL/SQD4xfS8Fp8AWBprjzxe7r+7w
         54WlIRoBZR4How2s06tKWMV469xxG8g0uMR+D/T02/YY/Cjx52vOOknjyz47rpytFt
         NhOmjV56/c/eN/2xVIJUaf/Lt9nralBjguIV69dWs+mK+IfjbPYQBo7zfQ05DGY+I5
         TxQ1rfXFGrPE56NAqssborqgXGeaPSCP0D62PjJUl09F3ngA6AWwRYUT5TY9cdgV8B
         zQK8f5+4lTjrQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 05/11] mm/damon/sysfs-schemes: implement filters directory
Date:   Wed, 30 Nov 2022 20:09:31 +0000
Message-Id: <20221130200937.118005-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
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

DAMOS filters is currently supported by only DAMON kernel API.  To
expose the feature to user space, implement a DAMON sysfs directory
named 'filters' under each scheme directory.  Please note that this is
implementing only the directory.  Following commits will implement more
files and directories, and finally connect the DAMOS filters feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 85 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 81fc4d27f4e4..50c8148cb474 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -258,6 +258,63 @@ static struct kobj_type damon_sysfs_stats_ktype = {
 	.default_groups = damon_sysfs_stats_groups,
 };
 
+/*
+ * filters directory
+ */
+
+struct damon_sysfs_scheme_filters {
+	struct kobject kobj;
+	int nr;
+};
+
+static struct damon_sysfs_scheme_filters *
+damon_sysfs_scheme_filters_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
+}
+
+static ssize_t nr_filters_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filters *filters = container_of(kobj,
+			struct damon_sysfs_scheme_filters, kobj);
+
+	return sysfs_emit(buf, "%d\n", filters->nr);
+}
+
+static ssize_t nr_filters_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static void damon_sysfs_scheme_filters_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_scheme_filters, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_scheme_filters_nr_attr =
+		__ATTR_RW_MODE(nr_filters, 0600);
+
+static struct attribute *damon_sysfs_scheme_filters_attrs[] = {
+	&damon_sysfs_scheme_filters_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme_filters);
+
+static struct kobj_type damon_sysfs_scheme_filters_ktype = {
+	.release = damon_sysfs_scheme_filters_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_filters_groups,
+};
+
 /*
  * watermarks directory
  */
@@ -784,6 +841,7 @@ struct damon_sysfs_scheme {
 	struct damon_sysfs_access_pattern *access_pattern;
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
+	struct damon_sysfs_scheme_filters *filters;
 	struct damon_sysfs_stats *stats;
 	struct damon_sysfs_scheme_regions *tried_regions;
 };
@@ -878,6 +936,24 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 	return err;
 }
 
+static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme)
+{
+	struct damon_sysfs_scheme_filters *filters =
+		damon_sysfs_scheme_filters_alloc();
+	int err;
+
+	if (!filters)
+		return -ENOMEM;
+	err = kobject_init_and_add(&filters->kobj,
+			&damon_sysfs_scheme_filters_ktype, &scheme->kobj,
+			"filters");
+	if (err)
+		kobject_put(&filters->kobj);
+	else
+		scheme->filters = filters;
+	return err;
+}
+
 static int damon_sysfs_scheme_set_stats(struct damon_sysfs_scheme *scheme)
 {
 	struct damon_sysfs_stats *stats = damon_sysfs_stats_alloc();
@@ -926,9 +1002,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
-	err = damon_sysfs_scheme_set_stats(scheme);
+	err = damon_sysfs_scheme_set_filters(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
+	err = damon_sysfs_scheme_set_stats(scheme);
+	if (err)
+		goto put_filters_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_tried_regions(scheme);
 	if (err)
 		goto put_tried_regions_out;
@@ -937,6 +1016,9 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_tried_regions_out:
 	kobject_put(&scheme->tried_regions->kobj);
 	scheme->tried_regions = NULL;
+put_filters_watermarks_quotas_access_pattern_out:
+	kobject_put(&scheme->filters->kobj);
+	scheme->filters = NULL;
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
@@ -956,6 +1038,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
+	kobject_put(&scheme->filters->kobj);
 	kobject_put(&scheme->stats->kobj);
 	damon_sysfs_scheme_regions_rm_dirs(scheme->tried_regions);
 	kobject_put(&scheme->tried_regions->kobj);
-- 
2.25.1

