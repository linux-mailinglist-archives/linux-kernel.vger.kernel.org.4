Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502062220C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKICoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKICnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:43:51 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F81005F;
        Tue,  8 Nov 2022 18:43:50 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6Tmm3MyBz15MTw;
        Wed,  9 Nov 2022 10:43:36 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:43:48 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:43:47 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [RFC PATCH 2/5] scsi:scsi_debug: Add interface to remove injection which has been added
Date:   Wed, 9 Nov 2022 10:59:47 -0500
Message-ID: <20221109155950.3536976-3-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221109155950.3536976-1-haowenchao@huawei.com>
References: <20221109155950.3536976-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal interface is still "/sys/block/sdX/device/error_inect/error".
The format is still line-by-line integer separated by spaces with fixed 3
column.
  first column is "-", which tells this is a removal operation;
  second column is error code;
  third column is the scsi command.

For example the following command would remove timeout injection of
inquiry command.

  echo "- 0 0x12" > /sys/block/sdb/device/error_inect/error

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_debug.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 0cdc9599b628..06e3150812fa 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7653,6 +7653,30 @@ static void sdebug_err_add(struct device *dev, struct sdebug_err_inject *new)
 	list_add_tail(&new->list, &devip->inject_err_list);
 }
 
+static int sdebug_err_remove(struct device *dev, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *tmp, *err;
+	int type;
+	unsigned char cmd;
+
+	if (sscanf(buf, "- %d %hhx", &type, &cmd) != 2)
+		return -EINVAL;
+
+	list_for_each_entry_safe(err, tmp, &devip->inject_err_list, list) {
+		if (err->type == type && err->cmd == cmd) {
+			sdev_printk(KERN_INFO, sdev, "Remove %d 0x%x\n",
+				err->type, err->cmd);
+			list_del(&err->list);
+			kfree(err);
+			return count;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static ssize_t error_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -7698,6 +7722,9 @@ static ssize_t error_store(struct device *dev, struct device_attribute *attr,
 	unsigned int inject_type;
 	struct sdebug_err_inject *inject;
 
+	if (buf[0] == '-')
+		return sdebug_err_remove(dev, buf, count);
+
 	if (sscanf(buf, "%d", &inject_type) != 1)
 		return -EINVAL;
 
-- 
2.35.3

