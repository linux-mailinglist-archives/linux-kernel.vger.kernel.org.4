Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDE69DD78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjBUJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjBUJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:56:36 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DE164EF2;
        Tue, 21 Feb 2023 01:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=siFiW
        Ve+6dgr4X3pGDCiyuNPjBB9mzlfmDvd3HLozlA=; b=jkgBsycQNW3BalMlQERo0
        +qh1B+v8HO+UymUHUAH1aEkHrDTYIZ7DA3bd2xprJ0qb6PD7R//raBLkAH91NOFV
        el6Hu6xoDPdSKbLuVTFFNcmSEQphSwpRl7wBzItctG4ixAgW5GULhJyIuAktsuHP
        Ms07/11UdlxDTvGUQbAyXk=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wBH9pKDkfRjQ9J9Ag--.33381S2;
        Tue, 21 Feb 2023 17:40:19 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, hackerzheng666@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] media: bttv: fix use after free error due to btv->timeout timer
Date:   Tue, 21 Feb 2023 17:40:18 +0800
Message-Id: <20230221094018.19840-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBH9pKDkfRjQ9J9Ag--.33381S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7GF43Zr1xXFykur43Awb_yoW8CrWfpa
        yI9asxArykXr4Utryjya1kWFWfJws5ZrWkKrW7Wa4SvF4fAF4IvF1jva9FvF12vr9rXrya
        vas5WryfJ3WkCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaiiDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgsdU2I0XZinjwAAsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be some a race condition between timer function
bttv_irq_timeout and bttv_remove. The timer is setup in
probe and there is no timer_delete operation in remove
function. When it hit kfree btv, the function might still be
invoked, which will cause use after free bug.

This bug is found by static analysis, it may be false positive.

Fix it by adding del_timer_sync invoking to the remove function.

cpu0                cpu1
                  bttv_probe
                    ->timer_setup
                      ->bttv_set_dma
                        ->mod_timer;
bttv_remove
  ->kfree(btv);
                  ->bttv_irq_timeout
                    ->USE btv

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 1 +
 drivers/media/pci/bt8xx/bttv-risc.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index d40b537f4e98..24ba5729969d 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -4248,6 +4248,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
+	del_timer_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
diff --git a/drivers/media/pci/bt8xx/bttv-risc.c b/drivers/media/pci/bt8xx/bttv-risc.c
index 32fa4a7fe76f..ada469198645 100644
--- a/drivers/media/pci/bt8xx/bttv-risc.c
+++ b/drivers/media/pci/bt8xx/bttv-risc.c
@@ -481,7 +481,7 @@ bttv_set_dma(struct bttv *btv, int override)
 	if (btv->curr.frame_irq || btv->loop_irq || btv->cvbi) {
 		mod_timer(&btv->timeout, jiffies+BTTV_TIMEOUT);
 	} else {
-		del_timer(&btv->timeout);
+		del_timer_sync(&btv->timeout);
 	}
 	btv->main.cpu[RISC_SLOT_LOOP] = cpu_to_le32(cmd);
 
-- 
2.25.1

