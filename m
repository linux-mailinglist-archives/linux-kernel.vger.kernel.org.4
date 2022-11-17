Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45DE62DAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbiKQM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239884AbiKQM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40271F2C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688130; x=1700224130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z6j0Pc9MvHQ/hPI7Pcd93d1sFA3q3F7tY1V7r+uFvZw=;
  b=P6Rcvm97q0MdIYaEoTqYiO/93cI1Vi1CI5Zzn/WgqZc6MKxDC+eu4lGw
   UcpTRGCmebzvPf3FUbYh9lSC8yose5Qc5dL1/M/SgK8PcHdUCxms6iK5B
   allNHzeN/uSaYB102DQPVsbrnhN2P5dZdxVYPfWP/4aheA+X8q+pJ6DZL
   1MDAsuOkPO/W8Xp2inRD1aUMNVc640/im7XMm4FzRs2cUFgGK6GDUhgSc
   tXHBz8+g4Ofakef3IwOXUzpgjK/FrBuvzjKJCl6GnJAygbQhBoz1eu9lL
   iMOYLrCuh34uvmNHssRax+8V51qDr3XC6n92duWCBbc5kyIGBDDkKf8aX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199872"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604556"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604556"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 06/11] perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server
Date:   Thu, 17 Nov 2022 12:28:28 +0000
Message-Id: <20221117122833.3103580-7-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
KTIPCSTS (offset 0x120) registers which reside under IIO bus(3) on
SKX/CLX.

This patch enable UPI topology discovery on Skylake Server. Topology is
exposed through attributes /sys/devices/uncore_upi_<pmu_idx>/dieX,
where dieX is file which holds "upi_<idx1>:die_<idx2>" connected to
this UPI link.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 130 +++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 254ba0ad650a..f682a9a0f562 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4253,6 +4253,132 @@ static struct intel_uncore_ops skx_upi_uncore_pci_ops = {
 	.read_counter	= snbep_uncore_pci_read_counter,
 };
 
+static umode_t
+skx_upi_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(kobj_to_dev(kobj));
+
+	return pmu->type->topology[die][pmu->pmu_idx].upi->enabled ? attr->mode : 0;
+}
+
+static ssize_t skx_upi_mapping_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
+	struct dev_ext_attribute *ea = to_dev_ext_attribute(attr);
+	long die = (long)ea->var;
+	struct uncore_upi_topology *upi = pmu->type->topology[die][pmu->pmu_idx].upi;
+
+	return sysfs_emit(buf, "upi_%d,die_%d\n", upi->pmu_idx_to, upi->die_to);
+}
+
+#define SKX_UPI_REG_DID			0x2058
+#define SKX_UPI_REGS_ADDR_DEVICE_LINK0	0x0e
+#define SKX_UPI_REGS_ADDR_FUNCTION	0x00
+
+/*
+ * UPI Link Parameter 0
+ * |  Bit  |  Default  |  Description
+ * | 19:16 |     0h    | base_nodeid - The NodeID of the sending socket.
+ * | 12:8  |    00h    | sending_port - The processor die port number of the sending port.
+ */
+#define SKX_KTILP0_OFFSET	0x94
+
+/*
+ * UPI Pcode Status. This register is used by PCode to store the link training status.
+ * |  Bit  |  Default  |  Description
+ * |   4   |     0h    | ll_status_valid — Bit indicates the valid training status
+ *                       logged from PCode to the BIOS.
+ */
+#define SKX_KTIPCSTS_OFFSET	0x120
+
+static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *tp,
+			     int pmu_idx)
+{
+	int ret;
+	u32 upi_conf;
+	struct uncore_upi_topology *upi = tp->upi;
+
+	tp->pmu_idx = pmu_idx;
+	ret = pci_read_config_dword(dev, SKX_KTIPCSTS_OFFSET, &upi_conf);
+	if (ret) {
+		ret = pcibios_err_to_errno(ret);
+		goto err;
+	}
+	upi->enabled = (upi_conf >> 4) & 1;
+	if (upi->enabled) {
+		ret = pci_read_config_dword(dev, SKX_KTILP0_OFFSET,
+					    &upi_conf);
+		if (ret) {
+			ret = pcibios_err_to_errno(ret);
+			goto err;
+		}
+		upi->die_to = (upi_conf >> 16) & 0xf;
+		upi->pmu_idx_to = (upi_conf >> 8) & 0x1f;
+	}
+err:
+	return ret;
+}
+
+static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
+				int die, u64 cpu_bus_msr)
+{
+	int idx, ret;
+	struct intel_uncore_topology *upi;
+	unsigned int devfn;
+	struct pci_dev *dev = NULL;
+	u8 bus = cpu_bus_msr >> (3 * BUS_NUM_STRIDE);
+
+	for (idx = 0; idx < type->num_boxes; idx++) {
+		upi = &type->topology[die][idx];
+		devfn = PCI_DEVFN(SKX_UPI_REGS_ADDR_DEVICE_LINK0 + idx,
+				  SKX_UPI_REGS_ADDR_FUNCTION);
+		dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
+		if (dev) {
+			ret = upi_fill_topology(dev, upi, idx);
+			if (ret)
+				break;
+		}
+	}
+
+	pci_dev_put(dev);
+	return ret;
+}
+
+static int skx_upi_get_topology(struct intel_uncore_type *type)
+{
+	/* CPX case is not supported */
+	if (boot_cpu_data.x86_stepping == 11)
+		return -EPERM;
+
+	return skx_pmu_get_topology(type, skx_upi_topology_cb);
+}
+
+static struct attribute_group skx_upi_mapping_group = {
+	.is_visible	= skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *skx_upi_attr_update[] = {
+	&skx_upi_mapping_group,
+	NULL
+};
+
+static int
+pmu_upi_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
+{
+	return pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
+}
+
+static int skx_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &skx_upi_mapping_group);
+}
+
+static void skx_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &skx_upi_mapping_group);
+}
+
 static struct intel_uncore_type skx_uncore_upi = {
 	.name		= "upi",
 	.num_counters   = 4,
@@ -4265,6 +4391,10 @@ static struct intel_uncore_type skx_uncore_upi = {
 	.box_ctl	= SKX_UPI_PCI_PMON_BOX_CTL,
 	.ops		= &skx_upi_uncore_pci_ops,
 	.format_group	= &skx_upi_uncore_format_group,
+	.attr_update	= skx_upi_attr_update,
+	.get_topology	= skx_upi_get_topology,
+	.set_mapping	= skx_upi_set_mapping,
+	.cleanup_mapping = skx_upi_cleanup_mapping,
 };
 
 static void skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
-- 
2.25.1

