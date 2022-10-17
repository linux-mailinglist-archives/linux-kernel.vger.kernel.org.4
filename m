Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFD601478
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJQRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJQRO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:14:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07CC69F68;
        Mon, 17 Oct 2022 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026891; x=1697562891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YicqXZCTTMeS2vYU2zwLOt3q8gLXRSmM1gwuqL/8568=;
  b=lZMKGQrqH5dX3z3Hz2LniH8ULdBFoRnimox2Ixp91ORUjZGz9AhC9Y6F
   RhXprDomhTOfhABQNL5iEwErZONq4iFEAtRv2H02FBXqlN5lo0ixE5zyb
   ssMwS9frTZ7LfB3g04n0fs1eKXbVYHrwUlGNoHA7aoMqEWuH9KrPBIfQ/
   wcJFO+R88bBM2PlYy/SAW5kcULo5VBAYGQBkOKY9VArnk0KeR5rDZnwe7
   QW9aUTjHN4c7/0bCKzMTZoeTDB89b3TZwh8uVRWXTvc4Rh1ddF8tAy05S
   Ybr56lHWJlAwt3pqDPvoHFMr5jrlyBU/xL64YMsMm2sDGGRJjnWkB1Px1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="293230317"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="293230317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691441419"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="691441419"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 10:14:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 510C126D; Mon, 17 Oct 2022 20:15:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Use str_enable_disable() helper
Date:   Mon, 17 Oct 2022 20:15:06 +0300
Message-Id: <20221017171506.64183-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_enable_disable() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3695d7cb1d01..e9f4f95913ab 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
+#include <linux/string_helpers.h>
 #include <linux/time.h>
 
 #include <linux/pinctrl/consumer.h>
@@ -1171,7 +1172,7 @@ static int intel_gpio_irq_wake(struct irq_data *d, unsigned int on)
 	else
 		disable_irq_wake(pctrl->irq);
 
-	dev_dbg(pctrl->dev, "%sable wake for pin %u\n", on ? "en" : "dis", pin);
+	dev_dbg(pctrl->dev, "%s wake for pin %u\n", str_enable_disable(on), pin);
 	return 0;
 }
 
-- 
2.35.1

