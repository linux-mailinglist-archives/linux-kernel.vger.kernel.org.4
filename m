Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1F6150F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKARmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiKARmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:42:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE801D32F;
        Tue,  1 Nov 2022 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667324557; x=1698860557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oHHuxOzKVmiUxNopbnR8MZfBR9TH3eINRdcTm5mkIiE=;
  b=fklKvWAOUgxhzBXbMRj5KmpjzVkklz7DrGUEHl/9Azl4UlH4QPnrx4KI
   2U2l9f0srdspN3xAKUoRTJRXT8Hx6830ysDtufjZjXpKWRklHGys4QvjK
   FhGRZWlG5l7vWuLRFbarirYzgMOrA9mFK8Owudpx0gjZAxIY3IwW52/Mh
   qrfcoxhtebX942LxJkOsXp/8Liw8cgqNlV2Cyo0oJf8faF1p6X0mPQBj4
   GlSs26tDp7HfdDHSa1yAKfDSr0QCkaMOD1psJhH+JdO8Y97VVEN2JfGW5
   dVFXQJyJeQH0Ng/O12F4SjrjEpfCfTLXExCBP/pS/Gg8k4lFfKImrxx3o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292506333"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292506333"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636478620"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636478620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2022 10:42:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DBDAAF7; Tue,  1 Nov 2022 19:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] pwm: core: Refactor pwmchip_add() to avoid extra checks
Date:   Tue,  1 Nov 2022 19:42:53 +0200
Message-Id: <20221101174255.54452-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we already know that everything is fine there is no need
to use ret variable. Refactor code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d333e7422f4a..855abd0a776f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -296,16 +296,16 @@ int pwmchip_add(struct pwm_chip *chip)
 	INIT_LIST_HEAD(&chip->list);
 	list_add(&chip->list, &pwm_chips);
 
-	ret = 0;
-
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
-out:
 	mutex_unlock(&pwm_lock);
 
-	if (!ret)
-		pwmchip_sysfs_export(chip);
+	pwmchip_sysfs_export(chip);
+
+	return 0;
+out:
+	mutex_unlock(&pwm_lock);
 
 	return ret;
 }
-- 
2.35.1

