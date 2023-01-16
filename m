Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F066BE1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAPMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAPMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:46:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDDF8686;
        Mon, 16 Jan 2023 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673873194; x=1705409194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xp2JwHzpxBrb4N5/U9Ns3KD8bpJ3bcjuxAofJ9rLRq4=;
  b=kjggTLp8NDMRHYOitcDGtfNmR3E/KKdZVvKQno8oMhNMGYSR3Tl2vJSG
   hSGOWGfUnTeIJgqWuvPsp5hPIAOZBkLtTR9QbU1qZF/pcpMuWI3vksV9Z
   YbFDY6a7byX369S7WBmuTKIRa92TS4mEKy9gt3+9x9xX51jTpEUTLx/mE
   oA7wqpBA3BdtaBb5GUqptc4z2m06k2yxJJBLG8UkvjAWcILvLq3fvMOe6
   ybVCQZtbfZZZQNThV2BmT7bi1FECfVWSy2OvFmtCyr+FWeXalUeMTX9P4
   HNSPRdinkydV4YxjQNg0X/8eurn3XoEOupRcK67i9JjhPplkKBRYlJOQ/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="308009855"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="308009855"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 04:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="782895859"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="782895859"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2023 04:46:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9BCC31D; Mon, 16 Jan 2023 14:47:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpio: pcf857x: Drop unneeded explicit casting
Date:   Mon, 16 Jan 2023 14:47:04 +0200
Message-Id: <20230116124704.30470-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
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

The s32 is compatible with int, no need to cast.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pcf857x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 9d34776109db..3de1d3ad7472 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -88,7 +88,7 @@ static int i2c_write_le8(struct i2c_client *client, unsigned int data)
 
 static int i2c_read_le8(struct i2c_client *client)
 {
-	return (int)i2c_smbus_read_byte(client);
+	return i2c_smbus_read_byte(client);
 }
 
 /* Talk to 16-bit I/O expander */
-- 
2.39.0

