Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86292674056
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjASRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjASRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:51:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E0F76B;
        Thu, 19 Jan 2023 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674150679; x=1705686679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+5Oxk/r3XDlthxnLMMNPAo40waQkCEmgsaYdqtskGWQ=;
  b=AoZFyu5GWsSb8DsPdjRO/q2JGmtv+AR8e32h2HKvscU0SnhV0WOCujTb
   jqFwBE4mcpi0eEnEiIETkQrkcV3fVkQY1ciKk35srElk5RUvK9/6V+1cF
   xYkPS7Usy7gIo5XMhj5nZ2OUkcLmPN32Wo4Xyx0CDs/ZKPi9fK9s8b90L
   jAbTJxOWK9joIRvdG7yNjlfGHvcwFkLjK7Sj9paTLk4Y6EvkOO/gGuqxO
   f5bi878UGZVvmKcQpzH+ThDHo/gBX+4msLgH79hQGP/z5HlZY/HTydIoR
   roKbGuTxGEeUtpN0r6NMRrubfrbnTzlbfAOCjYLWAEVeaNit8Fs/zu5RJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326641734"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326641734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784148160"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="784148160"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 09:51:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF0DC36D; Thu, 19 Jan 2023 19:51:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] leds: tca6507: Convert to use fwnode_device_is_compatible()
Date:   Thu, 19 Jan 2023 19:51:50 +0200
Message-Id: <20230119175150.77250-1-andriy.shevchenko@linux.intel.com>
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

Replace open coded fwnode_device_is_compatible() in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-tca6507.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 46e76b894651..07dd12686a69 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -695,8 +695,7 @@ tca6507_led_dt_init(struct device *dev)
 					    &led.default_trigger);
 
 		led.flags = 0;
-		if (fwnode_property_match_string(child, "compatible",
-						 "gpio") >= 0)
+		if (fwnode_device_is_compatible(child, "gpio"))
 			led.flags |= TCA6507_MAKE_GPIO;
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-- 
2.39.0

