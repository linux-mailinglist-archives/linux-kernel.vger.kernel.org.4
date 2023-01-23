Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F1678711
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjAWUCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjAWUCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:34 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6173236691;
        Mon, 23 Jan 2023 12:02:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 39BC620005;
        Mon, 23 Jan 2023 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cX4WT0iUjsi0ct/mZF8XOG2185oGJ6UhHNdyoYuiuYI=;
        b=L9okzIkIOjt6FAoqR3EvvcJ9ZVKrXwt8Yy2qY0y8xGgrlULzKDPxZ/bWjcbKDKbRDik9P5
        OrAOcZVmMNBIo/Oz3+Tnb47ZgyJWiNjtXBzFsVAhKmiFEHi8DbKHMEj9N2DIf0rdVK9+39
        Kj1zwzWXqtIvyl+9nyUHjLJzyp4Jk5fzemo3MYWwrOJu/StMTwb+6YnH6C0+WTHXWsE26I
        I5E+tudFrTQ5zC4pjNsyuJ4+Xb45FlfN8H7LMNvgxbneePwlZtHHhtoEqGEHvXR1AcjmHx
        cq7qlL0MsAWaQy0npGO0f+59R4W4JBHMYAF49sTVJ+pLOMjAzThqhbTCFeOAsw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] rtc: pcf8523: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:12 +0100
Message-Id: <20230123200217.1236011-7-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf8523.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 92de99f11a7a..2e111cdb94f7 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -445,13 +445,18 @@ static int pcf8523_probe(struct i2c_client *client)
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		err = regmap_write(pcf8523->regmap, PCF8523_TMR_CLKOUT_CTRL, 0x38);
 		if (err < 0)
 			return err;
 
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf8523_irq,
-						IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+						IRQF_SHARED | IRQF_ONESHOT | irqflags,
 						dev_name(&rtc->dev), pcf8523);
 		if (err)
 			return err;
-- 
2.39.1

