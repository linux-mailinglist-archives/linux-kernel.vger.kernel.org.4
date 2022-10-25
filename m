Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC660C999
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJYKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiJYKKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:10:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CF1211C5;
        Tue, 25 Oct 2022 03:03:27 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxSC12RFXz6H73T;
        Tue, 25 Oct 2022 18:01:33 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:03:26 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:03:22 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 3/7] ata: libata: Make space for ATA queue command in scmd payload
Date:   Tue, 25 Oct 2022 18:32:52 +0800
Message-ID: <1666693976-181094-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to put the ATA queue command in a scmd payload by using priv
space per driver which uses libata.

The end goal is to remove ata_port.qcmd[].

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-scsi.c              | 6 ++++++
 drivers/scsi/aic94xx/aic94xx_init.c    | 2 ++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 2 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 ++
 drivers/scsi/isci/init.c               | 2 ++
 drivers/scsi/mvsas/mv_init.c           | 2 ++
 drivers/scsi/pm8001/pm8001_init.c      | 2 ++
 include/linux/libata.h                 | 5 ++++-
 9 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d6f37d80137..18c60addf943 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1118,6 +1118,12 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	return 0;
 }
 
+int ata_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_init_cmd_priv);
+
 int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 {
 	struct ata_port *ap;
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 70b735cedeb3..e2c99c74f73e 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -63,6 +63,8 @@ static struct scsi_host_template aic94xx_sht = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 438e8a963782..aec13a46de6e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1763,6 +1763,8 @@ static struct scsi_host_template sht_v1_hw = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b733eb18864c..cb057b3a84ac 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3581,6 +3581,8 @@ static struct scsi_host_template sht_v2_hw = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d703af7985b0..4caf07306b24 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3248,6 +3248,8 @@ static struct scsi_host_template sht_v3_hw = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index c07d89451bb6..0d0b8ef71c65 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -180,6 +180,8 @@ static struct scsi_host_template isci_sht = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds	= 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static struct sas_domain_function_template isci_transport_ops  = {
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 07e6c5d6c46d..e1b6cc196cef 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -57,6 +57,8 @@ static struct scsi_host_template mvs_sht = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 static struct sas_domain_function_template mvs_transport_ops = {
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index e37e8898afaa..fe55cc9765ae 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -126,6 +126,8 @@ static struct scsi_host_template pm8001_sht = {
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
 	.nr_reserved_cmds = 2,
+	.init_cmd_priv = ata_init_cmd_priv,
+	.cmd_size = sizeof(struct ata_queued_cmd),
 };
 
 /*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f09c5dca16ce..1a03c7fbb4e6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1143,6 +1143,7 @@ extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
 extern int ata_internal_queuecommand(struct Scsi_Host *shost,
 				struct scsi_cmnd *scmd);
+extern int ata_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
 extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
@@ -1394,7 +1395,9 @@ extern const struct attribute_group *ata_common_sdev_groups[];
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
 	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
-	.reserved_queuecommand = ata_internal_queuecommand
+	.reserved_queuecommand = ata_internal_queuecommand,\
+	.cmd_size = sizeof(struct ata_queued_cmd),\
+	.init_cmd_priv = ata_init_cmd_priv
 
 #define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
-- 
2.35.3

