Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC75E9832
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiIZDTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiIZDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2826AE6;
        Sun, 25 Sep 2022 20:18:32 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbSWs3X1BzHtnk;
        Mon, 26 Sep 2022 11:13:45 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:31 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:30 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 4/5] perf: Remove unused macros __PERF_EVENT_FIELD
Date:   Mon, 26 Sep 2022 11:14:39 +0800
Message-ID: <20220926031440.28275-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926031440.28275-1-chenzhongjin@huawei.com>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused macros reported by [-Wunused-macros].

This macros were introduced as __PERF_COUNTER_FIELD and used for
reading the bit in config.

'cdd6c482c9ff ("perf: Do the big rename: Performance Counters -> Performance Events")'
Changes it to __PERF_EVENT_FIELD but at this commit there is already
nowhere else using these macros, also no macros called
PERF_EVENT_##name##_MASK/SHIFT.

Now we are not reading type or id from config. These macros are
useless and incomplete.

So removing them for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/perf/util/parse-events.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f05e15acd33f..3ed914882b96 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -149,14 +149,6 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-#define __PERF_EVENT_FIELD(config, name) \
-	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
-
-#define PERF_EVENT_RAW(config)		__PERF_EVENT_FIELD(config, RAW)
-#define PERF_EVENT_CONFIG(config)	__PERF_EVENT_FIELD(config, CONFIG)
-#define PERF_EVENT_TYPE(config)		__PERF_EVENT_FIELD(config, TYPE)
-#define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
-
 const char *event_type(int type)
 {
 	switch (type) {
-- 
2.17.1

