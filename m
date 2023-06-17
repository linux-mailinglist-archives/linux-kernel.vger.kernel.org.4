Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FA733D74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 03:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjFQBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFQBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 21:44:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962363AB4;
        Fri, 16 Jun 2023 18:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686966297; x=1718502297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5os4uL0tj6EqAUIyn9+nlsK5sK4S/kAFE+rIybEFyjE=;
  b=K0fgDNNmwSmyvCY9UR6AGuTbqZq2EHRNr4rJtf08qmONunYFFC9XZ9Gd
   AgjHZIgQD5nZAm//0b+k/+Y16yKMUQBOrRZECFt8SoonT60AtVp1YJBfy
   4WBiW4ktWsqB5VxkqANsYttgr6D9jwVA+3gK1vnHWqKhsy7P5VRKpfLA1
   vydXPIYiEokjMREFlucadIn8M8NKNTD3DVlGpSkqjvKcWkY9GEul/tw2H
   g3Pqhkz0CwLhg3RQEjxNOPZ0e9yNsViUmCCSdj1gwgUGPpAGXxlct5nbC
   pYVDJe6FzGverrqz0VtaGzISEmWsTE9i7diW+6eSrwGoZg8u4laLJ6S/v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="349059129"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="349059129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="857590830"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="857590830"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2023 18:44:56 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel: tpmi: Remove hardcoded unit and offset
Date:   Fri, 16 Jun 2023 18:44:47 -0700
Message-Id: <20230617014447.2543592-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sizeof(u32) for TPMI entry size units. Also add a define
for capability offset unit size.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index a5227951decc..9c606ee2030c 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -222,7 +222,7 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
 	snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-%s", name);
 
 	for (i = 0, tmp = res; i < pfs->pfs_header.num_entries; i++, tmp++) {
-		u64 entry_size_bytes = pfs->pfs_header.entry_size * 4;
+		u64 entry_size_bytes = pfs->pfs_header.entry_size * sizeof(u32);
 
 		tmp->start = pfs->vsec_offset + entry_size_bytes * i;
 		tmp->end = tmp->start + entry_size_bytes - 1;
@@ -277,7 +277,7 @@ static int tpmi_process_info(struct intel_tpmi_info *tpmi_info,
 	void __iomem *info_mem;
 
 	info_mem = ioremap(pfs->vsec_offset + TPMI_INFO_BUS_INFO_OFFSET,
-			   pfs->pfs_header.entry_size * 4 - TPMI_INFO_BUS_INFO_OFFSET);
+			   pfs->pfs_header.entry_size * sizeof(u32) - TPMI_INFO_BUS_INFO_OFFSET);
 	if (!info_mem)
 		return -ENOMEM;
 
@@ -308,6 +308,8 @@ static int tpmi_fetch_pfs_header(struct intel_tpmi_pm_feature *pfs, u64 start, i
 	return 0;
 }
 
+#define TPMI_CAP_OFFSET_UNIT	1024
+
 static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 {
 	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
@@ -354,7 +356,7 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		if (!pfs_start)
 			pfs_start = res_start;
 
-		pfs->pfs_header.cap_offset *= 1024;
+		pfs->pfs_header.cap_offset *= TPMI_CAP_OFFSET_UNIT;
 
 		pfs->vsec_offset = pfs_start + pfs->pfs_header.cap_offset;
 
-- 
2.38.1

