Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2E6A7F91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCBKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCBKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:05:31 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AECE1420C;
        Thu,  2 Mar 2023 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H3yhF
        Avyem7KDnFlCyJY7TE1lpzbuiAFzAh4R+WP3vc=; b=J9cqH8c8k24/NV43YvWBA
        SToJHTPC5XM8ls8kWFY/dm6o+BMjrRGmUmC2odNNOtDRqrmLfa4k9igTnIjcnGEj
        oOfid7VzUYs5gfxzZsdzEW+tJEl9pcrZFHJJqzhChUp/1IntvJyTu+Zz5+xN6xYR
        /V0dXwF6+aGr6iusxT3pK0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wBnTQaRdABkcGIbBw--.20507S2;
        Thu, 02 Mar 2023 18:04:02 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, hackerzheng666@gmail.com,
        security@kernel.org, hdanton@sina.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] media: bttv: fix use after free error due to btv->timeout  timer
Date:   Thu,  2 Mar 2023 18:04:00 +0800
Message-Id: <20230302100400.821270-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnTQaRdABkcGIbBw--.20507S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7GF43Zr1xXFykur43Awb_yoW8Jw1kpa
        ySka43CFy8Xr4UtFyUAF4kZFy3A398XrWFg34xG3ZavF4fZF92vF4jyFWqvF17XF92qrya
        qa4Fqr13J3WkCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi-eOJUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBAmU1Xl5ypQrgABs7
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
v2:
- stop replacing del_timer with del_timer_sync suggested by Hillf Danton
---
 drivers/media/pci/bt8xx/bttv-driver.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.25.1

