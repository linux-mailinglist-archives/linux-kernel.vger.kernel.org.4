Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7944970B442
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjEVE6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEVE6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:58:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC91C6;
        Sun, 21 May 2023 21:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684731528; x=1716267528;
  h=from:to:cc:subject:date:message-id;
  bh=sDpsTFZfNibw4zeLjj7zpdDqfRmQ7qPkUjJ2IKMHo2Q=;
  b=TayMt/EJ2Z/O6rmkHi97hA+QN1MCrgEGnhmLxaOyWWFhYjTjRU04yA1/
   qEX14uteZjPejABYIf06L1fG5Ij0EzQ/JCaQGZB9bp3VgNV1jq86WKFRD
   IjyHzTW4XiJMLTebeJnwoe9MLyugpxhmrJVEt+nk+I7EIqKFF7tyzc1lR
   oPHsxw+vWSBXWVGzUEK3CQ24Qe+pdCuua/aaM8jLmmzLw8pj3ckLAtyo4
   8wEy65GQl/1gV9BsCi9+3/jKOPL4Lv5JS4PZe+uq5CuWUJij0hlaeJJ6i
   Ba/iFEIp2pDPDSLqeB0ftXup6+OsMme99v42P7xH5po+sIXXnjl/HDGC/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="418535102"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="418535102"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 21:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="768374525"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="768374525"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2023 21:58:45 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id DDF5819746;
        Mon, 22 May 2023 10:28:44 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id D891415B; Mon, 22 May 2023 10:28:44 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] gpio: tangier: calculate number of ctx using temporary variable
Date:   Mon, 22 May 2023 10:28:06 +0530
Message-Id: <20230522045806.3442-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize a temporary variable to calculate number of ctx from ngpio
inside ->probe() implementation.
While at it, include math.h for using DIV_ROUND_UP().

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpio/gpio-tangier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tangier.c b/drivers/gpio/gpio-tangier.c
index e990781935ba..7ce3eddaed25 100644
--- a/drivers/gpio/gpio-tangier.c
+++ b/drivers/gpio/gpio-tangier.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/spinlock.h>
@@ -428,10 +429,11 @@ static int tng_gpio_add_pin_ranges(struct gpio_chip *chip)
 int devm_tng_gpio_probe(struct device *dev, struct tng_gpio *gpio)
 {
 	const struct tng_gpio_info *info = &gpio->info;
+	size_t nctx = DIV_ROUND_UP(info->ngpio, 32);
 	struct gpio_irq_chip *girq;
 	int ret;
 
-	gpio->ctx = devm_kcalloc(dev, DIV_ROUND_UP(info->ngpio, 32), sizeof(*gpio->ctx), GFP_KERNEL);
+	gpio->ctx = devm_kcalloc(dev, nctx, sizeof(*gpio->ctx), GFP_KERNEL);
 	if (!gpio->ctx)
 		return -ENOMEM;
 
-- 
2.17.1

