Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36E650BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiLSMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLSMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47010079;
        Mon, 19 Dec 2022 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453137; x=1702989137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qgOVvrlzbHsqpf1XxwtsWs2Z6+2owIXYObNDgCh+7Ek=;
  b=UcODYG/ZcXWONQ/V6e2uI+9uAcWNrlOis+clsVK3Y0s+5pqy1rBr7QFs
   /sh532lwZAArQ4mnUnt5EtSCgNK0siwHjoyDkF0qZ6t72OzuniRF5IR1y
   rlM4v8CmeogpETahZxAS3hj2N3ol7GkVkvAHFzPwEFu3so3ZUTNCQ4sB7
   4RXkh6CtXZMsjiO4bQwPiHz5WgMR4GDrDzpbhemjfceb1/GNvrNlZFvhx
   tq9dQsgfTL99PVCxowlQZ6PJAdS1IMrZrhzOzJos2EP7OIP8WuA4JXbHc
   hgHrHzIAbaPaJIHbfpzuSOStni6pxPUM8NT6cZQIwM5/0lINZpEb1I8iJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="346430177"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="346430177"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="650532011"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="650532011"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2022 04:32:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 711D4F7; Mon, 19 Dec 2022 14:32:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Define maximum pad number in the group
Date:   Mon, 19 Dec 2022 14:32:40 +0200
Message-Id: <20221219123240.5601-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using hard coded magic number here and there,
define maximum pad number in the group in newly added
INTEL_PINCTRL_MAX_GPP_SIZE.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 +++---
 drivers/pinctrl/intel/pinctrl-intel.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 9d2791a81ffa..2f7931d9602c 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1403,7 +1403,7 @@ static int intel_pinctrl_add_padgroups_by_gpps(struct intel_pinctrl *pctrl,
 	for (i = 0; i < ngpps; i++) {
 		gpps[i] = community->gpps[i];
 
-		if (gpps[i].size > 32)
+		if (gpps[i].size > INTEL_PINCTRL_MAX_GPP_SIZE)
 			return -EINVAL;
 
 		/* Special treatment for GPIO base */
@@ -1421,7 +1421,7 @@ static int intel_pinctrl_add_padgroups_by_gpps(struct intel_pinctrl *pctrl,
 		}
 
 		gpps[i].padown_num = padown_num;
-		padown_num += DIV_ROUND_UP(gpps[i].size * 4, 32);
+		padown_num += DIV_ROUND_UP(gpps[i].size * 4, INTEL_PINCTRL_MAX_GPP_SIZE);
 	}
 
 	community->gpps = gpps;
@@ -1437,7 +1437,7 @@ static int intel_pinctrl_add_padgroups_by_size(struct intel_pinctrl *pctrl,
 	unsigned int padown_num = 0;
 	size_t i, ngpps = DIV_ROUND_UP(npins, community->gpp_size);
 
-	if (community->gpp_size > 32)
+	if (community->gpp_size > INTEL_PINCTRL_MAX_GPP_SIZE)
 		return -EINVAL;
 
 	gpps = devm_kcalloc(pctrl->dev, ngpps, sizeof(*gpps), GFP_KERNEL);
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 981c1f520f13..3b0e2d3f15d5 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -46,11 +46,13 @@ struct intel_function {
 	size_t ngroups;
 };
 
+#define INTEL_PINCTRL_MAX_GPP_SIZE	32
+
 /**
  * struct intel_padgroup - Hardware pad group information
  * @reg_num: GPI_IS register number
  * @base: Starting pin of this group
- * @size: Size of this group (maximum is 32).
+ * @size: Size of this group (maximum is %INTEL_PINCTRL_MAX_GPP_SIZE).
  * @gpio_base: Starting GPIO base of this group
  * @padown_num: PAD_OWN register number (assigned by the core driver)
  *
-- 
2.35.1

