Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EC6773BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 02:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAWBM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 20:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWBMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:12:55 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F2F70EB7C;
        Sun, 22 Jan 2023 17:12:50 -0800 (PST)
Received: from ubuntu.localdomain (unknown [112.254.167.99])
        by mail-app4 (Coremail) with SMTP id cS_KCgB3nN_63s1jv4NmCg--.22122S2;
        Mon, 23 Jan 2023 09:12:37 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, maximlevitsky@gmail.com,
        sean@mess.org, mchehab@kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] media: rc: Fix use-after-free bugs caused by ene_tx_irqsim()
Date:   Mon, 23 Jan 2023 09:12:23 +0800
Message-Id: <20230123011223.23804-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgB3nN_63s1jv4NmCg--.22122S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrJF17Kw1rAw4xuF17Jrb_yoW8JFW8pr
        W8GFWSkFyUGw12gFnrXw4ku3W5Xws3Ja4UW342g3y0vwn5GFy3JF90qa4jvay8AF95AFZF
        vr45Xw43CFsxuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6w4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUg4SOUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIDAVZdtdUtdwAqsZ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
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

This problem is found by static analysis.

Fixes: 9ea53b74df9c ("V4L/DVB: STAGING: remove lirc_ene0100 driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/media/rc/ene_ir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index e09270916fb..716b72a048f 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -1114,6 +1114,7 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 	free_irq(dev->irq, dev);
 	release_region(dev->hw_io, ENE_IO_SIZE);
 	rc_unregister_device(dev->rdev);
+	del_timer_sync(&dev->tx_sim_timer);
 	kfree(dev);
 }
 
-- 
2.17.1

