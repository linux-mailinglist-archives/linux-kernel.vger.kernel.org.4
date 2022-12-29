Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40326658CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiL2M7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiL2M7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:59:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4313E34;
        Thu, 29 Dec 2022 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672318774; x=1703854774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cEYKSoq9ion/Msb52XFy1pALM0Lv1Yrd952UiRZkdb8=;
  b=UWWB2UmAg2uuSNqTDNEplkOTKevWDjfN+1lUl8W4RWjmKe2NYuDkUnrb
   jmte8hkQ+YojfLLpo9DMkiCuNoBZysUEZh/iZqG6Ve6eVltLIwcObXFw3
   deY9HuLAo62XGe8DSa8hyHrHkotIFtkfAac3xP2gtg9Pa9RQOF4Frts7X
   I0qYNeEZTFUdpr5RoEU0yiSa/j6+J3IXyR6QoRrBp2Qx5FETYBzPUnLO2
   lzoMVT5NHWCP48fO/PswtEfDP65ecte7UM1ET+pNp0LptrJmlI547gjBo
   aCEAiJ2qMoxuio4IpQdcm5bbiRznixSL3AQ8F32EQWAH5bXpOl60FE6Lb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="318722547"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="318722547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="684203053"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="684203053"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2022 04:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 660871CA; Thu, 29 Dec 2022 15:00:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 3/3] pinctrl: cherryview: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Thu, 29 Dec 2022 14:59:57 +0200
Message-Id: <20221229125957.45923-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pm.h provides a helper for system no-IRQ PM callbacks,
switch the driver to use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 917563cef965..ddb83a40cce5 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1875,9 +1875,7 @@ static int chv_pinctrl_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops chv_pinctrl_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(chv_pinctrl_suspend_noirq, chv_pinctrl_resume_noirq)
-};
+static DEFINE_NOIRQ_DEV_PM_OPS(chv_pinctrl_pm_ops, chv_pinctrl_suspend_noirq, chv_pinctrl_resume_noirq);
 
 static const struct acpi_device_id chv_pinctrl_acpi_match[] = {
 	{ "INT33FF", (kernel_ulong_t)chv_soc_data },
-- 
2.35.1

