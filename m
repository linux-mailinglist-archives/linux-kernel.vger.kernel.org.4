Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C30650BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiLSMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiLSMma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:42:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96BE00F;
        Mon, 19 Dec 2022 04:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453749; x=1702989749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wjyg7b3+Cz5+uNHjs62Sul3FvaH5gYXBtxaOwtuoGJc=;
  b=XWgUyfYnApA/VoJgeL2+T9Ctib6QjjFLjUAVuJepbaarNr3L+5kJr+DM
   dFlzouB6dFTmSOuxiLrsmLQ7991JeUXSl02a1MqeUCZHLxBz1IbH0QTK3
   NrmznuEDoNxelro8/xWmC/MpJyls6xpaDnvLs1epiUc423r78nVfn7FXR
   19GyBeFcVaPzke1TLSZbNlBAMnrD1Jz4KIlRgCZlwigcQgSRypwK9BX32
   ZdNiy7o3aJig3CbrmUUtKUjhswcd7aoS5mlBP5LjMVPiTaINUw+BSor6/
   8QX9OUjCX72sLX0qfXlQ3mNaXkq6r0YJurwKgAMCHzkvSaqRFTVOk0oN1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="381564787"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="381564787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="979361373"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="979361373"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2022 04:42:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4FFD71C3; Mon, 19 Dec 2022 14:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 5/8] pinctrl: lynxpoint: Convert to use new memeber in struct intel_function
Date:   Mon, 19 Dec 2022 14:42:37 +0200
Message-Id: <20221219124240.62781-5-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 8d05dad38556..cdace55aaeac 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -341,18 +341,18 @@ static const char *lp_get_function_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 
-	return lg->soc->functions[selector].name;
+	return lg->soc->functions[selector].func.name;
 }
 
 static int lp_get_function_groups(struct pinctrl_dev *pctldev,
 				  unsigned int selector,
 				  const char * const **groups,
-				  unsigned int *num_groups)
+				  unsigned int *ngroups)
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups		= lg->soc->functions[selector].groups;
-	*num_groups	= lg->soc->functions[selector].ngroups;
+	*groups		= lg->soc->functions[selector].func.groups;
+	*ngroups	= lg->soc->functions[selector].func.ngroups;
 
 	return 0;
 }
-- 
2.35.1

