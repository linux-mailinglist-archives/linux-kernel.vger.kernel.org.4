Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33132605F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiJTLpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJTLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:45:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF43846A;
        Thu, 20 Oct 2022 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666266291; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KWh0qYj9ci/7l0SX9GJj178mtuBeJCrc8Rr6rhBv1Jc=;
        b=u83sYt3GAv6rj/z9kDSku4S97vyjayKoxcYlVSdoKPNL/KY3brawOXpGYHm4rObisxIstC
        l6mglpeBzZ5d9fTxnPNgopGjabTMtIDybi+x6J6UF5tSUMs+petIMQSGBYp0r4sZnUOwFp
        L6e4gPyLTaKccL986vLX5YQHEaz1N9w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] leds: max8997: Don't error if there is no pdata
Date:   Thu, 20 Oct 2022 12:44:42 +0100
Message-Id: <20221020114442.22215-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver works just fine if no platform data is supplied.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 v2: Add Andy's reviewed-by and reword the commit description.

 drivers/leds/leds-max8997.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
index c0bddb33888d..c8d7f55c9dec 100644
--- a/drivers/leds/leds-max8997.c
+++ b/drivers/leds/leds-max8997.c
@@ -238,11 +238,6 @@ static int max8997_led_probe(struct platform_device *pdev)
 	char name[20];
 	int ret = 0;
 
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -ENODEV;
-	}
-
 	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
 	if (led == NULL)
 		return -ENOMEM;
@@ -258,7 +253,7 @@ static int max8997_led_probe(struct platform_device *pdev)
 	led->iodev = iodev;
 
 	/* initialize mode and brightness according to platform_data */
-	if (pdata->led_pdata) {
+	if (pdata && pdata->led_pdata) {
 		u8 mode = 0, brightness = 0;
 
 		mode = pdata->led_pdata->mode[led->id];
-- 
2.35.1

