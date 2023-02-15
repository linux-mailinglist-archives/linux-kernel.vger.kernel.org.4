Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6D698194
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBORFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBORFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:05:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569859DA;
        Wed, 15 Feb 2023 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676480705; x=1708016705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOimDod//OCrW4INcjgAv6xJyq0ZxmoU28TD++6SzWw=;
  b=EJvr2QE4SDnC0NgYijXHTzKlzyKbs/SfTsWrEFoKNWrk137d4vBImKOl
   d0sc/Ak0HqmfV/IdAJF/C2lT6yr96Ky4Wj65ERvjIoW8cwzLu75AGPsNq
   WQEEWeXafpr6K+4f7/peYKTTIjI5JCjCdu8DEX8JU//Th1j+6DSiCcV7W
   DfoH+c7EXoQnNV0S//jh1fGNIKk1mTScbtQ4JhXmxGo74XIAMZeLtKKBD
   riwvLllsHsOh+ZJKR8TXqUBBVubiVC/khXGbMpMB0YN6CXZkk4V25HOgr
   Y8SaOdd2jra6NaOHPTkFFB2UqIZ9W6XklPhn7B1gjDKWEPVcfVflGF91c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311847975"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311847975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="812539731"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="812539731"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2023 09:03:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AFAC91C5; Wed, 15 Feb 2023 19:04:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/2] leds: lp8860: Remove duplicate NULL checks
Date:   Wed, 15 Feb 2023 19:04:03 +0200
Message-Id: <20230215170403.84449-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
References: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
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

gpiod_*() API check already for the NULL, no need
to repeat that in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-lp8860.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 666f4d38214f..221b386443bc 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -249,8 +249,7 @@ static int lp8860_init(struct lp8860_led *led)
 		}
 	}
 
-	if (led->enable_gpio)
-		gpiod_direction_output(led->enable_gpio, 1);
+	gpiod_direction_output(led->enable_gpio, 1);
 
 	ret = lp8860_fault_check(led);
 	if (ret)
@@ -293,8 +292,7 @@ static int lp8860_init(struct lp8860_led *led)
 
 out:
 	if (ret)
-		if (led->enable_gpio)
-			gpiod_direction_output(led->enable_gpio, 0);
+		gpiod_direction_output(led->enable_gpio, 0);
 
 	if (led->regulator) {
 		ret = regulator_disable(led->regulator);
@@ -448,8 +446,7 @@ static void lp8860_remove(struct i2c_client *client)
 	struct lp8860_led *led = i2c_get_clientdata(client);
 	int ret;
 
-	if (led->enable_gpio)
-		gpiod_direction_output(led->enable_gpio, 0);
+	gpiod_direction_output(led->enable_gpio, 0);
 
 	if (led->regulator) {
 		ret = regulator_disable(led->regulator);
-- 
2.39.1

