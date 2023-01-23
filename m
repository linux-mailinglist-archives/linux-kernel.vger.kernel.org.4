Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48E678712
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjAWUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjAWUCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:34 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5222430EBF;
        Mon, 23 Jan 2023 12:02:31 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 04DFC100007;
        Mon, 23 Jan 2023 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUMSKoIqoTY1ys3wlmeSnwP9pCI3vVCTlSO8cM9HZHU=;
        b=jQ1/tQVVLTcCrf/Q0N71HrN+ndkglafDwHTNyQ1ynK1lm3amQGKK8o1dI3Elc/sqpP6VWU
        7pmfnCXfMdA+W+zYl6u12ZyZXzLrf1J6jh74RNwudhNcoUaw9bVSiKHHA9Lk5Np6kP6KEb
        OMKlR3NHKJ+ghDiDzrJne+VdVQ+/lmSBlg9EMbCvkclppJEmkp604/kQsVz1TpSN2RA5Ne
        Qw0vraFLbyNTVG8HwU6OrEUTBcBeGIzThQXzy7SdhEdFf/FCRk+ZQBy8hfWQWx+bWaABPx
        v+RiXYQ9+qZV7UrZjwxuFFtkWN3Xu6eR/xvJN/MrjUaM0S+++KNo4jAahdRJzw==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] rtc: pcf85363: use IRQ flags obtained fromfwnode
Date:   Mon, 23 Jan 2023 21:02:13 +0100
Message-Id: <20230123200217.1236011-8-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf85363.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c05b722f0060..5de323acd178 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -400,12 +400,17 @@ static int pcf85363_probe(struct i2c_client *client)
 	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
 				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						"pcf85363", client);
 		if (ret)
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-- 
2.39.1

