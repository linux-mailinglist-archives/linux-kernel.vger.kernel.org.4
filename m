Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307A6E0552
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDMDfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDMDeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:34:37 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9510772BB;
        Wed, 12 Apr 2023 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lIcVf
        dDOG5loBmiWhCLSBqSRWz3dIU8sdeChu5hTPJE=; b=Z4NDFiWAEX/oY3sAbcKf8
        f/uZQI44HOhZ+dKeMudg4EHiU4h8+fBE9LtBSVGtKEQjZpcQyUjLXLS9bvo0nsqZ
        p2I1uIfe7I++JOkWrWfRjj4aXt5GRC51tcJ3b/e/uK5rW+axmzlGOUd2UsiQqxPI
        v43chJJnWtRddW+1vkA4ik=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wBXFM0_eDdkjKocBQ--.60991S2;
        Thu, 13 Apr 2023 11:34:23 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] scsi: qedi: Fix use after free bug in qedi_remove due to race  condition
Date:   Thu, 13 Apr 2023 11:34:22 +0800
Message-Id: <20230413033422.28003-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXFM0_eDdkjKocBQ--.60991S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw17Gry3WFWUtFWUWr4UArb_yoW8Wr48pr
        ZxGa4Fkw45KFyrXFn8JF10qFy0kayDtFW0ga97W3y7X3Wa93ykZFySka4jgFyUJFs2va17
        tF1kXFy3W3WDGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zimFAAUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQgRPU1aEE9wfvgACsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2:
- remove unnecessary comment suggested by Mike Christie and cancel the work
after qedi_ops->stop and qedi_ops->ll2->stop which ensure there is no more
work suggested by Manish Rangankar
---
 drivers/scsi/qedi/qedi_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index f2ee49756df8..45d359554182 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2450,6 +2450,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
-- 
2.25.1

