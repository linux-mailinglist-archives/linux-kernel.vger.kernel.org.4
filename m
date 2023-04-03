Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8806D3EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjDCIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDCIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:15:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00155A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:15:40 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PqkC41LjJz17R1J;
        Mon,  3 Apr 2023 16:12:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Apr 2023 16:15:38 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <jonathan.cameron@huawei.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 2/2] drivers/perf: hisi: add NULL check for name
Date:   Mon, 3 Apr 2023 16:14:23 +0800
Message-ID: <20230403081423.62460-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230403081423.62460-1-hejunhao3@huawei.com>
References: <20230403081423.62460-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocations fails that can be NULL now.

If the name provided is NULL, then the initialization process of the PMU
type and dev will be skipped in function perf_pmu_register().
Consequently, the PMU will not be able to register into the kernel.
Moreover, in the case of unregister the PMU, the function device_del()
will need to handle NULL pointers, which potentially can cause issues.

So move this allocation above the cpuhp_state_add_instance() and directly
return if it does fail.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 17 ++++++++++-------
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  7 +++++--
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 11 +++++------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 8a3d74ddcd6d..ffb039d05d07 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -499,13 +499,6 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
-				       &ddrc_pmu->node);
-	if (ret) {
-		dev_err(&pdev->dev, "Error %d registering hotplug;\n", ret);
-		return ret;
-	}
-
 	if (ddrc_pmu->identifier >= HISI_PMU_V2)
 		name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				      "hisi_sccl%u_ddrc%u_%u",
@@ -516,6 +509,16 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 				      "hisi_sccl%u_ddrc%u", ddrc_pmu->sccl_id,
 				      ddrc_pmu->index_id);
 
+	if (!name)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
+				       &ddrc_pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug;\n", ret);
+		return ret;
+	}
+
 	hisi_pmu_init(ddrc_pmu, THIS_MODULE);
 
 	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 5701a84edb0e..15caf99e1eef 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -510,6 +510,11 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
+			      hha_pmu->sccl_id, hha_pmu->index_id);
+	if (!name)
+		return -ENOMEM;
+
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
 				       &hha_pmu->node);
 	if (ret) {
@@ -517,8 +522,6 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
-			      hha_pmu->sccl_id, hha_pmu->index_id);
 	hisi_pmu_init(hha_pmu, THIS_MODULE);
 
 	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 68596b566344..794dbcd19b7a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -544,6 +544,11 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
+			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
+	if (!name)
+		return -ENOMEM;
+
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
 				       &l3c_pmu->node);
 	if (ret) {
@@ -551,12 +556,6 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * CCL_ID is used to identify the L3C in the same SCCL which was
-	 * used _UID by mistake.
-	 */
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
-			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
 	hisi_pmu_init(l3c_pmu, THIS_MODULE);
 
 	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
-- 
2.33.0

