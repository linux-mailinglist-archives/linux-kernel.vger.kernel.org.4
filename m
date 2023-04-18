Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6AF6E57C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDRDRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDRDQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:16:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635244685;
        Mon, 17 Apr 2023 20:16:55 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [7.221.188.120])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q0pwM4LgdzKs8m;
        Tue, 18 Apr 2023 11:16:03 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 11:15:35 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v5 1/2] perf: add helper map__fprintf_dsoname_dsoff
Date:   Tue, 18 Apr 2023 11:15:18 +0800
Message-ID: <20230418031519.1261310-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418031519.1261310-1-changbin.du@huawei.com>
References: <20230418031519.1261310-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a helper function map__fprintf_dsoname_dsoff() to print dsoname
with optional dso offset.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/map.c | 13 +++++++++++++
 tools/perf/util/map.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d81b6ca18ee9..7da96b41100f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -445,6 +445,19 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
+{
+	int printed = 0;
+
+	printed += fprintf(fp, " (");
+	printed += map__fprintf_dsoname(map, fp);
+	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
+		printed += fprintf(fp, "+0x%" PRIx64, addr);
+	printed += fprintf(fp, ")");
+
+	return printed;
+}
+
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
 {
 	if (map == NULL)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f89ab7c2d327..4cca211b6e66 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -175,6 +175,7 @@ static inline void __map__zput(struct map **map)
 
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
+size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
-- 
2.25.1

