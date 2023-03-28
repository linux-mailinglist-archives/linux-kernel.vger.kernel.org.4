Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835F16CC229
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjC1Ofe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjC1Of0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40FD311;
        Tue, 28 Mar 2023 07:35:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PmBzl2ZVtz4f3pCS;
        Tue, 28 Mar 2023 22:35:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R8X+yJkk4bgFg--.7384S6;
        Tue, 28 Mar 2023 22:35:16 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/3] scsi: introduce 'blocked' sysfs api
Date:   Tue, 28 Mar 2023 22:34:41 +0800
Message-Id: <20230328143442.2684167-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230328143442.2684167-1-yebin@huaweicloud.com>
References: <20230328143442.2684167-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R8X+yJkk4bgFg--.7384S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kKw4DXF4UCFWUAw4Utwb_yoW5Jr1fpa
        98Ga45KrWUGr1Ig3ZI9r45Wa43Ww48G347Jay7Ww1rZFWrJF9rtaykGa45XFyrJr4fWrsF
        qF4qqry5CFW8ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUFD73DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Introduce 'blocked' sysfs api to control scsi host blocking IO.
Use this founction for test. Perhaps we can use this to do some fault
recovery or firmware upgrades, as long as the driver support is good,
it may be insensitive to the upper layer.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_sysfs.c | 32 ++++++++++++++++++++++++++++++++
 include/scsi/scsi_host.h  |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 903aa9de46e5..cad1981ab528 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -345,6 +345,37 @@ store_shost_eh_deadline(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store_shost_eh_deadline);
 
+static ssize_t
+store_shost_blocked(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	int err;
+	bool blocked;
+	struct Scsi_Host *shost = class_to_shost(dev);
+
+	err = kstrtobool(buf, &blocked);
+	if (err)
+		return err;
+
+	if (shost->host_blockio != blocked) {
+		shost->host_blockio = blocked;
+		if (!blocked)
+			scsi_run_host_queues(shost);
+	}
+
+	return count;
+}
+
+static ssize_t
+show_shost_blocked(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+
+	return snprintf(buf, 20, "%d\n", shost->host_blockio);
+}
+static DEVICE_ATTR(blocked, S_IRUGO | S_IWUSR,
+		   show_shost_blocked, store_shost_blocked);
+
 shost_rd_attr(unique_id, "%u\n");
 shost_rd_attr(cmd_per_lun, "%hd\n");
 shost_rd_attr(can_queue, "%d\n");
@@ -397,6 +428,7 @@ static struct attribute *scsi_sysfs_shost_attrs[] = {
 	&dev_attr_host_reset.attr,
 	&dev_attr_eh_deadline.attr,
 	&dev_attr_nr_hw_queues.attr,
+	&dev_attr_blocked.attr,
 	NULL
 };
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 587cc767bb67..3e916dbac1cb 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -659,6 +659,9 @@ struct Scsi_Host {
 	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
 	unsigned no_scsi2_lun_in_cdb:1;
 
+	/* True host will blocking IO */
+	unsigned host_blockio:1;
+
 	/*
 	 * Optional work queue to be utilized by the transport
 	 */
-- 
2.31.1

