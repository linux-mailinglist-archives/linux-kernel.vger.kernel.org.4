Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553C573B047
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFWFqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFWFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:46:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AA26B7;
        Thu, 22 Jun 2023 22:46:16 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QnR425MhLztQnS;
        Fri, 23 Jun 2023 13:43:30 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 13:46:09 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <anshuman.khandual@arm.com>,
        <jesussanp@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v5 2/4] perf tools: Extend PRINT_ATTRf to support printing of members with a value of 0
Date:   Fri, 23 Jun 2023 05:44:14 +0000
Message-ID: <20230623054416.160858-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230623054416.160858-1-yangjihong1@huawei.com>
References: <20230623054416.160858-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When printing attr, members whose value is 0 will not be printed, we want
to print the case where attr->type is 0(PERF_TYPE_HARDWARE), add `_a`
param to PRINT_ATTRf macro to always print member when it is true
No functional change.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 7e5e7b30510d..433029c6afc5 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -80,15 +80,15 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
 
-#define PRINT_ATTRn(_n, _f, _p)				\
+#define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
-	if (attr->_f) {					\
+	if (_a || attr->_f) {				\
 		_p(attr->_f);				\
 		ret += attr__fprintf(fp, _n, buf, priv);\
 	}						\
 } while (0)
 
-#define PRINT_ATTRf(_f, _p)	PRINT_ATTRn(#_f, _f, _p)
+#define PRINT_ATTRf(_f, _p)	PRINT_ATTRn(#_f, _f, _p, false)
 
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
@@ -99,7 +99,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(type, p_unsigned);
 	PRINT_ATTRf(size, p_unsigned);
 	PRINT_ATTRf(config, p_hex);
-	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned);
+	PRINT_ATTRn("{ sample_period, sample_freq }", sample_period, p_unsigned, false);
 	PRINT_ATTRf(sample_type, p_sample_type);
 	PRINT_ATTRf(read_format, p_read_format);
 
@@ -141,10 +141,10 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
 
-	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
+	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
-	PRINT_ATTRn("{ bp_addr, config1 }", bp_addr, p_hex);
-	PRINT_ATTRn("{ bp_len, config2 }", bp_len, p_hex);
+	PRINT_ATTRn("{ bp_addr, config1 }", bp_addr, p_hex, false);
+	PRINT_ATTRn("{ bp_len, config2 }", bp_len, p_hex, false);
 	PRINT_ATTRf(branch_sample_type, p_branch_sample_type);
 	PRINT_ATTRf(sample_regs_user, p_hex);
 	PRINT_ATTRf(sample_stack_user, p_unsigned);
-- 
2.30.GIT

