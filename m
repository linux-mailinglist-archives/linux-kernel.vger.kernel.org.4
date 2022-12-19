Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5772650BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiLSMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiLSMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644CBF018;
        Mon, 19 Dec 2022 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453107; x=1702989107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/otEhEs+STYSNvH47lyUPmGAgLM3giYO0stFpJM8ox0=;
  b=cMqCwPqgTvNoSomzr81QRacZ6r8f566ojSRWY+KzJ+kap7qv5Am92liD
   QoLtfg/f5uWYBFx5d0lVG7iJoxYar5LspMZBvYDuRGgtk9EuD0A710WwL
   Lw8WyM+QLVCA0YINl37AERNrEwvgGuywGUD3lnyyEszbznDe9RItWnMSx
   CPjtMv6jVyPMLus5rV9N4Fv+T2WYLv5t9V7NEa+Pt3yJ9s14IVI+1QfCq
   egropQcs0RcbKYwDqHpj5rODvThHgkEkBjcG7dwDn2vGQDxffJMLDfw4t
   gN+6ZalCw/C8dqSCAY/ppJgy/juqRNAy95/T5RzleGqhJJsTvlan6QNye
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="320509090"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="320509090"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="774913750"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="774913750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2022 04:31:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9917B7; Mon, 19 Dec 2022 14:32:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/4] pinctrl: intel: Deduplicate some code in intel_config_set_pull()
Date:   Mon, 19 Dec 2022 14:32:06 +0200
Message-Id: <20221219123208.5505-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
References: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First part is to assign default argument for all cases, since
bias disablement doesn't use it anyway.

Second part is to clear all bits in the bias setting and
depending on the argument and parameter set them as asked.

While at it, add break statement to the default cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 4b1d5a21aa68..6926f64b68d4 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -691,21 +691,14 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	value = readl(padcfg1);
+	value &= ~(PADCFG1_TERM_MASK | PADCFG1_TERM_UP);
 
-	switch (param) {
-	case PIN_CONFIG_BIAS_DISABLE:
-		value &= ~(PADCFG1_TERM_MASK | PADCFG1_TERM_UP);
-		break;
+	/* Set default strength value in case none is given */
+	if (arg == 1)
+		arg = 5000;
 
+	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
-		value &= ~PADCFG1_TERM_MASK;
-
-		value |= PADCFG1_TERM_UP;
-
-		/* Set default strength value in case none is given */
-		if (arg == 1)
-			arg = 5000;
-
 		switch (arg) {
 		case 20000:
 			value |= PADCFG1_TERM_20K << PADCFG1_TERM_SHIFT;
@@ -721,17 +714,13 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			break;
 		default:
 			ret = -EINVAL;
+			break;
 		}
 
+		value |= PADCFG1_TERM_UP;
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		value &= ~(PADCFG1_TERM_UP | PADCFG1_TERM_MASK);
-
-		/* Set default strength value in case none is given */
-		if (arg == 1)
-			arg = 5000;
-
 		switch (arg) {
 		case 20000:
 			value |= PADCFG1_TERM_20K << PADCFG1_TERM_SHIFT;
@@ -755,6 +744,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 			break;
 		default:
 			ret = -EINVAL;
+			break;
 		}
 
 		break;
-- 
2.35.1

