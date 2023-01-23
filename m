Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C143678717
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjAWUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjAWUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:35 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA831E25;
        Mon, 23 Jan 2023 12:02:33 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A32466000B;
        Mon, 23 Jan 2023 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXtTZs09uSxVKKdsIxv/TOmQrf4x0mBpqBxucCPNmJk=;
        b=gV+g4gEOzAaXk8QjVfnAgZ8mMAg+uOJgXpM3ec3BYhHv7G1djqNH29+VxaFwowEFTxR+lH
        CpTpHdwubehIyALaEalN5SH8QK8nxlPIKuxFhDqKSHlDpT39+iLVsfUnpCk3uRdRMGorYU
        0aNly5ODQ+befIvIhR+WdLhFNac90bd2W5iEmOplcLmijNQhIMPJmea8mYoGLtnLUHCC7P
        jpdaiVqpHCz2eFaG0Fnfc2sRS3seOVgaD6tBy54Of5J1eZwExAJNb6TXWQ1get+MR819lC
        n/hXkBKvSMX8zhUvEM+Bfxi8JOWhp60bE0OV4kda/hJqS8p/3yvpiSFzOTSRNA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] rtc: rv3029c2: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:15 +0100
Message-Id: <20230123200217.1236011-10-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rv3029c2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index e4fdd47ae066..0852f6709a85 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -735,9 +735,14 @@ static int rv3029_probe(struct device *dev, struct regmap *regmap, int irq,
 		return PTR_ERR(rv3029->rtc);
 
 	if (rv3029->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(dev))
+			irqflags = 0;
+
 		rc = devm_request_threaded_irq(dev, rv3029->irq,
 					       NULL, rv3029_handle_irq,
-					       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					       irqflags | IRQF_ONESHOT,
 					       "rv3029", dev);
 		if (rc) {
 			dev_warn(dev, "unable to request IRQ, alarms disabled\n");
-- 
2.39.1

