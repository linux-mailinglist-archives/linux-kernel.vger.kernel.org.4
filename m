Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B966A215
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjAMSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjAMS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:29:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AE080AE6;
        Fri, 13 Jan 2023 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673634349; x=1705170349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eG4OuRyjCZe8OikZYs+kddA7ukKCqAcj7N9qQVWtCFw=;
  b=CKzhJNJXyPUSoC3TsFbp/ENTdzKtrBZuV8/GXPw/32oJjpgXGKtdPRvZ
   ybcj+++5MPSOpYZh6YHlL0bY78CrnMHDOaH00sU+r777bfotBDQi9qhR0
   qi2EiHb6sfSOGq4YCBLaLOONO44WaQw7zcjPqKWwyKFtyJAxmC24yVmLf
   hWTpWcCIx4aqad1Hfqd0K3RSkOluvPFadOTDZsqO/CJQoJ4Ju35bwzsyS
   eTurVWTcoYQQburQ8GJsAENu7+FZVJCDkiNI2988RFnpJe3FGml02ak3P
   p50M6S7LXz0FIaJbxmjzjFM/G4laWFSHAcodtS2eFseoNM2glT2Gmx7yh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351297783"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351297783"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 10:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987087236"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="987087236"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 10:25:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3271FE1; Fri, 13 Jan 2023 20:26:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/2] gpio: wcd934x: Remove duplicate assignment of of_gpio_n_cells
Date:   Fri, 13 Jan 2023 20:26:18 +0200
Message-Id: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The of_gpio_n_cells default is 2 when ->of_xlate() callback is
not defined. No need to assign it explicitly in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpio-wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 97e6caedf1f3..817750e4e033 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -98,7 +98,6 @@ static int wcd_gpio_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->ngpio = WCD934X_NPINS;
 	chip->label = dev_name(dev);
-	chip->of_gpio_n_cells = 2;
 	chip->can_sleep = false;
 
 	return devm_gpiochip_add_data(dev, chip, data);
-- 
2.39.0

