Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A472C94D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjFLPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjFLPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:05:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B98019A;
        Mon, 12 Jun 2023 08:05:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60F91FB;
        Mon, 12 Jun 2023 08:06:02 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7782A3F5A1;
        Mon, 12 Jun 2023 08:05:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf map: Fix refcount errors on Arm with -DREFCNT_CHECKING=1
Date:   Mon, 12 Jun 2023 16:04:24 +0100
Message-Id: <20230612150424.198914-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When quitting after running a perf report, the refcount checker finds
some double frees. The issue is that map__put() is called on a function
argument so it removes the refcount wrapper that someone else was using.

Fix it by only calling map__put() on a reference that is owned by this
function.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol-elf.c | 9 +++++----
 tools/perf/util/symbol.c     | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 63882a4db5c7..ec0d7810bbb0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1365,6 +1365,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	struct dso *curr_dso = *curr_dsop;
 	struct map *curr_map;
 	char dso_name[PATH_MAX];
+	struct map *map_ref;
 
 	/* Adjust symbol to map to file offset */
 	if (adjust_kernel_syms)
@@ -1390,10 +1391,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			if (kmaps) {
 				int err;
 
-				map__get(map);
-				maps__remove(kmaps, map);
-				err = maps__insert(kmaps, map);
-				map__put(map);
+				map_ref = map__get(map);
+				maps__remove(kmaps, map_ref);
+				err = maps__insert(kmaps, map_ref);
+				map__put(map_ref);
 				if (err)
 					return err;
 			}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6b9c55784b56..b3034fd5c0af 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,6 +1368,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	int err, fd;
 	char kcore_filename[PATH_MAX];
 	u64 stext;
+	struct map *map_ref;
 
 	if (!kmaps)
 		return -EINVAL;
@@ -1464,10 +1465,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			map__set_map_ip(map, map__map_ip_ptr(new_map));
 			map__set_unmap_ip(map, map__unmap_ip_ptr(new_map));
 			/* Ensure maps are correctly ordered */
-			map__get(map);
-			maps__remove(kmaps, map);
-			err = maps__insert(kmaps, map);
-			map__put(map);
+			map_ref = map__get(map);
+			maps__remove(kmaps, map_ref);
+			err = maps__insert(kmaps, map_ref);
+			map__put(map_ref);
 			map__put(new_map);
 			if (err)
 				goto out_err;
-- 
2.34.1

