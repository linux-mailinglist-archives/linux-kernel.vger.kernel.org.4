Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E9678708
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjAWUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjAWUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:28 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49BA30E93;
        Mon, 23 Jan 2023 12:02:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E72640006;
        Mon, 23 Jan 2023 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itQ/AGjKyNo2fkcIbkmOoRnuNHgnlz3Nr0BwieritzE=;
        b=XVzFPaXmTJzszYm9iugkGbl66Q8+SpKYtxXDwZ5GnZbsl9xhZ5WOMrmzXBuvxCk4Fe1Hg/
        L0b6FADbFn0NivlQaFO2GqNBtScJXlJdp4nbZuItxfbvIU1L0mkVgBeSrmYuM68/AAp7Al
        jWxNiYOjkojXQgCs54HkRVK2Inq1PKOWBJF+toxQsIkFsAZ8UjGi9eLQV8tHHx5p21wh6k
        RMgkslp7QhJ3l/664TuF1Kf0JGnifiFMIHkSFxYZTfjsHcPnEkXhB4tIP852cEvls6ze1f
        yH+80lm5gc4xrrubzqZ+xCyQmqTbg4z9eaeMcii7I49AjMxLG/1esM5YXzzOPA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] rtc: ab-eoz9: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:07 +0100
Message-Id: <20230123200217.1236011-2-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-ab-eoz9.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ab-eoz9.c b/drivers/rtc/rtc-ab-eoz9.c
index 2f8deb8c4cd3..34611f6dedcb 100644
--- a/drivers/rtc/rtc-ab-eoz9.c
+++ b/drivers/rtc/rtc-ab-eoz9.c
@@ -536,9 +536,14 @@ static int abeoz9_probe(struct i2c_client *client)
 	clear_bit(RTC_FEATURE_ALARM, data->rtc->features);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						abeoz9_rtc_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						dev_name(dev), dev);
 		if (ret) {
 			dev_err(dev, "failed to request alarm irq\n");
-- 
2.39.1

