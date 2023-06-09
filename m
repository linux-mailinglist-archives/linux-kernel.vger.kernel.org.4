Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48755729359
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbjFIIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbjFIIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:35:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD395;
        Fri,  9 Jun 2023 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299734; x=1717835734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sznpqbUnf3e44zkDCl4nVJmabj30D4AyCD67n0wSKpM=;
  b=cpXoYJsNaDI//667vsJjZfhheXQZ6EtV7v+l0Wpjzd+dLdgky1mey7Xk
   EIvfF6Uo3HUjU1FS8TE5ky4QPI7hZ0R+MXTkixlbub92M6auy8fWcgLXd
   rbAHOuEphtSGwwrSQ6lxTaJHvZHuQ0x0vUPaW/iZe69A4MZxCSbSc9Ode
   O+lCSe/VJ3xJC/52VGwNuVtwFPWawW6ottownhs+wwyjO5eeTG+uptUsz
   tyAmOSNVmVVbSlvxNUZE3T/cKGIoQNb+Kqk0qz7nYOoxdBV4p8iyFGBoJ
   WU/bCHkYPdIBw3hM1CWAyziMVtYzpzUqDMLP0puCH9EyJzZbKuOsVug1Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355041495"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355041495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660690485"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660690485"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 01:35:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id B11A5911EA;
        Fri,  9 Jun 2023 14:05:06 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id ADA5DB6; Fri,  9 Jun 2023 14:05:06 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] pinctrl: cherryview: simplify exit path of gpio_request_enable hook
Date:   Fri,  9 Jun 2023 14:03:56 +0530
Message-Id: <20230609083356.24849-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609083356.24849-1-raag.jadav@intel.com>
References: <20230609083356.24849-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pinctrl/intel/pinctrl-cherryview.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 4942d22cf9d9..49af41e4b6af 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -799,6 +799,7 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned long flags;
+	int ret = 0;
 	u32 value;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
@@ -806,9 +807,8 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
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
@@ -842,9 +842,10 @@ static int chv_gpio_request_enable(struct pinctrl_dev *pctldev,
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

