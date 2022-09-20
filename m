Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676D05BE368
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiITKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiITKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:35:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293CB719AD;
        Tue, 20 Sep 2022 03:34:09 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MWyYY1Khnz6873f;
        Tue, 20 Sep 2022 18:33:05 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 12:34:07 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 11:34:04 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <brking@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 6/6] ata: libata-scsi: Allocate sdev early in port probe
Date:   Tue, 20 Sep 2022 18:27:10 +0800
Message-ID: <1663669630-21333-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Currently the per-ata device sdev is allocated as part of the scsi target
scan, which is after the ata port probe.

However it is useful to have the sdev available in the port probe. As an
example of an advantage, if the request queue is available in the probe
(which it would be if the sdev is available), then it is possible to use
a SCSI cmnd for ATA internal commands. The benefit of this is then we can
put the ATA qc structure in the SCSI cmnd private data. It will also be
useful if we want to send ATA internal commands as requests.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-eh.c   |  4 ++++
 drivers/ata/libata-scsi.c | 20 ++++++--------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..35375873a464 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2971,6 +2971,10 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			 */
 			dev->class = ehc->classes[dev->devno];
 
+			rc = ata_scsi_setup_sdev(dev);
+			if (rc)
+				goto err;
+
 			if (dev->class == ATA_DEV_PMP)
 				rc = sata_pmp_attach(dev);
 			else
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 88f39ab10a92..0e26860a82e2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1111,7 +1111,9 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	if (dev->flags & ATA_DFLAG_TRUSTED)
 		sdev->security_supported = 1;
 
-	dev->sdev = sdev;
+	/* Put extra reference which we get when allocating the starget initially */
+	scsi_target_reap(scsi_target(sdev));
+
 	return 0;
 }
 
@@ -4279,6 +4281,7 @@ int ata_scsi_setup_sdev(struct ata_device *dev)
 	if (!sdev)
 		return -ENODEV;
 	dev->sdev = sdev;
+	ata_scsi_assign_ofnode(dev, ap);
 	return 0;
 }
 
@@ -4292,26 +4295,15 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
  repeat:
 	ata_for_each_link(link, ap, EDGE) {
 		ata_for_each_dev(dev, link, ENABLED) {
-			struct scsi_device *sdev;
+			struct Scsi_Host *shost = ap->scsi_host;
 			int channel = 0, id = 0;
 
-			if (dev->sdev)
-				continue;
-
 			if (ata_is_host_link(link))
 				id = dev->devno;
 			else
 				channel = link->pmp;
 
-			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
-						 NULL);
-			if (!IS_ERR(sdev)) {
-				dev->sdev = sdev;
-				ata_scsi_assign_ofnode(dev, ap);
-				scsi_device_put(sdev);
-			} else {
-				dev->sdev = NULL;
-			}
+			scsi_scan_target(&shost->shost_gendev, channel, id, 0, SCSI_SCAN_INITIAL);
 		}
 	}
 
-- 
2.35.3

