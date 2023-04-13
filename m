Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B66E056D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDMDoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:44:46 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73F824EE5;
        Wed, 12 Apr 2023 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H3yhF
        Avyem7KDnFlCyJY7TE1lpzbuiAFzAh4R+WP3vc=; b=OmXjSMzZAcLSWJjrO0K6n
        99GE4FRsIuCiQcmAwg5q0ppzOqfKJaGZ36k8ayMHG6DiAjoHaGQvBw7I6anqHlYw
        aPAnaz0HLbEgLqekAdBYYHlTkmEtpYP7CZgDEzLmnibMr5b8RU9g5hzJLHEfx65b
        560AvmpQXT0927I3B3CPYo=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wCXt2eGejdkzWFfBQ--.36620S2;
        Thu, 13 Apr 2023 11:44:06 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, hackerzheng666@gmail.com,
        security@kernel.org, hdanton@sina.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [RESEND PATCH v2] media: bttv: fix use after free error due to btv->timeout  timer
Date:   Thu, 13 Apr 2023 11:44:05 +0800
Message-Id: <20230413034405.36037-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXt2eGejdkzWFfBQ--.36620S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7GF43Zr1xXFykur43Awb_yoW8Jw1kpa
        ySka43CFy8Xr4UtFyUAF4kZFy3A398XrWFg34xG3ZavF4fZF92vF4jyFWqvF17XF92qrya
        qa4Fqr13J3WkCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinjjPUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzgFQU2I0Yp2FlgABs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

