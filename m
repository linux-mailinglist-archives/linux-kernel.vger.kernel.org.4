Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C366414D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjAJNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjAJNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:09:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FB6ECBD;
        Tue, 10 Jan 2023 05:09:13 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NrrhN4xkHzJrDt;
        Tue, 10 Jan 2023 21:07:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 21:09:05 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/2] hwtracing: hisi_ptt: Only add the supported devices to the filters list
Date:   Tue, 10 Jan 2023 21:08:32 +0800
Message-ID: <20230110130833.53474-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

The PTT device can only support the devices on the same PCIe core,
within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
the devices on the root bus are from the same PCIe core, there are
cases that root ports from different PCIe core are sharing the same
bus. So add the checking when initialize the filters list.

Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Change since v1:
- Add tags from Jonathan
Link: https://lore.kernel.org/linux-pci/20221122120209.25682-1-yangyicong@huawei.com/raw

 drivers/hwtracing/ptt/hisi_ptt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 5d5526aa60c4..30f1525639b5 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -356,8 +356,18 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
 
 static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
 {
+	struct pci_dev *root_port = pcie_find_root_port(pdev);
 	struct hisi_ptt_filter_desc *filter;
 	struct hisi_ptt *hisi_ptt = data;
+	u32 port_devid;
+
+	if (!root_port)
+		return 0;
+
+	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
+	if (port_devid < hisi_ptt->lower_bdf ||
+	    port_devid > hisi_ptt->upper_bdf)
+		return 0;
 
 	/*
 	 * We won't fail the probe if filter allocation failed here. The filters
-- 
2.24.0

