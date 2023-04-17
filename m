Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA496E4E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDQQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:53:14 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3AE78F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=difeq
        NYROJLd3h7pJgHbiQGat6ELIM7KbJhDgj4H5js=; b=EKu60oX0w16R8PltMmtIK
        YbgiRhHMdG4GiNpUM7mRAczlD4wCqyYmHmZIXqLOWM5uA7KHL4B3DhyVBYCdAoZ1
        C4Mw5/aaysBCenWZS+JM+vH2uySewzwG75X4YY34rwpPtD2NbXZsTwFBo6vaTriU
        X3Fxhx+h4aFERFCkZv37Lg=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wB33mZgeT1kpY0GBw--.48629S2;
        Tue, 18 Apr 2023 00:52:48 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     matt.hsiao@hpe.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due  to race condition with ilo_open
Date:   Tue, 18 Apr 2023 00:52:46 +0800
Message-Id: <20230417165246.467723-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB33mZgeT1kpY0GBw--.48629S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryUJFyDuFWDKFyxZr4kXrb_yoW5Ww1xpF
        W5Xa45CF4rXrZrWF4Utr4DCFyay34xtrykGrWIk3s5ZF1Svr1vgF18ta4UZFy5tFZ5XF13
        JF1YgryrG3WUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXAFUU1Xl6SOPWAAAs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes the ilo device 
while calling ilo_open.

If we remove the driver which will call ilo_remove to make cleanup, there 
is no guarantee to make sure there's no more ilo_open invoking.

The possible sequence is as follows:

Fix it by adding a refcount check to ilo_remove() function to free the 
"ilo_hwinfo " structure after the last file is closed.

CPU0                  CPU1

                    |ilo_open
ilo_remove          |
kfree(ilo_hw)       |
//free	            |
                    |hw = container_of(ip->i_cdev,
	   	     |struct ilo_hwinfo, cdev);
                    |hw->ccb_alloc[slot]
                    |//use
Fixes: 89bcb05d9bbf ("HP iLO driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/misc/hpilo.c | 16 +++++++++++++++-
 drivers/misc/hpilo.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..2e9af39e91a4 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -37,6 +37,8 @@ static const struct pci_device_id ilo_blacklist[] = {
 	{}
 };
 
+static void ilo_delete(struct kref *kref);
+
 static inline int get_entry_id(int entry)
 {
 	return (entry & ENTRY_MASK_DESCRIPTOR) >> ENTRY_BITPOS_DESCRIPTOR;
@@ -559,6 +561,7 @@ static int ilo_close(struct inode *ip, struct file *fp)
 		hw->ccb_alloc[slot]->ccb_cnt--;
 
 	spin_unlock(&hw->open_lock);
+	kref_put(&hw->refcnt, ilo_delete);
 
 	return 0;
 }
@@ -578,6 +581,7 @@ static int ilo_open(struct inode *ip, struct file *fp)
 	if (!data)
 		return -ENOMEM;
 
+	kref_get(&hw->refcnt);
 	spin_lock(&hw->open_lock);
 
 	/* each fd private_data holds sw/hw view of ccb */
@@ -633,6 +637,8 @@ static int ilo_open(struct inode *ip, struct file *fp)
 
 	if (!error)
 		fp->private_data = hw->ccb_alloc[slot];
+	else
+		kref_put(&hw->refcnt, ilo_delete);
 
 	return error;
 }
@@ -742,8 +748,15 @@ static int ilo_map_device(struct pci_dev *pdev, struct ilo_hwinfo *hw)
 
 static void ilo_remove(struct pci_dev *pdev)
 {
-	int i, minor;
 	struct ilo_hwinfo *ilo_hw = pci_get_drvdata(pdev);
+	kref_put(&ilo_hw->refcnt, ilo_delete);
+}
+
+static void ilo_delete(struct kref *kref)
+{
+	int i, minor;
+	struct ilo_hwinfo *ilo_hw = container_of(kref, struct ilo_hwinfo, refcnt);
+	struct pci_dev *pdev = ilo_hw->ilo_dev;
 
 	if (!ilo_hw)
 		return;
@@ -807,6 +820,7 @@ static int ilo_probe(struct pci_dev *pdev,
 		goto out;
 
 	ilo_hw->ilo_dev = pdev;
+	kref_init(&ilo_hw->refcnt);
 	spin_lock_init(&ilo_hw->alloc_lock);
 	spin_lock_init(&ilo_hw->fifo_lock);
 	spin_lock_init(&ilo_hw->open_lock);
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index d57c34680b09..ebc677eb45ae 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -62,6 +62,7 @@ struct ilo_hwinfo {
 	spinlock_t fifo_lock;
 
 	struct cdev cdev;
+	struct kref refcnt;
 };
 
 /* offset from mmio_vaddr for enabling doorbell interrupts */
-- 
2.25.1

