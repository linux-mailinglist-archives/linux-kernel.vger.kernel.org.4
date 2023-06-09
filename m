Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9A729315
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbjFII1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbjFII0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:26:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF573A88;
        Fri,  9 Jun 2023 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686299163; x=1717835163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FdOUg0wrIHPy8S0vIosISMVGhprK8AkkqdGWBQxA5zY=;
  b=ZG8wtSDRucr0V6x7dRWIb/aLTq35esGqxL2smpKzEj0R/lLFy4FcSVCe
   mVz3T+XDWAKY2433pQ2hDs5TOW4d2kwIi2P7SJjdi0Ep22RjRiKc8XKCF
   7+Gtihi81BhtlK4wRiSEQKFiRffKX14Z2dX/f+ntjAac+VefC0U46ZlH/
   ixmEcXecSnd0KpagsTuuQOn+lwuZYVW0zJrSvQXGABhd48e3IwiTprBa6
   xs1jTvUpfc5U6R+09lwwAaNjfRvj/MjbU0ICBmOk7N5i/mTgGGu2G9hLW
   vnX14liewaWirwrgwzBYTBRGQSf04Pc2ETodaih49eiAU1x0NElebdsmT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342222300"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342222300"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713424276"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713424276"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:25:59 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 060B71435B;
        Fri,  9 Jun 2023 13:55:59 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id F387DAB; Fri,  9 Jun 2023 13:55:58 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/4] pinctrl: intel: refine set_mux hook
Date:   Fri,  9 Jun 2023 13:55:36 +0530
Message-Id: <20230609082539.24311-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230609082539.24311-1-raag.jadav@intel.com>
References: <20230609082539.24311-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation
inside ->set_mux() hook and improve readability.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index c7a71c49df0a..e8adf2580321 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -411,18 +411,19 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	/* Now enable the mux setting for each pin in the group */
 	for (i = 0; i < grp->grp.npins; i++) {
 		void __iomem *padcfg0;
-		u32 value;
+		u32 value, pmode;
 
 		padcfg0 = intel_get_padcfg(pctrl, grp->grp.pins[i], PADCFG0);
-		value = readl(padcfg0);
 
+		value = readl(padcfg0);
 		value &= ~PADCFG0_PMODE_MASK;
 
 		if (grp->modes)
-			value |= grp->modes[i] << PADCFG0_PMODE_SHIFT;
+			pmode = grp->modes[i];
 		else
-			value |= grp->mode << PADCFG0_PMODE_SHIFT;
+			pmode = grp->mode;
 
+		value |= pmode << PADCFG0_PMODE_SHIFT;
 		writel(value, padcfg0);
 	}
 
-- 
2.17.1

