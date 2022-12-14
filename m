Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEF64C445
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiLNHJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiLNHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:09:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322E363F8;
        Tue, 13 Dec 2022 23:09:14 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NX5zv6LrkzRpxP;
        Wed, 14 Dec 2022 15:08:11 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 15:09:12 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 1/2] scsi:core:Add sysfs interface to control if skip lun with PQ=1
Date:   Wed, 14 Dec 2022 15:08:45 +0800
Message-ID: <20221214070846.1808300-2-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221214070846.1808300-1-haowenchao@huawei.com>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 948e922fc4461 ("scsi: core: map PQ=1, PDT=other values to
SCSI_SCAN_TARGET_PRESENT") returns SCSI_SCAN_TARGET_PRESENT if inquiry
returns PQ=1.

According to the SPC, PQ=1 means the addressed logical unit having the
indicated device type is not accessible, it does not mean the addressed
logical unit is invalid. We still can map this lun to an sg device.

In some conditions, we do not want to skip these devices, for example
with iSCSI:

When iSCSI initiator logged in target, the target attached none valid
lun but lun0. lun0 is not an valid disk, while it would response
inquiry command with PQ=1 and other general scsi commands like probe lun.
The others luns of target is added/removed dynamicly.

We want the lun0 to be mapped to an sg device in initiator, so we can
probe luns of target based on lun0.

I add an sysfs interface named no_skip_pq1 in each Scsi_Host to
control if to skip lun which return PQ=1 for inquiry.

The default behavior is not changed, which means we would still skip
add lun if inquiry returns PQ=1. We can set host's no_skip_pq1  in
specific drivers or via sysfs.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_scan.c  |  9 ++++++---
 drivers/scsi/scsi_sysfs.c | 29 +++++++++++++++++++++++++++++
 include/scsi/scsi_host.h  |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 920b145f80b7..bd4faaabee8c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1233,10 +1233,13 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	 * that no LUN is present, so don't add sdev in these cases.
 	 * Two specific examples are:
 	 * 1) NetApp targets: return PQ=1, PDT=0x1f
-	 * 2) IBM/2145 targets: return PQ=1, PDT=0
-	 * 3) USB UFI: returns PDT=0x1f, with the PQ bits being "reserved"
+	 * 2) USB UFI: returns PDT=0x1f, with the PQ bits being "reserved"
 	 *    in the UFI 1.0 spec (we cannot rely on reserved bits).
 	 *
+	 * Targets set PQ=1 would be skipped if shost->no_skip_pq1 is not set
+	 * For example:
+	 * 1) IBM/2145 targets: return PQ=1, PDT=0
+	 *
 	 * References:
 	 * 1) SCSI SPC-3, pp. 145-146
 	 * PQ=1: "A peripheral device having the specified peripheral
@@ -1248,7 +1251,7 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	 * PDT=00h Direct-access device (floppy)
 	 * PDT=1Fh none (no FDD connected to the requested logical unit)
 	 */
-	if (((result[0] >> 5) == 1 ||
+	if ((((result[0] >> 5) == 1 && !shost->no_skip_pq1) ||
 	    (starget->pdt_1f_for_no_lun && (result[0] & 0x1f) == 0x1f)) &&
 	    !scsi_is_wlun(lun)) {
 		SCSI_LOG_SCAN_BUS(3, sdev_printk(KERN_INFO, sdev,
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index f2a345cc0f8a..a72466c7e3c4 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -369,6 +369,34 @@ store_shost_eh_deadline(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(eh_deadline, S_IRUGO | S_IWUSR, show_shost_eh_deadline, store_shost_eh_deadline);
 
+static ssize_t
+show_no_skip_pq1(struct device *dev,
+		      struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+
+	return sysfs_emit(buf, "%s\n", shost->no_skip_pq1 ? "Y" : "N");
+}
+
+static ssize_t
+store_no_skip_pq1(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	int ret = -EINVAL;
+	bool store_val;
+
+	ret = kstrtobool(buf, &store_val);
+	if (ret)
+		return ret;
+
+	shost->no_skip_pq1 = store_val;
+
+	return count;
+}
+
+static DEVICE_ATTR(no_skip_pq1, S_IRUGO | S_IWUSR, show_no_skip_pq1, store_no_skip_pq1);
+
 shost_rd_attr(unique_id, "%u\n");
 shost_rd_attr(cmd_per_lun, "%hd\n");
 shost_rd_attr(can_queue, "%d\n");
@@ -421,6 +449,7 @@ static struct attribute *scsi_sysfs_shost_attrs[] = {
 	&dev_attr_host_reset.attr,
 	&dev_attr_eh_deadline.attr,
 	&dev_attr_nr_hw_queues.attr,
+	&dev_attr_no_skip_pq1.attr,
 	NULL
 };
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 587cc767bb67..56bb11d9a886 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -659,6 +659,9 @@ struct Scsi_Host {
 	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
 	unsigned no_scsi2_lun_in_cdb:1;
 
+	/* Do not skip adding lun if inquiry command returns PQ == 1 */
+	unsigned no_skip_pq1:1;
+
 	/*
 	 * Optional work queue to be utilized by the transport
 	 */
-- 
2.32.0

