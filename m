Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5660C8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiJYJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJYJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D1110B0E;
        Tue, 25 Oct 2022 02:48:04 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRqL71Xnz6893Q;
        Tue, 25 Oct 2022 17:44:30 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:00 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:47:57 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 02/22] scsi: core: Add scsi_get_dev()
Date:   Tue, 25 Oct 2022 18:17:56 +0800
Message-ID: <1666693096-180008-3-git-send-email-john.garry@huawei.com>
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

Add a function which allows us to alloc a sdev with configurable
device parent, and channel:id:lun

This is useful for separating adding a scsi device into separate alloc
and scan steps

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_scan.c | 25 +++++++++++++++++++++++++
 include/scsi/scsi_host.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 5d27f5196de6..ad0a5902d1a0 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1979,3 +1979,28 @@ void scsi_forget_host(struct Scsi_Host *shost)
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
+struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun)
+{
+	struct Scsi_Host *shost = dev_to_shost(parent);
+	struct scsi_device *sdev = NULL;
+	struct scsi_target *starget;
+
+	mutex_lock(&shost->scan_mutex);
+	if (!scsi_host_scan_allowed(shost))
+		goto out;
+
+	starget = scsi_alloc_target(parent, channel, id);
+	if (!starget)
+		goto out;
+
+	sdev = scsi_alloc_sdev(starget, lun, NULL);
+	if (sdev)
+		sdev->borken = 0;
+	else
+		scsi_target_reap(starget);
+	put_device(&starget->dev);
+ out:
+	mutex_unlock(&shost->scan_mutex);
+	return sdev;
+}
+EXPORT_SYMBOL(scsi_get_dev);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index e71436183c0d..750ccf126377 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -787,6 +787,10 @@ void scsi_host_busy_iter(struct Scsi_Host *,
 
 struct class_container;
 
+
+extern struct scsi_device *scsi_get_dev(struct device *parent, int channel,
+					uint id, u64 lun);
+
 /*
  * DIF defines the exchange of protection information between
  * initiator and SBC block device.
-- 
2.35.3

