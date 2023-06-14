Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE27245D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbjFFOYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbjFFOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:24:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24F10E9;
        Tue,  6 Jun 2023 07:24:18 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QbCMD1gwczLqNp;
        Tue,  6 Jun 2023 22:21:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 22:24:13 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v4 5/5] hwtracing: hisi_ptt: Fix potential sleep in atomic context
Date:   Tue, 6 Jun 2023 22:22:44 +0800
Message-ID: <20230606142244.10939-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230606142244.10939-1-yangyicong@huawei.com>
References: <20230606142244.10939-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

We're using pci_irq_vector() to obtain the interrupt number and then
bind it to the CPU start perf under the protection of spinlock in
pmu::start(). pci_irq_vector() might sleep since [1] because it will
call msi_domain_get_virq() to get the MSI interrupt number and it
needs to acquire dev->msi.data->mutex. Getting a mutex will sleep on
contention. So use pci_irq_vector() in an atomic context is problematic.

This patch cached the interrupt number in the probe() and uses the
cached data instead to avoid potential sleep.

[1] commit 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 12 +++++-------
 drivers/hwtracing/ptt/hisi_ptt.h |  2 ++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index ff2c16efe5b1..d78d71b6764f 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -341,13 +341,13 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_request_threaded_irq(&pdev->dev,
-					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
+	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
+	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
 					NULL, hisi_ptt_isr, 0,
 					DRV_NAME, hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "failed to request irq %d, ret = %d\n",
-			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
+			hisi_ptt->trace_irq, ret);
 		return ret;
 	}
 
@@ -1096,8 +1096,7 @@ static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
 	 * core in event_function_local(). If CPU passed is offline we'll fail
 	 * here, just log it since we can do nothing here.
 	 */
-	ret = irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
-					      cpumask_of(cpu));
+	ret = irq_set_affinity(hisi_ptt->trace_irq, cpumask_of(cpu));
 	if (ret)
 		dev_warn(dev, "failed to set the affinity of trace interrupt\n");
 
@@ -1392,8 +1391,7 @@ static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	 * Also make sure the interrupt bind to the migrated CPU as well. Warn
 	 * the user on failure here.
 	 */
-	if (irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
-					    cpumask_of(target)))
+	if (irq_set_affinity(hisi_ptt->trace_irq, cpumask_of(target)))
 		dev_warn(dev, "failed to set the affinity of trace interrupt\n");
 
 	hisi_ptt->trace_ctrl.on_cpu = target;
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 164012dba4ec..e17f045d7e72 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -201,6 +201,7 @@ struct hisi_ptt_pmu_buf {
  * @pdev:         pci_dev of this PTT device
  * @tune_lock:    lock to serialize the tune process
  * @pmu_lock:     lock to serialize the perf process
+ * @trace_irq:    interrupt number used by trace
  * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
  * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
  * @port_filters: the filter list of root ports
@@ -221,6 +222,7 @@ struct hisi_ptt {
 	struct pci_dev *pdev;
 	struct mutex tune_lock;
 	spinlock_t pmu_lock;
+	int trace_irq;
 	u32 upper_bdf;
 	u32 lower_bdf;
 
-- 
2.24.0

