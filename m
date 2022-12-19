Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C3650C06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiLSMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiLSMnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:43:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D3FD18;
        Mon, 19 Dec 2022 04:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453807; x=1702989807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RiEyeQwFNbzEcZUDvCsiL9JfnkclSpnnO35jl8CiXtY=;
  b=I65WtZCOSg7lkuO+S06e3BtIKrINSNpIykdLuMldArBXjqx8EaGM8O6P
   3WJUTx5cO7/CGwhbL6L2SbI8pFH9W/Ujo+QTRRWS4HzMn8SqQDFV4uCjL
   Vr4CxpTvKccDqde+tew3L4pzxmtKd17b5ZFUzTwQTNdddH3SsMAwpkqjA
   f5R2c9B+Q/AleyyAKfNQJqoO5HtRD7RnzkA3vsO240WrUKwHJ2dYkwwOE
   PxqgeXU1cQ5mgRj3yd8SHSD9DUOAbtYVu0DqK+JN//E+sCwKMEvCOrnZe
   ZAdXUZHSRxwF346KAipKh9/jzd0nRJ9jr2hV5tPxKZiTSvQ4X72oUBlb7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="381564846"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="381564846"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="979361542"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979361542"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 04:42:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92D18F7; Mon, 19 Dec 2022 14:42:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/8] pinctrl: intel: Make use of struct pinfunction and PINCTRL_PINFUNCTION()
Date:   Mon, 19 Dec 2022 14:42:34 +0200
Message-Id: <20221219124240.62781-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pin control provides a generic data type and a macro for
the pin function definition, use them in the Intel driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I went with the embedding a generic structure into intel_function
instead of replacing the latter in order to keep symmetry with
intel_pingroup. In the case we will need the additional memeber
in the future there will be less churn, otherwise from the code
generation perspective it's the same.

 drivers/pinctrl/intel/pinctrl-intel.c |  6 +++---
 drivers/pinctrl/intel/pinctrl-intel.h | 13 ++++++++-----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 2f7931d9602c..682fd902009f 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -372,7 +372,7 @@ static const char *intel_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->soc->functions[function].name;
+	return pctrl->soc->functions[function].func.name;
 }
 
 static int intel_get_function_groups(struct pinctrl_dev *pctldev,
@@ -382,8 +382,8 @@ static int intel_get_function_groups(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = pctrl->soc->functions[function].groups;
-	*ngroups = pctrl->soc->functions[function].ngroups;
+	*groups = pctrl->soc->functions[function].func.groups;
+	*ngroups = pctrl->soc->functions[function].func.ngroups;
 	return 0;
 }
 
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 3b0e2d3f15d5..91e5bedba00b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -36,11 +36,13 @@ struct intel_pingroup {
 
 /**
  * struct intel_function - Description about a function
+ * @func: Generic data of the pin function (name and groups of pins)
  * @name: Name of the function
  * @groups: An array of groups for this function
  * @ngroups: Number of groups in @groups
  */
 struct intel_function {
+	struct pinfunction func;
 	const char *name;
 	const char * const *groups;
 	size_t ngroups;
@@ -183,11 +185,12 @@ struct intel_community {
 		.modes = __builtin_choose_expr(__builtin_constant_p((m)), NULL, (m)),	\
 	}
 
-#define FUNCTION(n, g)				\
-	{					\
-		.name = (n),			\
-		.groups = (g),			\
-		.ngroups = ARRAY_SIZE((g)),	\
+#define FUNCTION(n, g)							\
+	{								\
+		.func = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)),	\
+		.name = (n),						\
+		.groups = (g),						\
+		.ngroups = ARRAY_SIZE((g)),				\
 	}
 
 /**
-- 
2.35.1

