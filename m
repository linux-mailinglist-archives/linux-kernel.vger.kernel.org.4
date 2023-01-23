Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8282A678718
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjAWUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjAWUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:35 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B23366A5;
        Mon, 23 Jan 2023 12:02:33 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 65E4440014;
        Mon, 23 Jan 2023 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoJz4NTugfiOLZnwnnd2c9EVeNFPlrapvV4p8gpqtPE=;
        b=Npzqv5NozjwgAjAgr7Z6+OjREe/p5GQKuBhIfnfTmmKIpsMIN1XZqkCDHvcsfskqUnpD87
        zhFVIRbd77OvgN1dOwLDATWRqwpdF0Bm9uH2nTVncTS+717QBjPY7b2jW3HeBmjv/ytrFC
        jW3feMC42YYP8Tu0TnHlQBWUqEyTzV8u6enl2FdeCDoGSENTHE3u9OOzL+ithKrsFbEMLJ
        yu+xM456bTptvcBlT7W3JYdYG3X02EH0eVEwc5slPYnLhSWUSRy2w9FADBNhsev0ZzZkzE
        Hafxe982zyQQ1mGQnfe15tbhE7y9F6ybJNQDc5/C9Xu571IcxUlOwvZwmPTz5w==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] rtc: rv3032: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:16 +0100
Message-Id: <20230123200217.1236011-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
References: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-rv3032.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index c3bee305eacc..bf6954ec5943 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -930,9 +930,14 @@ static int rv3032_probe(struct i2c_client *client)
 		return PTR_ERR(rv3032->rtc);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, rv3032_handle_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						"rv3032", rv3032);
 		if (ret) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-- 
2.39.1

