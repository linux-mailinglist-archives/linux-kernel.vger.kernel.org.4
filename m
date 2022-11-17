Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993F62DAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiKQMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiKQM3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587C725CE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688131; x=1700224131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnUBqcl+k9EQthz+I0/JrzM1OicW378SnZoRnnRQKFU=;
  b=HRUMyYekRoe894F9yo/aJ35LCSmD1/Jprqesy2syAG6uupJOXnt2/fhz
   w1FJx/I4I/q+F3G1bp5+WZDmZ4zAPl0Sh5vQKd3RH/PuGNFg7I/t0EVRE
   FdDO8saFIjzAWhu2JUzC92lwjtX+Vr0fyKa3dyeKP+BSrm63ZepNuEzyb
   YngF+Oqdhk6i47JIM5wjzahiBGRvkXZKZgxkYNHVl3YkAoej9w1sKpRD5
   ZSLEy2m8Ap0ST6Th47lzwJVadLK87RGTOP7KU6dd7fNrz+2oMe2qD4OdV
   YmUTGMaRm1tqO0KkxA7nHw7Rf0gJzbGeDisFJ9PfpTyZQMOkiEMZjrZkk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199874"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199874"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604558"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604558"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 08/11] perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server
Date:   Thu, 17 Nov 2022 12:28:30 +0000
Message-Id: <20221117122833.3103580-9-alexander.antonov@linux.intel.com>
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

UPI topology discovery relies on data from KTILP0 (offset 0x94) and
KTIPCSTS (offset 0x120) as well as on SKX but on Icelake Server these
registers reside under UBOX (Device ID 0x3450) bus.

This patch enables /sys/devices/uncore_upi_*/die* attributes on Icelake
Server.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6da5f692afea..d45f5843444d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -445,6 +445,7 @@
 #define ICX_UPI_PCI_PMON_CTR0			0x320
 #define ICX_UPI_PCI_PMON_BOX_CTL		0x318
 #define ICX_UPI_CTL_UMASK_EXT			0xffffff
+#define ICX_UBOX_DID				0x3450
 
 /* ICX M3UPI*/
 #define ICX_M3UPI_PCI_PMON_CTL0			0xd8
@@ -5594,6 +5595,76 @@ static const struct attribute_group icx_upi_uncore_format_group = {
 	.attrs = icx_upi_uncore_formats_attr,
 };
 
+#define ICX_UPI_REGS_ADDR_DEVICE_LINK0	0x02
+#define ICX_UPI_REGS_ADDR_FUNCTION	0x01
+
+static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, int dev_link0)
+{
+	struct pci_dev *ubox = NULL;
+	struct pci_dev *dev = NULL;
+	u32 nid, gid;
+	int i, idx, ret = -EPERM;
+	struct intel_uncore_topology *upi;
+	unsigned int devfn;
+
+	/* GIDNIDMAP method supports machines which have less than 8 sockets. */
+	if (uncore_max_dies() > 8)
+		goto err;
+
+	while ((ubox = pci_get_device(PCI_VENDOR_ID_INTEL, ubox_did, ubox))) {
+		ret = upi_nodeid_groupid(ubox, SKX_CPUNODEID, SKX_GIDNIDMAP, &nid, &gid);
+		if (ret) {
+			ret = pcibios_err_to_errno(ret);
+			break;
+		}
+
+		for (i = 0; i < 8; i++) {
+			if (nid != GIDNIDMAP(gid, i))
+				continue;
+			for (idx = 0; idx < type->num_boxes; idx++) {
+				upi = &type->topology[nid][idx];
+				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
+				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
+								  ubox->bus->number,
+								  devfn);
+				if (dev) {
+					ret = upi_fill_topology(dev, upi, idx);
+					if (ret)
+						goto err;
+				}
+			}
+		}
+	}
+err:
+	pci_dev_put(ubox);
+	pci_dev_put(dev);
+	return ret;
+}
+
+static int icx_upi_get_topology(struct intel_uncore_type *type)
+{
+	return discover_upi_topology(type, ICX_UBOX_DID, ICX_UPI_REGS_ADDR_DEVICE_LINK0);
+}
+
+static struct attribute_group icx_upi_mapping_group = {
+	.is_visible	= skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *icx_upi_attr_update[] = {
+	&icx_upi_mapping_group,
+	NULL
+};
+
+static int icx_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &icx_upi_mapping_group);
+}
+
+static void icx_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &icx_upi_mapping_group);
+}
+
 static struct intel_uncore_type icx_uncore_upi = {
 	.name		= "upi",
 	.num_counters   = 4,
@@ -5606,6 +5677,10 @@ static struct intel_uncore_type icx_uncore_upi = {
 	.box_ctl	= ICX_UPI_PCI_PMON_BOX_CTL,
 	.ops		= &skx_upi_uncore_pci_ops,
 	.format_group	= &icx_upi_uncore_format_group,
+	.attr_update	= icx_upi_attr_update,
+	.get_topology	= icx_upi_get_topology,
+	.set_mapping	= icx_upi_set_mapping,
+	.cleanup_mapping = icx_upi_cleanup_mapping,
 };
 
 static struct event_constraint icx_uncore_m3upi_constraints[] = {
-- 
2.25.1

