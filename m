Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31154618993
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKCU3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:29:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE0B0E;
        Thu,  3 Nov 2022 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667507390; x=1699043390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lzVycpCtgMrBkMP7/oBhm5i+kEiUUwN/3PQpjRlnOCU=;
  b=kPXmBhlVznyAUF6lQhIPWH8eZVfjqDYFQtdCGOjXwY9bI+EYsSSkBiYm
   InWiGIP9mcpP9tmcHYpTr9bCGNaKebbBgJKY8gqnZf9+3ideny7bXAWy9
   4wvIoEX8T/LBnMg5jHMSzOAKG6RCVpZxdd35Mi1nDvCnnUehO15E4towt
   XB/zHgeoxgkrBwn122SpTyjb+VXJtKVownnDq859X3umYD7GPuVAZT/Cn
   my42mbuJAPrFJKurnyRLEcj4mweWUYdvqi5LNhfr3I7NCe/NSpj+v3G0E
   H0Wvv31/pwOO4tS6unQ/KANQVwXHriNntH5X1d+qxWJ6Jbe5Clf7Msyze
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307416953"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="307416953"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="634816847"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="634816847"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2022 13:29:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED00CF7; Thu,  3 Nov 2022 22:30:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: of: Make use of device_match_of_node()
Date:   Thu,  3 Nov 2022 22:30:05 +0200
Message-Id: <20221103203005.25743-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of device_match_of_node() instead of open coding its
functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 52616848a37c..4b91e19366a8 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -85,7 +85,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
 {
 	struct of_phandle_args *gpiospec = data;
 
-	return chip->gpiodev->dev.of_node == gpiospec->np &&
+	return device_match_of_node(&chip->gpiodev->dev, gpiospec->np) &&
 				chip->of_xlate &&
 				chip->of_xlate(chip, gpiospec, NULL) >= 0;
 }
-- 
2.35.1

