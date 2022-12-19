Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CF650C08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiLSMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:43:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831510B6A;
        Mon, 19 Dec 2022 04:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453814; x=1702989814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnL6MrmnzkZ9KQarfI8X6RWJyObe5UEYwf4Sqd3GiDU=;
  b=kR5H9Ucv6tFIJTC8ZxC56T8V4lOJOgALziDm9O4f3SIvlqR6yAfILYXy
   /+rhqRuuvz6GDRIqd6yjouPc65oluZaoioLjJ9JILRLLy4xSaa+ZpKT0h
   ZbZ3QXuQncMG1k+O/pnanvfZd+1COaBNEG7KssR6/rlvxDZGvL49E2Unu
   OOVOLBd6Hxk2adK+RnvynZz5jM7geui2+07bASEskrmZsi5Mrs4u5nm6x
   XMqC8B3mX0BUFLEh/nYgtPaenuQ3mLjLaomanK/fGSBMxe8w7NrFeWSsh
   /YoZAstGHGmFwiFeaAj2RPCtqgKGqlWxF6BKJKIKp4l45vGf1JN2hrm2z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="381564859"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="381564859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="979361554"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979361554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 04:42:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B67F0132; Mon, 19 Dec 2022 14:42:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/8] pinctrl: cherryview: Convert to use new memeber in struct intel_function
Date:   Mon, 19 Dec 2022 14:42:36 +0200
Message-Id: <20221219124240.62781-4-andriy.shevchenko@linux.intel.com>
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

Convert driver to use generic data type and hence a new member in
the struct intel_function. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 11b81213922d..722990e27836 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -694,7 +694,7 @@ static const char *chv_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->soc->functions[function].name;
+	return pctrl->soc->functions[function].func.name;
 }
 
 static int chv_get_function_groups(struct pinctrl_dev *pctldev,
@@ -704,8 +704,8 @@ static int chv_get_function_groups(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = pctrl->soc->functions[function].groups;
-	*ngroups = pctrl->soc->functions[function].ngroups;
+	*groups = pctrl->soc->functions[function].func.groups;
+	*ngroups = pctrl->soc->functions[function].func.ngroups;
 	return 0;
 }
 
-- 
2.35.1

