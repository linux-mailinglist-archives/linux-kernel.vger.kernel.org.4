Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4B62866D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiKNRAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiKNRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:00:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516B31DE7;
        Mon, 14 Nov 2022 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668445184; x=1699981184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B3cccWBw0rMFOaKNnRwHvr376JFvt2Uj98KrwSkBaa8=;
  b=RWmd5IFZxSSLu3KpR4NPOjs0IiqHO+JbMH2N9ovQTSHeYdHXoxkMiBn3
   uIOq7Elm+ptOkkKxyb0HFT+1Lz7aIG8ddgd74v2vUyJlQ/11M+zmGwzJy
   e/mottGIogrIf1ratkBzwyIXxHbfSh+P6BH9ddRggqxupWFoo9n6aterX
   4cjNzFGQjneHoQ8hxBxx4VbTkL4LYLch+rqnKHysYpPfrYI59EkDNlMZh
   neUBtCgibp4435Z2krXvQDgz6iJoT81VRR5zwtrzi/6laKo8x8ibvpUMw
   ltKTZMPKNPu5LE3DoHsqIewkUYz8CBXD14gCbyUheTTfDx+YEVOiPMpOc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313168848"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313168848"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727595259"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727595259"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:59:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9D382F3; Mon, 14 Nov 2022 19:00:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] pwm: core: Refactor pwmchip_add() to avoid extra checks
Date:   Mon, 14 Nov 2022 19:00:04 +0200
Message-Id: <20221114170006.61751-1-andriy.shevchenko@linux.intel.com>
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

When we already know that everything is fine there is no need
to use ret variable. Refactor code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased with dropped wrong patch (LKP)
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

