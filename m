Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945B62B195
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKPCzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiKPCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:55:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3B1261B;
        Tue, 15 Nov 2022 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668567265; x=1700103265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hiUBpViMiMZ1GDXtqT+dOQIXeDtwXLX9aMXKnoRYsNA=;
  b=TDDkV1ByrD0fE6AiNHgu0k7x3TPn/J2cMK5iW4CfxsNc5q8cJLFRnCBA
   mWgI5nN9//m+3crM3bx1YunrgvsnBP9IMwTxif6mPF1PUHG/Gz/+3MMwU
   Iew49x5tQwFc5GtgEMK6gJCS+sxoZ0l2HtXJq5CVJA64Td+hEBIgzHUUA
   bfV71reNHXPbeHxmBFXxqJf0Wg2pLVEYK46tKcNHtANphh12FwYHr/J3X
   zN/tToUioXrV3gqTDBV5NoK8wjQbmaSGG+iq7L8Z/jPM+YBqvkmF//stJ
   Oksk1rKHxZjavOxhJ2fI+iQ2QOG+GjgqK7E8Nz5zwFajKm/UV6XCGCc91
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292138217"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292138217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 18:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633466006"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633466006"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2022 18:54:24 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of HFI status
Date:   Tue, 15 Nov 2022 18:54:16 -0800
Message-Id: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a package thermal interrupt with PROCHOT log, it will be
processed and cleared. It is possible that there is an active HFI event
status, which is about to get processed or getting processed. While
clearing PROCHOT log bit, it will also clear HFI status bit. This means
that hardware is free to update HFI memory.

When clearing a package thermal interrupt, some processors will generate
a "general protection fault" when any of the read only bit is set to 1.
The driver maintains a mask of all read-write bits which can be set.
This mask doesn't include HFI status bit. This bit will also be cleared,
as it will be assumed read-only bit. So, add HFI status bit 26 to the
mask.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Email address was wrong, so sending again.

 drivers/thermal/intel/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 8352083b87c7..9e8ab31d756e 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -197,7 +197,7 @@ static const struct attribute_group thermal_attr_group = {
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
 #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
-#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
+#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
 
 static void clear_therm_status_log(int level)
 {
-- 
2.31.1

