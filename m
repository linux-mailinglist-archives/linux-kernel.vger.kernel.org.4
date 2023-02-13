Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAD694B82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBMPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjBMPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:45:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E8193EC;
        Mon, 13 Feb 2023 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676303100; x=1707839100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCTJpmH0g4s615gzulXEqG52DaZfgj/STvSUqeWLqJI=;
  b=KL7kCTd0z6e2vpfL9YlSg3ke+sGAG0awaORtOL5Bb39mHRAsV1CYXeWU
   Sx/MjIme8N/BzugoRVWI+pfr5Qt4byAYjwMmczhQYZYvo77HDtJgo3OH5
   8U5dmL3DLINZEEK7enPAAWeBI+D1xe2AGZKaf2FDNmZztbL1a3k2iTfsp
   7ohmerCOlPD37zdY0i8Zzoh8lJHDNqgJAEfmjNb8doLm0FhC4NBsxQMdE
   Q4lgx+GTzY0hcVpCr+aWTizUEc+uFUlLk4OWML+M5rESVl44G3M69KoMb
   uDY9qa6yTFYovnUFVJl/xFA55L5MkefQFV2zXrrN2G3h1Dgk34NOlcklp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="318938347"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318938347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618682265"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618682265"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 07:44:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26C61210; Mon, 13 Feb 2023 17:45:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] pinctrl: at91: Use of_device_get_match_data()
Date:   Mon, 13 Feb 2023 17:45:30 +0200
Message-Id: <20230213154532.32992-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
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

