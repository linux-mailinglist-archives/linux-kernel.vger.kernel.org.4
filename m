Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3562B17B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiKPCuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKPCuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:50:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9224E1E72F;
        Tue, 15 Nov 2022 18:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668567009; x=1700103009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s20sResmhc8ejFkXsCSWiCoJuJKw41o0gUFDOP1PetU=;
  b=BATXj3C+hC65EHgfynScfTiMorass7QgXJpsmy9ijP57/EsQQcnggBO6
   8u+CLohvGms9xDx/NdHAOMudEmaJvQzRbu+mV7eEVPRF9raIsb46eLP6F
   yC1fM4q4Qk2R7a2h3TNWJfZIeWDwWV4mFDS6I4dHPlrdHWbXkiq7UVWdO
   tmEOb8BcFn8TbJ1UyuFINikH+XfjRCp4m3RFT6tnFVCy/1HzwpKL0ryc8
   H+UVBv2E2MTBXmlI0tInWrlkkNNzNr7grpSM1aJ8pPLOZfigR0aLi88VF
   z5RmAdBOzmDFPMaWqVOSJgeWS4uzeqLhcBVuChg3MtiBSMUBelr1qf5GX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314243438"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314243438"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 18:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707974583"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="707974583"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2022 18:50:06 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     afael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 1/2] thermal: intel: Prevent accidental clearing of HFI status
Date:   Tue, 15 Nov 2022 18:49:48 -0800
Message-Id: <20221116024949.2590043-1-srinivas.pandruvada@linux.intel.com>
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

