Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3B5BE367
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiITKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiITKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:35:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEA74CF5;
        Tue, 20 Sep 2022 03:34:03 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MWyYN2gMQz6H73Y;
        Tue, 20 Sep 2022 18:32:56 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 12:33:58 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 11:33:55 +0100
From:   John Garry <john.garry@huawei.com>
To:     <damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <brking@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 3/6] scsi: core: Add scsi_get_dev()
Date:   Tue, 20 Sep 2022 18:27:07 +0800
Message-ID: <1663669630-21333-4-git-send-email-john.garry@huawei.com>
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

Add a function which allows use to alloc a sdev with configurable
device parent, and channel:id:lun.

This is useful for separating adding a scsi device into separate alloc
and scan steps.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_scan.c | 25 +++++++++++++++++++++++++
 include/scsi/scsi_host.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 3759b1a77504..fd15ddac01b6 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1988,3 +1988,28 @@ void scsi_forget_host(struct Scsi_Host *shost)
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
+	starget = scsi_alloc_target(parent, 0, id);
+	if (!starget)
+		goto out;
+
+	sdev = scsi_alloc_sdev(starget, 0, NULL);
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
index aa7b7496c93a..5142c7df7647 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -794,7 +794,10 @@ void scsi_host_busy_iter(struct Scsi_Host *,
 
 struct class_container;
 
+extern struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun);
+
 /*
+
  * DIF defines the exchange of protection information between
  * initiator and SBC block device.
  *
-- 
2.35.3

