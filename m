Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC25ECBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiI0RzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiI0RzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:55:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D0C6453;
        Tue, 27 Sep 2022 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664301296; x=1695837296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kPvU4iuGositvq8mxsAQnuUACK6BvgZwdiD8bZlXAwc=;
  b=SdmTaTmBNEJCzrptFuXkD5Etibb4Pz8G0puuNa3++wJd2LXaMptq4oa2
   qN78DC04gcVS7KmWdMJcOXabIF+asnY5qg9h2g7pFDFuaR+fEaJOpJn2i
   lknX3avjwGSIZG0Ok8ndsdOzFT1ZxxzmwU9RWMBmdgj6p4E79OIm3rM+U
   5rfyPhaURjlNTG3oDkY55z20bHGTutXLSZr1a8AARJhB7UbhmJGIe3XLv
   lhgYlds5sdZBamOJkw8dimXZHzt7nymh94VDkzdkJ7S71KDJyeeF3i4Ks
   CkkopIsRsSWHP2eNq97P7bw/RhseU1uRDqBEdMdzta4un2CBUav7bmWGG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="298983146"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="298983146"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599265534"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="599265534"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2022 10:54:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 41BCF7C; Tue, 27 Sep 2022 20:55:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] pinctrl: wpcm450: Correct the fwnode_irq_get() return value check
Date:   Tue, 27 Sep 2022 20:55:09 +0300
Message-Id: <20220927175509.15695-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_irq_get() can return zero to indicate IRQ mapping errors.
Handle this case by skipping the interrupt resource.

Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: amended commit message (Jonathan)
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 0dbeb91f0bf2..8193b92da403 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1081,10 +1081,13 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 
 		girq->num_parents = 0;
 		for (i = 0; i < WPCM450_NUM_GPIO_IRQS; i++) {
-			int irq = fwnode_irq_get(child, i);
+			int irq;
 
+			irq = fwnode_irq_get(child, i);
 			if (irq < 0)
 				break;
+			if (!irq)
+				continue;
 
 			girq->parents[i] = irq;
 			girq->num_parents++;
-- 
2.35.1

