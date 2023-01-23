Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77E767870E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjAWUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjAWUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:31 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB530EBF;
        Mon, 23 Jan 2023 12:02:29 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F31824000B;
        Mon, 23 Jan 2023 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s8fB4SB1tQYPXzwsCZtyf9R6xiwoC+ZC5ZWgRWvKTE=;
        b=H3jCM/ZVWDDDNwuETFqpY5ZJy8yxY2BBXf/O5Bs27SAYGCPcLWbov9Q57NS6aGIU34Nn3z
        GGdpvNVdH3DeFYVG9sT89EWhGesgHEpI/izuEiDLest+d8YUmO9wbsLNVPHkT/aKx3xTQq
        GtH9M4950RAmWi4xo9DoE3dnzIvsM4A10QnXnKKbk2uEFys3OzbNzjxQWy2WvN2kFHfJcZ
        o6Gs8vLqJKiFOo8rnuP8707oac8orIpSL9PgThLiFyxBzfe/pchZgP1KJKFyXuuoXt4CWn
        hR01/HvjtRKbPNlp6MVYY6aEl9by3UDvQwvh4P7Wm6HxJQC7Y3KwI5tFHnNAvQ==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] rtc: pcf2123: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:10 +0100
Message-Id: <20230123200217.1236011-5-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf2123.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index e13b5e695d06..e714661e61a9 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -413,9 +413,14 @@ static int pcf2123_probe(struct spi_device *spi)
 
 	/* Register alarm irq */
 	if (spi->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&spi->dev))
+			irqflags = 0;
+
 		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
 				pcf2123_rtc_irq,
-				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				irqflags | IRQF_ONESHOT,
 				pcf2123_driver.driver.name, &spi->dev);
 		if (!ret)
 			device_init_wakeup(&spi->dev, true);
-- 
2.39.1

