Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF5A62220B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKICn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKICnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:43:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8810FD15;
        Tue,  8 Nov 2022 18:43:49 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6Tmq19Y9zRp7Q;
        Wed,  9 Nov 2022 10:43:39 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:43:47 +0800
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
Subject: [RFC PATCH 1/5] scsi:scsi_debug: Add sysfs interface to manager single devices' error inject
Date:   Wed, 9 Nov 2022 10:59:46 -0500
Message-ID: <20221109155950.3536976-2-haowenchao@huawei.com>
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

Add interface "/sys/block/sdX/device/error_inject/error" which is
readable and writable. Write this file to add new error injection,
read it to get the error injection info which has been added.

You can add error inject to specific scsi device's specific scsi
command. And you can inject different error for one scsi command.
When multiple error injects are added to one scsi command, the one
with smaller error code would take effect.

The format is line-by-line integer separated by spaces. The first two
integer has a fixed meaning which are "error code" and "error count".

Each error code is an unsigned integer which is 1 bytes length. It
stands for which type of error to inject. Now I defined 3 error types:
  - 0: timeout specific SCSI command
  - 1: make queuecommand return specific value
  - 2: set scsi_cmd's status or sense data to specific value

Error cnt stands for how many times this inject rules would take effect.
a positive value means this rule would always take effect;
a negative value means this rule would take effect for the absolute
value of this error count;
0 means this rule would not take effect

Timeout specific SCSI command format

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  s32 | Error type, fixed to 0x0                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: this rule would not take effect                   |
  |        |      |  positive: this rule would always take effect         |
  |        |      |  negative: take effect for the absolute of this value |
  +--------+------+-------------------------------------------------------+
  |   3    |  u8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+

  the following command make sdb's inquiry timeout for 10 time:
    echo "0 -10 0x12" > /sys/block/sdb/device/error_inject/error
  the following command make sdb's inquiry timeout forever:
    echo "0 1 0x12" > /sys/block/sdb/device/error_inject/error

Make queuecommand return specific value

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  s32 | Error type, fixed to 0x1                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: this rule would not take effect                   |
  |        |      |  positive: this rule would always take effect         |
  |        |      |  negative: take effect for the absolute of this value |
  +--------+------+-------------------------------------------------------+
  |   3    |  u8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+
  |   4    |  s32 | The return value of queuecommand we desired           |
  +--------+------+-------------------------------------------------------+

  for example the following command make sdb's inquiry command return
  0x1055(SCSI_MLQUEUE_HOST_BUSY) forever:
    echo "1 1 0x12 0x1055" >/sys/block/sdb/device/error_inject/error

Set scsi_cmd's status and sense data to specific value

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  s32 | Error type, fixed to 0x2                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: this rule would not take effect                   |
  |        |      |  positive: this rule would always take effect         |
  |        |      |  negative: take effect for the absolute of this value |
  +--------+------+-------------------------------------------------------+
  |   3    |  u8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+
  |   4    |  u8  | Host byte in scsi_cmd's status                        |
  +--------+------+-------------------------------------------------------+
  |   5    |  u8  | Driver byte in scsi_cmd's status                      |
  +--------+------+-------------------------------------------------------+
  |   6    |  u8  | Status byte in scsi_cmd's status                      |
  +--------+------+-------------------------------------------------------+
  |   7    |  u8  | Sense Key of scsi_cmnd                                |
  +--------+------+-------------------------------------------------------+
  |   8    |  u8  | ASC of scsi_cmnd                                      |
  +--------+------+-------------------------------------------------------+
  |   9    |  u8  | ASQ of scsi_cmnd                                      |
  +--------+------+-------------------------------------------------------+

  for example the following means make sdb's read command return with
  media error UNC:
    error=/sys/block/sdb/device/error_inject/error
    echo "2 -10 0x88 0 0 0x2 0x3 0x11 0x0" >$error

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_debug.c | 161 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 697fc57bc711..0cdc9599b628 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -280,6 +280,41 @@ struct sdeb_zone_state {	/* ZBC: per zone state */
 	sector_t z_wp;
 };
 
+enum sdebug_err_type {
+	ERR_TMOUT_CMD		= 0,	/* make specific scsi command timeout */
+	ERR_FAIL_QUEUE_CMD	= 1,	/* make specific scsi command's */
+					/* queuecmd return failed */
+	ERR_FAIL_CMD		= 2,	/* make specific scsi command's */
+					/* queuecmd return succeed but */
+					/* with errors set in scsi_cmnd */
+};
+
+struct sdebug_err_inject {
+	int type;
+	struct list_head list;
+	int cnt;
+	unsigned char cmd;
+
+	union {
+		/*
+		 * For ERR_FAIL_QUEUE_CMD
+		 */
+		int queuecmd_ret;
+
+		/*
+		 * For ERR_FAIL_CMD
+		 */
+		struct {
+			unsigned char host_byte;
+			unsigned char driver_byte;
+			unsigned char status_byte;
+			unsigned char sense_key;
+			unsigned char asc;
+			unsigned char asq;
+		};
+	};
+};
+
 struct sdebug_dev_info {
 	struct list_head dev_list;
 	unsigned int channel;
@@ -306,6 +341,8 @@ struct sdebug_dev_info {
 	unsigned int max_open;
 	ktime_t create_ts;	/* time since bootup that this device was created */
 	struct sdeb_zone_state *zstate;
+
+	struct list_head inject_err_list;
 };
 
 struct sdebug_host_info {
@@ -5150,6 +5187,7 @@ static struct sdebug_dev_info *sdebug_device_create(
 		devip->sdbg_host = sdbg_host;
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
+		INIT_LIST_HEAD(&devip->inject_err_list);
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
 	}
 	return devip;
@@ -7597,6 +7635,128 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	return num_entries;
 }
 
+static void sdebug_err_add(struct device *dev, struct sdebug_err_inject *new)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *tmp, *err;
+
+	list_for_each_entry_safe(err, tmp, &devip->inject_err_list, list) {
+		if (err->type == new->type && err->cmd == new->cmd) {
+			sdev_printk(KERN_INFO, sdev, "Substituted %d 0x%x\n",
+				err->type, err->cmd);
+			list_del(&err->list);
+			kfree(err);
+		}
+	}
+
+	list_add_tail(&new->list, &devip->inject_err_list);
+}
+
+static ssize_t error_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int tmp, ret = 0;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *err;
+
+	tmp = sysfs_emit_at(buf, ret, "Type\tCount\tCommand\n");
+	ret += tmp;
+
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		switch (err->type) {
+		case ERR_TMOUT_CMD:
+			tmp = sysfs_emit_at(buf, ret, "%d\t%d\t0x%x\n",
+				err->type, err->cnt, err->cmd);
+			ret += tmp;
+		break;
+
+		case ERR_FAIL_QUEUE_CMD:
+			tmp = sysfs_emit_at(buf, ret, "%d\t%d\t0x%x\t0x%x\n",
+				err->type, err->cnt, err->cmd, err->queuecmd_ret);
+			ret += tmp;
+		break;
+
+		case ERR_FAIL_CMD:
+			tmp = sysfs_emit_at(buf, ret,
+				"%d\t%d\t0x%x\t0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+				err->type, err->cnt, err->cmd,
+				err->host_byte, err->driver_byte,
+				err->status_byte, err->sense_key,
+				err->asc, err->asq);
+			ret += tmp;
+		break;
+		}
+	}
+
+	return ret;
+}
+static ssize_t error_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	unsigned int inject_type;
+	struct sdebug_err_inject *inject;
+
+	if (sscanf(buf, "%d", &inject_type) != 1)
+		return -EINVAL;
+
+	inject = kzalloc(sizeof(struct sdebug_err_inject), GFP_KERNEL);
+	if (!inject)
+		return -ENOMEM;
+
+	switch (inject_type) {
+	case ERR_TMOUT_CMD:
+		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
+			   &inject->cmd) != 3)
+			goto out_error;
+	break;
+
+	case ERR_FAIL_QUEUE_CMD:
+		if (sscanf(buf, "%d %d %hhx %x", &inject->type, &inject->cnt,
+			   &inject->cmd, &inject->queuecmd_ret) != 4)
+			goto out_error;
+	break;
+
+	case ERR_FAIL_CMD:
+		if (sscanf(buf, "%d %d %hhx %hhx %hhx %hhx %hhx %hhx %hhx",
+			   &inject->type, &inject->cnt, &inject->cmd,
+			   &inject->host_byte, &inject->driver_byte,
+			   &inject->status_byte, &inject->sense_key,
+			   &inject->asc, &inject->asq) != 9)
+			goto out_error;
+	break;
+
+	default:
+		goto out_error;
+	break;
+	}
+
+	sdebug_err_add(dev, inject);
+
+	return count;
+
+out_error:
+	kfree(inject);
+	return -EINVAL;
+}
+static DEVICE_ATTR_RW(error);
+
+static struct attribute *sdebug_sdev_attrs[] = {
+	&dev_attr_error.attr,
+	NULL
+};
+
+static const struct attribute_group sdebug_sdev_attr_group = {
+	.name = "error_inject",
+	.attrs = sdebug_sdev_attrs,
+};
+
+const struct attribute_group *sdebug_sdev_groups[] = {
+	&sdebug_sdev_attr_group,
+	NULL
+};
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7776,6 +7936,7 @@ static struct scsi_host_template sdebug_driver_template = {
 	.ioctl =		scsi_debug_ioctl,
 	.queuecommand =		scsi_debug_queuecommand,
 	.change_queue_depth =	sdebug_change_qdepth,
+	.sdev_groups =		sdebug_sdev_groups,
 	.map_queues =		sdebug_map_queues,
 	.mq_poll =		sdebug_blk_mq_poll,
 	.eh_abort_handler =	scsi_debug_abort,
-- 
2.35.3

