Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD60667415
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjALOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjALOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:02:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D279517E3;
        Thu, 12 Jan 2023 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673532124; x=1705068124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nmBkWzTGPQmO2j44FytSg1Prn+t+R62VDjJB8NnPYeU=;
  b=E6t2XIf+TwYKKgPwQCm07YQb5rK8BmEeMJMk5Po1+WY9x02zZYyQasjE
   +rcGaTQxn4BPbtryWfaGJTKIM51qPfh0vRS6MvSJnpeR9wIBkSkFfBxyZ
   Vdi4+EdrKY1FoiTjmujR4JnPDMV5Wi3XJgCbRIM4kwDkXgsSmn0G03TCa
   db4qlsfzQWgQ3oGg9CfiNgjsfIuSDmsMBbpGs3J6+6uvfj/hYijL19mz6
   TAY19joK0WLj6P2CyPnbQ9I9CEh9r3ehSb2sdPtPJRYc1T34uXUUglvvE
   +5S5n06+TssboSHt5BOgamLf8+xlCm5qAUJia/dYjxWKwt1zu9t6oexTK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325732431"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325732431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800215229"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="800215229"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 06:01:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 856EBE1; Thu, 12 Jan 2023 16:02:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] power: supply: collie_battery: Convert to GPIO descriptors (part 2)
Date:   Thu, 12 Jan 2023 16:02:09 +0200
Message-Id: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Finish the job started by the commit ba940ed83218 ("power: supply:
collie_battery: Convert to GPIO descriptors"), i.e. convert the use
of gpio_to_irq() to gpiod_to_irq(). No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/collie_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index 7fb9b549f2de..68390bd1004f 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -404,7 +404,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 		goto err_psy_reg_bu;
 	}
 
-	ret = request_irq(gpio_to_irq(COLLIE_GPIO_CO),
+	ret = request_irq(gpiod_to_irq(collie_bat_main.gpio_full),
 				collie_bat_gpio_isr,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"main full", &collie_bat_main);
@@ -440,7 +440,7 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
-	free_irq(gpio_to_irq(COLLIE_GPIO_CO), &collie_bat_main);
+	free_irq(gpiod_to_irq(collie_bat_main.gpio_full), &collie_bat_main);
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
 
-- 
2.39.0

