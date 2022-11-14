Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48B628887
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiKNSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiKNSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:46:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E3595B9;
        Mon, 14 Nov 2022 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668451567; x=1699987567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1WKTqJpkjMEr16VW72RtfByJdldDDo4IhA1v1pcwfI=;
  b=lXjuic0mQOaUiLfVwioPt4V0+NTmgy6+yeBVaJPrT78EUSPhdBgmUZYe
   fn6JzgjX1EUrMQSwtTEs0TjawvN7lnyqIsbeUhvtlD5W6JcRc0auP/UCO
   HDk1cc2RnFx3v4KPpqgmoAcMHZZ1ax+llQupNSI04dKUb41lPdQHndLG+
   esAsIaTqjLkcC5l6mHKPG0G4xmFdEzecgPgPmx2EbzlMx9ooDDqfXFF8t
   rJW0+not33jAclqCUZIlFMqYWB5/1kTIzheQVerLyRgyz0Y9tY3c4WN3P
   aDAnpLDD0moMFywjadJrVipMh+uE8FiVtb8qOmbCyWMYFidiWG9pbZxRp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313197441"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313197441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669773432"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669773432"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 10:46:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A25C2F3; Mon, 14 Nov 2022 20:46:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data() for fwnode
Date:   Mon, 14 Nov 2022 20:46:25 +0200
Message-Id: <20221114184626.64214-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library is getting rid of of_node, fwnode should be utilized instead.
Prepare of_mm_gpiochip_add_data() for fwnode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: added tag (Linus), modified according to Dmitry's suggestion
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4be3c21aa718..d30a5210dfdd 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -935,8 +935,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 	if (mm_gc->save_regs)
 		mm_gc->save_regs(mm_gc);
 
-	of_node_put(mm_gc->gc.of_node);
-	mm_gc->gc.of_node = of_node_get(np);
+	fwnode_handle_put(mm_gc->gc.fwnode);
+	mm_gc->gc.fwnode = fwnode_handle_get(of_fwnode_handle(np));
 
 	ret = gpiochip_add_data(gc, data);
 	if (ret)

base-commit: 8dab99c9eab3162bfb4326c35579a3388dbf68f2
-- 
2.35.1

