Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A05BB3B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIPUyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIPUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:54:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E428E05;
        Fri, 16 Sep 2022 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663361683; x=1694897683;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5YFO5/eFntgeJ5SEuWgI8cDQyUjE1Im4OSuB+14ChF4=;
  b=iF8bta+WoVm9Gc6et3RX/fqVUJkgUuM+1mc3BTT2OsdXvmpccwkHAn4d
   N7R4SGW+XRTN2hJs1XX3fU59F/rqTqjPlQt0ksPli8kmuTu3/TcqFs4jy
   7pEPNtI99pvXuIwmpOLM1MJksFKR5D3ACJUcNZtHtReFXMTX8ZkfRJAw3
   ZQP9oTOp52oY58ux09WD3YXfmnMyiw2y6uLxNX8M015TQY4eY5//l0nWH
   kmk4Iu5mbM7Jj2T8063E/aasFXKofLTQeR7NuQ4///QyVOx10+PcQotOg
   q3Z5gr3gH7efLNLCtCnsDkqmk32c2NAnjlW/3e7KWd0ac7IsI4RT51suA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325354916"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="325354916"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="617803665"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2022 13:54:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36AA1F7; Fri, 16 Sep 2022 23:54:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] pinctrl: cy8c95x0: Drop atomicity on operations on push_pull
Date:   Fri, 16 Sep 2022 23:54:49 +0300
Message-Id: <20220916205450.86278-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
References: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The push_pull member is always accessed under the mutex, hence
no need to use atomic operations on it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 75be06d29dc1..367a9386dfb7 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -573,7 +573,8 @@ static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
 		ret = regmap_write_bits(chip->regmap, CY8C95X0_DRV_HIZ, bit, bit);
 		if (ret)
 			goto out;
-		clear_bit(off, chip->push_pull);
+
+		__clear_bit(off, chip->push_pull);
 	}
 
 out:
@@ -775,27 +776,27 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
-		clear_bit(off, chip->push_pull);
+		__clear_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_PU;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		clear_bit(off, chip->push_pull);
+		__clear_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_PD;
 		break;
 	case PIN_CONFIG_BIAS_DISABLE:
-		clear_bit(off, chip->push_pull);
+		__clear_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_HIZ;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		clear_bit(off, chip->push_pull);
+		__clear_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_ODL;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
-		clear_bit(off, chip->push_pull);
+		__clear_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_ODH;
 		break;
 	case PIN_CONFIG_DRIVE_PUSH_PULL:
-		set_bit(off, chip->push_pull);
+		__set_bit(off, chip->push_pull);
 		reg = CY8C95X0_DRV_PP_FAST;
 		break;
 	case PIN_CONFIG_MODE_PWM:
-- 
2.35.1

