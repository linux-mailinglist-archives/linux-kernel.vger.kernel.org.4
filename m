Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874E5646171
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLGTEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiLGTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2FC70614;
        Wed,  7 Dec 2022 11:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439842; x=1701975842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GwPuobCpJ0+heyq5ckbm6iaVU06rI+4xJ6yg8SuKhM=;
  b=RjrNYgy9SLTW0HJweCLS77U6R2DvngqMnAwbyEUdHv4gxzoAoetqOpdG
   U+h4q787M/pv56x8O2S0J+NUn7w/LjqrS2PQm+0pYspgSYnmJrBU0/IHS
   Kxkv2PFrcGrr8b7mQFxM2LkiYdaoDlxBrjpjTPzR72nQXyTYtIkwkK6mZ
   v5VD1EvPYq1OLi5qhRrqqmudgP+RiPGi9yePb7YvD4+qMjneNeRalH6G2
   zc9ngan3BdT1ctL4qAs/Bq3COnOwWjJzbEBLG3fTma+5FjnU4o8GQsoMT
   qtRMACKBD8DWR72wyglY6lqsLpllGnhKEdxXHLdjT9RMaEHiqjrF2xJzb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690226"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690226"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060668"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060668"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E46D184; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 05/11] iio: light: tsl2563: Drop unused defintion(s)
Date:   Wed,  7 Dec 2022 21:03:42 +0200
Message-Id: <20221207190348.9347-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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

The CALIB_FRAC() is defined and might had been used in
tsl2563_calib_from_sysfs(). But let's just move a comment
from it to the latter function.

CLAIB_FRAC_HALF is used in a single place, i.e. in
tsl2563_calib_to_sysfs(). So, let's just inline it there.

While at it, switch to use DIV_ROUND_CLOSEST().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 3b60d8000351..bdd40a5df53d 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/sched.h>
+#include <linux/math.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
@@ -38,10 +39,6 @@
 
 /* Bits used for fraction in calibration coefficients.*/
 #define CALIB_FRAC_BITS		10
-/* 0.5 in CALIB_FRAC_BITS precision */
-#define CALIB_FRAC_HALF		BIT(CALIB_FRAC_BITS - 1)
-/* Make a fraction from a number n that was multiplied with b. */
-#define CALIB_FRAC(n, b)	(((n) << CALIB_FRAC_BITS) / (b))
 /* Decimal 10^(digits in sysfs presentation) */
 #define CALIB_BASE_SYSFS	1000
 
@@ -360,12 +357,12 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 
 static inline int tsl2563_calib_to_sysfs(u32 calib)
 {
-	return (int) (((calib * CALIB_BASE_SYSFS) +
-		       CALIB_FRAC_HALF) >> CALIB_FRAC_BITS);
+	return (int)DIV_ROUND_CLOSEST(calib * CALIB_BASE_SYSFS, BIT(CALIB_FRAC_BITS));
 }
 
 static inline u32 tsl2563_calib_from_sysfs(int value)
 {
+	/* Make a fraction from a number n that was multiplied with b. */
 	return (((u32) value) << CALIB_FRAC_BITS) / CALIB_BASE_SYSFS;
 }
 
-- 
2.35.1

