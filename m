Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E94652E98
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiLUJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiLUJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:31:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91E8FCC;
        Wed, 21 Dec 2022 01:31:49 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NcSq33Lm7zmWfc;
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
Subject: [PATCH v3 1/3] scsi: libsas: Add sas_device_task_abort()
Date:   Wed, 21 Dec 2022 09:25:12 +0000
Message-ID: <20221221092514.4091-2-yangxingui@huawei.com>
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

Add support for abort all active IOs for device, and define a LLDD
interface lldd_device_task_abort for LLDD to implement.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 9 +++++++++
 include/scsi/libsas.h               | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index a36fa1c128a8..4ac7cffcbada 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -1230,6 +1230,15 @@ void sas_task_abort(struct sas_task *task)
 }
 EXPORT_SYMBOL_GPL(sas_task_abort);
 
+void sas_device_task_abort(struct domain_device *dev)
+{
+	struct sas_internal *i =
+		to_sas_internal(dev->port->ha->core.shost->transportt);
+	if (i->dft->lldd_device_task_abort)
+		i->dft->lldd_device_task_abort(dev);
+}
+EXPORT_SYMBOL_GPL(sas_device_task_abort);
+
 int sas_slave_alloc(struct scsi_device *sdev)
 {
 	if (dev_is_sata(sdev_to_domain_dev(sdev)) && sdev->lun)
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 1aee3d0ebbb2..1bf1cfb13912 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -678,6 +678,7 @@ struct sas_domain_function_template {
 	int (*lldd_abort_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_clear_task_set)(struct domain_device *, u8 *lun);
 	int (*lldd_I_T_nexus_reset)(struct domain_device *);
+	int (*lldd_device_task_abort)(struct domain_device *dev);
 	int (*lldd_ata_check_ready)(struct domain_device *);
 	void (*lldd_ata_set_dmamode)(struct domain_device *);
 	int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
@@ -743,6 +744,7 @@ void sas_unregister_dev(struct asd_sas_port *port, struct domain_device *);
 void sas_init_dev(struct domain_device *);
 
 void sas_task_abort(struct sas_task *);
+void sas_device_task_abort(struct domain_device *dev);
 int sas_eh_abort_handler(struct scsi_cmnd *cmd);
 int sas_eh_device_reset_handler(struct scsi_cmnd *cmd);
 int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
-- 
2.17.1

