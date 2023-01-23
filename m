Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7E678705
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjAWUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:27 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C3A28854;
        Mon, 23 Jan 2023 12:02:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9177F20004;
        Mon, 23 Jan 2023 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kLnDNkkI/ofompHbNI3p/Hi3nJNzFutm9TcQL778pmU=;
        b=LMfds0bSuBsB94c2ksSXe1FONM3/3/f71kCpvAXvVHbL91NuxgvmrsILGKsP+yMcFuS9DL
        H8SjvACmS9y/W4VQGT8yaJVcws6sx8cu1V0K/sRID1EoUEcmPUQRPTLsUOHG7FgYBAAYzL
        9WzYKZPcxBvJ73NK3iIEtRuqWaD20ElimzkkuhIc10RGxesUFqG+K+7dnsJz+FJHSU+9np
        CG3wEu0q49NQBmbFmT3vDnke0BeP9KRUzlUN2omGkPPU9TtofWL3/sEEVBGgCGbERw1KfP
        8KUuJaGYgI3ngOPqGpVrgyiD6L/+mZlY6hGDtUNY6VPJjxggKAmkImO4hrbIDw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] rtc: rx8010: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:06 +0100
Message-Id: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
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
 drivers/rtc/rtc-rx8010.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 5e2fd39f70bb..b9c8dad26208 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -394,9 +394,14 @@ static int rx8010_probe(struct i2c_client *client)
 		return PTR_ERR(rx8010->rtc);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		err = devm_request_threaded_irq(dev, client->irq, NULL,
 						rx8010_irq_1_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						"rx8010", client);
 		if (err) {
 			dev_err(dev, "unable to request IRQ\n");
-- 
2.39.1

