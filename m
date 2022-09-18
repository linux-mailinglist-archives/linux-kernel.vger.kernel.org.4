Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40A5BBB4A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIRDdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIRDd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:33:29 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A83E26AFF;
        Sat, 17 Sep 2022 20:33:26 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app2 (Coremail) with SMTP id by_KCgA3PiJ5kSZjDuz2BQ--.48716S2;
        Sun, 18 Sep 2022 11:33:21 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] usb: chipidea: fix deadlock in ci_otg_del_timer
Date:   Sun, 18 Sep 2022 11:33:12 +0800
Message-Id: <20220918033312.94348-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgA3PiJ5kSZjDuz2BQ--.48716S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDGrWkWFW8tF1xJr4fZrb_yoW8AFykpa
        17Xa4ftF1DAr4Ut3W8t3Wv9ryfXanFgrZrJFyfK3yUZw1xuF1UKFykG3yFqFW7J3Z3Krsx
        tr4rXr93AF1fC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgoQAVZdtbgaKwAmsI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in ci_otg_del_timer(), the process is
shown below:

    (thread 1)                  |        (thread 2)
ci_otg_del_timer()              | ci_otg_hrtimer_func()
  ...                           |
  spin_lock_irqsave() //(1)     |  ...
  ...                           |
  hrtimer_cancel()              |  spin_lock_irqsave() //(2)
  (block forever)

We hold ci->lock in position (1) and use hrtimer_cancel() to
wait ci_otg_hrtimer_func() to stop, but ci_otg_hrtimer_func()
also need ci->lock in position (2). As a result, the
hrtimer_cancel() in ci_otg_del_timer() will be blocked forever.

This patch extracts hrtimer_cancel() from the protection of
spin_lock_irqsave() in order that the ci_otg_hrtimer_func()
could obtain the ci->lock.

What`s more, there will be no race happen. Because the
"next_timer" is always under the protection of
spin_lock_irqsave() and we only check whether "next_timer"
equals to NUM_OTG_FSM_TIMERS in the following code.

Fixes: 3a316ec4c91c ("usb: chipidea: use hrtimer for otg fsm timers")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/usb/chipidea/otg_fsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 61b157b9c66..a7858462428 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -256,8 +256,10 @@ static void ci_otg_del_timer(struct ci_hdrc *ci, enum otg_fsm_timer t)
 	ci->enabled_otg_timer_bits &= ~(1 << t);
 	if (ci->next_otg_timer == t) {
 		if (ci->enabled_otg_timer_bits == 0) {
+			spin_unlock_irqrestore(&ci->lock, flags);
 			/* No enabled timers after delete it */
 			hrtimer_cancel(&ci->otg_fsm_hrtimer);
+			spin_lock_irqsave(&ci->lock, flags);
 			ci->next_otg_timer = NUM_OTG_FSM_TIMERS;
 		} else {
 			/* Find the next timer */
-- 
2.17.1

