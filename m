Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE367870C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjAWUCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjAWUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:29 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7528854;
        Mon, 23 Jan 2023 12:02:28 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B150D40005;
        Mon, 23 Jan 2023 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4CYOl5oNdw44YefzmYwC9lPiS1qIhS68kXXq1VFs7Y=;
        b=Zy6NVI6mqBIUHMRhbq92oVN/rz91vj+BTE2KLGqj1zYuVn0X1kCg2TYEIFZkRPFaRyK/Uc
        dmjWfVt6HwtDIuo6tu8y4KgHScBGOZ71EPBwXCRrRCM+Niw2WcMdRUNYuHsugB3VVtHrB6
        g86FnThlDyF1MDZFar+m+boHgOX03Xwv03P6Jxi/u59SexLM50WBTR0OdG7mKEa7JG2eAU
        Bviag3+orR22GvUFK2vooa/DSy70naTS8ZBHgkvHp0LzCkhuP7/YrcC/JWyqVCqw466SBq
        LSDDoYOCFOnlQxuBFJ4k3FP35C13yWT0+EzqQmZpk5Y3csjnVWKGhmqJpb7OMA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] rtc: m41t80: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:09 +0100
Message-Id: <20230123200217.1236011-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
References: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-m41t80.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 494052dbd39f..c1963f7c424d 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -914,9 +914,14 @@ static int m41t80_probe(struct i2c_client *client)
 					      "wakeup-source");
 #endif
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		rc = devm_request_threaded_irq(&client->dev, client->irq,
 					       NULL, m41t80_handle_irq,
-					       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					       irqflags | IRQF_ONESHOT,
 					       "m41t80", client);
 		if (rc) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-- 
2.39.1

