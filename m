Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFF72DD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbjFMIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbjFMIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:51:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB166CA;
        Tue, 13 Jun 2023 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686646293; x=1718182293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=f8fpX7WbHtQPgDSMHUPqyQBZ/trkXyouBY/M9suBHRw=;
  b=EHLqwVGIoRISkzonk1xYeHlaaVRhuGv+vSZS4ZYke8V78rXQokJm1fi2
   RJ/oonUeHLHq/FUxnxOqv6IOIBhYQT4su97Ogm54+RElwNIfIeI8IFlKR
   q/h6zu4/4Iz6GIGB3CGu11a6uV1lfh2+uodTfRPfb0mOWPMsN3yISBugB
   XSsXu/m1Rl+CaSN3vPOUf2FjE8NsTiZeDWzYLGhe0DOOHmCjU679MZ5FN
   o0LoPZM/dfFKVAkigQoNaNQDV4ar/zxJvKjlgE8RsrkQgJFdxlX/jNXhG
   R/EpbCzmjNv5RGvUSQ1nLfbJpMLnaJOzWwxOqG9Xp7Y6h4SqohmuLMpQD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386664949"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="386664949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824305098"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="824305098"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 01:51:29 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 731BD19746;
        Tue, 13 Jun 2023 14:21:28 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 70262104; Tue, 13 Jun 2023 14:21:28 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 3/3] pinctrl: intel: simplify exit path of ->gpio_request_enable() hook
Date:   Tue, 13 Jun 2023 14:20:54 +0530
Message-Id: <20230613085054.10976-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613085054.10976-1-raag.jadav@intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify exit path of ->gpio_request_enable() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-36 (-36)
Function                                     old     new   delta
intel_gpio_request_enable                    186     150     -36
Total: Before=10453, After=10417, chg -0.34%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3f78066b1837..43e17bc177d0 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -485,20 +485,19 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
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
@@ -506,16 +505,15 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
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

