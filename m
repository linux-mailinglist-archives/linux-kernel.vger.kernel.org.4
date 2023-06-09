Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5272931D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbjFII1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbjFII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:26:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C13AAC;
        Fri,  9 Jun 2023 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299164; x=1717835164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Jca4VwCHycfBasare1YXUgyB4DjUVfYUbAfgEFuOdug=;
  b=AzRoxGvAQWIIA9vj9fLauuCcevWPwNIyHCiFwkRfN3tJ9Zs3t7oGs4v/
   UPtkstMVhDOvzrmQG7+ndb8Kpc5INN0Op3kjbohOjd371/C0yM4rp7MUr
   /k/s5wBQXm01/mVKyvcFQCwZC5SDKC/NEtkQ87d0JokXqAqcoXoOyHHpQ
   gLMnoPhnle1QiLP1QnkUyuz4aTdAGVGw3X+PRxPA3VlSkRBvZkvok9n2Y
   GPPy+HmMi6Z6gvH+yJmTgblW/LUnDCYIaBniYn4URVANtROM5TfGmX/5X
   4o1CL7AJ5GXHJr2Ss5HOYcjU7ZZvWDZVTTf8GKdgg1aqnPyCxVaDm469H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342222305"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342222305"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713424282"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713424282"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:25:59 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 0C0F119742;
        Fri,  9 Jun 2023 13:55:59 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 08E3F17C; Fri,  9 Jun 2023 13:55:59 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 4/4] pinctrl: intel: simplify exit path of gpio_request_enable hook
Date:   Fri,  9 Jun 2023 13:55:39 +0530
Message-Id: <20230609082539.24311-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609082539.24311-1-raag.jadav@intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify exit path of ->gpio_request_enable() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
Function                                     old     new   delta
intel_gpio_request_enable                    186     150     -36
Total: Before=10431, After=10395, chg -0.35%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 2338e84615cc..12b994fa2aad 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -486,20 +486,19 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
+	int ret = 0;
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
 
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
@@ -507,16 +506,15 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
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

