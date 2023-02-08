Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584568E627
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBHClQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBHClO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:41:14 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13E562528B;
        Tue,  7 Feb 2023 18:41:10 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowACXn0vAC+NjYa8MBA--.12914S2;
        Wed, 08 Feb 2023 10:41:04 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     linuxdrivers@attotech.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] scsi: esas2r: Add missing check and destroy for create_singlethread_workqueue
Date:   Wed,  8 Feb 2023 10:41:03 +0800
Message-Id: <20230208024103.38992-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXn0vAC+NjYa8MBA--.12914S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fXrWfXF1UWryUJFWkWFg_yoWrJF4fpF
        ZxAa4jkF40yF4xCw45K3W5Za4rK3y8GFyv9ayIq3s0kFsakws5tFy0vFW2vFyrGF4DW347
        tF4vqwn8CF1UJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5vtCUUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check for the return value of the create_singlethread_workqueue
in order to avoid NULL pointer dereference.
Moreover, the allocated "a->fw_event_q" should be destroyed when
esas2r_init_adapter fails later in order to avoid memory leak.
It is better to use goto label to remove duplicate error handling code.

Fixes: 26780d9e12ed ("[SCSI] esas2r: ATTO Technology ExpressSAS 6G SAS/SATA RAID Adapter Driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/scsi/esas2r/esas2r_init.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index c1a5ab662dc8..820530639517 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -272,14 +272,14 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		esas2r_log(ESAS2R_LOG_CRIT,
 			   "tried to init invalid adapter index %u!",
 			   index);
-		return 0;
+		goto error_exit;
 	}
 
 	if (esas2r_adapters[index]) {
 		esas2r_log(ESAS2R_LOG_CRIT,
 			   "tried to init existing adapter index %u!",
 			   index);
-		return 0;
+		goto error_exit;
 	}
 
 	a = (struct esas2r_adapter *)host->hostdata;
@@ -294,8 +294,7 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 
 	if (!dma64 && dma_set_mask_and_coherent(&pcid->dev, DMA_BIT_MASK(32))) {
 		esas2r_log(ESAS2R_LOG_CRIT, "failed to set DMA mask");
-		esas2r_kill_adapter(index);
-		return 0;
+		goto error_kill_adapter;
 	}
 
 	esas2r_log_dev(ESAS2R_LOG_INFO, &pcid->dev,
@@ -314,6 +313,10 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 	snprintf(a->fw_event_q_name, ESAS2R_KOBJ_NAME_LEN, "esas2r/%d",
 		 a->index);
 	a->fw_event_q = create_singlethread_workqueue(a->fw_event_q_name);
+	if (!a->fw_event_q) {
+		esas2r_log(ESAS2R_LOG_CRIT, "failed to allocate workqueue");
+		goto error_kill_adapter;
+	}
 
 	init_waitqueue_head(&a->buffered_ioctl_waiter);
 	init_waitqueue_head(&a->nvram_waiter);
@@ -338,8 +341,7 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		if (!alloc_vda_req(a, last_request)) {
 			esas2r_log(ESAS2R_LOG_CRIT,
 				   "failed to allocate a VDA request!");
-			esas2r_kill_adapter(index);
-			return 0;
+			goto error_destroy_workqueue;
 		}
 	}
 
@@ -350,8 +352,7 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 
 	if (esas2r_map_regions(a) != 0) {
 		esas2r_log(ESAS2R_LOG_CRIT, "could not map PCI regions!");
-		esas2r_kill_adapter(index);
-		return 0;
+		goto error_destroy_workqueue;
 	}
 
 	a->index = index;
@@ -379,8 +380,7 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		esas2r_log(ESAS2R_LOG_CRIT,
 			   "failed to allocate %d bytes of consistent memory!",
 			   a->uncached_size);
-		esas2r_kill_adapter(index);
-		return 0;
+		goto error_destroy_workqueue;
 	}
 
 	a->uncached_phys = bus_addr;
@@ -397,8 +397,7 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 					&next_uncached)) {
 		esas2r_log(ESAS2R_LOG_CRIT,
 			   "failed to initialize adapter structure (2)!");
-		esas2r_kill_adapter(index);
-		return 0;
+		goto error_destroy_workqueue;
 	}
 
 	tasklet_init(&a->tasklet,
@@ -430,6 +429,13 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		     a, a->disable_cnt);
 
 	return 1;
+
+error_destroy_workqueue:
+	destroy_workqueue(a->fw_event_q);
+error_kill_adapter:
+	esas2r_kill_adapter(index);
+error_exit:
+	return 0;
 }
 
 static void esas2r_adapter_power_down(struct esas2r_adapter *a,
-- 
2.25.1

