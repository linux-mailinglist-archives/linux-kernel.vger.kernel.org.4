Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F87727811
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjFHHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjFHHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:02:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE931BD6;
        Thu,  8 Jun 2023 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686207710; x=1717743710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ef5s9TkcxXSlz6lTIJfajIVYzY4IV1HrFB/BqDVmIJA=;
  b=h5y+/OUJbTuPmHhSWwAORY3VTXo84225FNXdLYyTIXe42ZxNQwwHXyJD
   5fZ4I8FTSmxVotSS2mdYMFBfJis9tMOMrEHkh2PcKhwQupPyZg6fd/H9f
   NBoAcEM1x6As1sCiowGRU+i+hf8kNL4L8D6Gz3X5u6D3SPKG8v/Lt9Ycs
   H2LnW8mZMVpZJf7xVr3G4L2bimpEIIHy0SV+nGSB7XwSSHu4+xWRF7uca
   soRWNr11VbtihbsjZGil371AJX5fqKZMVRC1Qvb4+zDwa3niPXVWVHMV+
   2XzOIgdXzHc9bp15WQzzjTuITA/mju9rS20ypoHOuJxLxLzcNH4Erc3iJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359696344"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359696344"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709867969"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="709867969"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 00:01:07 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 0E9AD1AA12;
        Thu,  8 Jun 2023 12:31:07 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 089691DE; Thu,  8 Jun 2023 12:31:07 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/4] pinctrl: intel: optimize set_mux hook
Date:   Thu,  8 Jun 2023 12:30:14 +0530
Message-Id: <20230608070017.28072-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608070017.28072-1-raag.jadav@intel.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable for common shift operation
inside ->set_mux() hook and save a few bytes.

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

