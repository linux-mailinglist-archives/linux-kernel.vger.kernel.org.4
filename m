Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FD6B6865
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCLQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:48:31 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DE402200E;
        Sun, 12 Mar 2023 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=N4jp8
        xAkv6nJvns9rj2xzYaBjm242kwG0b+7YqJ0+cc=; b=d071C3qxmpqpF+KJF9YpO
        m9SEjmPqRNt1HO5i9TEjrNXpcIJ++HSZU4HdTeE/3mOwq8Pv0aq5ceO00OYhrsMg
        gIhHYoiOhYgLypp7ASZz1USmM36j+XYcBZJbE/lDGbYmQ6QtQHWET9CfMjUlkzEK
        AeJbOPrELz/BHFMBaaT6Jo=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wD31E5IAg5k_rGRDA--.2593S2;
        Mon, 13 Mar 2023 00:48:08 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     don.brace@microchip.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] scsi: smartpqi: Fix use after free bug in pqi_pci_remove due to race condition
Date:   Mon, 13 Mar 2023 00:48:06 +0800
Message-Id: <20230312164806.2104140-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD31E5IAg5k_rGRDA--.2593S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1xCr1rXr1kXw4fGrWkXrb_yoW8Xr18pF
        4fJ3sxCr45tryY9w1DA3W0yFy3Cay5KrW3Cwsrt343XF13CryjqryUCa1qvr43XFsYkr4Y
        yF1Fy3W5WFy7JFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-J55UUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBAwU1Xl55jdsgAAsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pqi_pci_probe, it calls pqi_alloc_ctrl_info and bound
&ctrl_info->event_work with pqi_event_worker.

When it calls pqi_irq_handler to handle IRQ, 
it will finally call schedule_work to start the work.

When we call pqi_pci_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in pqi_remove_ctrl.

CPU0                  CPU1

                    |pqi_event_worker
pqi_pci_remove      |
  pqi_remove_ctrl   |
pqi_free_ctrl_resources|
pqi_free_ctrl_info|
     kfree(ctrl_info)  |
//free ctrl_info   |
                    |pqi_ctrl_busy
                    |//use ctrl_info

Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 49a8f91810b6..555f1af38f38 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -8939,6 +8939,7 @@ static void pqi_take_ctrl_offline_deferred(struct pqi_ctrl_info *ctrl_info)
 	pqi_perform_lockup_action();
 	pqi_stop_heartbeat_timer(ctrl_info);
 	pqi_free_interrupts(ctrl_info);
+	cancel_work_sync(&ctrl_info->event_work);
 	pqi_cancel_rescan_worker(ctrl_info);
 	pqi_cancel_update_time_worker(ctrl_info);
 	pqi_ctrl_wait_until_quiesced(ctrl_info);
-- 
2.25.1

