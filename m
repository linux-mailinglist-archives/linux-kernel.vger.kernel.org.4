Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08A5B8C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiINPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiINPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:39:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2543082766
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663169864; x=1694705864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mp+Gy0qe2NXbWxeR7oFPdPYF1BnHp4QYcgJix1ZqC/U=;
  b=OISA7zm99EtMt61ffME6IyAV/J5EOIUib6KQ6IP0qhaf37M7vNLeIfKO
   N8G4vzsRgikcB6BAQQeoYgjv0W//PZtCcmJuh0PJ3vNKGhPRXtL+CB+c7
   2AF/ea6xCQW6DzkfoEvNaPd+3hXlAbeW938gSy/bRUWFOYMtDbyS0moio
   pkbgmF+BdLluanyY3xcjq6gJW4Q8pyl1hQOrCsIjpHM98k0M2UzxF2LAo
   DLSbnZNIR5WTjb8A/ujjryCDCyRD6xEQo2FyYXm/IkVnYGa4ydxGmhmIJ
   F3fGDnmY1WENpluegFf5ZSJN2OtoGh37oOuVbp9yLdkSqr0y8dXco5Hf9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324714760"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324714760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="650116641"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 08:37:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 235DBF7; Wed, 14 Sep 2022 18:37:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v1 1/1] HSI: nokia-modem: Replace of_gpio_count() by gpiod_count()
Date:   Wed, 14 Sep 2022 18:37:55 +0300
Message-Id: <20220914153755.37866-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 drivers/hsi/clients/nokia-modem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index cd7ebf4c2e2f..97ba59e60663 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/hsi/ssi_protocol.h>
 
 static unsigned int pm = 1;
@@ -75,8 +74,7 @@ static int nokia_modem_gpio_probe(struct device *dev)
 	struct nokia_modem_device *modem = dev_get_drvdata(dev);
 	int gpio_count, gpio_name_count, i, err;
 
-	gpio_count = of_gpio_count(np);
-
+	gpio_count = gpiod_count(dev, NULL);
 	if (gpio_count < 0) {
 		dev_err(dev, "missing gpios: %d\n", gpio_count);
 		return gpio_count;
-- 
2.35.1

