Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF46C7639
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCXD3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXD3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:29:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDEA212A4;
        Thu, 23 Mar 2023 20:28:59 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PjSJn5BpGzSp8n;
        Fri, 24 Mar 2023 11:25:29 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 11:28:57 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf ftrace: Make system wide the default target for latency subcommand
Date:   Fri, 24 Mar 2023 03:27:02 +0000
Message-ID: <20230324032702.109964-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no target is specified for 'latency' subcommand, the execution fails
because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
Make system wide the default target, which is the same as the default
behavior of 'trace' subcommand.

Before the fix:

  # perf ftrace latency -T schedule
  failed to set ftrace pid

After the fix:

  # perf ftrace latency -T schedule
  ^C#   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |          0 |                                                |
       1 - 2    us |          0 |                                                |
       2 - 4    us |          0 |                                                |
       4 - 8    us |       2828 | ####                                           |
       8 - 16   us |      23953 | ########################################       |
      16 - 32   us |        408 |                                                |
      32 - 64   us |        318 |                                                |
      64 - 128  us |          4 |                                                |
     128 - 256  us |          3 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          1 |                                                |
       1 - 2    ms |          4 |                                                |
       2 - 4    ms |          0 |                                                |
       4 - 8    ms |          0 |                                                |
       8 - 16   ms |          0 |                                                |
      16 - 32   ms |          0 |                                                |
      32 - 64   ms |          0 |                                                |
      64 - 128  ms |          0 |                                                |
     128 - 256  ms |          4 |                                                |
     256 - 512  ms |          2 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...   s |          0 |                                                |

Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-ftrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d7fe00f66b83..fb1b66ef2e16 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
 		goto out_delete_filters;
 	}
 
+	/* Make system wide (-a) the default target. */
+	if (!argc && target__none(&ftrace.target))
+		ftrace.target.system_wide = true;
+
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
-		if (!argc && target__none(&ftrace.target))
-			ftrace.target.system_wide = true;
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
-- 
2.30.GIT

