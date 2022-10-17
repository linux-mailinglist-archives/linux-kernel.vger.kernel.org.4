Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A20601476
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJQROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:14:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64073220E0;
        Mon, 17 Oct 2022 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026870; x=1697562870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mfrt02hQFUuDbPuu0wnNVxkM323gW4XMbyd4eW8Ha78=;
  b=k+VuLmgyo0k+p7TNCXgM8aFMwzjbT4NjXCv9ruLOn0YbH/xiAjkKHjIB
   jXz2C7D5k9z0YppqaOuyPe1Ve2nC9+g662OMtq++LBFdxuYIC+8YqqEwO
   gTPOvMZmzfgTZ8aM1JyGDTyQ8tUmJCnJv8mLJKFYOpD7PwxzmL3szlP/C
   FAjm4txuNGIdY2wSN+X4PR6N5sTE2jbj9blG1kFhoCJb4u0pZ+rikv7s4
   ak2ri+wxOExRC2P6v5RL1MXhnQZEU8TRaDtAmL1KHD+3/3XEl8x0SKqnh
   7Tu1XWAcED3qyPBRI2pocyEKYDbhxdvYwTeyycRof/0Ulb1+0goC5Ky+p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305849933"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305849933"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="630766855"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="630766855"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2022 10:14:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8179626D; Mon, 17 Oct 2022 20:14:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: merrifield: Use str_enable_disable() helper
Date:   Mon, 17 Oct 2022 20:14:48 +0300
Message-Id: <20221017171448.63932-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_enable_disable() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-merrifield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 72ac09a59702..92ea8411050d 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/string_helpers.h>
 
 #define GCCR		0x000	/* controller configuration */
 #define GPLR		0x004	/* pin level r/o */
@@ -331,7 +332,7 @@ static int mrfld_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
-	dev_dbg(priv->dev, "%sable wake for gpio %u\n", on ? "en" : "dis", gpio);
+	dev_dbg(priv->dev, "%s wake for gpio %u\n", str_enable_disable(on), gpio);
 	return 0;
 }
 
-- 
2.35.1

