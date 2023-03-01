Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE16A6BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCALZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCALZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:25:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64B3C785
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677669952; x=1709205952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I9CVx3YkdUHJr4E2pGCFHDjcEnwiTTIe4ytPxpqbNXU=;
  b=XLOni15qgSOZg20qUEzT8J1E9Fo0h5wHstssTUbiJy2DWfzXKyPB157l
   nh6arxMScjPkiVpYcX9MwFOSWyaJmD+iKQFk3lRkd3TrDS7ktgy7Wpu2E
   mTUH5N8n/Casfm9mAHrz77kF7yQ/l/AnCxnDmCxUmKlzn/F8408eQ7X6/
   2RkDfPfia3DTNdWNDM5CKkLQi5YV6RGCUYeGA3TmPLuV3m2goH00fuEHf
   k5PU9t8CT1ku/TH5+7SSBeWZpH9bkgeJNgJRWtD8OExC5RJ7hEdXHokUz
   04jCFUYftH4u5B3npTLtNWCyssEvfmnxCg1g8Hjr2JxX0RwZtf72rwJ+2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335875460"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="335875460"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 03:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798405755"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="798405755"
Received: from nemesa.iind.intel.com ([10.190.239.22])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2023 03:25:49 -0800
From:   "Garg, Nemesa" <nemesa.garg@intel.com>
To:     linux-kernel@vger.kernel.org, gfx-internal-devel@eclists.intel.com
Cc:     matthew.d.roper@intel.com, chaitanya.kumar.borah@intel.com,
        clinton.a.taylor@intel.com, "Garg, Nemesa" <nemesa.garg@intel.com>,
        Garg@vger.kernel.org
Subject: [PATCH dii-client 1/3] drm/pciid : Adding ARL-S and ARL-P PCI/device ids
Date:   Wed,  1 Mar 2023 16:54:43 +0530
Message-Id: <20230301112445.2207064-2-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301112445.2207064-1-nemesa.garg@intel.com>
References: <20230301112445.2207064-1-nemesa.garg@intel.com>
MIME-Version: 1.0
X-Git-Pile: INTEL_DII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrow Lake behaves the same as Meteor Lake with just minor differences.
Add definitions for ARL_P. Update MTL and ARL definitions with new
device IDs for ARL-S and ARL-P.

Bspec: 55420

Signed-off-by: Garg, Nemesa <nemesa.garg@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h          |  2 ++
 drivers/gpu/drm/i915/intel_device_info.c |  7 +++++++
 drivers/gpu/drm/i915/intel_device_info.h |  1 +
 include/drm/i915_pciids.h                | 11 +++++++++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index da3ee9b27747..0490fa282663 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -574,6 +574,8 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_M)
 #define IS_METEORLAKE_P(dev_priv) \
 	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_P)
+#define IS_ARROWLAKE_P(dev_priv) \
+	IS_SUBPLATFORM(dev_priv, INTEL_METEORLAKE, INTEL_SUBPLATFORM_ARL_P)
 #define IS_DG2_G10(dev_priv) \
 	IS_SUBPLATFORM(dev_priv, INTEL_DG2, INTEL_SUBPLATFORM_G10)
 #define IS_DG2_G11(dev_priv) \
diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index 98769e5f2c3d..bda73201417f 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -224,6 +224,10 @@ static const u16 subplatform_p_ids[] = {
 	INTEL_MTL_P_IDS(0),
 };
 
+static const u16 subplatform_arl_p_ids[] = {
+	INTEL_ARL_P_IDS(0),
+};
+
 static bool find_devid(u16 id, const u16 *p, unsigned int num)
 {
 	for (; num; num--, p++) {
@@ -284,6 +288,9 @@ static void intel_device_info_subplatform_init(struct drm_i915_private *i915)
 	} else if (find_devid(devid, subplatform_p_ids,
 			      ARRAY_SIZE(subplatform_p_ids))) {
 		mask = BIT(INTEL_SUBPLATFORM_P);
+	} else if (find_devid(devid, subplatform_arl_p_ids,
+				ARRAY_SIZE(subplatform_arl_p_ids))) {
+		mask = BIT(INTEL_SUBPLATFORM_ARL_P);
 	}
 
 	GEM_BUG_ON(mask & ~INTEL_SUBPLATFORM_MASK);
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index 80bda653d61b..eba718d98482 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -131,6 +131,7 @@ enum intel_platform {
 /* MTL */
 #define INTEL_SUBPLATFORM_M	0
 #define INTEL_SUBPLATFORM_P	1
+#define INTEL_SUBPLATFORM_ARL_P 2
 
 enum intel_ppgtt_type {
 	INTEL_PPGTT_NONE = I915_GEM_PPGTT_NONE,
diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
index 92205054e542..cc3f01c7e98b 100644
--- a/include/drm/i915_pciids.h
+++ b/include/drm/i915_pciids.h
@@ -738,15 +738,22 @@
 /* MTL */
 #define INTEL_MTL_M_IDS(info) \
 	INTEL_VGA_DEVICE(0x7D40, info), \
-	INTEL_VGA_DEVICE(0x7D60, info)
+	INTEL_VGA_DEVICE(0x7D41, info), \
+	INTEL_VGA_DEVICE(0x7D60, info), \
+	INTEL_VGA_DEVICE(0x7D67, info)
 
 #define INTEL_MTL_P_IDS(info) \
 	INTEL_VGA_DEVICE(0x7D45, info), \
 	INTEL_VGA_DEVICE(0x7D55, info), \
 	INTEL_VGA_DEVICE(0x7DD5, info)
 
+#define INTEL_ARL_P_IDS(info) \
+	INTEL_VGA_DEVICE(0x7D51, info), \
+	INTEL_VGA_DEVICE(0x7DD1, info)
+
 #define INTEL_MTL_IDS(info) \
 	INTEL_MTL_M_IDS(info), \
-	INTEL_MTL_P_IDS(info)
+	INTEL_MTL_P_IDS(info), \
+	INTEL_ARL_P_IDS(info)
 
 #endif /* _I915_PCIIDS_H */
