Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B16BF8E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCRIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCRIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:15:22 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B6433BD8A;
        Sat, 18 Mar 2023 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GU4Bt
        iF/mURnT05J+b2ZAAYVXtRHoTughkALlexgzGg=; b=RzyDNH3cpfjQTZ5EEJPbA
        rpJyG2XNpeYuHr9Rac5O8fWlhrP+JvBNmEwwdbnFycPZpyaTRxeRS7NkkOgWdEOn
        HSZfppWv7VNhnVMngR8s01+cMdLlOXZFmGeAFNV3DTJwcpwT0LepzHL+GM1uSY3z
        FnWquRZNuN83WWcLJHVcgU=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wB3k8QLcxVk6mdpAQ--.23029S2;
        Sat, 18 Mar 2023 16:15:07 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH RESEND] media: dm1105: Fix use after free bug in dm1105_remove due to race condition
Date:   Sat, 18 Mar 2023 16:15:06 +0800
Message-Id: <20230318081506.795147-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3k8QLcxVk6mdpAQ--.23029S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7GrWDtr43Cw48Aw1kuryxAFb_yoW8Jry5pr
        ZxCFyYkFWfGry8Jr1DGw17XFy5JrZxJFy3WrW7Ww43Xr15ZFWDtayqv3WUAry3AFZ7ZrWa
        qa1rXr13W3yUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziPl1LUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQw2U1WBo9NqrgAAsU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dm1105_probe, it called dm1105_ir_init and bound
&dm1105->ir.work with dm1105_emit_key.
When it handles IRQ request with dm1105_irq,
it may call schedule_work to start the work.

When we call dm1105_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in dm1105_remove

CPU0                  CPU1

                    |dm1105_emit_key
dm1105_remove      |
  dm1105_ir_exit       |
    rc_unregister_device |
    rc_free_device  |
    rc_dev_release  |
    kfree(dev);     |
                    |
                    | rc_keydown
                    |   //use

Fixes: 34d2f9bf189c ("V4L/DVB: dm1105: use dm1105_dev & dev instead of dm1105dvb")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 drivers/media/pci/dm1105/dm1105.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 4ac645a56c14..9e9c7c071acc 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1176,6 +1176,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
-- 
2.25.1

