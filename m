Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16A69213A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjBJO4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBJO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:56:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C36C7E0;
        Fri, 10 Feb 2023 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676040983; x=1707576983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+AkmZ/j0Ltm2vhm8z9qz/CNnGgU1gRksq4fGSdRq2A=;
  b=ZRAVI9lZewkGovCvJFA4ELxbEj7yNcislun+FbR2mWA3NF5s/oyleXo4
   PnOsYPkexDk258+v7jjl84c8EwcUP2o9kkk10zKrmLOUKXqSfE6QpU+KD
   T85pNX3pTBK5DhwAySm4DGc8TD+AY3xOUTvAmirM+x5YzMFTNpmiZ5t9F
   dZ3pCYtoCZE9DblHapwkrq9GN3QkTMyGa8JyHhrTw9khRVFypTZOY0i6Z
   iiZIXyqESEgPaaKwjuB+sHSDB4HscaY4BqiHTI548zgqV7adXdd3Y8HDR
   Avo0Fv3yc1x53lqqvCa0TKWoaYyo5N06DTPrSdT/4x+an3Fz0jLAexbJV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="395041588"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="395041588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="776953052"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="776953052"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 06:56:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EFF961F8; Fri, 10 Feb 2023 16:56:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] pinctrl: at91: Use of_device_get_match_data()
Date:   Fri, 10 Feb 2023 16:56:54 +0200
Message-Id: <20230210145656.71838-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210145656.71838-1-andriy.shevchenko@linux.intel.com>
References: <20230210145656.71838-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 6d5ebdae0bf9..203a29ad9344 100644
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

