Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA262DAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiKQMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiKQM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B984725D2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688131; x=1700224131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiguIHAQUyFA/n7ZpCGUHKImucX21MgsisSqebhnJ/k=;
  b=erRHWQBSTGrub6kMrBne1LI3JnphPK6bK8ONleM0YkwbIHVxuhWN4gy5
   qmYQK7a28FqesUenSCt1mh4QLHE3579Hm3ET9yIk9VPVbQJSekjVXM32a
   Er+/xcMm1KRbjAqL95RLOrU8XmAQTD0S5ILNdhIH4PqkZZJlj5BNxaEhH
   19tPN7gYAPqgWw/fAJ/fqGeaI7RbMwq1n/Tj5bMh/68jP20Le4/lwT2oM
   VVpcFxdxuGPxfZ2VLacKJN3+wJq4S6KMzvdIgsUGBQuwLXJGdfmdSb2vg
   D1Hi9YleXPCw0KcJM3G3fRSl3z+kqLWjFfZlK53tUXooMkLYgUJ3wlGcW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199875"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199875"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604559"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604559"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 09/11] perf/x86/intel/uncore: Enable UPI topology discovery for Sapphire Rapids
Date:   Thu, 17 Nov 2022 12:28:31 +0000
Message-Id: <20221117122833.3103580-10-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
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

From: Alexander Antonov <alexander.antonov@linux.intel.com>

UPI topology discovery on SPR is same as in ICX but UBOX device has
different Device ID 0x3250.

This patch enables /sys/devices/uncore_upi_*/die* attributes on SPR.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 43 +++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d45f5843444d..4c2d5b5ea445 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -458,6 +458,7 @@
 
 /* SPR */
 #define SPR_RAW_EVENT_MASK_EXT			0xffffff
+#define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
@@ -6112,9 +6113,43 @@ static struct intel_uncore_type spr_uncore_m2m = {
 	.name			= "m2m",
 };
 
+static struct attribute_group spr_upi_mapping_group = {
+	.is_visible	= skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *spr_upi_attr_update[] = {
+	&uncore_alias_group,
+	&spr_upi_mapping_group,
+	NULL
+};
+
+#define SPR_UPI_REGS_ADDR_DEVICE_LINK0	0x01
+
+static int spr_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &spr_upi_mapping_group);
+}
+
+static void spr_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &spr_upi_mapping_group);
+}
+
+static int spr_upi_get_topology(struct intel_uncore_type *type)
+{
+	return discover_upi_topology(type, SPR_UBOX_DID, SPR_UPI_REGS_ADDR_DEVICE_LINK0);
+}
+
 static struct intel_uncore_type spr_uncore_upi = {
-	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.format_group		= &spr_uncore_raw_format_group,
+	.ops			= &spr_uncore_pci_ops,
 	.name			= "upi",
+	.attr_update		= spr_upi_attr_update,
+	.get_topology		= spr_upi_get_topology,
+	.set_mapping		= spr_upi_set_mapping,
+	.cleanup_mapping	= spr_upi_cleanup_mapping,
 };
 
 static struct intel_uncore_type spr_uncore_m3upi = {
@@ -6318,6 +6353,12 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->format_group = from_type->format_group;
 	if (from_type->attr_update)
 		to_type->attr_update = from_type->attr_update;
+	if (from_type->set_mapping)
+		to_type->set_mapping = from_type->set_mapping;
+	if (from_type->get_topology)
+		to_type->get_topology = from_type->get_topology;
+	if (from_type->cleanup_mapping)
+		to_type->cleanup_mapping = from_type->cleanup_mapping;
 }
 
 static struct intel_uncore_type **
-- 
2.25.1

