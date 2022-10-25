Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6C60C8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiJYJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:50:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606F134A83;
        Tue, 25 Oct 2022 02:48:59 -0700 (PDT)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtw68SCz689QR;
        Tue, 25 Oct 2022 17:47:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:57 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:53 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 15/22] scsi: libsas: Add sas_ata_setup_device()
Date:   Tue, 25 Oct 2022 18:18:09 +0800
Message-ID: <1666693096-180008-16-git-send-email-john.garry@huawei.com>
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

Add a function which does a custom sdev alloc - essentially replicates
what we do in sas_rphy_add() in terms of sdev parent and id.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 78e6046fb55a..a46a2d345422 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -523,6 +523,25 @@ static int sas_ata_prereset(struct ata_link *link, unsigned long deadline)
 	return res;
 }
 
+static int sas_ata_setup_device(struct ata_device *dev)
+{
+	u64 lun = 0;
+	int channel = 0;
+	struct ata_link *link = dev->link;
+	struct ata_port *ap = link->ap;
+	struct scsi_device *sdev;
+	struct domain_device *ddev = ap->private_data;
+	struct sas_rphy *rphy = ddev->rphy;
+	struct device *parent = &rphy->dev;
+	uint id = rphy->scsi_target_id;
+
+	sdev = scsi_get_dev(parent, channel, id, lun);
+	if (!sdev)
+		return -ENODEV;
+	dev->sdev = sdev;
+	return 0;
+}
+
 static struct ata_port_operations sas_sata_ops = {
 	.prereset		= sas_ata_prereset,
 	.hardreset		= sas_ata_hard_reset,
@@ -537,6 +556,7 @@ static struct ata_port_operations sas_sata_ops = {
 	.set_dmamode		= sas_ata_set_dmamode,
 	.sched_eh		= sas_ata_sched_eh,
 	.end_eh			= sas_ata_end_eh,
+	.setup_scsi_device	= sas_ata_setup_device,
 };
 
 static struct ata_port_info sata_port_info = {
-- 
2.35.3

