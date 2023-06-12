Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5819072B573
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFLCfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFLCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:35:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855B19A;
        Sun, 11 Jun 2023 19:35:49 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QfbJr4gx3zqTm2;
        Mon, 12 Jun 2023 10:30:52 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 10:35:46 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hw.huiwang@huawei.com>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf/doc: revise the description about PR_TASK_PERF_EVENTS_{ENABLE,DISABLE}
Date:   Mon, 12 Jun 2023 10:35:23 +0800
Message-ID: <20230612023523.3918618-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of PR_TASK_PERF_EVENTS_{ENABLE,DISABLE} has been changed
since v2.6.30, commit 082ff5a2767a ("perf_counter: Change pctrl()
behaviour").

This patch revises the documentation about these two prctl options to match
the real behavior. The linux man pages should also be updated.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/design.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index aa8cfeabb743..cc9a2716d5ec 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -439,16 +439,15 @@ Additionally, non-inherited overflow counters can use
 
 to enable a counter for 'nr' events, after which it gets disabled again.
 
-A process can enable or disable all the counter groups that are
-attached to it, using prctl:
+A thread can enable or disable all the counter groups that are
+created by itself, using prctl:
 
 	prctl(PR_TASK_PERF_EVENTS_ENABLE);
 
 	prctl(PR_TASK_PERF_EVENTS_DISABLE);
 
-This applies to all counters on the current process, whether created
-by this process or by another, and doesn't affect any counters that
-this process has created on other processes.  It only enables or
+This applies to all counters created by this thread, and doesn't affect any
+counters that created by other processes or threads.  It only enables or
 disables the group leaders, not any other members in the groups.
 
 
-- 
2.25.1

