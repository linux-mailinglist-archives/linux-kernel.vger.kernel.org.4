Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A971160C90B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiJYJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJYJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:52:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C6214093;
        Tue, 25 Oct 2022 02:49:29 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRtt6bPxz6H72c;
        Tue, 25 Oct 2022 17:47:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:49:27 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:49:23 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 22/22] scsi: libsas: Delete sas_task_slow.timer
Date:   Tue, 25 Oct 2022 18:18:16 +0800
Message-ID: <1666693096-180008-23-git-send-email-john.garry@huawei.com>
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

We now send every slow task through the block layer and use the timeout
facility there, so delete sas_task_slow.timer .

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_init.c      | 1 -
 drivers/scsi/libsas/sas_scsi_host.c | 1 -
 include/scsi/libsas.h               | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index c3f602bd2c4c..8b0e72c447d0 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -50,7 +50,6 @@ struct sas_task *sas_alloc_slow_task(gfp_t flags)
 
 	task->slow_task = slow;
 	slow->task = task;
-	timer_setup(&slow->timer, NULL, 0);
 	init_completion(&slow->completion);
 
 	return task;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index a93e019a7dbf..4fdd84868ac2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -909,7 +909,6 @@ EXPORT_SYMBOL_GPL(sas_bios_param);
 
 void sas_task_internal_done(struct sas_task *task)
 {
-	del_timer(&task->slow_task->timer);
 	complete(&task->slow_task->completion);
 }
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 60543d8b01d4..f903be5895a9 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -9,8 +9,6 @@
 #ifndef _LIBSAS_H_
 #define _LIBSAS_H_
 
-
-#include <linux/timer.h>
 #include <linux/pci.h>
 #include <scsi/sas.h>
 #include <linux/libata.h>
@@ -628,7 +626,6 @@ struct sas_task_slow {
 	/* standard/extra infrastructure for slow path commands (SMP and
 	 * internal lldd commands
 	 */
-	struct timer_list     timer;
 	struct completion     completion;
 	struct sas_task       *task;
 };
-- 
2.35.3

