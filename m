Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB335EBB31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiI0HLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiI0HLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:11:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B1A6C56;
        Tue, 27 Sep 2022 00:11:34 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mc9jQ55htz67L9G;
        Tue, 27 Sep 2022 15:09:30 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:11:32 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 08:11:29 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <yanaijie@huawei.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v5 1/7] scsi: libsas: Add sas_ata_device_link_abort()
Date:   Tue, 27 Sep 2022 15:04:52 +0800
Message-ID: <1664262298-239952-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
to call to initiate a link abort.

This will mark all outstanding QCs as failed and kick-off EH.

Note:
A "force reset" argument is added for drivers which require the ATA error
handling to always reset the device.

A driver may require this feature for when SATA device per-SCSI cmnd
resources are only released during reset for ATA EH. As such, we need an
option to force reset to be done, regardless of what any EH autopsy
decides.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 12 ++++++++++++
 include/scsi/sas_ata.h        |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d35c9296f738..bdffb6852dcf 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -861,6 +861,18 @@ void sas_ata_wait_eh(struct domain_device *dev)
 	ata_port_wait_eh(ap);
 }
 
+void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
+{
+	struct ata_port *ap = device->sata_dev.ap;
+	struct ata_link *link = &ap->link;
+
+	link->eh_info.err_mask |= AC_ERR_DEV;
+	if (force_reset)
+		link->eh_info.action |= ATA_EH_RESET;
+	ata_link_abort(link);
+}
+EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
+
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
 {
 	struct sas_tmf_task tmf_task = {};
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index a1df4f9d57a3..e47f0aec0722 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -32,6 +32,7 @@ void sas_probe_sata(struct asd_sas_port *port);
 void sas_suspend_sata(struct asd_sas_port *port);
 void sas_resume_sata(struct asd_sas_port *port);
 void sas_ata_end_eh(struct ata_port *ap);
+void sas_ata_device_link_abort(struct domain_device *dev, bool force_reset);
 int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 			int force_phy_id);
 int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
@@ -87,6 +88,11 @@ static inline void sas_ata_end_eh(struct ata_port *ap)
 {
 }
 
+static inline void sas_ata_device_link_abort(struct domain_device *dev,
+					     bool force_reset)
+{
+}
+
 static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
 				      int force_phy_id)
 {
-- 
2.35.3

