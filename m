Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07399601444
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJQRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJQRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:05:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE370E65;
        Mon, 17 Oct 2022 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026349; x=1697562349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A3GSK7UcppYiZrTEXbYQcILOnGqIDRlwIG2L6adHdKY=;
  b=nZHyNW03gs6s5nsdIB4W6BnVmiouwKVTdAgJMvL1SdyoUBonQ/6JOKK8
   RqjqmwtWZ9cj3BXLFLOzosZTjjvRKp457oANs2IcKDXbhoWIHuHB7wHvW
   3sYWdsb3QNnGf39pjeoynsnegIErHEU/uiuJGRTbOZHjNjWe7xyhpw34j
   x9XZQ0JTiqeZt9ueCXIhiHc+RPyMBblq9Bj/RURg5z9/eYv/MRzuJk0jW
   Mgcv3PJuld6+xn+pddG6hBMJKWCMs3guVOGLjYF0MO3SNh6JppCjbVRxl
   AzOrFOpK434pMu2Tk8ShxzM1hWdDH0IazeYxXPrRTT7cs5Z+FRdstjKDg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289154494"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289154494"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="628374303"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="628374303"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2022 10:05:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 11E2F26D; Mon, 17 Oct 2022 20:06:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qingtao Cao <qingtao.cao.au@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: exar: Allow IO port access
Date:   Mon, 17 Oct 2022 20:06:00 +0300
Message-Id: <20221017170600.88480-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that PCI device can provide an IO port resource for
the device. regmap MMIO currently uses MMIO by default. With an
additional flag we enable support for IO port accesses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-exar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 482f678c893e..df1bdaae441c 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -141,6 +141,7 @@ static const struct regmap_config exar_regmap_config = {
 	.name		= "exar-gpio",
 	.reg_bits	= 16,
 	.val_bits	= 8,
+	.io_port	= true,
 };
 
 static int gpio_exar_probe(struct platform_device *pdev)
-- 
2.35.1

