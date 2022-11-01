Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7F6154A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKAWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiKAWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF436254
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CD861732
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F21C433C1;
        Tue,  1 Nov 2022 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340215;
        bh=2CYTY0LTOD+j47uyqqEPkxAe2vTbM34BEl7VdIQiTbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NY0KGL9pnY8GRjz9mElbgeCD51TS1y9GeR2s5INOEzxXIMsYm/2meHVH0xEcDnXJm
         vJsPZSH+M3AOlPfc0krvSGWWkOjqWxnOuhMWcSqEexGLkB0ws0sdhuTwFGQpzxSKvH
         pZgpmh82gjcDbk1VX9MUb1UPnYRPZbSciNV6cy83JbBCsukHoLTMiuRzumD0Zj2lZF
         JtrTOtcScrMnHnKUJjq5LdQ/yxaKfA8VEx4CZXcpKoZV74AQY4HyHLzD049lyabwsI
         R4UACiazfXFyVEc44+Yjb2WuzAI1/x6axaxyqNVkyUHNKhC7b1mbHsLERNowe4NqhP
         3kS43a1xs7LVg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/8] mm/damon/sysfs: implement DAMOS tried regions update command
Date:   Tue,  1 Nov 2022 22:03:24 +0000
Message-Id: <20221101220328.95765-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the code for filling the data of 'tried_regions' DAMON sysfs
directory.  With this commit, DAMON sysfs interface users can write a
special keyword, 'update_schemes_tried_regions' to the corresponding
'state' file of the kdamond.  Then, DAMON sysfs interface will collect
the tried regions information using the 'before_damos_apply()' callback
for one aggregation interval and populate scheme region directories with
the values.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  6 ++++
 mm/damon/sysfs-schemes.c | 75 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c         | 57 ++++++++++++++++++++++++++++--
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 4626b2784404..634a6e7fca78 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -44,3 +44,9 @@ int damon_sysfs_set_schemes(struct damon_ctx *ctx,
 void damon_sysfs_schemes_update_stats(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+int damon_sysfs_schemes_update_regions_start(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
+
+int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 1a8ab6341bf1..dd4ecd093cd6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1198,3 +1198,78 @@ void damon_sysfs_schemes_update_stats(
 		sysfs_stats->qt_exceeds = scheme->stat.qt_exceeds;
 	}
 }
+
+/*
+ * damon_sysfs_schemes that need to update its schemes regions dir.  Protected
+ * by damon_sysfs_lock
+ */
+static struct damon_sysfs_schemes *damon_sysfs_schemes_for_damos_callback;
+static int damon_sysfs_schemes_region_idx;
+
+/*
+ * DAMON callback that called before damos apply.  While this callback is
+ * registered, damon_sysfs_lock should be held to ensure the regions
+ * directories exist.
+ */
+static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *s)
+{
+	struct damos *scheme;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	struct damon_sysfs_scheme_region *region;
+	struct damon_sysfs_schemes *sysfs_schemes =
+		damon_sysfs_schemes_for_damos_callback;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		if (scheme == s)
+			break;
+		schemes_idx++;
+	}
+	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	region = damon_sysfs_scheme_region_alloc(r);
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
+	if (kobject_init_and_add(&region->kobj,
+				&damon_sysfs_scheme_region_ktype,
+				&sysfs_regions->kobj, "%d",
+				damon_sysfs_schemes_region_idx++)) {
+		kobject_put(&region->kobj);
+	}
+	return 0;
+}
+
+/* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
+int damon_sysfs_schemes_update_regions_start(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_scheme *sysfs_scheme;
+
+		sysfs_scheme = sysfs_schemes->schemes_arr[schemes_idx++];
+		damon_sysfs_scheme_regions_rm_dirs(
+				sysfs_scheme->tried_regions);
+	}
+
+	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
+	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
+	return 0;
+}
+
+/*
+ * Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock.  Caller
+ * should unlock damon_sysfs_lock which held before
+ * damon_sysfs_schemes_update_regions_start()
+ */
+int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
+{
+	damon_sysfs_schemes_for_damos_callback = NULL;
+	ctx->callback.before_damos_apply = NULL;
+	damon_sysfs_schemes_region_idx = 0;
+	return 0;
+}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 284daf274b3e..ffb5a84059d7 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -999,6 +999,11 @@ enum damon_sysfs_cmd {
 	 * files.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS: Update schemes tried
+	 * regions
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1011,6 +1016,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"update_schemes_stats",
+	"update_schemes_tried_regions",
 };
 
 /*
@@ -1193,6 +1199,16 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
+	struct damon_sysfs_kdamond *kdamond;
+
+	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
+	kdamond = damon_sysfs_cmd_request.kdamond;
+	if (kdamond && damon_sysfs_cmd_request.cmd ==
+			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
+			ctx == kdamond->damon_ctx) {
+		damon_sysfs_schemes_update_regions_stop(ctx);
+		mutex_unlock(&damon_sysfs_lock);
+	}
 
 	if (!damon_target_has_pid(ctx))
 		return;
@@ -1225,6 +1241,27 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 	return 0;
 }
 
+static int damon_sysfs_upd_schemes_regions_start(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+	return damon_sysfs_schemes_update_regions_start(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+}
+
+static int damon_sysfs_upd_schemes_regions_stop(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+	return damon_sysfs_schemes_update_regions_stop(ctx);
+}
+
 static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
@@ -1277,10 +1314,12 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
+	static bool damon_sysfs_schemes_regions_updating;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
-	if (!mutex_trylock(&damon_sysfs_lock))
+	if (!damon_sysfs_schemes_regions_updating &&
+			!mutex_trylock(&damon_sysfs_lock))
 		return 0;
 	kdamond = damon_sysfs_cmd_request.kdamond;
 	if (!kdamond || kdamond->damon_ctx != c)
@@ -1292,13 +1331,27 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
+		if (!damon_sysfs_schemes_regions_updating) {
+			err = damon_sysfs_upd_schemes_regions_start(kdamond);
+			if (!err) {
+				damon_sysfs_schemes_regions_updating = true;
+				goto keep_lock_out;
+			}
+		} else {
+			err = damon_sysfs_upd_schemes_regions_stop(kdamond);
+			damon_sysfs_schemes_regions_updating = false;
+		}
+		break;
 	default:
 		break;
 	}
 	/* Mark the request as invalid now. */
 	damon_sysfs_cmd_request.kdamond = NULL;
 out:
-	mutex_unlock(&damon_sysfs_lock);
+	if (!damon_sysfs_schemes_regions_updating)
+		mutex_unlock(&damon_sysfs_lock);
+keep_lock_out:
 	return err;
 }
 
-- 
2.25.1

