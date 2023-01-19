Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCF673511
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjASKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjASKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:04:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEFC717B2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:32 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NyJ3s6ZDDzqVBP;
        Thu, 19 Jan 2023 17:58:33 +0800 (CST)
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
Subject: [PATCH 2/3] drivers/perf: hisi: Simplify the parameters of hisi_pmu_init()
Date:   Thu, 19 Jan 2023 18:03:06 +0800
Message-ID: <20230119100307.3660-3-hejunhao3@huawei.com>
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

Use "hisi_pmu" to simplify the parameter list for the hisi_pmu_init()
function.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      | 8 +++++---
 drivers/perf/hisilicon/hisi_uncore_pmu.h      | 4 ++--
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 50d0c0a2f1fe..8c3ffcbfd4c0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -516,7 +516,7 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
 				      "hisi_sccl%u_ddrc%u", ddrc_pmu->sccl_id,
 				      ddrc_pmu->index_id);
 
-	hisi_pmu_init(&ddrc_pmu->pmu, name, ddrc_pmu->pmu_events.attr_groups, THIS_MODULE);
+	hisi_pmu_init(ddrc_pmu, name, THIS_MODULE);
 
 	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
 	if (ret) {
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 13017b3412a5..806698b9eabf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -519,7 +519,7 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
 			      hha_pmu->sccl_id, hha_pmu->index_id);
-	hisi_pmu_init(&hha_pmu->pmu, name, hha_pmu->pmu_events.attr_groups, THIS_MODULE);
+	hisi_pmu_init(hha_pmu, name, THIS_MODULE);
 
 	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
 	if (ret) {
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 2995f3630d49..5b2c35f1658a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -557,7 +557,7 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
 	 */
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
 			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
-	hisi_pmu_init(&l3c_pmu->pmu, name, l3c_pmu->pmu_events.attr_groups, THIS_MODULE);
+	hisi_pmu_init(l3c_pmu, name, THIS_MODULE);
 
 	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
 	if (ret) {
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 47d3cc9b6eec..afe3419f3f6d 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -412,7 +412,7 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	hisi_pmu_init(&pa_pmu->pmu, name, pa_pmu->pmu_events.attr_groups, THIS_MODULE);
+	hisi_pmu_init(pa_pmu, name, THIS_MODULE);
 	ret = perf_pmu_register(&pa_pmu->pmu, name, -1);
 	if (ret) {
 		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 2a466477920b..f1b0f5e1a28f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -531,9 +531,11 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 }
 EXPORT_SYMBOL_GPL(hisi_uncore_pmu_offline_cpu);
 
-void hisi_pmu_init(struct pmu *pmu, const char *name,
-		const struct attribute_group **attr_groups, struct module *module)
+void hisi_pmu_init(struct hisi_pmu *hisi_pmu, const char *name,
+		   struct module *module)
 {
+	struct pmu *pmu = &hisi_pmu->pmu;
+
 	pmu->name               = name;
 	pmu->module             = module;
 	pmu->task_ctx_nr        = perf_invalid_context;
@@ -545,7 +547,7 @@ void hisi_pmu_init(struct pmu *pmu, const char *name,
 	pmu->start              = hisi_uncore_pmu_start;
 	pmu->stop               = hisi_uncore_pmu_stop;
 	pmu->read               = hisi_uncore_pmu_read;
-	pmu->attr_groups        = attr_groups;
+	pmu->attr_groups        = hisi_pmu->pmu_events.attr_groups;
 	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE;
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index b59de33cd059..f8e3cc6903d7 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -121,6 +121,6 @@ ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
 int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
 			     struct platform_device *pdev);
 
-void hisi_pmu_init(struct pmu *pmu, const char *name,
-		const struct attribute_group **attr_groups, struct module *module);
+void hisi_pmu_init(struct hisi_pmu *hisi_pmu, const char *name,
+		   struct module *module);
 #endif /* __HISI_UNCORE_PMU_H__ */
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index b9c79f17230c..1e354433776a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -445,7 +445,7 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	hisi_pmu_init(&sllc_pmu->pmu, name, sllc_pmu->pmu_events.attr_groups, THIS_MODULE);
+	hisi_pmu_init(sllc_pmu, name, THIS_MODULE);
 
 	ret = perf_pmu_register(&sllc_pmu->pmu, name, -1);
 	if (ret) {
-- 
2.33.0

