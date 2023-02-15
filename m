Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A249697DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBONmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBONmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:42:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E42E0D5;
        Wed, 15 Feb 2023 05:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468529; x=1708004529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGZTgxIhMsUzgY8FxmNXbX88JsjVT1Ty1RH/GYeJM58=;
  b=MyezgMN8ydcaGJwa2s4DsbajGCN0+25Bf5B2e+0GRzliKRMfhuvhXom8
   lSPEBY1Z2CJObiIbR+AO3GvQ3Kq1Pdfd8etMAU3yMar67syVz6QeQgD/O
   tWWymNhQt8YuidiIDczTI0lCiz91Mkq80ck9IqvYcZ3gf5BBa4tVL78ps
   CsuRg74CLw539P/frl6Tw/jTq4Aua2rm9duVWBotMUKu1WbgiCLa8dMqW
   MDP9+X/DnIonxtl6IZxhss2LAwfNq8YZZE2xc3LqoFbpmhQJSsQkvSDTZ
   rOLjNGuBG1P5+CD6uNB0LQOwuMCHNzFtHhktlzs9a2QssjS+mbASagrvL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358849426"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358849426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793502741"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="793502741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 05:42:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F2E2210; Wed, 15 Feb 2023 15:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] pinctrl: at91: Use of_device_get_match_data()
Date:   Wed, 15 Feb 2023 15:42:40 +0200
Message-Id: <20230215134242.37618-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 6d9015ed8a3b..055a88b2dacc 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1304,8 +1304,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENODEV;
 
 	info->dev = &pdev->dev;
-	info->ops = (const struct at91_pinctrl_mux_ops *)
-		of_match_device(at91_pinctrl_of_match, &pdev->dev)->data;
+	info->ops = of_device_get_match_data(dev);
 	at91_pinctrl_child_count(info, np);
 
 	/*
@@ -1844,8 +1843,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	at91_chip->ops = (const struct at91_pinctrl_mux_ops *)
-		of_match_device(at91_gpio_of_match, &pdev->dev)->data;
+	at91_chip->ops = of_device_get_match_data(dev);
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
 
-- 
2.39.1

