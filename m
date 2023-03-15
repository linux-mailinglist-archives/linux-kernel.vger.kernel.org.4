Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF86BBC27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjCOSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCOSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55615CAB;
        Wed, 15 Mar 2023 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905250; x=1710441250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiBxACl1aCLc9qaOAQl3+p3ktpJtGcq9KNcC9SlIB0c=;
  b=W+Ydu8WopGlDsAQbUOsq0rQsWlVnGIe9lCFf8d1lWshEIHMmprTOypS8
   6cmHpYw0kO9E5qdV4Lcf05wwcf6dEkwDFSAjoDuAtXngYipL9BD0N+IB1
   ZjgtSp+7HI3S0DKSOT8NsDhmbdLq/O9xJ1be0LRvLsOA2rBg06wnUby7p
   DjK4NWut8A82PoVxgGX+vI3/47I6X6eLn04Ht52HDVR9F1n7i43/L96pc
   4XOT0cZWmlKy7Ex4enEbRI/n5amDnFpSAWNyniy3MapzuYU7/Jq1dIqCW
   odATeYIGcLAbmZ1/3hcz6OzMmbDboBSk6hx7wbVcm93oqYtlfOIgiwZ9l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154532"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154532"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435205"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435205"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:07 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id D3C8F580C6E;
        Wed, 15 Mar 2023 11:34:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 03/11] platform/x86/intel/vsec: Add base address field
Date:   Wed, 15 Mar 2023 11:33:57 -0700
Message-Id: <20230315183405.2465630-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Intel PCIe VSEC capabilities may be emulated in MMIO. In such cases
the BAR is not readable from config space. Provide a field for drivers to
indicate the base address that is to be used.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 14 +++++++++++---
 drivers/platform/x86/intel/vsec.c      | 10 ++++++++--
 drivers/platform/x86/intel/vsec.h      |  2 ++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 9f505c6ef278..7136475d4ab5 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -161,10 +161,11 @@ static struct class intel_pmt_class = {
 
 static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 				    struct intel_pmt_header *header,
-				    struct device *dev,
+				    struct intel_vsec_device *ivdev,
 				    struct resource *disc_res)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev->parent);
+	struct pci_dev *pci_dev = ivdev->pcidev;
+	struct device *dev = &ivdev->auxdev.dev;
 	u8 bir;
 
 	/*
@@ -216,6 +217,13 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 
 		break;
 	case ACCESS_BARID:
+		/* Use the provided base address if it exists */
+		if (ivdev->base_addr) {
+			entry->base_addr = ivdev->base_addr +
+				   GET_ADDRESS(header->base_offset);
+			break;
+		}
+
 		/*
 		 * If another BAR was specified then the base offset
 		 * represents the offset within that BAR. SO retrieve the
@@ -320,7 +328,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	if (ret)
 		return ret;
 
-	ret = intel_pmt_populate_entry(entry, &header, dev, disc_res);
+	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
 	if (ret)
 		return ret;
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 0d5cf250e288..77063f699a1d 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -153,6 +153,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	struct intel_vsec_device *intel_vsec_dev;
 	struct resource *res, *tmp;
 	unsigned long quirks = info->quirks;
+	u64 base_addr;
 	int i;
 
 	if (!intel_vsec_supported(header->id, info->caps))
@@ -181,14 +182,18 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
 
+	if (info->base_addr)
+		base_addr = info->base_addr;
+	else
+		base_addr = pdev->resource[header->tbir].start;
+
 	/*
 	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables. Create a resource array of these tables to the
 	 * auxiliary device driver.
 	 */
 	for (i = 0, tmp = res; i < header->num_entries; i++, tmp++) {
-		tmp->start = pdev->resource[header->tbir].start +
-			     header->offset + i * (header->entry_size * sizeof(u32));
+		tmp->start = base_addr + header->offset + i * (header->entry_size * sizeof(u32));
 		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
 
@@ -206,6 +211,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	intel_vsec_dev->resource = res;
 	intel_vsec_dev->num_resources = header->num_entries;
 	intel_vsec_dev->quirks = info->quirks;
+	intel_vsec_dev->base_addr = info->base_addr;
 
 	if (header->id == VSEC_ID_SDSI)
 		intel_vsec_dev->ida = &intel_vsec_sdsi_ida;
diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/intel/vsec.h
index 54fdea93f762..4157ec546cd3 100644
--- a/drivers/platform/x86/intel/vsec.h
+++ b/drivers/platform/x86/intel/vsec.h
@@ -74,6 +74,7 @@ struct intel_vsec_platform_info {
 	struct intel_vsec_header **headers;
 	unsigned long caps;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 struct intel_vsec_device {
@@ -86,6 +87,7 @@ struct intel_vsec_device {
 	void *priv_data;
 	size_t priv_data_size;
 	unsigned long quirks;
+	u64 base_addr;
 };
 
 int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
-- 
2.34.1

