Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685FC6F0589
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbjD0MNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243814AbjD0MMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:12:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200505275;
        Thu, 27 Apr 2023 05:12:18 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6ZLn4PhfzsR5H;
        Thu, 27 Apr 2023 20:10:25 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 20:12:03 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v2 2/6] scsi:scsi_debug: Add interface to manage single device's error inject
Date:   Fri, 28 Apr 2023 09:33:16 +0800
Message-ID: <20230428013320.347050-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230428013320.347050-1-haowenchao2@huawei.com>
References: <20230428013320.347050-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface "/sys/kernel/debug/scsi_debug/<h:c:t:l>/error" to
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
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "0 -10 0x12" > $error
  would make the device's inquiry command timeout for 10 time.
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
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
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
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
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "2 -10 0x88 0 0 0x2 0x3 0x11 0x0" >$error
  would make device's read command return with media error UNC:

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 174 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d4bf67f52fbb..1d19a2f1f5f2 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -286,6 +286,41 @@ struct sdeb_zone_state {	/* ZBC: per zone state */
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
@@ -311,6 +346,9 @@ struct sdebug_dev_info {
 	unsigned int max_open;
 	ktime_t create_ts;	/* time since bootup that this device was created */
 	struct sdeb_zone_state *zstate;
+
+	struct dentry *debugfs_entry;
+	struct list_head inject_err_list;
 };
 
 struct sdebug_host_info {
@@ -870,6 +908,132 @@ static const int condition_met_result = SAM_STAT_CONDITION_MET;
 
 static struct dentry *sdebug_debugfs_root;
 
+static void sdebug_err_add(struct scsi_device *sdev, struct sdebug_err_inject *new)
+{
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
+static int sdebug_error_show(struct seq_file *m, void *p)
+{
+	struct scsi_device *sdev = (struct scsi_device *)m->private;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *err;
+
+	seq_puts(m, "Type\tCount\tCommand\n");
+
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		switch (err->type) {
+		case ERR_TMOUT_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
+				err->cmd);
+		break;
+
+		case ERR_FAIL_QUEUE_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\t0x%x\n", err->type,
+				err->cnt, err->cmd, err->queuecmd_ret);
+		break;
+
+		case ERR_FAIL_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\t0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+				err->type, err->cnt, err->cmd,
+				err->host_byte, err->driver_byte,
+				err->status_byte, err->sense_key,
+				err->asc, err->asq);
+		break;
+		}
+	}
+
+	return 0;
+}
+
+static int sdebug_error_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sdebug_error_show, inode->i_private);
+}
+
+static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	char *buf;
+	unsigned int inject_type;
+	struct sdebug_err_inject *inject;
+	struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, ubuf, count)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	if (sscanf(buf, "%d", &inject_type) != 1) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	inject = kzalloc(sizeof(struct sdebug_err_inject), GFP_KERNEL);
+	if (!inject) {
+		kfree(buf);
+		return -ENOMEM;
+	}
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
+	kfree(buf);
+	sdebug_err_add(sdev, inject);
+
+	return count;
+
+out_error:
+	kfree(buf);
+	kfree(inject);
+	return -EINVAL;
+}
+
+static const struct file_operations sdebug_error_fops = {
+	.open	= sdebug_error_open,
+	.read	= seq_read,
+	.write	= sdebug_error_write,
+};
 
 /* Only do the extra work involved in logical block provisioning if one or
  * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
@@ -5104,6 +5268,7 @@ static struct sdebug_dev_info *sdebug_device_create(
 		}
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
+		INIT_LIST_HEAD(&devip->inject_err_list);
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
 	}
 	return devip;
@@ -5149,6 +5314,7 @@ static int scsi_debug_slave_alloc(struct scsi_device *sdp)
 	if (sdebug_verbose)
 		pr_info("slave_alloc <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+
 	return 0;
 }
 
@@ -5171,6 +5337,12 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
 	if (sdebug_no_uld)
 		sdp->no_uld_attach = 1;
 	config_cdb_len(sdp);
+
+	devip->debugfs_entry = debugfs_create_dir(dev_name(&sdp->sdev_dev),
+				sdebug_debugfs_root);
+	debugfs_create_file("error", 0600, devip->debugfs_entry, sdp,
+				&sdebug_error_fops);
+
 	return 0;
 }
 
@@ -5182,6 +5354,8 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
 	if (sdebug_verbose)
 		pr_info("slave_destroy <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+
+	debugfs_remove(devip->debugfs_entry);
 	if (devip) {
 		/* make this slot available for re-use */
 		devip->used = false;
-- 
2.32.0

