Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE9622211
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKICoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiKICnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:43:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53210064;
        Tue,  8 Nov 2022 18:43:51 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6Tms09BtzRp7Z;
        Wed,  9 Nov 2022 10:43:41 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:43:49 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:43:49 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [RFC PATCH 5/5] scsi:scsi_debug: fail specific scsi command with result and sense data
Date:   Wed, 9 Nov 2022 10:59:50 -0500
Message-ID: <20221109155950.3536976-6-haowenchao@huawei.com>
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

If a fail commnd error is injected for specific scsi command, set the
scsi command's status and sense data, then finish this scsi command.

For example, the following command would make read(0x88) command finished
with UNC for 8 times:

  error=/sys/block/sdb/device/error_inject/error
  echo "2 -8 0x88 0 0 0x2 0x3 0x11 0x0" >$error

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_debug.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 217a9e892391..06fe2914117f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7832,6 +7832,41 @@ static int sdebug_fail_queue_cmd(struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+static int sdebug_fail_cmd(struct scsi_cmnd *cmnd, int *retval,
+			   struct sdebug_err_inject *info)
+{
+	struct scsi_device *sdp = cmnd->device;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
+	struct sdebug_err_inject *err;
+	unsigned char *cmd = cmnd->cmnd;
+	int ret = 0;
+	int result;
+
+	if (devip == NULL)
+		return 0;
+
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		if (err->type == ERR_FAIL_CMD &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			if (!err->cnt)
+				return 0;
+			ret = !!err->cnt;
+			goto out_handle;
+		}
+	}
+	return 0;
+
+out_handle:
+	if (err->cnt < 0)
+		err->cnt++;
+	mk_sense_buffer(cmnd, err->sense_key, err->asc, err->asq);
+	result = err->status_byte | err->host_byte << 16 | err->driver_byte << 24;
+	*info = *err;
+	*retval = schedule_resp(cmnd, devip, result, NULL, 0, 0);
+
+	return ret;
+}
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7852,6 +7887,7 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	bool has_wlun_rl;
 	bool inject_now;
 	int ret = 0;
+	struct sdebug_err_inject err;
 
 	scsi_set_resid(scp, 0);
 	if (sdebug_statistics) {
@@ -7904,6 +7940,16 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 		return ret;
 	}
 
+	if (sdebug_fail_cmd(scp, &ret, &err)) {
+		scmd_printk(KERN_INFO, scp,
+			"fail command 0x%x with hostbyte=0x%x, "
+			"driverbyte=0x%x, statusbyte=0x%x, "
+			"sense_key=0x%x, asc=0x%x, asq=0x%x\n",
+			opcode, err.host_byte, err.driver_byte,
+			err.status_byte, err.sense_key, err.asc, err.asq);
+		return ret;
+	}
+
 	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
 		atomic_set(&sdeb_inject_pending, 1);
 
-- 
2.35.3

