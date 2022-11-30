Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EA63E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiK3UKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiK3UJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:09:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B69135F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF5CEB81CD4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B3CC433D7;
        Wed, 30 Nov 2022 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838986;
        bh=np2Yu8Q2x8gtS0MXr5n11c7mRGrlDAkmbbQ8z9YhO6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDZWQCv37cmXsYFuxYM0g0H2ZjJowAriJKZo8FsXKWLj8qlWolYjcXjJhwvkk3d+c
         KQSwHfNNcGPzZhiYi+zZjbJjkFTHjbJf7r6/nufM6eSWVZAfIlpIFd7m3Ba6KrSoFx
         HieZTIPofdbQ2oSR1BigvrpLdka6+X3JdbGGuK+F3IRvKeVn3NyejfBiTQCZwxG4he
         uq6BJqRPwkHZM8YbBFPfp5cFD8PUxZLtp6VZUDb5vJCKw/IoqD1LHcZkYxfnEc3hXM
         2H/w2J1I2+5UBCRXz4Zma5Jiw0jomnS5mTxTgUWV/8P/pWXT5PVtGDoUN8RSlL3+Gn
         x/mC1E2bxhKQg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date:   Wed, 30 Nov 2022 20:09:34 +0000
Message-Id: <20221130200937.118005-9-sj@kernel.org>
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

Implement scheme filters functionality of DAMON sysfs interface by
making the code reads the values of files under the filter directories
and pass that to DAMON using DAMON kernel API.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 89 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e79c678a69d5..0501862534f2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1403,6 +1403,75 @@ struct kobj_type damon_sysfs_schemes_ktype = {
 	.default_groups = damon_sysfs_schemes_groups,
 };
 
+static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
+		char *memcg_path_buf, char *path)
+{
+#ifdef CONFIG_MEMCG
+	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
+	if (sysfs_streq(memcg_path_buf, path))
+		return true;
+#endif /* CONFIG_MEMCG */
+	return false;
+}
+
+static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
+{
+	struct mem_cgroup *memcg;
+	char *path;
+
+	if (!memcg_path)
+		return -EINVAL;
+
+	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
+			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
+		/* skip removed memcg */
+		if (!mem_cgroup_id(memcg))
+			continue;
+		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
+			*id = mem_cgroup_id(memcg);
+			break;
+		}
+	}
+
+	kfree(path);
+	return 0;
+}
+
+static int damon_sysfs_set_scheme_filters(struct damos *scheme,
+		struct damon_sysfs_scheme_filters *sysfs_filters)
+{
+	int i;
+	struct damos_filter *filter, *next;
+
+	damos_for_each_filter_safe(filter, next, scheme)
+		damos_destroy_filter(filter);
+
+	for (i = 0; i < sysfs_filters->nr; i++) {
+		struct damon_sysfs_scheme_filter *sysfs_filter =
+			sysfs_filters->filters_arr[i];
+		struct damos_filter *filter =
+			damos_new_filter(sysfs_filter->type,
+					sysfs_filter->matching);
+		int err;
+
+		if (!filter)
+			return -ENOMEM;
+		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
+			err = damon_sysfs_memcg_path_to_id(
+					sysfs_filter->memcg_path,
+					&filter->memcg_id);
+			if (err)
+				return err;
+		}
+		damos_add_filter(scheme, filter);
+	}
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -1411,6 +1480,10 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
+	struct damon_sysfs_scheme_filters *sysfs_filters =
+		sysfs_scheme->filters;
+	struct damos *scheme;
+	int err;
 
 	struct damos_access_pattern pattern = {
 		.min_sz_region = access_pattern->sz->min,
@@ -1436,8 +1509,17 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	return damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
 			&wmarks);
+	if (!scheme)
+		return NULL;
+
+	err = damon_sysfs_set_scheme_filters(scheme, sysfs_filters);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	return scheme;
 }
 
 static void damon_sysfs_update_scheme(struct damos *scheme,
@@ -1448,6 +1530,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
+	int err;
 
 	scheme->pattern.min_sz_region = access_pattern->sz->min;
 	scheme->pattern.max_sz_region = access_pattern->sz->max;
@@ -1470,6 +1553,10 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->wmarks.high = sysfs_wmarks->high;
 	scheme->wmarks.mid = sysfs_wmarks->mid;
 	scheme->wmarks.low = sysfs_wmarks->low;
+
+	err = damon_sysfs_set_scheme_filters(scheme, sysfs_scheme->filters);
+	if (err)
+		damon_destroy_scheme(scheme);
 }
 
 int damon_sysfs_set_schemes(struct damon_ctx *ctx,
-- 
2.25.1

