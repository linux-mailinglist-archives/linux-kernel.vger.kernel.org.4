Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD9722BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjFEPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjFEPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA33E54;
        Mon,  5 Jun 2023 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685979950; x=1717515950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/IVTcr+jzG8u5BML8CWpJRp9glsm0WdjT1NvRtOaRGc=;
  b=DZV0xBlGtR15f4s32AUbRpkStMNTgwFgtMFE1Y1e/WGmOaray+ANHXhR
   X2yEYhNmTCviPKDp1PLPSRiJ4aN6kIbGdrdZubX8eY23s83pVoWBZQ68y
   5cyOKBa68Akfps1Ut5pAD7n29RKHdbckCpsBcZVifYZ8/SloKC8nxaymY
   HyV8/B/vYdktuIihEovRxhFwGzysWkwOUlFo9/+NRCtYU2RE71cg0HuCw
   70093amNE0DwXODY69vs9iTgdmVNvP72iwiSNvML5xcVKMZbYt6/iH3X9
   vJkTKH6Gz4Zw42kAjNFHQcVLcIVlESYdB91PNgOMxwAz6kSSVYjL/YmhP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384707604"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384707604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="738405451"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="738405451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2023 08:45:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 443B3204; Mon,  5 Jun 2023 18:45:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] pinctrl: merrifield: Fix open-drain pin mode configuration
Date:   Mon,  5 Jun 2023 18:45:08 +0300
Message-Id: <20230605154509.11616-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pinctrl/intel/pinctrl-merrifield.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-merrifield.c b/drivers/pinctrl/intel/pinctrl-merrifield.c
index 365c391c97a3..f1d0b7576703 100644
--- a/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ b/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -710,6 +710,11 @@ static int mrfld_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		break;
 
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (value & BUFCFG_OD_EN)
+			return -EINVAL;
+		break;
+
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		if (!(value & BUFCFG_OD_EN))
 			return -EINVAL;
@@ -791,10 +796,14 @@ static int mrfld_config_set_pin(struct mrfld_pinctrl *mp, unsigned int pin,
 
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
@@ -826,6 +835,7 @@ static int mrfld_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_BIAS_DISABLE:
 		case PIN_CONFIG_BIAS_PULL_UP:
 		case PIN_CONFIG_BIAS_PULL_DOWN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		case PIN_CONFIG_SLEW_RATE:
 			ret = mrfld_config_set_pin(mp, pin, configs[i]);
-- 
2.40.0.1.gaa8946217a0b

