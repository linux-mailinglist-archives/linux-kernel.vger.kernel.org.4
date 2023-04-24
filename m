Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7706E57C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDRDTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDRDSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:18:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EB59DF;
        Mon, 17 Apr 2023 20:18:48 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [7.221.188.120])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q0pyX3K6xzKs83;
        Tue, 18 Apr 2023 11:17:56 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 11:18:45 +0800
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
Subject: [PATCH v5 1/3] perf script: print raw ip instead of binary offset for callchain
Date:   Tue, 18 Apr 2023 11:18:23 +0800
Message-ID: <20230418031825.1262579-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418031825.1262579-1-changbin.du@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this, the raw ip is printed for non-callchain and dso offset for
callchain. This inconsistent output for address may confuse people. And
mostly what we expect is the raw ip.

'dso offset' is printed in callchain:
$ perf script
...
ls 1341034 2739463.008343:    2162417 cycles:
        ffffffff99d657a7 [unknown] ([unknown])
        ffffffff99e00b67 [unknown] ([unknown])
                   235d3 memset+0x53 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)  # dso offset
                    a61b _dl_map_object+0x1bb (/usr/lib/x86_64-linux-gnu/ld-2.31.so)

raw ip is printed for non-callchain:
$ perf script  -G
	...
        ls 1341034 2739463.008876:    2053304 cycles:  ffffffffc1596923 [unknown] ([unknown])
        ls 1341034 2739463.009381:    1917049 cycles:      14def8e149e6 __strcoll_l+0xd96 (/usr/lib/x86_64-linux-gnu/libc-2.31.so) # raw ip

Let's have consistent output for it. Later I'll add a new field 'dsoff' to
print dso offset.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/evsel_fprintf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index a09ac00810b7..cc80ec554c0a 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -153,13 +153,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (map)
 				addr = map__map_ip(map, node->ip);
 
-			if (print_ip) {
-				/* Show binary offset for userspace addr */
-				if (map && !map__dso(map)->kernel)
-					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
-				else
-					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
-			}
+			if (print_ip)
+				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
 
 			if (print_sym) {
 				printed += fprintf(fp, " ");
-- 
2.25.1

