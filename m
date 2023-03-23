Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B56C675A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjCWL57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:57:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547AF35263;
        Thu, 23 Mar 2023 04:56:58 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj3dl5M4XzbcQc;
        Thu, 23 Mar 2023 19:53:47 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:56:55 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <haowenchao2@huawei.com>
Subject: [PATCH 4/5] scsi:scsi_debug: Return failed value if the error is injected
Date:   Thu, 23 Mar 2023 19:56:00 +0800
Message-ID: <20230323115601.178494-5-haowenchao2@huawei.com>
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

If a fail queuecommand error is injected, return the failed value defined
in the rule from queuecommand.

We can make any scsi command's queuecommand return the value we desired,
for example make it return SCSI_MLQUEUE_HOST_BUSY.

  error=/sys/class/scsi_device/0:0:0:1/device/error_inject/error
  echo "1 1 0x12 0x1055" > $error

would make all inquiry(0x12) command's queuecommand return 0x1055:

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 06a830eb2ca1..1deccf8dfc90 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7764,6 +7764,30 @@ static int sdebug_timeout_cmd(struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+static int sdebug_fail_queue_cmd(struct scsi_cmnd *cmnd)
+{
+	struct scsi_device *sdp = cmnd->device;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
+	struct sdebug_err_inject *err;
+	unsigned char *cmd = cmnd->cmnd;
+	int ret = 0;
+
+	if (devip == NULL)
+		return 0;
+
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		if (err->type == ERR_FAIL_QUEUE_CMD &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			ret = err->cnt ? err->queuecmd_ret : 0;
+			if (err->cnt < 0)
+				err->cnt++;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7783,6 +7807,7 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	u8 opcode = cmd[0];
 	bool has_wlun_rl;
 	bool inject_now;
+	int ret = 0;
 
 	scsi_set_resid(scp, 0);
 	if (sdebug_statistics) {
@@ -7828,6 +7853,13 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 		return 0;
 	}
 
+	ret = sdebug_fail_queue_cmd(scp);
+	if (ret) {
+		scmd_printk(KERN_INFO, scp, "fail queue command 0x%x with 0x%x\n",
+				opcode, ret);
+		return ret;
+	}
+
 	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
 		atomic_set(&sdeb_inject_pending, 1);
 
-- 
2.35.3

