Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892706B7182
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCMIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCMItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:49:15 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D6A58C09;
        Mon, 13 Mar 2023 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0txFr
        uaHYw7D6gvoux40mvteetA7L1PU1RtHGjVt8xg=; b=TF8AwXNMXQf08Db5rwAMq
        ZwRjqdhx82roChU596x3fM5nJ4AJIf7lSEW4TFThc78tHAY03YYJZr3YzKBOY1vk
        Jlj+B8oNYfE2BV7InhHMKKkURwGNiLCJLCemTbzhdmA/TGI25qPsF6Mfo7uLN3sJ
        oosPsM+nsVPkF6gctSMLuo=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wD3_cXQ4g5k_c0fAA--.6206S2;
        Mon, 13 Mar 2023 16:46:08 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] scsi: qedi: Fix use after free bug in qedi_remove due to race condition
Date:   Mon, 13 Mar 2023 16:46:07 +0800
Message-Id: <20230313084607.3297813-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_cXQ4g5k_c0fAA--.6206S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Gry3WFWUtFWUWr4UArb_yoW8GF43pr
        ZxGryfCw1UWa4FqFn8J3W0qFy0k3yDtFW0ga97Ww47X3W3u3yqv34Ika4jgry7JFZ2qa17
        tF4xXFy7WFyDG3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQhgxU1aEEo7UBwAAsl
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
with qedi_recovery_handler and bound &qedi->board_disable_work
with qedi_board_disable_work.

When it calls qedi_schedule_recovery_handler, it will finally
call schedule_delayed_work to start the work.

When we call qedi_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in qedi_remove.

CPU0                  CPU1

                     |qedi_recovery_handler
qedi_remove          |
  __qedi_remove      |
iscsi_host_free      |
scsi_host_put        |
//free shost         |
                     |iscsi_host_for_each_session
                     |//use qedi->shost

Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/scsi/qedi/qedi_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index f2ee49756df8..25223f6f5344 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2414,6 +2414,10 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 	int rval;
 	u16 retry = 10;
 
+	/*cancel work*/
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	if (mode == QEDI_MODE_NORMAL)
 		iscsi_host_remove(qedi->shost, false);
 	else if (mode == QEDI_MODE_SHUTDOWN)
-- 
2.25.1

