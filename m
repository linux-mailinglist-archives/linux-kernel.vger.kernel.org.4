Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDCA60C8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiJYJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJYJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:51:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C9164BC2;
        Tue, 25 Oct 2022 02:49:08 -0700 (PDT)
Received: from frapeml100002.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRv53SC3z67yhg;
        Tue, 25 Oct 2022 17:47:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100002.china.huawei.com (7.182.85.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:49:06 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:49:02 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 17/22] scsi: libsas drivers: Reserve tags
Date:   Tue, 25 Oct 2022 18:18:11 +0800
Message-ID: <1666693096-180008-18-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Reserve 2x tags for libsas reserved tag handling, which should be
enough.

Continue to carve out a region of tags for driver internal management
until each sas_task always has a request.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c    | 1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 4 ++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 5 +++++
 drivers/scsi/isci/init.c               | 1 +
 drivers/scsi/mvsas/mv_init.c           | 5 +++++
 drivers/scsi/pm8001/pm8001_init.c      | 6 +++++-
 8 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 06c86d7a777a..70b735cedeb3 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -62,6 +62,7 @@ static struct scsi_host_template aic94xx_sht = {
 	.track_queue_depth	= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 54860d252466..fe2752d24fe8 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2442,6 +2442,10 @@ int hisi_sas_probe(struct platform_device *pdev,
 		shost->can_queue = HISI_SAS_MAX_COMMANDS;
 		shost->cmd_per_lun = HISI_SAS_MAX_COMMANDS;
 	} else {
+		/*
+		 * Intentionally use HISI_SAS_UNRESERVED_IPTT for .can_queue until
+		 * every sas_task we're sent has a request associated.
+		 */
 		shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
 		shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 	}
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 9f71cc72cd80..438e8a963782 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1762,6 +1762,7 @@ static struct scsi_host_template sht_v1_hw = {
 	.host_reset             = hisi_sas_host_reset,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 483a03ed6253..b733eb18864c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3580,6 +3580,7 @@ static struct scsi_host_template sht_v2_hw = {
 	.host_tagset		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 02d96fba510f..d703af7985b0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3247,6 +3247,7 @@ static struct scsi_host_template sht_v3_hw = {
 	.host_tagset		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
@@ -4859,6 +4860,10 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_lun = ~0;
 	shost->max_channel = 1;
 	shost->max_cmd_len = 16;
+	/*
+	 * Intentionally use HISI_SAS_UNRESERVED_IPTT for .can_queue until
+	 * every sas_task we're sent has a request associated.
+	 */
 	shost->can_queue = HISI_SAS_UNRESERVED_IPTT;
 	shost->cmd_per_lun = HISI_SAS_UNRESERVED_IPTT;
 
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 9c7869bf6cde..c07d89451bb6 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -179,6 +179,7 @@ static struct scsi_host_template isci_sht = {
 	.track_queue_depth		= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds	= 2,
 };
 
 static struct sas_domain_function_template isci_transport_ops  = {
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 7fed0259e1f5..07e6c5d6c46d 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -56,6 +56,7 @@ static struct scsi_host_template mvs_sht = {
 	.track_queue_depth	= 1,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 static struct sas_domain_function_template mvs_transport_ops = {
@@ -470,6 +471,10 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 	else
 		can_queue = MVS_CHIP_SLOT_SZ;
 
+	/*
+	 * Carve out MVS_RSVD_SLOTS slots internally until every sas_task we're sent
+	 * has a request associated.
+	 */
 	can_queue -= MVS_RSVD_SLOTS;
 
 	shost->sg_tablesize = min_t(u16, SG_ALL, MVS_MAX_SG);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ce9509792bc0..e37e8898afaa 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -125,6 +125,7 @@ static struct scsi_host_template pm8001_sht = {
 	.map_queues		= pm8001_map_queues,
 	.reserved_queuecommand = sas_queuecommand_internal,
 	.reserved_timedout = sas_internal_timeout,
+	.nr_reserved_cmds = 2,
 };
 
 /*
@@ -1214,7 +1215,10 @@ static int pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha)
 
 	max_out_io = pm8001_ha->main_cfg_tbl.pm80xx_tbl.max_out_io;
 	ccb_count = min_t(int, PM8001_MAX_CCB, max_out_io);
-
+	/*
+	 * Intentionally use ccb_count - PM8001_RESERVE_SLOT for .can_queue
+	 * until every sas_task we're sent has a request associated.
+	 */
 	shost->can_queue = ccb_count - PM8001_RESERVE_SLOT;
 
 	pm8001_ha->rsvd_tags = bitmap_zalloc(PM8001_RESERVE_SLOT, GFP_KERNEL);
-- 
2.35.3

