Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2A677DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjAWOVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAWOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:21:41 -0500
X-Greylist: delayed 47329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 06:21:38 PST
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8BF2D2004D;
        Mon, 23 Jan 2023 06:21:38 -0800 (PST)
Received: from ubuntu.localdomain (unknown [112.254.167.99])
        by mail-app4 (Coremail) with SMTP id cS_KCgDnet3ml85jwadpCg--.20831S2;
        Mon, 23 Jan 2023 22:21:34 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-media@vger.kernel.org, sean@mess.org
Cc:     maximlevitsky@gmail.com, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] media: rc: Fix use-after-free bugs caused by ene_tx_irqsim()
Date:   Mon, 23 Jan 2023 22:21:23 +0800
Message-Id: <20230123142123.58870-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgDnet3ml85jwadpCg--.20831S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrJF17Kw1rAw4xuF17Jrb_yoW8Ww47p3
        y8GFWSkry8Jr42vFnrXw4ku3W5Zws5J34UuryxW3yjvrn5GFy5AF9Yqa4jqay5AFyxZFZF
        vr4rXF4fCFn8uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xryl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe_M3DUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgcEAVZdtdU8lAAjsg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

What's more, the timer can call ene_tx_sample() which can write
to the io ports. So we should put rc_unregister_device() and
del_timer_sync(&dev->tx_sim_timer) before release_region() in
ene_remove().

Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Move rc_unregister_device() and del_timer_sync() before release_region().

 drivers/media/rc/ene_ir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index e09270916fb..2864360af9e 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1112,8 +1112,9 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	spin_unlock_irqrestore(&dev->hw_lock, flags);
 
 	free_irq(dev->irq, dev);
-	release_region(dev->hw_io, ENE_IO_SIZE);
 	rc_unregister_device(dev->rdev);
+	del_timer_sync(&dev->tx_sim_timer);
+	release_region(dev->hw_io, ENE_IO_SIZE);
 	kfree(dev);
 }
 
-- 
2.17.1

