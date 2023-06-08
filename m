Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13072789C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjFHHUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjFHHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:20:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FE1B9;
        Thu,  8 Jun 2023 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686208808; x=1717744808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gfcSu09bj+RlhNlH4HRYD43333YTuQ369JrQHUWdk2Q=;
  b=AdTLTjQLg/SqfOT+Ko19kIbmqcc9c+kfjWe9uNmGfUgpbQ3REey2Oi9t
   AXOm54pAEUhT6AIprdg/+FNZZbOLgFQsuJ4qLNPO7QmZGg90ss/qabIwh
   RItxypfLzDpGa1ZdeUqN8WhfqbgVJwOOcEI+9w6B84HSFAeahGL8u5y38
   u9oWQRmqcKgzjHS5Z4TnbNVqnyjdbrkRofD24c83O6QrXOHSA6kdjq3NY
   EDf3SxNaa5mtAOIwvBWdjBcgjRE6tNDK368J4oM3MEH6BCd4JfnOYOJ2s
   Djno1FaSUURIROipIu1DANfe+hh/MWx17Nth+NDI1YJTaP6iuK/pL8TJQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346849011"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="346849011"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="713005669"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="713005669"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 00:20:05 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 11B3A1AA12;
        Thu,  8 Jun 2023 12:50:05 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 0BFE21DE; Thu,  8 Jun 2023 12:50:05 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/2] pinctrl: cherryview: simplify exit path of set_mux hook
Date:   Thu,  8 Jun 2023 12:49:02 +0530
Message-Id: <20230608071903.19170-2-raag.jadav@intel.com>
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

Simplify exit path of ->set_mux() hook and save a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-34 (-34)
Function                                     old     new   delta
chv_pinmux_set_mux                           640     606     -34
Total: Before=19233, After=19199, chg -0.18%

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index b9b2b1d2d47f..1e21c6f8aa7f 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -716,18 +716,21 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	struct device *dev = pctrl->dev;
 	const struct intel_pingroup *grp;
 	unsigned long flags;
-	int i;
+	int i, ret;
 
 	grp = &pctrl->soc->groups[group];
 
+	/* In case we never really enter any of the below loops */
+	ret = 0;
+
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
 	/* Check first that the pad is not locked */
 	for (i = 0; i < grp->grp.npins; i++) {
 		if (chv_pad_locked(pctrl, grp->grp.pins[i])) {
-			raw_spin_unlock_irqrestore(&chv_lock, flags);
 			dev_warn(dev, "unable to set mode for locked pin %u\n", grp->grp.pins[i]);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_unlock;
 		}
 	}
 
@@ -765,9 +768,10 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			invert_oe ? "" : "not ");
 	}
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void chv_gpio_clear_triggering(struct intel_pinctrl *pctrl,
-- 
2.17.1

