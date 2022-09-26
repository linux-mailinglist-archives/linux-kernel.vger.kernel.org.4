Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266C45E982E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIZDSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIZDSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:18:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238226AE7;
        Sun, 25 Sep 2022 20:18:33 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbSWs4VpHzHtnh;
        Mon, 26 Sep 2022 11:13:45 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:31 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:18:31 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <john.garry@huawei.com>, <adrian.hunter@intel.com>,
        <ak@linux.intel.com>, <florian.fischer@muhq.space>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 5/5] perf: Remove unused macro K
Date:   Mon, 26 Sep 2022 11:14:40 +0800
Message-ID: <20220926031440.28275-6-chenzhongjin@huawei.com>
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

Unused macro reported by [-Wunused-macros].

This macro is introduced to calculate the 'unit' size, in:
'd2fb8b4151a9 ("perf tools: Add new perf_atoll() function to parse string representing size in bytes")'

'8ba7f6c2faad ("saner perf_atoll()")'
This commit has simplified the perf_atoll() function and remove the
'unit' variable. This macro is not deleted, but nowhere else is using it.

A single letter macro is confusing and easy to be misused.
So remove it for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/perf/util/string.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index f6d90cdd9225..4f12a96f33cc 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -15,7 +15,6 @@ const char *dots =
 	"....................................................................."
 	".....................................................................";
 
-#define K 1024LL
 /*
  * perf_atoll()
  * Parse (\d+)(b|B|kb|KB|mb|MB|gb|GB|tb|TB) (e.g. "256MB")
-- 
2.17.1

