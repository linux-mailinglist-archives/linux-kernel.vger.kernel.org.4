Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665266BD0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCPNdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCPNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:33:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26764850;
        Thu, 16 Mar 2023 06:33:36 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pcp9p41TCzKnKJ;
        Thu, 16 Mar 2023 21:33:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 21:33:34 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <linux-perf-users@vger.kernel.org>, <acme@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <mike.leach@linaro.org>, <john.g.garry@oracle.com>,
        <will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [RESEND PATCH] perf cs-etm: add error logging to cs_etm_is_etmv4()
Date:   Thu, 16 Mar 2023 21:32:32 +0800
Message-ID: <20230316133232.42209-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the HiSilicon platform, there is one ETM per logic core.
When setting up SMT, not every process has an ETM. So the path
".../cs_etm/cpux/trcidr/trcidr0" does not exist, the function
perf_pmu__scan_file() return an error. However, the command
'perf record' will returns silently and don't print.

After this patch, log a error when read fails that makes it easy
for users to debug.

  root@localhost:/# perf record -e /cs_etm/@ultra_smb0/ -C 3 uname -a
  cs_etm: can't read file cpu3/trcidr/trcidr0
  root@localhost:/#

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 7f71c8a237ff..19ea17430399 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -585,7 +585,6 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
 {
-	bool ret = false;
 	char path[PATH_MAX];
 	int scan;
 	unsigned int val;
@@ -600,9 +599,10 @@ static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu)
 
 	/* The file was read successfully, we have a winner */
 	if (scan == 1)
-		ret = true;
+		return true;
 
-	return ret;
+	pr_err("%s: can't read file %s\n", CORESIGHT_ETM_PMU_NAME, path);
+	return false;
 }
 
 static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
-- 
2.33.0

