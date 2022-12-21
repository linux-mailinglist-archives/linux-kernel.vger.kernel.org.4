Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88AB652E99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiLUJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiLUJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:31:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F2205D7;
        Wed, 21 Dec 2022 01:31:49 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NcSq35yNJzmWZ8;
        Wed, 21 Dec 2022 17:30:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 17:31:47 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v3 3/3] scsi: hisi_sas: Implement lldd_device_task_abort()
Date:   Wed, 21 Dec 2022 09:25:14 +0000
Message-ID: <20221221092514.4091-4-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221221092514.4091-1-yangxingui@huawei.com>
References: <20221221092514.4091-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement lldd_device_task_abort() to abort active io for device.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 41ba22f6c7f0..647479e54b62 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1839,6 +1839,24 @@ static int hisi_sas_clear_nexus_ha(struct sas_ha_struct *sas_ha)
 	return TMF_RESP_FUNC_COMPLETE;
 }
 
+static int hisi_sas_device_task_abort(struct domain_device *dev)
+{
+	struct hisi_sas_device *sas_dev = dev->lldd_dev;
+	struct hisi_sas_slot *slot, *slot2;
+	struct sas_task *task;
+
+	spin_lock(&sas_dev->lock);
+	list_for_each_entry_safe(slot, slot2, &sas_dev->list, entry) {
+		task = slot->task;
+		if (unlikely(!task || !task->lldd_task || !task->dev))
+			continue;
+		sas_task_abort(task);
+	}
+	spin_unlock(&sas_dev->lock);
+
+	return 0;
+}
+
 static int hisi_sas_query_task(struct sas_task *task)
 {
 	int rc = TMF_RESP_FUNC_FAILED;
@@ -2029,6 +2047,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_abort_task_set	= hisi_sas_abort_task_set,
 	.lldd_I_T_nexus_reset	= hisi_sas_I_T_nexus_reset,
 	.lldd_lu_reset		= hisi_sas_lu_reset,
+	.lldd_device_task_abort = hisi_sas_device_task_abort,
 	.lldd_query_task	= hisi_sas_query_task,
 	.lldd_clear_nexus_ha	= hisi_sas_clear_nexus_ha,
 	.lldd_port_formed	= hisi_sas_port_formed,
-- 
2.17.1

