Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3C746AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGDHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGDHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:44:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFFE7A;
        Tue,  4 Jul 2023 00:44:24 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QwF9t4yctzLnh6;
        Tue,  4 Jul 2023 15:42:10 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 15:44:21 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 4/5] perf test: Add test case for record tracking
Date:   Tue, 4 Jul 2023 07:42:16 +0000
Message-ID: <20230704074217.240939-5-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230704074217.240939-1-yangjihong1@huawei.com>
References: <20230704074217.240939-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Add a new test case to record tracking side-band events for all CPUs when
tracing selected CPUs

Test result:

  # ./perf test list 2>&1 | grep 'perf record tracking tests'
   95: perf record tracking tests
  f# ./perf test 95
   95: perf record tracking tests                                      : Ok

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/tests/shell/record_tracking.sh | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 tools/perf/tests/shell/record_tracking.sh

diff --git a/tools/perf/tests/shell/record_tracking.sh b/tools/perf/tests/shell/record_tracking.sh
new file mode 100755
index 000000000000..fe05f4772999
--- /dev/null
+++ b/tools/perf/tests/shell/record_tracking.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# perf record tracking tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+can_cpu_wide()
+{
+    if ! perf record -o ${perfdata} -BN --no-bpf-event -e dummy:u -C $1 true 2>&1 >/dev/null
+    then
+	echo "record tracking test [Skipped cannot record cpu$1]"
+	err=2
+    fi
+
+    rm -f ${perfdata}
+    return $err
+}
+
+test_system_wide_tracking()
+{
+    # Need CPU 0 and CPU 1
+    can_cpu_wide 0 || return 0
+    can_cpu_wide 1 || return 0
+
+    # Record on CPU 0 a task running on CPU 1
+    perf record -BN --no-bpf-event -o ${perfdata} -e dummy:u -C 0 -- taskset --cpu-list 1 true
+
+    # Should get MMAP events from CPU 1
+    mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
+
+    rm -f ${perfdata}
+
+    if [ ${mmap_cnt} -gt 0 ] ; then
+	return 0
+    fi
+
+    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
+    return 1
+}
+
+test_system_wide_tracking
-- 
2.30.GIT

