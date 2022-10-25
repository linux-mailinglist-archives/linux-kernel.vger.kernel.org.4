Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C260C8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJYJso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiJYJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA312B354;
        Tue, 25 Oct 2022 02:48:16 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRqc0nS9z67XGR;
        Tue, 25 Oct 2022 17:44:44 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:48:14 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:48:10 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 05/22] scsi: core: Add support for reserved command timeout handling
Date:   Tue, 25 Oct 2022 18:17:59 +0800
Message-ID: <1666693096-180008-6-git-send-email-john.garry@huawei.com>
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

Add support for reserved timeout handling. Any driver which specifies
that it supports reserved tags must supply a handler.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hosts.c      | 15 +++++++++++----
 drivers/scsi/scsi_error.c |  3 +++
 include/scsi/scsi_host.h  |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 78968553089f..52346085b3c1 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -230,10 +230,17 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 	}
 
-	if (shost->nr_reserved_cmds && !sht->reserved_queuecommand) {
-		shost_printk(KERN_ERR, shost,
-			"nr_reserved_cmds set but no method to queue\n");
-		goto fail;
+	if (shost->nr_reserved_cmds) {
+		if (!sht->reserved_queuecommand) {
+			shost_printk(KERN_ERR, shost,
+				"nr_reserved_cmds set but no method to queue\n");
+			goto fail;
+		}
+		if (!sht->reserved_timedout) {
+			shost_printk(KERN_ERR, shost,
+				"nr_reserved_cmds set but no method to handle timeouts\n");
+			goto fail;
+		}
 	}
 
 	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 6995c8979230..2f86a4284f29 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -338,6 +338,9 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
 	if (host->eh_deadline != -1 && !host->last_reset)
 		host->last_reset = jiffies;
 
+	if (blk_mq_is_reserved_rq(req))
+		return host->hostt->reserved_timedout(scmd);
+
 	if (host->hostt->eh_timed_out)
 		rtn = host->hostt->eh_timed_out(scmd);
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a39f36aa0b0d..266c13e731de 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -74,6 +74,7 @@ struct scsi_host_template {
 	 */
 	int (* queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
 	int (*reserved_queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
+	enum blk_eh_timer_return (*reserved_timedout)(struct scsi_cmnd *);
 
 	/*
 	 * The commit_rqs function is used to trigger a hardware
-- 
2.35.3

