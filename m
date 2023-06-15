Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9EB7315D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjFOKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbjFOKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:54:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6F269A;
        Thu, 15 Jun 2023 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686826455; x=1718362455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkwNJa0lrqgcBoAYQJldjJ8QWkitSk0hghnyQyG2tqs=;
  b=hT9Nt/YdvKF7OJU2kBX7ebjgrYQwFzQ0wi1fgS3SgxQxMwQ/yEW7wwwD
   Etyc26BUl87d/CTiLDR4yZ8QuRV4nbiCCHlsqLuVRR92Px0Of3+QQfrGx
   hdL4vTbJ12QOqQUEvMtJ/e9Dmm4l2vB4+0o7lvfwaBP4sB7iagqV+Ry9f
   Bqm8UovqRIhRYWmjuMU2EvZQg7lTJCzg5zqb0Lcd9M3X0rcLw8txbxG7Z
   jYf4M1UfTsx3+slTNX8ZUp5KitcIbClV6Jpe1tPtPjSDrQm0errGO1qCx
   wp3VJbQImV8olCph7USS4eP/be9i927bAUkFXgj47+Oorok2DdT4OYj+6
   g==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218006816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 03:54:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 03:54:06 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 03:54:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] pinctrl: at91-pio4: check return value of devm_kasprintf()
Date:   Thu, 15 Jun 2023 13:53:33 +0300
Message-ID: <20230615105333.585304-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615105333.585304-1-claudiu.beznea@microchip.com>
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
Depends-on: 1c4e5c470a56 ("pinctrl: at91: use devm_kasprintf() to avoid potential leaks")
Depends-on: 5a8f9cf269e8 ("pinctrl: at91-pio4: use proper format specifier for unsigned int")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index e40487be2038..fc7d7155bb8d 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1146,6 +1146,8 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		/* Pin naming convention: P(bank_name)(bank_pin_number). */
 		pin_desc[i].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "P%c%u",
 						  bank + 'A', line);
+		if (!pin_desc[i].name)
+			return -ENOMEM;
 
 		group->name = group_names[i] = pin_desc[i].name;
 		group->pin = pin_desc[i].number;
-- 
2.34.1

