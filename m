Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED94658CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiL2M7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiL2M7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:59:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E03D13E3A;
        Thu, 29 Dec 2022 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672318774; x=1703854774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3WsSO9O51lFPB1otUWTEinjSTgtzgo4BI9Nj5m+iCzE=;
  b=fmEWMVTj3hxgA9jr76ZHXVZoK4s0GJLg04t4ROqaoGSHreJTOLuIAh4q
   OYteP2AkvPFOAX4+8Gp9Q5qdwogKekVCPocPFRmew8i1+6ELnQ5Y6fZnS
   stb22KFPIm4H2dh20fhVY0T9pvYKua1l/hjS/2SxU/FQWVu/+qvvQyjHG
   5jNdI/ID2bth3UfLPD7OvgRvsPufRIL3fdML9ZLCAnf8oKvCXQTWtFyGB
   7yTkDWzzH/a7tSjTpnTX9pzCq5efS4WWaXj36gMeUS9cd2dHLHCsGRozR
   kiKor624GzaH/bePF3NlZsGAcnaTl4kgDhOix/NOFew//3MRcNzj9aMn0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="348247468"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="348247468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777691263"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777691263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CBF719E; Thu, 29 Dec 2022 15:00:01 +0200 (EET)
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
Subject: [PATCH v1 2/3] pinctrl: intel: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
Date:   Thu, 29 Dec 2022 14:59:56 +0200
Message-Id: <20221229125957.45923-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pm.h provides a helper for system no-IRQ PM callbacks,
switch the driver to use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 350328988571..207ef71f4a7d 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -261,9 +261,7 @@ int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 int intel_pinctrl_suspend_noirq(struct device *dev);
 int intel_pinctrl_resume_noirq(struct device *dev);
 
-#define INTEL_PINCTRL_PM_OPS(_name)								\
-const struct dev_pm_ops _name = {								\
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)	\
-}
+#define INTEL_PINCTRL_PM_OPS(name)								\
+	DEFINE_NOIRQ_DEV_PM_OPS((name), intel_pinctrl_suspend_noirq, intel_pinctrl_resume_noirq)
 
 #endif /* PINCTRL_INTEL_H */
-- 
2.35.1

