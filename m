Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548A6C6756
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCWL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:57:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219DA3609B;
        Thu, 23 Mar 2023 04:56:57 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pj3fh1zJ9zLFXB;
        Thu, 23 Mar 2023 19:54:36 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:56:53 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <haowenchao2@huawei.com>
Subject: [PATCH 1/5] scsi:scsi_debug: Add sysfs interface to manage scsi devices' error injection
Date:   Thu, 23 Mar 2023 19:55:57 +0800
Message-ID: <20230323115601.178494-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230323115601.178494-1-haowenchao2@huawei.com>
References: <20230323115601.178494-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface "/sys/class/scsi_device/<hctl>/device/error_inject/error" to
manage scsi_device's error injection rules. Write it to add/remove an error
injection rule, read it to get error injection rules.

The interface format is line-by-line, each line is an error injection rule.
Each rule contains integers separated by spaces, first three columns are
fixed to "Error code", "Error count" and "SCSI command", other columns
depend on error code.

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error code                                            |
  |        |      |  0: timeout SCSI command                              |
  |        |      |  1: fail queuecommand, make queuecommand return       |
  |        |      |     specific value                                    |
  |        |      |  2: fail command, finish command with specific status |
  |        |      |     and sense date                                    |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: the rule would not take effect                    |
  |        |      |  positive: the rule would always take effect          |
  |        |      |  negative: the rule take effect for the absolute of   |
  |        |      |            this value                                 |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+
  |  ...   |  xxx | Error type specific fields                            |
  +--------+------+-------------------------------------------------------+

- When multiple error injects are added to one scsi command, the one
  with smaller error code would take effect.
- If an same error is added to one device, old one would be overwritten.
- Currently, basic types are (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal
  types (x8/x16/x32/x64)

Timeout SCSI command:

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x0                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: the rule would not take effect                    |
  |        |      |  positive: the rule would always take effect          |
  |        |      |  negative: the rule take effect for the absolute of   |
  |        |      |            this value                                 |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+

  Examples:
    error=/sys/class/scsi_device/0:0:0:1/device/error_inject/error
    echo "0 -10 0x12" > $error
  would make the device's inquiry command timeout for 10 time.
    error=/sys/class/scsi_device/0:0:0:1/device/error_inject/error
    echo "0 1 0x12" > $error
  would make the device's inquiry timeout forever.

Make queuecommand return specific value:

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x1                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: the rule would not take effect                    |
  |        |      |  positive: the rule would always take effect          |
  |        |      |  negative: the rule take effect for the absolute of   |
  |        |      |            this value                                 |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+
  |   4    |  x32 | The return value of queuecommand we desired           |
  +--------+------+-------------------------------------------------------+

  Examples:
    error=/sys/class/scsi_device/0:0:0:1/device/error_inject/error
    echo "1 1 0x12 0x1055" > $error
  would make device's inquiry command return 0x1055(SCSI_MLQUEUE_HOST_BUSY)
  forever.

Set scsi_cmd's status and sense data to specific value:

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x2                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: the rule would not take effect                    |
  |        |      |  positive: the rule would always take effect          |
  |        |      |  negative: the rule take effect for the absolute of   |
  |        |      |            this value                                 |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command this rule is for, 0xff for all command   |
  +--------+------+-------------------------------------------------------+
  |   4    |  x8  | Host byte in scsi_cmd's status                        |
  +--------+------+-------------------------------------------------------+
  |   5    |  x8  | Driver byte in scsi_cmd's status                      |
  +--------+------+-------------------------------------------------------+
  |   6    |  x8  | Status byte in scsi_cmd's status                      |
  +--------+------+-------------------------------------------------------+
  |   7    |  x8  | Sense Key of scsi_cmnd                                |
  +--------+------+-------------------------------------------------------+
  |   8    |  x8  | ASC of scsi_cmnd                                      |
  +--------+------+-------------------------------------------------------+
  |   9    |  x8  | ASQ of scsi_cmnd                                      |
  +--------+------+-------------------------------------------------------+

  Examples:
    error=/sys/class/scsi_device/0:0:0:1/device/error_inject/error
    echo "2 -10 0x88 0 0 0x2 0x3 0x11 0x0" >$error
  would make device's read command return with media error UNC:

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 161 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7ed117e78bd4..8cfa19f8b034 100644
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
@@ -305,6 +340,8 @@ struct sdebug_dev_info {
 	unsigned int max_open;
 	ktime_t create_ts;	/* time since bootup that this device was created */
 	struct sdeb_zone_state *zstate;
+
+	struct list_head inject_err_list;
 };
 
 struct sdebug_host_info {
@@ -5152,6 +5189,7 @@ static struct sdebug_dev_info *sdebug_device_create(
 		}
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
+		INIT_LIST_HEAD(&devip->inject_err_list);
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
 	}
 	return devip;
@@ -7553,6 +7591,128 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
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
@@ -7732,6 +7892,7 @@ static struct scsi_host_template sdebug_driver_template = {
 	.ioctl =		scsi_debug_ioctl,
 	.queuecommand =		scsi_debug_queuecommand,
 	.change_queue_depth =	sdebug_change_qdepth,
+	.sdev_groups =		sdebug_sdev_groups,
 	.map_queues =		sdebug_map_queues,
 	.mq_poll =		sdebug_blk_mq_poll,
 	.eh_abort_handler =	scsi_debug_abort,
-- 
2.35.3

