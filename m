Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7896B2D14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCISqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCISqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:46:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6FF9D3D;
        Thu,  9 Mar 2023 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678387574; x=1709923574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lpy9hKJnb/d+jy2NFBJN48EgZ0mPU6bdSBNhMxRwoiU=;
  b=kB2WhPRYc6tqwV7CTG3ZMaGCaNAlHrS7RX9CFdgcRRmoHTgmzVH9fx4Q
   25dpfvp799d0sSMgtja2BnURpwQhDVLngZudP6OR+usJVzGPYa2vihs+V
   +DHoCCypKDYe8EJBk8p+ugPk7ZtXze6XksJZDLf5wah4TjrsrM+d8FcDt
   Z2rieMvXITMhuUW2Y4tqPo5oOEBZkkV/p3mNOhXgLn6W3+cDJHi1CDMQ3
   +zd2lLsmnToDk/WWPv/zk70JvDqc53l7p6W4kqJgEgne2dqN6s6kQ4Ssf
   o1e3fsh1YyHZ2zxxmGehjrJ2g8hIWfU436t+Lkc/At66hwckQ9+twnfeE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="334012443"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="334012443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801274607"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="801274607"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 10:45:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 007B414F; Thu,  9 Mar 2023 20:46:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpio: sim: Print boolean as unsigned integer
Date:   Thu,  9 Mar 2023 20:46:36 +0200
Message-Id: <20230309184636.84124-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309184636.84124-1-andriy.shevchenko@linux.intel.com>
References: <20230309184636.84124-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print boolean as unsigned integer instead of using %c and manually
converting to a character.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index a1c8702f362c..5ac1de5db751 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -684,7 +684,7 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	live = gpio_sim_device_is_live_unlocked(dev);
 	mutex_unlock(&dev->lock);
 
-	return sprintf(page, "%c\n", live ? '1' : '0');
+	return sprintf(page, "%u\n", live);
 }
 
 static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
-- 
2.39.1

