Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E8727899
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjFHHUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjFHHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:20:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FB1AE;
        Thu,  8 Jun 2023 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686208808; x=1717744808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EsjW/PvLJkzSdLhvN+Hfe10NWNmh3wkFVUaEDVOatLo=;
  b=NxGFZYOF0F8MaMLUD6P+5wiJ6KLSkRuT+AnYamI/RO9Z8YIRTID4Lq9O
   5bAzRay9fH8Uylnj8KOoI8jbCtCg8oeMS+quIfCvl3OHqvQt+jaHQbYr0
   g9XZXe8WKBd5tOfBpT+ZFLrlufo7wBPo6PfVTAVispKfiowIRg7rvWkYL
   hXfqHqmFFGHXXP9/zDwkby2+NqN/HDT0q4egzptAFoZD8vroKy0pvYLE8
   p2ZwRgaoT1jx0BfkDT5o4OskjNZDI3rnixcghV5+TwwIu5uiLxH/ReMn8
   yqaqANa9BFS1ggTr2u3ENuj2sSxutgZYhXLLb0l2tSk3RoD8RXgemf8Bc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346849010"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="346849010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="713005668"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="713005668"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 00:20:05 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 14A9E1AA15;
        Thu,  8 Jun 2023 12:50:05 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 1146A176; Thu,  8 Jun 2023 12:50:05 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 2/2] pinctrl: cherryview: simplify exit path of gpio_request_enable hook
Date:   Thu,  8 Jun 2023 12:49:03 +0530
Message-Id: <20230608071903.19170-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608071903.19170-1-raag.jadav@intel.com>
References: <20230608071903.19170-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify exit path of ->gpio_request_enable() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-10 (-10)
Function                                     old     new   delta
chv_gpio_request_enable                      296     286     -10
Total: Before=19199, After=19189, chg -0.05%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 1e21c6f8aa7f..8dbe92cd1c21 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -803,15 +803,18 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned long flags;
 	u32 value;
+	int ret;
+
+	/* For positive cases */
+	ret = 0;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
 	if (chv_pad_locked(pctrl, offset)) {
 		value = chv_readl(pctrl, offset, CHV_PADCTRL0);
 		if (!(value & CHV_PADCTRL0_GPIOEN)) {
-			/* Locked so cannot enable */
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_unlock;
 		}
 	} else {
 		struct intel_community_context *cctx = &pctrl->context.communities[0];
@@ -845,9 +848,10 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 		chv_writel(pctrl, offset, CHV_PADCTRL0, value);
 	}
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void chv_gpio_disable_free(struct pinctrl_dev *pctldev,
-- 
2.17.1

