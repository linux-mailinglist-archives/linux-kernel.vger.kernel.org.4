Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC59669B14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAMO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAMO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:56:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7E90845;
        Fri, 13 Jan 2023 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673620937; x=1705156937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=18oofQWHf5DFIwDs98Wn9Hl16JNrdAL2In5saqMvGME=;
  b=JaipAo6oX0LcypWynuh2CGNn65JVY7qXzYpJ3Cua3Q8jkWlkMpei/mtO
   3tMWwPLrVE036SJ//Z4ky5L72NVC53v4t4/etx/cJ/Md2T0HK3UnW4j5R
   ekXtk8tqJnFuw/9bnG7REcDUZVjPbrUOzaYTvMn1DLtBt9a1Vw+Bw6lNO
   4walz+pwTZCocwqAABsTyaf0ngb7wunM5Pu51OM4j1pOlMZ3iWYr5Bas0
   9bc71s0otBlV5soJjND+E1l3RbJrmNPT7aQcCu1M5OmUhzhZ/UGSnj86X
   ft244a9uQrcgg9L9q8D6ut7cINBvOIvtHn8GukNkPI5WwXjrA2kpnzUET
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307548090"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307548090"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:36:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766033116"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766033116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2023 06:36:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFE7C130; Fri, 13 Jan 2023 16:36:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 1/2] pinctrl: digicolor: Remove duplicate assignment of of_gpio_n_cells
Date:   Fri, 13 Jan 2023 16:36:39 +0200
Message-Id: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
v2: added tag (Baruch), avoid confusion with previously sent patch
 drivers/pinctrl/pinctrl-digicolor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index cc3546fc4610..05213261b8a4 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -248,7 +248,6 @@ static int dc_gpiochip_add(struct dc_pinmap *pmap)
 	chip->set		= dc_gpio_set;
 	chip->base		= -1;
 	chip->ngpio		= PINS_COUNT;
-	chip->of_gpio_n_cells	= 2;
 
 	spin_lock_init(&pmap->lock);
 
-- 
2.39.0

