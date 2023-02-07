Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0468E10A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBGTVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjBGTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:21:22 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD21274BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:21:20 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675797678;
        bh=LoBTCG/oycpVG+asEbk/KiwysCZzWdl4sVo8qNIQGpI=;
        h=From:Date:Subject:To:Cc:From;
        b=opegAJ0UJYUwCKUyVcFDqXJfE4JpGRgXy5jKYCjlFylnnCiwYt6IXJwT87eWAlcD8
         FeCeyo0lg0AekUcsH/VwkAlElEjAVgapvPkLYDTxSrnqb8+91OhFRpdf2OJYmkXwW3
         WdQL3DtsZEzP7MWZXwIBFNlhk1Rd+7N1Wt+E4SVM=
Date:   Tue, 07 Feb 2023 19:21:15 +0000
Subject: [PATCH] mm/damon/sysfs: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-kobj_type-damon-v1-1-9d4fea6a465b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKqk4mMC/x2N0QrCMAwAf2Xk2UCXwUR/RUTSLrroTEer4hj7d
 4OPd3DcClWKSoVjs0KRj1bN5tDuGkgj201QB2egQF2gsMdHjvfLa5kFB35mQ44HCT1R2yUBryJ
 XwVjY0uidvafJ5Vzkqt//5nTeth/JZSx2dgAAAA==
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675797676; l=9920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LoBTCG/oycpVG+asEbk/KiwysCZzWdl4sVo8qNIQGpI=;
 b=pa67lkv7S9lAbb30xmyy2f9u48dt2crHJuSFopYL+fO9n5hb4UBBAMxgB1r5uJ/dyJOMrLHj7
 Ukze/fbStVaCgc71vXsh2pATLE+oLTWOR0t5osRyStiG9jCoIA5xd1d
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/damon/sysfs-common.c  |  2 +-
 mm/damon/sysfs-common.h  |  4 ++--
 mm/damon/sysfs-schemes.c | 18 +++++++++---------
 mm/damon/sysfs.c         | 22 +++++++++++-----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 52bebf242f74..70edf45c2174 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -99,7 +99,7 @@ static struct attribute *damon_sysfs_ul_range_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
 
-struct kobj_type damon_sysfs_ul_range_ktype = {
+const struct kobj_type damon_sysfs_ul_range_ktype = {
 	.release = damon_sysfs_ul_range_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_ul_range_groups,
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 604a6cbc3ede..db677eba78fd 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -21,7 +21,7 @@ struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
 		unsigned long max);
 void damon_sysfs_ul_range_release(struct kobject *kobj);
 
-extern struct kobj_type damon_sysfs_ul_range_ktype;
+extern const struct kobj_type damon_sysfs_ul_range_ktype;
 
 /*
  * schemes directory
@@ -36,7 +36,7 @@ struct damon_sysfs_schemes {
 struct damon_sysfs_schemes *damon_sysfs_schemes_alloc(void);
 void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes);
 
-extern struct kobj_type damon_sysfs_schemes_ktype;
+extern const struct kobj_type damon_sysfs_schemes_ktype;
 
 int damon_sysfs_set_schemes(struct damon_ctx *ctx,
 		struct damon_sysfs_schemes *sysfs_schemes);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 81fc4d27f4e4..6e7c3accdd94 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -103,7 +103,7 @@ static struct attribute *damon_sysfs_scheme_region_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_region);
 
-static struct kobj_type damon_sysfs_scheme_region_ktype = {
+static const struct kobj_type damon_sysfs_scheme_region_ktype = {
 	.release = damon_sysfs_scheme_region_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_region_groups,
@@ -153,7 +153,7 @@ static struct attribute *damon_sysfs_scheme_regions_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_regions);
 
-static struct kobj_type damon_sysfs_scheme_regions_ktype = {
+static const struct kobj_type damon_sysfs_scheme_regions_ktype = {
 	.release = damon_sysfs_scheme_regions_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_regions_groups,
@@ -252,7 +252,7 @@ static struct attribute *damon_sysfs_stats_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_stats);
 
-static struct kobj_type damon_sysfs_stats_ktype = {
+static const struct kobj_type damon_sysfs_stats_ktype = {
 	.release = damon_sysfs_stats_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_stats_groups,
@@ -427,7 +427,7 @@ static struct attribute *damon_sysfs_watermarks_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_watermarks);
 
-static struct kobj_type damon_sysfs_watermarks_ktype = {
+static const struct kobj_type damon_sysfs_watermarks_ktype = {
 	.release = damon_sysfs_watermarks_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_watermarks_groups,
@@ -538,7 +538,7 @@ static struct attribute *damon_sysfs_weights_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_weights);
 
-static struct kobj_type damon_sysfs_weights_ktype = {
+static const struct kobj_type damon_sysfs_weights_ktype = {
 	.release = damon_sysfs_weights_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_weights_groups,
@@ -669,7 +669,7 @@ static struct attribute *damon_sysfs_quotas_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_quotas);
 
-static struct kobj_type damon_sysfs_quotas_ktype = {
+static const struct kobj_type damon_sysfs_quotas_ktype = {
 	.release = damon_sysfs_quotas_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_quotas_groups,
@@ -768,7 +768,7 @@ static struct attribute *damon_sysfs_access_pattern_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_access_pattern);
 
-static struct kobj_type damon_sysfs_access_pattern_ktype = {
+static const struct kobj_type damon_sysfs_access_pattern_ktype = {
 	.release = damon_sysfs_access_pattern_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_access_pattern_groups,
@@ -1001,7 +1001,7 @@ static struct attribute *damon_sysfs_scheme_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
 
-static struct kobj_type damon_sysfs_scheme_ktype = {
+static const struct kobj_type damon_sysfs_scheme_ktype = {
 	.release = damon_sysfs_scheme_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_scheme_groups,
@@ -1118,7 +1118,7 @@ static struct attribute *damon_sysfs_schemes_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_schemes);
 
-struct kobj_type damon_sysfs_schemes_ktype = {
+const struct kobj_type damon_sysfs_schemes_ktype = {
 	.release = damon_sysfs_schemes_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_schemes_groups,
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index aeb0beb1da91..33e1d5c9cb54 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -81,7 +81,7 @@ static struct attribute *damon_sysfs_region_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_region);
 
-static struct kobj_type damon_sysfs_region_ktype = {
+static const struct kobj_type damon_sysfs_region_ktype = {
 	.release = damon_sysfs_region_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_region_groups,
@@ -198,7 +198,7 @@ static struct attribute *damon_sysfs_regions_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_regions);
 
-static struct kobj_type damon_sysfs_regions_ktype = {
+static const struct kobj_type damon_sysfs_regions_ktype = {
 	.release = damon_sysfs_regions_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_regions_groups,
@@ -277,7 +277,7 @@ static struct attribute *damon_sysfs_target_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_target);
 
-static struct kobj_type damon_sysfs_target_ktype = {
+static const struct kobj_type damon_sysfs_target_ktype = {
 	.release = damon_sysfs_target_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_target_groups,
@@ -402,7 +402,7 @@ static struct attribute *damon_sysfs_targets_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_targets);
 
-static struct kobj_type damon_sysfs_targets_ktype = {
+static const struct kobj_type damon_sysfs_targets_ktype = {
 	.release = damon_sysfs_targets_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_targets_groups,
@@ -530,7 +530,7 @@ static struct attribute *damon_sysfs_intervals_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_intervals);
 
-static struct kobj_type damon_sysfs_intervals_ktype = {
+static const struct kobj_type damon_sysfs_intervals_ktype = {
 	.release = damon_sysfs_intervals_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_intervals_groups,
@@ -612,7 +612,7 @@ static struct attribute *damon_sysfs_attrs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_attrs);
 
-static struct kobj_type damon_sysfs_attrs_ktype = {
+static const struct kobj_type damon_sysfs_attrs_ktype = {
 	.release = damon_sysfs_attrs_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_attrs_groups,
@@ -800,7 +800,7 @@ static struct attribute *damon_sysfs_context_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_context);
 
-static struct kobj_type damon_sysfs_context_ktype = {
+static const struct kobj_type damon_sysfs_context_ktype = {
 	.release = damon_sysfs_context_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_context_groups,
@@ -926,7 +926,7 @@ static struct attribute *damon_sysfs_contexts_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_contexts);
 
-static struct kobj_type damon_sysfs_contexts_ktype = {
+static const struct kobj_type damon_sysfs_contexts_ktype = {
 	.release = damon_sysfs_contexts_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_contexts_groups,
@@ -1564,7 +1564,7 @@ static struct attribute *damon_sysfs_kdamond_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
 
-static struct kobj_type damon_sysfs_kdamond_ktype = {
+static const struct kobj_type damon_sysfs_kdamond_ktype = {
 	.release = damon_sysfs_kdamond_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_kdamond_groups,
@@ -1707,7 +1707,7 @@ static struct attribute *damon_sysfs_kdamonds_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_kdamonds);
 
-static struct kobj_type damon_sysfs_kdamonds_ktype = {
+static const struct kobj_type damon_sysfs_kdamonds_ktype = {
 	.release = damon_sysfs_kdamonds_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_kdamonds_groups,
@@ -1757,7 +1757,7 @@ static struct attribute *damon_sysfs_ui_dir_attrs[] = {
 };
 ATTRIBUTE_GROUPS(damon_sysfs_ui_dir);
 
-static struct kobj_type damon_sysfs_ui_dir_ktype = {
+static const struct kobj_type damon_sysfs_ui_dir_ktype = {
 	.release = damon_sysfs_ui_dir_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = damon_sysfs_ui_dir_groups,

---
base-commit: 513c1a3d3f1982fb850c910937099525b0d35e24
change-id: 20230207-kobj_type-damon-ab9e062213ce

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

