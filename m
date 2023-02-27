Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECA96A43C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjB0OIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjB0OI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:08:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E22AFF38;
        Mon, 27 Feb 2023 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677506902; x=1709042902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iQdGRiKPZjZMBQPADUzT+Bwwba26L0M/zf5vmcYHm2E=;
  b=HpODl6NT6+VuPohEDyY5+jqOejfERjLYD3gZSmoLwuMcEwyBA0svvjhj
   9ZV32HsJgbJ/nK56MjbA3i3nrnPS7kI9cRENcTe1sl49Dhq1jyF+ju4Ie
   CmdrXUuXxXwQ3z8GKMlrGnY+minpdqi9zbWA3RKF9S256Or5mHH/jnYN2
   cilSYrhcmt0E28M1gxyplFwIzxcyb4nKphCQ8b5UmKI/UJT0IbehUXeZr
   QMu4C69h80XYGnKl84SuZlaSbz5TKS2WB7c24py5JGGibB+hWTCv5D/AW
   BZDEB+ZdqGVYxt/2db9wdaSJIdMt7SYcr/Mze9bn8nd/euKbzJ+n3Cx7i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="396416703"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="396416703"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 06:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919366160"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="919366160"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2023 06:06:17 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] platform/x86/intel/tpmi: Fix double free reported by Smatch
Date:   Mon, 27 Feb 2023 06:06:14 -0800
Message-Id: <20230227140614.2913474-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Fix warning:
drivers/platform/x86/intel/tpmi.c:253 tpmi_create_device()
	warn: 'feature_vsec_dev' was already freed.

If there is some error, feature_vsec_dev memory is freed as part
of resource managed call intel_vsec_add_aux(). So, additional
kfree() call is not required.

Reordered res allocation and feature_vsec_dev, so that on error
only res is freed.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/platform-driver-x86/Y%2FxYR7WGiPayZu%2FR@kili/T/#u
Fixes: 47731fd2865f ("platform/x86/intel: Intel TPMI enumeration driver")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index c60733261c89..c999732b0f1e 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -209,14 +209,14 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	if (!name)
 		return -EOPNOTSUPP;
 
-	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
-	if (!feature_vsec_dev)
+	res = kcalloc(pfs->pfs_header.num_entries, sizeof(*res), GFP_KERNEL);
+	if (!res)
 		return -ENOMEM;
 
-	res = kcalloc(pfs->pfs_header.num_entries, sizeof(*res), GFP_KERNEL);
-	if (!res) {
+	feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev), GFP_KERNEL);
+	if (!feature_vsec_dev) {
 		ret = -ENOMEM;
-		goto free_vsec;
+		goto free_res;
 	}
 
 	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
@@ -239,6 +239,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	/*
 	 * intel_vsec_add_aux() is resource managed, no explicit
 	 * delete is required on error or on module unload.
+	 * feature_vsec_dev memory is also freed as part of device
+	 * delete.
 	 */
 	ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
 				 feature_vsec_dev, feature_id_name);
@@ -249,8 +251,6 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 
 free_res:
 	kfree(res);
-free_vsec:
-	kfree(feature_vsec_dev);
 
 	return ret;
 }
-- 
2.39.1

