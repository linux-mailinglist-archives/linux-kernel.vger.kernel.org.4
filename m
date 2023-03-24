Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BC6C7E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCXNTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:19:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA712860;
        Fri, 24 Mar 2023 06:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3B9EB82303;
        Fri, 24 Mar 2023 13:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F985C4339C;
        Fri, 24 Mar 2023 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679663940;
        bh=n5azJT38PvOIS9z98MuhiQgqA+N6UCY/FD9OPf2roSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iqx7xVtMtD8mPE+WbN/St84YFBtuaTHqFUyMKVBUCd3aEwUgX8JIecbiann+8L4Ty
         O5rD1RaBK0WBfya9CwIB4fJBWNjSS+yqHw+gTG+pcip1s4b8PQG7J7v036NxdG3EUN
         k+CFjUFkcFVunTIMlsnjfa2Cgi4lvEj19lCvTqNBkhu1hSj4at5htyhxDpYGqAOlnT
         3A/OArQMOHSZ4zpy9RP/+Kk8I3+bPbVQiQsFA8SYOunc65q8Owlo/u/evCG9H7Mxap
         /n+g66NqWo6ltnaKMet5xsom/9V/4ET3Tmb+2tIxIy24z6NjNmV/BlcOTyhgSYC1GY
         g07MvLDjUCYiA==
From:   Roger Quadros <rogerq@kernel.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] usb: typec: tps6598x: Add support for polling interrupts status
Date:   Fri, 24 Mar 2023 15:18:53 +0200
Message-Id: <20230324131853.41102-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

Some development boards don't have the interrupt line connected.

In such cases we can resort to polling the interrupt status.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 41 ++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 485b90c13078..d28ffa10a122 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -16,6 +16,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/role.h>
+#include <linux/workqueue.h>
 
 #include "tps6598x.h"
 #include "trace.h"
@@ -97,6 +98,8 @@ struct tps6598x {
 
 	int wakeup;
 	u16 pwr_status;
+	struct delayed_work	wq_poll;
+	irq_handler_t irq_handler;
 };
 
 static enum power_supply_property tps6598x_psy_props[] = {
@@ -568,6 +571,18 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
+/* Time interval for Polling */
+#define POLL_INTERVAL	500 /* msecs */
+static void tps6598x_poll_work(struct work_struct *work)
+{
+	struct tps6598x *tps = container_of(to_delayed_work(work),
+					    struct tps6598x, wq_poll);
+
+	tps->irq_handler(0, tps);
+	queue_delayed_work(system_power_efficient_wq,
+			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
+}
+
 static int tps6598x_check_mode(struct tps6598x *tps)
 {
 	char mode[5] = { };
@@ -746,6 +761,7 @@ static int tps6598x_probe(struct i2c_client *client)
 			TPS_REG_INT_PLUG_EVENT;
 	}
 
+	tps->irq_handler = irq_handler;
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
 	if (ret)
@@ -837,10 +853,18 @@ static int tps6598x_probe(struct i2c_client *client)
 			dev_err(&client->dev, "failed to register partner\n");
 	}
 
-	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					irq_handler,
-					IRQF_SHARED | IRQF_ONESHOT,
-					dev_name(&client->dev), tps);
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						irq_handler,
+						IRQF_SHARED | IRQF_ONESHOT,
+						dev_name(&client->dev), tps);
+	} else {
+		dev_warn(tps->dev, "Unable to find the interrupt, switching to polling\n");
+		INIT_DELAYED_WORK(&tps->wq_poll, tps6598x_poll_work);
+		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
+				   msecs_to_jiffies(POLL_INTERVAL));
+	}
+
 	if (ret)
 		goto err_disconnect;
 
@@ -848,7 +872,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	fwnode_handle_put(fwnode);
 
 	tps->wakeup = device_property_read_bool(tps->dev, "wakeup-source");
-	if (tps->wakeup) {
+	if (tps->wakeup && client->irq) {
 		device_init_wakeup(&client->dev, true);
 		enable_irq_wake(client->irq);
 	}
@@ -887,6 +911,9 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
 		enable_irq_wake(client->irq);
 	}
 
+	if (!client->irq)
+		cancel_delayed_work_sync(&tps->wq_poll);
+
 	return 0;
 }
 
@@ -900,6 +927,10 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		enable_irq(client->irq);
 	}
 
+	if (client->irq)
+		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
+				   msecs_to_jiffies(POLL_INTERVAL));
+
 	return 0;
 }
 
-- 
2.34.1

