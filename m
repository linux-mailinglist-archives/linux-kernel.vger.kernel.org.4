Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930255B8BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiINPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiINPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:33:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E74CA28;
        Wed, 14 Sep 2022 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663169600; x=1694705600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i0coO9c2FKwC5925wxjPvabKFiFqb3KTprwtnRi8gUk=;
  b=UA9LIZGhdB3WBYyy/fD5Ucp4pP2sWSyBE88UNkkpitFAOh8hNek56hKG
   tEv3EOYuZI/hkdeemO5NIypAH5Jjaf/cqNaF+PlWMURhTjpEuySn/d/oz
   xcgrDxhOph+obyej6kAdDn52uiKEIMv/xCXOTcMpFZe4l1Vn965ms1s6P
   UtKhVO2REEJxRRo5yE7lwfzzNQQFar43a7E6vds7U3wA+P5euHszM0DRA
   cmyaEs5mK2xSzuafI6mRYPP1+6/PsAZ78q2StFilYcUNqikIi1Q0j9o7e
   MtHyU3E8i+W+PQBgp+P5Ujz/9MI0nuBf2yw+337r1cHF/96ASJY+lPsHz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299271446"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299271446"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="792351983"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2022 08:33:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 61CABF7; Wed, 14 Sep 2022 18:33:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: mpc52xx: Replace of_gpio_count() by gpiod_count()
Date:   Wed, 14 Sep 2022 18:33:33 +0300
Message-Id: <20220914153333.37701-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to unexport of_gpio_named_count(), convert the
driver to use gpiod_count() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc52xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index bc5e36fd4288..97cdd6545ee1 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/io.h>
 #include <linux/of_gpio.h>
@@ -438,7 +439,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	ms->irq1 = irq_of_parse_and_map(op->dev.of_node, 1);
 	ms->state = mpc52xx_spi_fsmstate_idle;
 	ms->ipb_freq = mpc5xxx_get_bus_frequency(&op->dev);
-	ms->gpio_cs_count = of_gpio_count(op->dev.of_node);
+	ms->gpio_cs_count = gpiod_count(&op->dev, NULL);
 	if (ms->gpio_cs_count > 0) {
 		master->num_chipselect = ms->gpio_cs_count;
 		ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
-- 
2.35.1

