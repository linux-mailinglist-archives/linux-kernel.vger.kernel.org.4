Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540335BE71C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiITNaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:30:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D330563;
        Tue, 20 Sep 2022 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663680617; x=1695216617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bn99q4ngGyop/53C923Ky1yeNu9zZONopt7ou69a41U=;
  b=JJc0ARY6k/m2Y9qdXqPJSRYHsoT2whSickylCOlpA5YhmFpcPxP8AC51
   lhVQgadQlYSkKa2nt8K9mgij/4oeOXA+YJGkKcUATt2Ms/CsSnOCQvXp7
   7r8Y2AJGBPrqe2/F/vkYZVfAuZZavNANAHDdziuwI+MYB+GIvtvslqltZ
   7TP4/khnmYk5JXMjg0BIfIu2l8x98LlXCFCoroFMrzhppZqZZvrpl4yA7
   p584urM2w9er4RnGL32aoFUjgi5mMkWR/92/zXvqpUM3mQ5PBKk1thjvL
   a5iNQ94TGEDwAnDaBzKtTlo4GYsw3OMxxomqxhTIoCJQpYSUe8f37ZuCK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299681408"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="299681408"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="794259561"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 06:30:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA3F9238; Tue, 20 Sep 2022 16:30:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] gpio: mockup: Fix potential resource leakage when register a chip
Date:   Tue, 20 Sep 2022 16:30:31 +0300
Message-Id: <20220920133031.30031-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If creation of software node fails, the locally allocated string
array is left unfreed. Free it on error path.

Fixes: 6fda593f3082 ("gpio: mockup: Convert to use software nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-mockup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index a2e505a7545c..d6e42159fe44 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -533,8 +533,10 @@ static int __init gpio_mockup_register_chip(int idx)
 	}
 
 	fwnode = fwnode_create_software_node(properties, NULL);
-	if (IS_ERR(fwnode))
+	if (IS_ERR(fwnode)) {
+		kfree_strarray(line_names, ngpio);
 		return PTR_ERR(fwnode);
+	}
 
 	pdevinfo.name = "gpio-mockup";
 	pdevinfo.id = idx;
-- 
2.35.1

