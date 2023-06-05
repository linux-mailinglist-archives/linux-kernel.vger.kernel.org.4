Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03293722BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjFEPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjFEPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:47:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D1210DB;
        Mon,  5 Jun 2023 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685980017; x=1717516017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eC2G+d8txu/yxblVWStVJW47JlaxpIrg61haGv7/ORU=;
  b=KbR3wF88hoZVkrsAvqvm7K1Aq+fWEPppKeNsrmf4IqNyJAowLzdIYg5K
   PDmHVs8lgAwpqQHxRqaWmnmjqqCOFrw+k4vxdgewDwHvzoSA3BlA7nbFs
   3LllPbNCdpHb5mQcb8QT6IMG1deOQ84auPflB+UEchdhtWKxps1S22rg0
   MWJnNWZZilDBh6KGzflJ66+y7cc30Y5umsnoI19C9TpALqUcOHekoZ+pG
   drPITOpGg8sz9O5eJa4nGsAm279Fh7rhRxr0rXU6VTLXXQtLSF8MmoBgX
   KqYmsGfimz9zYu+rGOTvXYnj0358Rb4NWYZIdukCZUZvBL2rOFlLx6w0k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359713186"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="359713186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="773777196"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="773777196"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2023 08:45:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBDF1204; Mon,  5 Jun 2023 18:45:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] pinctrl: moorefield: Fix open-drain pin mode configuration
Date:   Mon,  5 Jun 2023 18:45:22 +0300
Message-Id: <20230605154523.11799-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pin may not be configured as open-drain in some
cases because the argument may be 0 for the boolean types of
the pin configurations. Fix this by ignoring the argument.

With that, allow to actually restore pin to the push-pull mode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-moorefield.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-moorefield.c b/drivers/pinctrl/intel/pinctrl-moorefield.c
index 3c9a8484b442..7656a5e20919 100644
--- a/drivers/pinctrl/intel/pinctrl-moorefield.c
+++ b/drivers/pinctrl/intel/pinctrl-moorefield.c
@@ -661,6 +661,11 @@ static int mofld_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		break;
 
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (value & BUFCFG_OD_EN)
+			return -EINVAL;
+		break;
+
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		if (!(value & BUFCFG_OD_EN))
 			return -EINVAL;
@@ -734,10 +739,14 @@ static int mofld_config_set_pin(struct mofld_pinctrl *mp, unsigned int pin,
 
 		break;
 
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		mask |= BUFCFG_OD_EN;
+		bits &= ~BUFCFG_OD_EN;
+		break;
+
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		mask |= BUFCFG_OD_EN;
-		if (arg)
-			bits |= BUFCFG_OD_EN;
+		bits |= BUFCFG_OD_EN;
 		break;
 
 	case PIN_CONFIG_SLEW_RATE:
@@ -769,6 +778,7 @@ static int mofld_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_BIAS_DISABLE:
 		case PIN_CONFIG_BIAS_PULL_UP:
 		case PIN_CONFIG_BIAS_PULL_DOWN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		case PIN_CONFIG_SLEW_RATE:
 			ret = mofld_config_set_pin(mp, pin, configs[i]);
-- 
2.40.0.1.gaa8946217a0b

