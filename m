Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076C602F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJRPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJRPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:14:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE01F9C6;
        Tue, 18 Oct 2022 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666106080; x=1697642080;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XIk8rnYCV/xKkm4yWKJej0Ef26WangurQvbBJaJZ7xU=;
  b=fberNBkpm+1TKQVfrlAkRQPp5FjDvFdtX0MXLRjqFUWrXaSQvwa1zaEn
   97mN32b1LM1xkcBMidwhClZdlzD7gGI4T2oe7XWiwhhUUCFQMzOfUk/ld
   1ExkmXkFDx/wLZ9YL+JSbOPJIPA2gNOEh3dUneygpfcX2KkR0+GpGCZBF
   QE7PXXJx361zUHl6q73Hs6f9hhvNjkmT2dIjeSyWWTsCjRHR5QEToMxdG
   oveo632HZ4mpjF2GjOZxw1qa734YMyBT0YlYX7mjYwhkdF8lHLJpNOV5v
   LpYrNJgQoFOCPDhYrkOXWLvXn6Tr0Rb5cZyoz8roDGznWfNVFu18prgPS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332681421"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="332681421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 08:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="628760333"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="628760333"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2022 08:12:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C446B9; Tue, 18 Oct 2022 18:12:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: cy8c95x0: Don't use cy8c95x0_set_mode() twice
Date:   Tue, 18 Oct 2022 18:12:23 +0300
Message-Id: <20221018151223.80846-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead, call it once in cy8c95x0_pinmux_mode() and if selector is 0,
shortcut the flow by returning 0 immediately.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index b44b36be54b3..ee753e080481 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1107,13 +1107,13 @@ static int cy8c95x0_pinmux_mode(struct cy8c95x0_pinctrl *chip,
 	u8 bit = cypress_get_pin_mask(chip, group);
 	int ret;
 
-	if (selector == 0)
-		return cy8c95x0_set_mode(chip, group, false);
-
-	ret = cy8c95x0_set_mode(chip, group, true);
+	ret = cy8c95x0_set_mode(chip, group, selector);
 	if (ret < 0)
 		return ret;
 
+	if (selector == 0)
+		return 0;
+
 	/* Set direction to output & set output to 1 so that PWM can work */
 	ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, bit);
 	if (ret < 0)
-- 
2.35.1

