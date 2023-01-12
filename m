Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC093667EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbjALTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjALTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:05:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2A253701;
        Thu, 12 Jan 2023 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549280; x=1705085280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ISG4iMQCmJbQyOjDtFzJuWJ6r9CraDTaJ1v4LxJL5H8=;
  b=iGCeQcHYfVice9l/n+aJmmTE2VH9ahVOp0iM6nNplxFwzUIUNG6OKZTn
   k/YKIX9iskFIBlqT3Az+5zI733ZEf0bZJTE8G1GwPBo9MLJqTPIyTiCF+
   JpZO8pDs/UF3zvdZ+eoKyLdcq50cOWETDBd2uFxc2Ponl3KQF2Gn+YTBk
   uBoI55mNm5YvE0w9WYkd7u8tSFPmT1dTQ1e3emc3WZVTaKDb/MZpJnph0
   IoXoM0259jbOHhkUn7LWWdTHnScGLeudJPIZxQTHcW8GXCwsDQa+EsWT+
   f9+lzj3DikpnbFxj4z132MD+hF5nJgUvjPS7av/G0Xxvwi306Aw+TypDa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351021824"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="351021824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800333026"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="800333026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2023 10:47:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 562691A3; Thu, 12 Jan 2023 20:48:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v1 2/2] pinctrl: digicolor: Use proper headers and drop OF dependency
Date:   Thu, 12 Jan 2023 20:48:23 +0200
Message-Id: <20230112184823.80349-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
References: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com>
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

The driver doesn't depend on the OF to be complied. Hence
the proper header to use is mod_devicetable.h. Replace of*.h with
the above mentioned and drop redundant dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/Kconfig             | 2 +-
 drivers/pinctrl/pinctrl-digicolor.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 476f3cbbdce0..1e44708201ad 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -170,7 +170,7 @@ config PINCTRL_DA9062
 
 config PINCTRL_DIGICOLOR
 	bool
-	depends on OF && (ARCH_DIGICOLOR || COMPILE_TEST)
+	depends on ARCH_DIGICOLOR || COMPILE_TEST
 	select PINMUX
 	select GENERIC_PINCONF
 
diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index 05213261b8a4..a0423172bdd6 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -11,18 +11,19 @@
  * - Pin pad configuration (pull up/down, strength)
  */
 
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/io.h>
-#include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
+
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+
 #include "pinctrl-utils.h"
 
 #define DRIVER_NAME	"pinctrl-digicolor"
-- 
2.39.0

