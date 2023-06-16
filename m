Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5856D733AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjFPUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjFPUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:34:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2B63A92;
        Fri, 16 Jun 2023 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686947693; x=1718483693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=M4+ZSao6t8hnC6QT4ItA5tKP2pHPLCNAcpFWdcdgUh4=;
  b=lpzw5vOBflPjXkfUa+lQ/sFpj56smCPC85YTtoe9HFTDk+I+H37f6cKe
   GupekwVqok3i8pbQeUHwN3LvQHn2wO+h7LP1s4iIwS48bvDJiwlEX/nIN
   fgdYpYWdZIQ4dS9PFL2oCqcfP5s80vTosYKj8RbuwAGOqPxvLdkWg1liW
   AE7E2eT+HLqQqFH5FtvSmOVgbYqxvfoEFJVqiGMZXFHQFOF4bbEhUmo0R
   R5NsgcinYAY5tkk/1ed9oS8IzI8PC1lrWKzqUOPfICWIUn23yA0TMLnxv
   n3AfSWyQ33AwunOwNj3+xWGEGVE4YDeHbMkUa8QecriJbsUHve7HH1rU8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358181780"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358181780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="802964401"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="802964401"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2023 13:34:50 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5530E911E9;
        Sat, 17 Jun 2023 02:04:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 505B31D3; Sat, 17 Jun 2023 02:04:49 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH for-next v1 2/3] pinctrl: baytrail: add warning for BYT_VAL_REG retrieval failure
Date:   Sat, 17 Jun 2023 02:03:55 +0530
Message-Id: <20230616203356.27343-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616203356.27343-1-raag.jadav@intel.com>
References: <20230616203356.27343-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add warning for BYT_VAL_REG retrieval failure and continue such case
to avoid unintended reads/writes in pm_ops.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 54d3c5c26944..97ead2c58b66 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1758,6 +1758,10 @@ static int byt_gpio_suspend(struct device *dev)
 		vg->context.pads[i].conf0 = value;
 
 		reg = byt_gpio_reg(vg, pin, BYT_VAL_REG);
+		if (!reg) {
+			dev_warn(vg->dev, "Pin %i: can't retrieve VAL\n", i);
+			continue;
+		}
 		value = readl(reg) & BYT_VAL_RESTORE_MASK;
 		vg->context.pads[i].val = value;
 	}
@@ -1794,6 +1798,10 @@ static int byt_gpio_resume(struct device *dev)
 		}
 
 		reg = byt_gpio_reg(vg, pin, BYT_VAL_REG);
+		if (!reg) {
+			dev_warn(vg->dev, "Pin %i: can't retrieve VAL\n", i);
+			continue;
+		}
 		value = readl(reg);
 		if ((value & BYT_VAL_RESTORE_MASK) !=
 		     vg->context.pads[i].val) {
-- 
2.17.1

