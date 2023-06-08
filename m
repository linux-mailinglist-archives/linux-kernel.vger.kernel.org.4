Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80AA72780F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjFHHCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjFHHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:02:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3D1BF7;
        Thu,  8 Jun 2023 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686207710; x=1717743710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=07mx7Ug6tXfeMPMgNwQtvYzD0FW2NuxcTQr5+0xwwes=;
  b=Ugz7mPKsjRcATjOu5nrRuYIsNxRtcfMTCVqfeHXyN3esoPlpPrVVQhy6
   RSiE3CimiSYDXpp/cyyU1SxmqaccYPj3poJHa0CoG/aogPajfHwLOcX9Y
   0quJASqc8hPom/07Qaps5+YPoDEDltxskvp0FnDQy7PaON7Eeaa3rGfKq
   RyN17vEVT0YEK/tuKDwE5HGSLa5L48eXnJp23GdN2jN8IfIf650aohc2I
   4QAvQiXsZYIOIxdI8TdJs92m2etlurhsAh+KvGWB6oEqVG1AtElqVombV
   XFLhmxd3lPYKA+FtSCDOpUruXaPwKV3qy+efihn0Qyu6idTSBsAZGscMp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359696346"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359696346"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709867968"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709867968"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 00:01:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 1518A1AA18;
        Thu,  8 Jun 2023 12:31:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 11534176; Thu,  8 Jun 2023 12:31:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/4] pinctrl: intel: simplify exit path of set_mux hook
Date:   Thu,  8 Jun 2023 12:30:16 +0530
Message-Id: <20230608070017.28072-4-raag.jadav@intel.com>
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

Simplify exit path of ->set_mux() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-22 (-22)
Function                                     old     new   delta
intel_pinmux_set_mux                         242     220     -22
Total: Before=10453, After=10431, chg -0.21%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3f78066b1837..1b5745202058 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -393,7 +393,10 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct intel_pingroup *grp = &pctrl->soc->groups[group];
 	unsigned long flags;
-	int i;
+	int i, ret;
+
+	/* In case we never really enter any of the below loops */
+	ret = 0;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -403,8 +406,8 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 */
 	for (i = 0; i < grp->grp.npins; i++) {
 		if (!intel_pad_usable(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_unlock;
 		}
 	}
 
@@ -427,9 +430,10 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		writel(value, padcfg0);
 	}
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void __intel_gpio_set_direction(void __iomem *padcfg0, bool input)
-- 
2.17.1

