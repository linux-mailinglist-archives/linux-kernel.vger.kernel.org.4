Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34524669AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAMOta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAMOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:49:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C295793A;
        Fri, 13 Jan 2023 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673620615; x=1705156615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trOCjL/5KMUUQ8iui4T0y8ctTC7nLasEtUt6t7vEejM=;
  b=TryZQdIHq92gDLyVXIqxcoxr/dVragV2EMqrdg9FGknVTT9DPAhVmJ/6
   KlQGlGeZEa7A2uwjov73fa3v00/vOVP0zY7ATQCQhpOLmxCKFdhM9FDWS
   M+9uyGZTXF2pWLciyoquit5S/cUG/2k6M/Sq5gjOhRQdzPpLOnPwcz0S6
   kbZey9pR3KGmvvH1Uu7QiebVaRE5hfGllqOg8LUg/GtY5YUyB96nxf0lo
   J1KUt6kudwrjK47j8JgO3G2KtIHFmKvvTNDyJCrzS/7teNW6Wc/O41PYK
   VcHXDhwd63jDicc3gkKkT3xXS0EwYzJEYgNUGzg9EJEPJDLI0DyuDKhw6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324061670"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324061670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608182775"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608182775"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 06:36:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C88F6E1; Fri, 13 Jan 2023 16:36:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 2/2] pinctrl: digicolor: Use proper headers and drop OF dependency
Date:   Fri, 13 Jan 2023 16:36:40 +0200
Message-Id: <20230113143640.24302-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
References: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
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

The driver doesn't depend on the OF to be complied. Hence
the proper header to use is mod_devicetable.h. Replace of*.h with
the above mentioned and drop redundant dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
v2: added tag (Baruch)
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

