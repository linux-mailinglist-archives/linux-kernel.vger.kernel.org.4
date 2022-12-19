Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F43650BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiLSMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLSMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:42:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B31DFC6;
        Mon, 19 Dec 2022 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453748; x=1702989748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6mI0ViUNS836fKzrEqVfJ8ESwDkp7g6U7Pv35w8R+Dg=;
  b=XpQg3riiYT1Pq6Hft3nxZWZza5I+cbDMMzeVhBzKZBLHR5fsDjN0pwk0
   auNrveIAo5+PMcrTPYXPfPag+VH22ipgPEz3pA1X8kIlXf1A4WZTJh12W
   8oCxEwD8JENbx/zIgE4Xo3Ahb20Y+P7vEvdn9RBYHPm1JS1Nffcq4xtsN
   xW8uFZi3cjjVJkGRxsSEd0pjYpE9oz3fVt5n7N/gPdjO904iXmMclWIKr
   IaJEb6OEdan5iE6NsaYgDK4nthoeYIbI16T3GQd6xIN0xIV48W6n5nrZl
   bqBa4GQOWJ9MkSSvjDiEaleRyIkbd19Pj0XAWOpXrgxce+1jEvOmzXxEl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="320510348"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="320510348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="681210358"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="681210358"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 04:42:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 400C011D; Mon, 19 Dec 2022 14:42:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/8] pinctrl: baytrail: Convert to use new memeber in struct intel_function
Date:   Mon, 19 Dec 2022 14:42:35 +0200
Message-Id: <20221219124240.62781-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
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

Convert driver to use generic data type and hence a new member in
the struct intel_function. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 67db79f38051..770a2723ef81 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -637,18 +637,18 @@ static const char *byt_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
 
-	return vg->soc->functions[selector].name;
+	return vg->soc->functions[selector].func.name;
 }
 
 static int byt_get_function_groups(struct pinctrl_dev *pctldev,
 				   unsigned int selector,
 				   const char * const **groups,
-				   unsigned int *num_groups)
+				   unsigned int *ngroups)
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups		= vg->soc->functions[selector].groups;
-	*num_groups	= vg->soc->functions[selector].ngroups;
+	*groups		= vg->soc->functions[selector].func.groups;
+	*ngroups	= vg->soc->functions[selector].func.ngroups;
 
 	return 0;
 }
@@ -722,7 +722,7 @@ static int byt_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
 
 	if (group.modes)
 		byt_set_group_mixed_mux(vg, group, group.modes);
-	else if (!strcmp(func.name, "gpio"))
+	else if (!strcmp(func.func.name, "gpio"))
 		byt_set_group_simple_mux(vg, group, BYT_DEFAULT_GPIO_MUX);
 	else
 		byt_set_group_simple_mux(vg, group, group.mode);
-- 
2.35.1

