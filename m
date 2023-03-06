Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973A96ACEA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCFT4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCFTzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9067008;
        Mon,  6 Mar 2023 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132544; x=1709668544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SFgifrqhkmsPANQZmuCQE2iTgDgwx3gMBtOgb0D6EI=;
  b=V36p920UqBS5EVvio5dFDx77kcRqDNpKHT2LwEabVWd1gLF2gYd3Kn4j
   qhHOUjzq4nB/IZA+Dk8GmcINgA+dBueFtoRETbUVRHHq+p2aSGJjBgMqJ
   D8xrqLqVR1ihRcSg9ptBpq2Yi8jooVLEbb5ykwUzxSCCvdXVmn+0WBoVo
   kSG9X5kE2Uitjov6TsB40kr2d3p8EV25cSM1WfZWLZwiYRTzyca2m7/Wa
   dXyCaBmcrJvwOWk3rzzjr6dCx5At2oUuAA9tjsEY1cp/mnM8M29kUtTt2
   P2fGAn4xLpbH22gV5BIc/TKwD+Kf9kkTEPpOWgwf1UWITgDrrS5CNI1Lo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333129000"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333129000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745185192"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745185192"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2023 11:55:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C9B5484; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 07/16] gpio: brcmstb: Utilize helpers from string_choices.h
Date:   Mon,  6 Mar 2023 21:55:47 +0200
Message-Id: <20230306195556.55475-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
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

There are a few helpers available to convert a boolean variable
to the dedicated string literals depending on the application.
Use them in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index c55b35da61a0..a0535be1201c 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -9,6 +9,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
+#include <linux/string_choices.h>
 
 enum gio_reg_index {
 	GIO_REG_ODEN = 0,
@@ -225,7 +226,7 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
 		ret = disable_irq_wake(priv->parent_wake_irq);
 	if (ret)
 		dev_err(&priv->pdev->dev, "failed to %s wake-up interrupt\n",
-				enable ? "enable" : "disable");
+			str_enable_disable(enable));
 	return ret;
 }
 
-- 
2.39.1

