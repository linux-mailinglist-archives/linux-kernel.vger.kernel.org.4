Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E264FEFF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLRNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 08:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiLRNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 08:34:17 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4240B1E9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 05:34:14 -0800 (PST)
Received: from ubuntu.localdomain (unknown [10.162.98.155])
        by mail-app4 (Coremail) with SMTP id cS_KCgCHGt3IFp9j82ZnCQ--.42703S2;
        Sun, 18 Dec 2022 21:34:08 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, laforge@gnumonks.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] Revert "char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol"
Date:   Sun, 18 Dec 2022 21:34:00 +0800
Message-Id: <20221218133400.99581-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgCHGt3IFp9j82ZnCQ--.42703S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fJr1UXw4rZFWUJry8Grg_yoW8Wr4UpF
        4FkF90yF48G39av3WDAa10934YgaySq34xKF4fG3s8ZF9Yq3WDKrykJFW3Kr1DXrZ5Jw1S
        v3Waqay3KF4jkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
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
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgwIAVZdtc6XkAAAsw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit be826ada52f1fcabed5b5217c94609ebf5967211.

The function monitor_card() is a timer handler that runs in an
atomic context, but it calls usleep_range() that can sleep.
As a result, the sleep-in-atomic-context bugs will happen.
The process is shown below:

    (atomic context)
monitor_card()
  set_protocol()
    usleep_range() //sleep

The origin commit c1986ee9bea3 ("[PATCH] New Omnikey Cardman
4000 driver") works fine.

Fixes: be826ada52f1 ("char: pcmcia: cm4000_cs: Replace mdelay with usleep_range in set_protocol")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Add comments so that this will not be changed again in the future.

 drivers/char/pcmcia/cm4000_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index adaec8fd4b1..e656f42a28a 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -529,7 +529,8 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
 			DEBUGP(5, dev, "NumRecBytes is valid\n");
 			break;
 		}
-		usleep_range(10000, 11000);
+		/* can not sleep as this is in atomic context */
+		mdelay(10);
 	}
 	if (i == 100) {
 		DEBUGP(5, dev, "Timeout waiting for NumRecBytes getting "
@@ -549,7 +550,8 @@ static int set_protocol(struct cm4000_dev *dev, struct ptsreq *ptsreq)
 			}
 			break;
 		}
-		usleep_range(10000, 11000);
+		/* can not sleep as this is in atomic context */
+		mdelay(10);
 	}
 
 	/* check whether it is a short PTS reply? */
-- 
2.17.1

