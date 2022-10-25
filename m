Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB060C8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJYJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiJYJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A91111B99;
        Tue, 25 Oct 2022 02:48:12 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRqW5gcqz67xV0;
        Tue, 25 Oct 2022 17:44:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:05 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 04/22] scsi: core: Add support to send reserved commands
Date:   Tue, 25 Oct 2022 18:17:58 +0800
Message-ID: <1666693096-180008-5-git-send-email-john.garry@huawei.com>
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

Add a method to queue reserved commands.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hosts.c     |  6 ++++++
 drivers/scsi/scsi_lib.c  | 25 +++++++++++++++++++++++++
 include/scsi/scsi_host.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index db89afc37bc9..78968553089f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -230,6 +230,12 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 	}
 
+	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
+		shost_printk(KERN_ERR, shost,
+			"nr_reserved_cmds set but no method to queue\n");
+		goto fail;
+	}
+
 	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
 	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
 				   shost->can_queue);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a8c4e7c037ae..08015c42c326 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1428,6 +1428,16 @@ static void scsi_complete(struct request *rq)
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
 	enum scsi_disposition disposition;
 
+	if (blk_mq_is_reserved_rq(rq)) {
+		struct scsi_device *sdev = cmd->device;
+
+		scsi_mq_uninit_cmd(cmd);
+		scsi_device_unbusy(sdev, cmd);
+		__blk_mq_end_request(rq, 0);
+
+		return;
+	}
+
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
 	atomic_inc(&cmd->device->iodone_cnt);
@@ -1718,6 +1728,21 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t ret;
 	int reason;
 
+	if (blk_mq_is_reserved_rq(req)) {
+		if (!(req->rq_flags & RQF_DONTPREP)) {
+			ret = scsi_prepare_cmd(req);
+			if (ret != BLK_STS_OK)
+				goto out_dec_host_busy;
+
+			req->rq_flags |= RQF_DONTPREP;
+		} else {
+			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
+		}
+		blk_mq_start_request(req);
+
+		return shost->hostt->reserved_queuecommand(shost, cmd);
+	}
+
 	WARN_ON_ONCE(cmd->budget_token < 0);
 
 	/*
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 91678c77398e..a39f36aa0b0d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -73,6 +73,7 @@ struct scsi_host_template {
 	 * STATUS: REQUIRED
 	 */
 	int (* queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
+	int (*reserved_queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
 
 	/*
 	 * The commit_rqs function is used to trigger a hardware
-- 
2.35.3

