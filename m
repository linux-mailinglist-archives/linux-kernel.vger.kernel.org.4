Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719CE6E79CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjDSMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjDSMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16717685;
        Wed, 19 Apr 2023 05:31:13 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q1g5j1dYgzStCN;
        Wed, 19 Apr 2023 20:27:05 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 20:31:11 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/4] perf trace-event-info: Add tracepoint_id_to_name() helper
Date:   Wed, 19 Apr 2023 12:29:09 +0000
Message-ID: <20230419122912.73746-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230419122912.73746-1-yangjihong1@huawei.com>
References: <20230419122912.73746-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracepoint_id_to_name() helper to search for the trace events directory
by given event id and return the corresponding tracepoint.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/trace-event-info.c | 13 +++++++++++++
 tools/perf/util/trace-event.h      |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c24b3a15e319..79907caaf0ca 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -466,6 +466,19 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
 	return NULL;
 }
 
+char *tracepoint_id_to_name(u64 config)
+{
+	char buf[MAX_EVENT_LENGTH];
+	struct tracepoint_path *path = NULL;
+
+	path = tracepoint_id_to_path(config);
+	if (path == NULL)
+		return NULL;
+
+	snprintf(buf, sizeof(buf), "%s:%s", path->system, path->name);
+	return strdup(buf);
+}
+
 static struct tracepoint_path *tracepoint_name_to_path(const char *name)
 {
 	struct tracepoint_path *path = zalloc(sizeof(*path));
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index a0cff184b1cd..a69ee29419f3 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -62,6 +62,12 @@ unsigned long long eval_flag(const char *flag);
 
 int read_tracing_data(int fd, struct list_head *pattrs);
 
+/*
+ * Return the tracepoint name in the format "subsystem:event_name",
+ * callers should free the returned string.
+ */
+char *tracepoint_id_to_name(u64 config);
+
 struct tracing_data {
 	/* size is only valid if temp is 'true' */
 	ssize_t size;
-- 
2.30.GIT

