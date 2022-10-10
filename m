Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279135F9EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJJMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJJMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:52:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4C52DC0;
        Mon, 10 Oct 2022 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665406327; x=1696942327;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JHiNEn1VO1XjaqbGRbNtJMKQOanLaGLJSkjjUAgEfvs=;
  b=jfk/0B2BdOKmb2vCJamDAG+La+k8g438xd4ozEFXIge5jSUNH/WXikGQ
   Ys4nC1JxN6IUivCZHnHNLt1Ahd5LFHghoiitnvAXxqOO1K+bV9qkZq3xD
   fzlc4xQ3K0LNMaXgz5O5X+laEd9yj0spT3Moxc6plGYDehuSYAcThdXd+
   gpajC0fUMHZQf3EHfT1oWFSS9smmlnldu8HafPVcnSRTrrCCu71tVvuGJ
   Sd6H2EfywBXjmIkY1cTSjB+663nc0+i1g96M0LDlleLFVvC6dMGm/1QP9
   /uK0p6STU4p34A+YBHiFMUuptM2y6q1ShZb7C+/nZwCv9m7dpWNLfwZtK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366181070"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="366181070"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628266211"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628266211"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2022 05:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA3512B0; Mon, 10 Oct 2022 15:52:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] pinctrl: cy8c95x0: Extract cy8c95x0_set_mode() helper
Date:   Mon, 10 Oct 2022 15:52:20 +0300
Message-Id: <20221010125221.28275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The code in newly introduced cy8c95x0_set_mode() helper may be
used later on by another function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 68509a2301b8..33eba7ad87f4 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1124,9 +1124,7 @@ static int cy8c95x0_get_function_groups(struct pinctrl_dev *pctldev, unsigned in
 	return 0;
 }
 
-static int cy8c95x0_pinmux_cfg(struct cy8c95x0_pinctrl *chip,
-			       unsigned int val,
-			       unsigned long off)
+static int cy8c95x0_set_mode(struct cy8c95x0_pinctrl *chip, unsigned int off, bool mode)
 {
 	u8 port = cypress_get_port(chip, off);
 	u8 bit = cypress_get_pin_mask(chip, off);
@@ -1137,7 +1135,20 @@ static int cy8c95x0_pinmux_cfg(struct cy8c95x0_pinctrl *chip,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_write_bits(chip->regmap, CY8C95X0_PWMSEL, bit, val ? bit : 0);
+	return regmap_write_bits(chip->regmap, CY8C95X0_PWMSEL, bit, mode ? bit : 0);
+}
+
+static int cy8c95x0_pinmux_mode(struct cy8c95x0_pinctrl *chip,
+				unsigned int selector, unsigned int group)
+{
+	u8 port = cypress_get_port(chip, group);
+	u8 bit = cypress_get_pin_mask(chip, group);
+	int ret;
+
+	if (selector == 0)
+		return cy8c95x0_set_mode(chip, group, false);
+
+	ret = cy8c95x0_set_mode(chip, group, true);
 	if (ret < 0)
 		return ret;
 
@@ -1156,7 +1167,7 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 	int ret;
 
 	mutex_lock(&chip->i2c_lock);
-	ret = cy8c95x0_pinmux_cfg(chip, selector, group);
+	ret = cy8c95x0_pinmux_mode(chip, selector, group);
 	mutex_unlock(&chip->i2c_lock);
 
 	return ret;
-- 
2.35.1

