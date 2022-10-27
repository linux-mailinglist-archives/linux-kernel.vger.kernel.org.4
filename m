Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D560FBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiJ0PVu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Oct 2022 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiJ0PVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:21:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DECD101D6;
        Thu, 27 Oct 2022 08:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3E28B826DB;
        Thu, 27 Oct 2022 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20249C433C1;
        Thu, 27 Oct 2022 15:21:03 +0000 (UTC)
Date:   Thu, 27 Oct 2022 11:21:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [RFC][PATCH v2 15/31] timers: Input: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221027112117.7324570a@gandalf.local.home>
In-Reply-To: <20221027150927.992061541@goodmis.org>
References: <20221027150525.753064657@goodmis.org>
        <20221027150927.992061541@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  quilt mail --send still can't handle unicode characters.
    Here's the patch again
]

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/input/keyboard/locomokbd.c   | 2 +-
 drivers/input/keyboard/omap-keypad.c | 2 +-
 drivers/input/mouse/alps.c           | 2 +-
 drivers/input/serio/hil_mlc.c        | 2 +-
 drivers/input/serio/hp_sdc.c         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index dae053596572..aabd1f6a986a 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -310,7 +310,7 @@ static void locomokbd_remove(struct locomo_dev *dev)
 
 	free_irq(dev->irq[0], locomokbd);
 
-	del_timer_sync(&locomokbd->timer);
+	del_timer_shutdown(&locomokbd->timer);
 
 	input_unregister_device(locomokbd->input);
 	locomo_set_drvdata(dev, NULL);
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 57447d6c9007..39974158961d 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -296,7 +296,7 @@ static int omap_kp_remove(struct platform_device *pdev)
 	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	free_irq(omap_kp->irq, omap_kp);
 
-	del_timer_sync(&omap_kp->timer);
+	del_timer_shutdown(&omap_kp->timer);
 	tasklet_kill(&kp_tasklet);
 
 	/* unregister everything */
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4a6b33bbe7ea..4d402e75aca8 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2970,7 +2970,7 @@ static void alps_disconnect(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 
 	psmouse_reset(psmouse);
-	del_timer_sync(&priv->timer);
+	del_timer_shutdown(&priv->timer);
 	if (priv->dev2)
 		input_unregister_device(priv->dev2);
 	if (!IS_ERR_OR_NULL(priv->dev3))
diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index d36e89d6fc54..33fc73da8e54 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -1017,7 +1017,7 @@ static int __init hil_mlc_init(void)
 
 static void __exit hil_mlc_exit(void)
 {
-	del_timer_sync(&hil_mlcs_kicker);
+	del_timer_shutdown(&hil_mlcs_kicker);
 	tasklet_kill(&hil_mlcs_tasklet);
 }
 
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 13eacf6ab431..49e5884df801 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -980,7 +980,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	del_timer_sync(&hp_sdc.kicker);
+	del_timer_shutdown(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 
-- 
2.35.1
