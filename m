Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC566C6852
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCWM3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCWM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:29:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66856868B;
        Thu, 23 Mar 2023 05:29:44 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NCTfn5129015;
        Thu, 23 Mar 2023 07:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679574581;
        bh=WBtmHvLCnXFwimXJYXKj87tMDRRpgcs5A8ej9EYRbcw=;
        h=From:To:CC:Subject:Date;
        b=Daf6nrkjTVha6r2zrZ8D7JAq9IT5+ZVwIsW4AVEK16LcophOYeNO34mvWXZxgbxF7
         zCzhq7w1fAw/g8xvkOU2hI0Evnadw2Z+fkawrikWqVsvMUZO9/sG9uiJOxs/Klq5kv
         6P9Svc3j9Mmv5LQc/K06iO0fx3QnErazY2JdWdvE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NCTfU1031374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 07:29:41 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 07:29:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 07:29:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NCTeVY010812;
        Thu, 23 Mar 2023 07:29:40 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Devarsh Thakkar <devarsht@ti.com>
Subject: [RFC PATCH 1/2] gpio: davinci: Do not clear the bank intr enable bit in save_context
Date:   Thu, 23 Mar 2023 17:59:09 +0530
Message-ID: <20230323122910.991148-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt enable bits might be set if we want to use the GPIO as
wakeup source. Clearing this will mean disabling of interrupts in the GPIO
banks that we may want to wakeup from.
Thus remove the line that was clearing this bit from the driver's save
context function.

Fixes: 0651a730924b ("gpio: davinci: Add support for system suspend/resume PM")
Cc: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/gpio/gpio-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 7fc83057990a..d7595b39e8c4 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -639,9 +639,6 @@ static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
 		context->set_falling = readl_relaxed(&g->set_falling);
 	}
 
-	/* Clear Bank interrupt enable bit */
-	writel_relaxed(0, base + BINTEN);
-
 	/* Clear all interrupt status registers */
 	writel_relaxed(GENMASK(31, 0), &g->intstat);
 }
-- 
2.25.1

