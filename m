Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05880679263
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjAXHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:55:54 -0500
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E5DEC44A9;
        Mon, 23 Jan 2023 23:55:49 -0800 (PST)
Received: from ubuntu.localdomain (unknown [112.254.167.99])
        by mail-app2 (Coremail) with SMTP id by_KCgAXHyP3js9j+tkkCg--.54572S2;
        Tue, 24 Jan 2023 15:55:45 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     sean@mess.org, linux-media@vger.kernel.org
Cc:     maximlevitsky@gmail.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v3] media: rc: Fix use-after-free bugs caused by ene_tx_irqsim()
Date:   Tue, 24 Jan 2023 15:55:33 +0800
Message-Id: <20230124075533.30152-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgAXHyP3js9j+tkkCg--.54572S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyxXrW3ZFW7AryUtF1rCrg_yoW5Wr45p3
        95GFWfKryvqw429r17Xw48ZF15Wr4xJ34rZ34Sg34j9wn5CFyFqF9Yqa4j9a4rAFyrAFZF
        vr43Xw4fZFnxZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUekucDUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIFAVZdtdVLGAASsu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ene device is detaching, function ene_remove() will
be called. But there is no function to cancel tx_sim_timer
in ene_remove(), the timer handler ene_tx_irqsim() could race
with ene_remove(). As a result, the UAF bugs could happen,
the process is shown below.

    (cleanup routine)          |        (timer routine)
                               | mod_timer(&dev->tx_sim_timer, ..)
ene_remove()                   | (wait a time)
  kfree(dev) //FREE            |
                               | ene_tx_irqsim()
                               |   dev->hw_lock //USE
                               |   ene_tx_sample(dev) //USE

Fix by adding del_timer_sync(&dev->tx_sim_timer) in ene_remove(),
The tx_sim_timer could stop before ene device is deallocated.

What's more, The rc_unregister_device() and del_timer_sync()
should be called first in ene_remove() and the deallocated
functions such as free_irq(), release_region() and so on
should be called behind them. Because the rc_unregister_device()
is well synchronized. Otherwise, race conditions may happen. The
situations that may lead to race conditions are shown below.

Firstly, the rx receiver is disabled with ene_rx_disable()
before rc_unregister_device() in ene_remove(), which means it
can be enabled again if a process opens /dev/lirc0 between
ene_rx_disable() and rc_unregister_device().

Secondly, the irqaction descriptor is freed by free_irq()
before the rc device is unregistered, which means irqaction
descriptor may be accessed again after it is deallocated.

Thirdly, the timer can call ene_tx_sample() that can write
to the io ports, which means the io ports could be accessed
again after they are deallocated by release_region().

Therefore, the rc_unregister_device() and del_timer_sync()
should be called first in ene_remove().

Suggested by: Sean Young <sean@mess.org>

Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v3:
  - Call rc_unregister_device() and del_timer_sync() first in ene_remove().

 drivers/media/rc/ene_ir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index e09270916fb..11ee21a7db8 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1106,6 +1106,8 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	struct ene_device *dev = pnp_get_drvdata(pnp_dev);
 	unsigned long flags;
 
+	rc_unregister_device(dev->rdev);
+	del_timer_sync(&dev->tx_sim_timer);
 	spin_lock_irqsave(&dev->hw_lock, flags);
 	ene_rx_disable(dev);
 	ene_rx_restore_hw_buffer(dev);
@@ -1113,7 +1115,6 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 
 	free_irq(dev->irq, dev);
 	release_region(dev->hw_io, ENE_IO_SIZE);
-	rc_unregister_device(dev->rdev);
 	kfree(dev);
 }
 
-- 
2.17.1

