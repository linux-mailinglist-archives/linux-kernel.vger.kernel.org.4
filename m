Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5C60C8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiJYJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJYJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:50:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78AA16021D;
        Tue, 25 Oct 2022 02:49:03 -0700 (PDT)
Received: from frapeml100003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtP2LpNz688Kc;
        Tue, 25 Oct 2022 17:47:09 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100003.china.huawei.com (7.182.85.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:49:02 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:57 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in port probe
Date:   Tue, 25 Oct 2022 18:18:10 +0800
Message-ID: <1666693096-180008-17-git-send-email-john.garry@huawei.com>
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

Currently the per-ata device sdev is allocated as part of the scsi target
scan, which is after the ata port probe.

However it is useful to have the sdev available in the port probe. As an
example of an advantage, if the request queue is available in the probe
(which it would be if the sdev is available), then it is possible to use
a SCSI cmnd for ATA internal commands. The benefit of this is then we can
put the ATA qc structure in the SCSI cmnd private data. It will also be
useful if we want to send ATA internal commands as requests.

Export scsi_target_reap() so that it can be used to put the extra
reference we get when allocating the sdev.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/ata/libata-eh.c   |  1 +
 drivers/ata/libata-scsi.c | 23 +++++++++--------------
 drivers/scsi/scsi_scan.c  |  1 +
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08e11bc312c2..1ed5b1b64792 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3446,6 +3446,7 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
 
 	ata_eh_detach_dev(dev);
 	ata_dev_init(dev);
+	ata_scsi_setup_sdev(dev);
 	ehc->did_probe_mask |= (1 << dev->devno);
 	ehc->i.action |= ATA_EH_RESET;
 	ehc->saved_xfer_mode[dev->devno] = 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index efdba852e363..476e0ef4bd29 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1109,7 +1109,12 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
 	if (dev->flags & ATA_DFLAG_TRUSTED)
 		sdev->security_supported = 1;
 
-	dev->sdev = sdev;
+	/*
+	 * Put extra reference which we get when allocating the starget
+	 * initially
+	 */
+	scsi_target_reap(scsi_target(sdev));
+
 	return 0;
 }
 
@@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
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
+			scsi_scan_target(&shost->shost_gendev, channel, id,
+					 0, SCSI_SCAN_INITIAL);
 		}
 	}
 
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index b795c138f2c1..da7bc14b030c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -598,6 +598,7 @@ void scsi_target_reap(struct scsi_target *starget)
 	BUG_ON(starget->state == STARGET_DEL);
 	scsi_target_reap_ref_put(starget);
 }
+EXPORT_SYMBOL_GPL(scsi_target_reap);
 
 /**
  * scsi_sanitize_inquiry_string - remove non-graphical chars from an
-- 
2.35.3

