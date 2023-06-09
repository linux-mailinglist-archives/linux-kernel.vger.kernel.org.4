Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1483729323
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjFII1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbjFII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:26:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4543A8B;
        Fri,  9 Jun 2023 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299164; x=1717835164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=z9xXo48x1ggxmMr9XY4R6V8kfPhOyr/XiwTtF620lK4=;
  b=ROHCT2TMPloVPtb6RLY/12QdWXLbASigsxFXCAKiiYw7FrufrVRcjxOB
   B/HT/9BKj8NY4qN2TF0Fe3g+U/990DjCCR3JPGgbuNZHiqbfccbmCJzmZ
   xMn2RyTZQii71Fp1AZR6zYkVLlNdZ3hCkFND2dGNOla92lDuFEhw/cTrN
   9uogJRjwMQHAqweS2LIVZd48vKjSg5Y8kU33IqgF7qN4e9xEqJBlbApLn
   DOp8zqX1Z/YNOrZQoGlgatO1q/bwmoXgdeNxCqiNUq7mJEjcQxQwIaHmY
   SIVaN1ruqeqEham+7ixZJjkJ2SH3Em7dgkiYF4J+G0hPdi5z3JPa/YSAC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342222303"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342222303"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713424281"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713424281"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:25:59 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 0ABF119740;
        Fri,  9 Jun 2023 13:55:59 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 03724163; Fri,  9 Jun 2023 13:55:58 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 3/4] pinctrl: intel: simplify exit path of set_mux hook
Date:   Fri,  9 Jun 2023 13:55:38 +0530
Message-Id: <20230609082539.24311-4-raag.jadav@intel.com>
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

Simplify exit path of ->set_mux() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-22 (-22)
Function                                     old     new   delta
intel_pinmux_set_mux                         242     220     -22
Total: Before=10453, After=10431, chg -0.21%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3f78066b1837..2338e84615cc 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -393,7 +393,7 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct intel_pingroup *grp = &pctrl->soc->groups[group];
 	unsigned long flags;
-	int i;
+	int i, ret = 0;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -403,8 +403,8 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 */
 	for (i = 0; i < grp->grp.npins; i++) {
 		if (!intel_pad_usable(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_unlock;
 		}
 	}
 
@@ -427,9 +427,10 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
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

