Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D38678713
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjAWUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjAWUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:35 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90DD36089;
        Mon, 23 Jan 2023 12:02:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D10BAFF802;
        Mon, 23 Jan 2023 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fmaqsb9kmO3TmJW/YFmsCtVyenih1v/2TVqIzrS5D/U=;
        b=Kp8ChoOOzQ1KdfXtuD2S1zrT433O4l9CqSQQyRtDdfoQhGAzPulstnAfVzPyEXX51OGB6V
        CDXbQmmgCReBshJHxahbHvyT8u+74XXT4cSA089gFgCjtrlnfqU8e5S9biJ6K8uQtjRVAg
        1DnuoSqdg5lKF63yCF/xO9TXKSPT2KxLBOs46FcAYTxh/g1JzX8m85HjzocS2I3Zsxq+yA
        AN8/R/oAy10ZqnSWGFJhTs7kkDN2vZan22zLnl7dA6g9xgnuFTEM2k9GRAAraQskV8YADr
        f08uLRxnKctQYbyxLWiS23BzCnHu+lBYnyXbsPyRFoE04OrgHaWZ5pMp9yIvSw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] rtc: pcf8563: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:14 +0100
Message-Id: <20230123200217.1236011-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
References: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow the IRQ type to be passed from the device tree if available as there
may be components changing the trigger type of the interrupt between the
RTC and the IRQ controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8563.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0a7fd9478465..7e720472213c 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -558,9 +558,14 @@ static int pcf8563_probe(struct i2c_client *client)
 	pcf8563->rtc->set_start_time = true;
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 				NULL, pcf8563_irq,
-				IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				IRQF_SHARED | IRQF_ONESHOT | irqflags,
 				pcf8563_driver.driver.name, client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ %d\n",
-- 
2.39.1

