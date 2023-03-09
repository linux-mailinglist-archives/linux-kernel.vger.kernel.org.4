Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188966B2D06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCISib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCISia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:38:30 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDF7FF16BD;
        Thu,  9 Mar 2023 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LmXry
        pUhkfQZNqHBXt/FnFD1GHWz24KdFa4arN1jaDs=; b=OeGEkv9b2LimBM9xgXpwk
        olYySl+AaRQp/4TBZNoRWsvyDb4bS3atoHeRy5n+BunTBSemigD1Iv08CO+eS1rw
        mDPXgA717P625BEjaXGNYbaZpi7F/Kohtam2Mi0n6YQhQqM8AHLa4YXpwLpdfk7x
        3n8Pp/UUoJCdUNI0ZAbvIk=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wCXBZ6VJwpkAS33Cg--.7263S2;
        Fri, 10 Mar 2023 02:38:13 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] scsi: qla4xxx: Fix use after free bug in da9150_charger_remove due to race condition
Date:   Fri, 10 Mar 2023 02:38:12 +0800
Message-Id: <20230309183812.299349-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXBZ6VJwpkAS33Cg--.7263S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUKw1xtw4rAr1UWFy3Jwb_yoWkWrX_C3
        yqvryxKr1aqr4kKr17Xr13ArWxWF4kXF90kFyrtF13AFy5uwn3X3yDuFZ0vw4UG39FyFy3
        Cw1jyrW5Zrn8KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMwZ2DUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiQhctU1aEEmt7MAAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qla4xxx_probe_adapter, &ha->dpc_work is bound with
qla4xxx_do_dpc. qla4xxx_post_aen_work may be called
to start the work.

If we remove the module which will call qla4xxx_remove_adapter
  to make cleanup, there may be a unfinished work. The possible
  sequence is as follows:

Fix it by canceling the work before cleanup in qla4xxx_remove_adapter

CPU0                  CPUc1

                    |qla4xxx_do_dpc
qla4xxx_remove_adapter|
scsi_remove_host  	|
kfree(ha->host)   	|
                    |
                    |   iscsi_host_for_each_session
                    |   //use ha->host
Fixes: afaf5a2d341d ("[SCSI] Initial Commit of qla4xxx")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 005502125b27..d530cc853f43 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9001,6 +9001,7 @@ static void qla4xxx_remove_adapter(struct pci_dev *pdev)
 	if (!pci_is_enabled(pdev))
 		return;
 
+	cancel_work_sync(&ha->dpc_work);
 	ha = pci_get_drvdata(pdev);
 
 	if (is_qla40XX(ha))
-- 
2.25.1

