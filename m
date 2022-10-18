Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B76024F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJRHGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJRHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:05:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F298B2F2;
        Tue, 18 Oct 2022 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666076752; x=1697612752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WesnfTizQ5udDjJjTAlHXwnfd5NfpD8mjhBShg0jKvU=;
  b=SjkkjZx2V0CpxDqvYzNmSt1xOFSVzQ+lWcaM0TRw+WCZ9SFm86EXC6Hs
   SjYC1Cj5gx1SVqN66JaPtIAXsLzTQ3OWXq2OB2cVDi6AHPEIXTJITOg/n
   MDKOXPCLkWXjvSpL/4WggsYVOlDddbYBJ9TiS3a5fNdQAs0YJ7sBl7LXZ
   A3ROUEWu8hTC4d9juI5POQbYdpoabFU+Aw1EaeVd9wEsAAhbnuM7JDmhB
   d247OTHuhVsCMn3MUwjYd/fbiZIzcW8LuT3UCwYqGG4Ub2Q+PYP6II0Kg
   5luxFpzFDISjEFo7jDYs3f8kqya/AuwnQGJPeMgoTjiqGZIP3DSYSvTRd
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="185289415"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 00:05:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 00:05:46 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 18 Oct 2022 00:05:44 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <michael@walle.cc>, <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] pinctrl: ocelot: Fix incorrect trigger of the interrupt.
Date:   Tue, 18 Oct 2022 09:09:59 +0200
Message-ID: <20221018070959.1322606-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt controller can detect only link changes. So in case an
external device generated a level based interrupt, then the interrupt
controller detected correctly the first edge. But the problem was that
the interrupt controller was detecting also the edge when the interrupt
was cleared. So it would generate another interrupt.
The fix for this is to clear the second interrupt but still check the
interrupt line status.

Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 266fbc9572736..3d5995cbcb782 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1864,19 +1864,28 @@ static void ocelot_irq_unmask_level(struct irq_data *data)
 	if (val & bit)
 		ack = true;
 
+	/* Try to clear any rising edges */
+	if (!active && ack)
+		regmap_write_bits(info->map, REG(OCELOT_GPIO_INTR, info, gpio),
+				  bit, bit);
+
 	/* Enable the interrupt now */
 	gpiochip_enable_irq(chip, gpio);
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   bit, bit);
 
 	/*
-	 * In case the interrupt line is still active and the interrupt
-	 * controller has not seen any changes in the interrupt line, then it
-	 * means that there happen another interrupt while the line was active.
+	 * In case the interrupt line is still active then it means that
+	 * there happen another interrupt while the line was active.
 	 * So we missed that one, so we need to kick the interrupt again
 	 * handler.
 	 */
-	if (active && !ack) {
+	regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
+	if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
+	      (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
+		active = true;
+
+	if (active) {
 		struct ocelot_irq_work *work;
 
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-- 
2.38.0

