Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC6673512
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjASKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjASKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:04:32 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA060717A8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:34 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NyJ7W71rHz16MlY;
        Thu, 19 Jan 2023 18:01:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 18:03:28 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 3/3] drivers/perf: hisi: Extract initialization of "cpa_pmu->pmu"
Date:   Thu, 19 Jan 2023 18:03:07 +0800
Message-ID: <20230119100307.3660-4-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230119100307.3660-1-hejunhao3@huawei.com>
References: <20230119100307.3660-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hisi_pmu_init() function to simplify initialization of "cpa_pmu->pmu".

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
index a9bb73f76be4..4c67d57217a7 100644
--- a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
@@ -316,21 +316,7 @@ static int hisi_cpa_pmu_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	cpa_pmu->pmu = (struct pmu) {
-		.name		= name,
-		.module		= THIS_MODULE,
-		.task_ctx_nr	= perf_invalid_context,
-		.event_init	= hisi_uncore_pmu_event_init,
-		.pmu_enable	= hisi_uncore_pmu_enable,
-		.pmu_disable	= hisi_uncore_pmu_disable,
-		.add		= hisi_uncore_pmu_add,
-		.del		= hisi_uncore_pmu_del,
-		.start		= hisi_uncore_pmu_start,
-		.stop		= hisi_uncore_pmu_stop,
-		.read		= hisi_uncore_pmu_read,
-		.attr_groups	= cpa_pmu->pmu_events.attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
-	};
+	hisi_pmu_init(cpa_pmu, name, THIS_MODULE);
 
 	/* Power Management should be disabled before using CPA PMU. */
 	hisi_cpa_pmu_disable_pm(cpa_pmu);
-- 
2.33.0

