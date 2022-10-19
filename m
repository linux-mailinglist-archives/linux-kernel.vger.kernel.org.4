Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC06036ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJSAON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJSANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0DDAC49
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2C261739
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D560C43470;
        Wed, 19 Oct 2022 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138412;
        bh=sftcrSg47Wkp/6of/TNsgoFTZR3ve0kx1JL6Su2cuIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gdxrN6SIq2NOHs5GIWo3gFFASIAF6OZ2cpB9F22vh2rDPfUuDPmBzHqpPcmasYSDq
         Ob2Cd11h3Qqs7JPgW5h08GbYlYGdeJOSUu8r9t02yzaqx2jUZ9jB9jAirdYLbx5Iow
         yeYo5TZ4YgA9mp7Svk5e5tJIzNDAcq8FJyiaLJ4F1VxclmTubiRmVW7vHHrDydAH2C
         R2/hHPQClVz1k8mry2waVhd1Yiray22mmt0hdpbwP3n+hDEsxeQaRy5wH9aKimGnC4
         tsxWwgBLyhdvy2c9yKllUqaWjOtLiXbDHGRtEIbvZfP67QsT0YkMqMXOjY7UZh5ZKN
         3lRB+LwgS/qYQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/18] mm/damon/sysfs: implement DAMOS-tried regions update command
Date:   Wed, 19 Oct 2022 00:13:14 +0000
Message-Id: <20221019001317.104270-16-sj@kernel.org>
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

Implement filling of the data for 'tried_regions' directory of
DAMON-based operation schemes for specific kdamond.  With this commit,
DAMON sysfs interface users can write a special keyword,
'update_schemes_regions' to the 'state' file of the kdamond directory to
signal DAMON to fill the relevant 'tried_regions' directories.  In
detail, once the keyword is written, DAMON sysfs interface will collect
the information using the 'before_damos_apply()' callback for one
aggregation interval and populate scheme region directories with the
values.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  6 ++++
 mm/damon/sysfs-schemes.c | 64 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/sysfs.c         | 54 +++++++++++++++++++++++++++++++--
 3 files changed, 122 insertions(+), 2 deletions(-)

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
index 1a8ab6341bf1..2cea58e49d8d 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1198,3 +1198,67 @@ void damon_sysfs_schemes_update_stats(
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
index 284daf274b3e..6d26ae6052b6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -999,6 +999,8 @@ enum damon_sysfs_cmd {
 	 * files.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+	/* @DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS: Update scheme regions */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1011,6 +1013,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"update_schemes_stats",
+	"update_schemes_regions",
 };
 
 /*
@@ -1193,6 +1196,16 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
+	struct damon_sysfs_kdamond *kdamond;
+
+	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
+	kdamond = damon_sysfs_cmd_request.kdamond;
+	if (kdamond && damon_sysfs_cmd_request.cmd ==
+			DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS &&
+			ctx == kdamond->damon_ctx) {
+		damon_sysfs_schemes_update_regions_stop(ctx);
+		mutex_unlock(&damon_sysfs_lock);
+	}
 
 	if (!damon_target_has_pid(ctx))
 		return;
@@ -1225,6 +1238,27 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
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
@@ -1277,10 +1311,12 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
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
@@ -1292,13 +1328,27 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS:
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

