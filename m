Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398072DD07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbjFMIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjFMIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:51:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D5C0;
        Tue, 13 Jun 2023 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686646291; x=1718182291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lRlqrIOLlgszhQgiQp5cTIQBBj7DVYDQjqPLzSvJfg0=;
  b=FvGdOigcrxES0oRfCfYyXapHzpsPlEZUT9HJOyfSxjVYICBRNkFF43GY
   90Ep0esb4IwQU0MX9DOXDFbVGlKeGXM8Y1TtwoDhzrnUtOEKD5eFP128l
   pnHYGHxyIhxJ1M7afeJcfP9Ny0+8/srFCk+3P2iycpNCPn2JBSxHbfS7w
   5N3DNkaPPAyaRITbHXba+xv8HE6/OtyQ7J8v1FamsudBwFiVOrpobQH6z
   8fJegQthz4dLmPMYydu9K6fgdiGiedEL4TqaJNd6NJnyBENu2JLIHaXBC
   N8qxVpbjgcQPRWAZnN5bPNvhXFZeg+Ua+RKW0Zlm5heeOKbNksZ4s8hmv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386664945"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="386664945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824305094"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="824305094"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 01:51:29 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 6CAF21973E;
        Tue, 13 Jun 2023 14:21:28 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 680C6196; Tue, 13 Jun 2023 14:21:28 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 1/3] pinctrl: intel: refine ->set_mux() hook
Date:   Tue, 13 Jun 2023 14:20:52 +0530
Message-Id: <20230613085054.10976-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613085054.10976-1-raag.jadav@intel.com>
References: <20230613085054.10976-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation in
->set_mux() hook and improve readability while saving a few bytes.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-3 (-3)
Function                                     old     new   delta
intel_pinmux_set_mux                         245     242      -3
Total: Before=10472, After=10469, chg -0.03%

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

