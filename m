Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A26E79CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjDSMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjDSMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC84813F9C;
        Wed, 19 Apr 2023 05:31:15 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q1g691PzRzncxX;
        Wed, 19 Apr 2023 20:27:29 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 20:31:12 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 3/4] perf tools: Add printing perf_event_attr->type symbol in perf_event_attr__fprintf()
Date:   Wed, 19 Apr 2023 12:29:11 +0000
Message-ID: <20230419122912.73746-4-yangjihong1@huawei.com>
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

When printing perf_event_attr, always display attr->type and its symbol
to improve the readability of debugging information.

Before:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
  <SNIP>
  ------------------------------------------------------------
  perf_event_attr:
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
  ------------------------------------------------------------
  perf_event_attr:
    type                             2
    size                             136
    config                           0x131
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
  ------------------------------------------------------------
  perf_event_attr:
    type                             3
    size                             136
    config                           0x10005
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             136
    config                           0x101
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  <SNIP>

After:

  # perf --debug verbose=2 record -e cycles,cpu-clock,sched:sched_switch,branch-load-misses,r101 -C 0 true
  <SNIP>
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
  ------------------------------------------------------------
  perf_event_attr:
    type                             2 (PERF_TYPE_TRACEPOINT)
    size                             136
    config                           0x131
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
  ------------------------------------------------------------
  perf_event_attr:
    type                             3 (PERF_TYPE_HW_CACHE)
    size                             136
    config                           0x10005
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 10
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (PERF_TYPE_RAW)
    size                             136
    config                           0x101
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 11
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 24 ++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 433029c6afc5..d9d70126d505 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -71,6 +71,27 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 	__p_bits(buf, size, value, bits);
 }
 
+static void __p_type_id(char *buf, size_t size, u64 value)
+{
+	/* sync with enum perf_type_id in perf_event.h */
+	switch (value) {
+#define PRINT_ENUM_PERF_TYPE_ID_CASE(x)					\
+	case x:								\
+		snprintf(buf, size, "%"PRIu64" (%s)", value, #x);	\
+		return;
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HARDWARE)
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_SOFTWARE)
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_TRACEPOINT)
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_HW_CACHE)
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_RAW)
+	PRINT_ENUM_PERF_TYPE_ID_CASE(PERF_TYPE_BREAKPOINT)
+#undef PRINT_ENUM_PERF_TYPE_ID_CASE
+	default:
+		snprintf(buf, size, "%"PRIu64, value);
+		return;
+	}
+}
+
 #define BUF_SIZE		1024
 
 #define p_hex(val)		snprintf(buf, BUF_SIZE, "%#"PRIx64, (uint64_t)(val))
@@ -79,6 +100,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
+#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
@@ -96,7 +118,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	char buf[BUF_SIZE];
 	int ret = 0;
 
-	PRINT_ATTRf(type, p_unsigned);
+	PRINT_ATTRn("type", type, p_type_id, true);
 	PRINT_ATTRf(size, p_unsigned);
 	PRINT_ATTRf(config, p_hex);
 	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
-- 
2.30.GIT

