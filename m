Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74816C6854
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCWM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCWM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:29:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB0386B6;
        Thu, 23 Mar 2023 05:29:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NCTjRY129022;
        Thu, 23 Mar 2023 07:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679574585;
        bh=jfAz3nNZtnM8wt/Xe8+Ol2GrO9qEEqrh7IFYH6+9tvI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F4Npmk6XB15R4qhvjoMrOsFj1MLYc5fT2eYdcJXhvxjU1PvnRxBi9DZ7FK6YcOO38
         5lYLSRZ6J13inonE9vkRHgUxX3dDYuk1Ao65MYd5pAFMya7sVGxGU1QYEIhHGyyrKQ
         hogZhsoUSmTrNozxThZt2N2RyeZQWnidRnK1NcyI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NCTj6W038925
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 07:29:45 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 07:29:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 07:29:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NCTicN019249;
        Thu, 23 Mar 2023 07:29:44 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/2] gpio: davinci: Add irq chip flag to skip set wake
Date:   Thu, 23 Mar 2023 17:59:10 +0530
Message-ID: <20230323122910.991148-2-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323122910.991148-1-d-gole@ti.com>
References: <20230323122910.991148-1-d-gole@ti.com>
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

Add the IRQCHIP_SKIP_SET_WAKE flag since there are no special IRQ Wake
bits that can be set to enable wakeup IRQ.

Fixes: 3d9edf09d452 ("[ARM] 4457/2: davinci: GPIO support")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/gpio/gpio-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index d7595b39e8c4..aaaf61dc2632 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -322,7 +322,7 @@ static struct irq_chip gpio_irqchip = {
 	.irq_enable	= gpio_irq_enable,
 	.irq_disable	= gpio_irq_disable,
 	.irq_set_type	= gpio_irq_type,
-	.flags		= IRQCHIP_SET_TYPE_MASKED,
+	.flags		= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static void gpio_irq_handler(struct irq_desc *desc)
-- 
2.25.1

