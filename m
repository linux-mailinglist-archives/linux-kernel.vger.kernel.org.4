Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0DC64C222
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiLNCHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiLNCHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:07:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D43275D6;
        Tue, 13 Dec 2022 18:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670983648; x=1702519648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5g2Oe9zCYZKtQPNgkgYOsDcVAbBTFpcRbE/PaSDyVHU=;
  b=M72iTOAocFIOcKjyTwwCXI5IrZjxZENdm9ldGYvYsCdMGSqhfhXjV3ml
   WmTp3QlrRotuq3PEUKeBgcc6R2nP6gPysjzf7D9MBESKa7tUfaVkNy2Gv
   mncFM1WKRAY6T0V+sd8Ptk061oANFzqlJsbtzDHjSZ5+84X778x/4+T7y
   qCJ649ZCSNdSqvQuS2YftD6TX9I3parEXs2vOyIYlqOhw0Lqh81OqNQGK
   cAgPknu28tIiB/2IBN8STpmN7kSpqIh1YH0Ym1HdBPX1+p3yqlzaXHr5S
   Je3cL3pIFwM9m8fP7iRIWBuEIaxiYlCClVsXNMqIDaV1tl81rTJY0MYhm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="380497715"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="380497715"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="894105112"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="894105112"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2022 18:07:27 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, torvalds@linux-foundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: Don't set HFI status bit to 1
Date:   Tue, 13 Dec 2022 18:06:51 -0800
Message-Id: <20221214020651.1362731-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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

When CPU doesn't support HFI (Hardware Feedback Interface), don't include
BIT 26 in the mask to prevent clearing. otherwise this results in:
    unchecked MSR access error: WRMSR to 0x1b1
      (tried to write 0x0000000004000aa8)
      at rIP: 0xffffffff8b8559fe (throttle_active_work+0xbe/0x1b0)

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/therm_throt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 4bb7fddaa143..2e22bb82b738 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -194,7 +194,7 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
 #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
-#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
 
 /*
  * Clear the bits in package thermal status register for bit = 1
@@ -211,6 +211,9 @@ void thermal_clear_package_intr_status(int level, u64 bit_mask)
 	} else {
 		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
 		msr_val = THERM_STATUS_CLEAR_PKG_MASK;
+		if (boot_cpu_has(X86_FEATURE_HFI))
+			msr_val |= BIT(26);
+
 	}
 
 	msr_val &= ~bit_mask;
-- 
2.31.1

