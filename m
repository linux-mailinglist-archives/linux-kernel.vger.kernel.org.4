Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64E56036F0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJSAO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJSANk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:13:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC075D2CE4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0D6B821AE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F271C43143;
        Wed, 19 Oct 2022 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666138412;
        bh=+4u+XHFnx9VTZYDm4OZZLOkSeV73RiOKluyAqxZ2I4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPVB1sLs6ZaCTMOqkm1Wuwic4nCru5ECQKGdRfUUOvGdmYguDa0Vl20neocxUQkdd
         +Q+7Ht/D6lUD0gBtzFiymJ2sohWUq9VhyEdt7dMbA9xDvK8zFcNOvf6yr3mQODgiKs
         3ExD7afAltdCnh5EQLD1WI3IehGSsGuJjK9hfZ2YnIMvpOk4IhbxuqXYlETaHf4l/l
         WMqRJW6wjSftWFh6P/E50IthgAsOHdkFtV6xCrr2P209jGzEidcJO36EGs9RVPDTDu
         G5D3pG2HyMdPwTWZzX8QdA2EW0rYw/Vl0d4YzqwUcTsvUDQh+x7kcS6TQgGyzXS3ox
         vagpOwE0EaJ9g==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/18] mm/damon/sysfs-schemes: implement DAMOS tried regions clear command
Date:   Wed, 19 Oct 2022 00:13:15 +0000
Message-Id: <20221019001317.104270-17-sj@kernel.org>
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

When there are huge number of DAMON regions that specific scheme actions
are tried to be applied, directories and files under 'tried_regions'
scheme directory could waste some memory.  Add another special input
keyword for 'state' file of each kdamond sysfs directory that can be
used for cleanup of the 'tried_regions' sub-directories.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  4 ++++
 mm/damon/sysfs-schemes.c | 17 +++++++++++++++++
 mm/damon/sysfs.c         | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 634a6e7fca78..604a6cbc3ede 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -50,3 +50,7 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_ctx *ctx);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
+
+int damon_sysfs_schemes_clear_regions(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2cea58e49d8d..223de1d06740 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1262,3 +1262,20 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
 	damon_sysfs_schemes_region_idx = 0;
 	return 0;
 }
+
+int damon_sysfs_schemes_clear_regions(
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
+	return 0;
+}
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d26ae6052b6..acc16473f6fd 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1001,6 +1001,9 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
 	/* @DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS: Update scheme regions */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_REGIONS,
+	/* @DAMON_SYSFS_CMD_CLEAR_SCHEMES_REGIONS: Clear scheme regions */
+	DAMON_SYSFS_CMD_CLEAR_SCHEMES_REGIONS,
+
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1014,6 +1017,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"commit",
 	"update_schemes_stats",
 	"update_schemes_regions",
+	"clear_schemes_regions",
 };
 
 /*
@@ -1259,6 +1263,17 @@ static int damon_sysfs_upd_schemes_regions_stop(
 	return damon_sysfs_schemes_update_regions_stop(ctx);
 }
 
+static int damon_sysfs_clear_schemes_regions(
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+	return damon_sysfs_schemes_clear_regions(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+}
+
 static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
@@ -1340,6 +1355,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
+	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_REGIONS:
+		err = damon_sysfs_clear_schemes_regions(kdamond);
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

