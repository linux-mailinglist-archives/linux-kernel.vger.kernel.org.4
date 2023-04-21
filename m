Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505C66EA5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDUIe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDUIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:34:51 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 01:34:48 PDT
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 629475B8F;
        Fri, 21 Apr 2023 01:34:48 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [106.117.98.24])
        by mail-app4 (Coremail) with SMTP id cS_KCgCn+bFfSUJkjtmAAA--.53646S2;
        Fri, 21 Apr 2023 16:29:28 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        dmitry.torokhov@gmail.com, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] Input: cyttsp4_core - change del_timer_sync() to timer_shutdown_sync()
Date:   Fri, 21 Apr 2023 16:29:19 +0800
Message-Id: <20230421082919.8471-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgCn+bFfSUJkjtmAAA--.53646S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17CF43AF13Ar13Kr1kAFb_yoW8tr18p3
        y3Cr13Jw48GFWUtr17J3s7ZF95Cw15KFyUKF47Gws5Zrn3AryrAF1FyrWfGFW3JFZ8ZFn3
        Jr4Fv3y5GF9Ykr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUIzuXUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIMAWRBVNslyAAasR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog_timer can schedule tx_timeout_task and watchdog_work
can also arm watchdog_timer. The process is shown below:

----------- timer schedules work ------------
cyttsp4_watchdog_timer() //timer handler
  schedule_work(&cd->watchdog_work)

----------- work arms timer ------------
cyttsp4_watchdog_work() //workqueue callback function
  cyttsp4_start_wd_timer()
    mod_timer(&cd->watchdog_timer, ...)

Although del_timer_sync() and cancel_work_sync() are called in
cyttsp4_remove(), the timer and workqueue could still be rearmed.
As a result, the possible use after free bugs could happen. The
process is shown below:

  (cleanup routine)           |  (timer and workqueue routine)
cyttsp4_remove()              | cyttsp4_watchdog_timer() //timer
  cyttsp4_stop_wd_timer()     |   schedule_work()
    del_timer_sync()          |
                              | cyttsp4_watchdog_work() //worker
                              |   cyttsp4_start_wd_timer()
                              |     mod_timer()
    cancel_work_sync()        |
                              | cyttsp4_watchdog_timer() //timer
                              |   schedule_work()
    del_timer_sync()          |
  kfree(cd) //FREE            |
                              | cyttsp4_watchdog_work() // reschedule!
                              |   cd-> //USE

This patch changes del_timer_sync() to timer_shutdown_sync(),
which could prevent rearming of the timer from the workqueue.

Fixes: 17fb1563d69b ("Input: cyttsp4 - add core driver for Cypress TMA4XX touchscreen devices")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/input/touchscreen/cyttsp4_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 0cd6f626ade..7cb26929dc7 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -1263,9 +1263,8 @@ static void cyttsp4_stop_wd_timer(struct cyttsp4 *cd)
 	 * Ensure we wait until the watchdog timer
 	 * running on a different CPU finishes
 	 */
-	del_timer_sync(&cd->watchdog_timer);
+	timer_shutdown_sync(&cd->watchdog_timer);
 	cancel_work_sync(&cd->watchdog_work);
-	del_timer_sync(&cd->watchdog_timer);
 }
 
 static void cyttsp4_watchdog_timer(struct timer_list *t)
-- 
2.17.1

