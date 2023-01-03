Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB82665C0A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjACNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbjACNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:16:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D510FD8;
        Tue,  3 Jan 2023 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672751726; x=1704287726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v5CCLLO+upNdoJWrssvE30mPz+dADC8azsX5O8Z4OGw=;
  b=SZYAZ+XQx5nYR5eMitoqbhIIf2t5DTJLx07916zFBg+OdLwWby4/Y1tr
   JO0Ltzk7v+ExOuqzUHk94A/k5cnpx78yvF9RQPSOGzZNpQgj++CqWH5ri
   6nOTCIOyYaOOIBTwR+s4fNHRivm1lU1nOFNQiuVVQ6npCdTY49gU/zDPL
   6xhgI5bIBR9d39PdYJR/gXCanHdtrfMDdoy8tJQGfPCLHL3GeVGUVivfN
   ia3GPaW9gHT19bVRYbpd9cIwpHBerwYA+bkVDQ3GpAalHoogSja66cm9L
   p8R0ARaN0D7HisJmFR70FwOO+K56W+Fq3Et4fx67MGXyBu82Ta5UCzq68
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305160782"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="305160782"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 05:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="743492376"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="743492376"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2023 05:15:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1DDD7162; Tue,  3 Jan 2023 15:15:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Lee Jones <lee@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [resent, PATCH v2 1/1] leds: is31fl319x: Wrap mutex_destroy() for devm_add_action_or_rest()
Date:   Tue,  3 Jan 2023 15:15:53 +0200
Message-Id: <20230103131553.34124-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Clang complains that devm_add_action() takes a parameter with a wrong type:

warning: cast from 'void (*)(struct mutex *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
    err = devm_add_action(dev, (void (*)(void *))mutex_destroy, &is31->lock);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1 warning generated.

It appears that the commit e1af5c815586 ("leds: is31fl319x: Fix devm vs.
non-devm ordering") missed two things:
- while mention devm_add_action_or_reset() the actual change got
  devm_add_action() call by unknown reason
- strictly speaking the parameter is not compatible by type

Fix both issues by switching to devm_add_action_or_reset() and adding a
wrapper for mutex_destroy() call.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e1af5c815586 ("leds: is31fl319x: Fix devm vs. non-devm ordering")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>
---

v2 resent: resent as v2
v2: added tag (Vincent), Cc'ed to Lee                                                                            

 drivers/leds/leds-is31fl319x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index b2f4c4ec7c56..7c908414ac7e 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -495,6 +495,11 @@ static inline int is31fl3196_db_to_gain(u32 dezibel)
 	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
 }
 
+static void is31f1319x_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int is31fl319x_probe(struct i2c_client *client)
 {
 	struct is31fl319x_chip *is31;
@@ -511,7 +516,7 @@ static int is31fl319x_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&is31->lock);
-	err = devm_add_action(dev, (void (*)(void *))mutex_destroy, &is31->lock);
+	err = devm_add_action_or_reset(dev, is31f1319x_mutex_destroy, &is31->lock);
 	if (err)
 		return err;
 
-- 
2.35.1

