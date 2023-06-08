Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B7D727810
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjFHHCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjFHHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:02:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D791FDA;
        Thu,  8 Jun 2023 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686207711; x=1717743711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GkOP7rNUwgMIthRmAlcjFR5s8EhHf8h9HpAjchfyKK8=;
  b=JEMzjN6F97ONk20TGmwatG4I9Fpg56gZwlccPS0QBLU/bvGXvpUIb9i+
   FPlcU3LrUrR5WyPUp9E/9N2ibY/fxhnVD4/Apj0P1JcJdnLDjKqEwIT3Y
   ovEm9WgvbG7vtRJGyak4exb7VFuuPU3ETUiZQNWqwmeuQCdOaOXtLtBjX
   MUK5l+WKl/oKx1H/6wZA/RR/njwQm55M5vGuJ+XnyBqCD+F+wRQAHDFhU
   6OnaUp3gMrYu+8wUYMAZTFyfY7JxJcpOKHDDDN84bqanU2PXjHrhWd5r1
   2N9427x58zHnOhTRBJ6laiHMSHgSgiXIAotcyI5afKTP+BslPNrtlpfuD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359696355"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359696355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709867977"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709867977"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 00:01:09 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 192481AA19;
        Thu,  8 Jun 2023 12:31:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 155F41DE; Thu,  8 Jun 2023 12:31:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/4] pinctrl: intel: simplify exit path of gpio_request_enable hook
Date:   Thu,  8 Jun 2023 12:30:17 +0530
Message-Id: <20230608070017.28072-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608070017.28072-1-raag.jadav@intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify exit path of ->gpio_request_enable() hook
and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
Function                                     old     new   delta
intel_gpio_request_enable                    186     150     -36
Total: Before=10431, After=10395, chg -0.35%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 1b5745202058..947797d87c93 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -489,20 +489,22 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
+	int ret;
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
 
+	/* For positive cases */
+	ret = 0;
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	if (!intel_pad_owned_by_host(pctrl, pin)) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock;
 	}
 
-	if (!intel_pad_is_unlocked(pctrl, pin)) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-		return 0;
-	}
+	if (!intel_pad_is_unlocked(pctrl, pin))
+		goto out_unlock;
 
 	/*
 	 * If pin is already configured in GPIO mode, we assume that
@@ -510,16 +512,15 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 	 * potential glitches on the pin. Otherwise, for the pin in
 	 * alternative mode, consumer has to supply respective flags.
 	 */
-	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO) {
-		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-		return 0;
-	}
+	if (intel_gpio_get_gpio_mode(padcfg0) == PADCFG0_PMODE_GPIO)
+		goto out_unlock;
 
 	intel_gpio_set_gpio_mode(padcfg0);
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int intel_gpio_set_direction(struct pinctrl_dev *pctldev,
-- 
2.17.1

