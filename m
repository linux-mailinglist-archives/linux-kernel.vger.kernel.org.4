Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111557228F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjFEOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjFEOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:37:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253CEC;
        Mon,  5 Jun 2023 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685975852; x=1717511852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/qGZlNd6RIP40N6XQ7Vl40wHuHBVAHMtRbiRDDBiBU=;
  b=aZJgVl6eInwQo0/yBBr3sRJuAEUn2h4HJDwDgQuuNHVv0AXLVMVlqIJY
   cFSC6N4l/S/ClmR3AsvixGIWbodwzrDn+Phzrr3ROF/5jxrOZAvuX7w79
   tCJFjfoFFpch2VqpArLdRONXuYUGALrS5glCTSfapvKZPjkFxm+PfihkZ
   w7UL38bNe6szwGqvh4IlTYKX9SM7hx2El6QNYWxkClRTyhDLMMCMV6PbX
   N+Ww6dakONHa4vDojSsRSyRy67hEVC9MFufl/lk2AJp0zjJ0kw4e8FJFI
   lXQsYzX85TMPhMhAFxVH8OmEUWvvb0KDwj8Jtm1yhYe6uRdYlyzoQUoIt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384688231"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384688231"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 07:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="708679957"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708679957"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2023 07:37:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D3A17204; Mon,  5 Jun 2023 17:37:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: cherryview: Return correct value if pin in push-pull mode
Date:   Mon,  5 Jun 2023 17:37:34 +0300
Message-Id: <20230605143734.73434-1-andriy.shevchenko@linux.intel.com>
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

Currently the getter returns ENOTSUPP on pin configured in
the push-pull mode. Fix this by adding the missed switch case.

Fixes: ccdf81d08dbe ("pinctrl: cherryview: add option to set open-drain pin config")
Fixes: 6e08d6bbebeb ("pinctrl: Add Intel Cherryview/Braswell pin controller support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index ee333337bc1b..b25717d54f69 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -949,11 +949,6 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		break;
 
-	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
-			return -EINVAL;
-		break;
-
 	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE: {
 		u32 cfg;
 
@@ -963,6 +958,16 @@ static int chv_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
 			return -EINVAL;
 
 		break;
+
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (ctrl1 & CHV_PADCTRL1_ODEN)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!(ctrl1 & CHV_PADCTRL1_ODEN))
+			return -EINVAL;
+		break;
 	}
 
 	default:
-- 
2.40.0.1.gaa8946217a0b

