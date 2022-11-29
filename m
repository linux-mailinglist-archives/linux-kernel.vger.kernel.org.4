Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A163C7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiK2TLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiK2TKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:10:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5975ADF9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669749047; x=1701285047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAOm52S+zGz+4hb/ZX5jqXvAjhsP8kD0UOXj6xS3eys=;
  b=Im3+PoVLkWKVlOwnTwRgL5llj9VnNfePeY3HPvmJuqdR38mKfzLjMe8F
   vxogtr1aukDp5bPFtcnRsuvkjnrQS9lLLkvhM7bz2rvFKolXq0RdTvZ7E
   sBgcMTN4inVijVzorBmaPMz92UENm6X9TIHWA9MUGfvHq9eEfMN0vZNc8
   Er3U8Hb+y7LdAwWUIL5ZecItRr4YLTBfrNS5BE7Sdx/jLmXx2XhE4n0Ev
   9PHCneFIYjjyQUKVlLeu0/EkB7ZEpfYQ/0mC3y3vhzKcn73xQpxyxeNVx
   ncIJQUOetin8PB2smZ3vtpfsYi8q2Jum8CS395hESfSWLfJcXrhdjvLTf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379490784"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379490784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749992010"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="749992010"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 11:10:35 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf/x86/uncore: Add a quirk for UPI on SPR
Date:   Tue, 29 Nov 2022 11:10:22 -0800
Message-Id: <20221129191023.936738-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129191023.936738-1-kan.liang@linux.intel.com>
References: <20221129191023.936738-1-kan.liang@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

The discovery table of UPI on some SPR variants, e.g., MCC, is broken.
The third UPI table may includes a wrong address which points to a
non-exists device. The bug impacts both UPI and M3UPI uncore PMON.

Use a pre-defined UPI and M3UPI table to replace the broken table.

Different BIOS may populate a device into a different domain or a
different BUS. The accurate location can only be retrieved at load time.
Add spr_update_device_location() to update the location of the UPI and
M3UPI in the pre-defined table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |   1 +
 arch/x86/events/intel/uncore.h           |   1 +
 arch/x86/events/intel/uncore_discovery.h |  12 +-
 arch/x86/events/intel/uncore_snbep.c     | 146 +++++++++++++++++++----
 4 files changed, 136 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 751df6460bff..0ac7ebfa1faa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1806,6 +1806,7 @@ static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
 	.pci_init = spr_uncore_pci_init,
 	.mmio_init = spr_uncore_mmio_init,
 	.use_discovery = true,
+	.uncore_units_ignore = spr_uncore_units_ignore,
 };
 
 static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index bbaa57cd868d..e76b945a079e 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -592,6 +592,7 @@ extern raw_spinlock_t pci2phy_map_lock;
 extern struct list_head pci2phy_map_head;
 extern struct pci_extra_dev *uncore_extra_pci_dev;
 extern struct event_constraint uncore_constraint_empty;
+extern int spr_uncore_units_ignore[];
 
 /* uncore_snb.c */
 int snb_uncore_pci_init(void);
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index 41637022b5d1..6ee80ad3423e 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -21,9 +21,15 @@
 /* Global discovery table size */
 #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
 
-#define UNCORE_DISCOVERY_PCI_DOMAIN(data)	((data >> 28) & 0x7)
-#define UNCORE_DISCOVERY_PCI_BUS(data)		((data >> 20) & 0xff)
-#define UNCORE_DISCOVERY_PCI_DEVFN(data)	((data >> 12) & 0xff)
+#define UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET	28
+#define UNCORE_DISCOVERY_PCI_DOMAIN(data)			\
+		((data >> UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET) & 0x7)
+#define UNCORE_DISCOVERY_PCI_BUS_OFFSET		20
+#define UNCORE_DISCOVERY_PCI_BUS(data)				\
+		((data >> UNCORE_DISCOVERY_PCI_BUS_OFFSET) & 0xff)
+#define UNCORE_DISCOVERY_PCI_DEVFN_OFFSET	12
+#define UNCORE_DISCOVERY_PCI_DEVFN(data)			\
+		((data >> UNCORE_DISCOVERY_PCI_DEVFN_OFFSET) & 0xff)
 #define UNCORE_DISCOVERY_PCI_BOX_CTRL(data)	(data & 0xfff)
 
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 31acc96ccb69..b6ba76bc669d 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6132,24 +6132,6 @@ static int spr_upi_get_topology(struct intel_uncore_type *type)
 	return discover_upi_topology(type, SPR_UBOX_DID, SPR_UPI_REGS_ADDR_DEVICE_LINK0);
 }
 
-static struct intel_uncore_type spr_uncore_upi = {
-	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
-	.format_group		= &spr_uncore_raw_format_group,
-	.ops			= &spr_uncore_pci_ops,
-	.name			= "upi",
-	.attr_update		= spr_upi_attr_update,
-	.get_topology		= spr_upi_get_topology,
-	.set_mapping		= spr_upi_set_mapping,
-	.cleanup_mapping	= spr_upi_cleanup_mapping,
-};
-
-static struct intel_uncore_type spr_uncore_m3upi = {
-	SPR_UNCORE_PCI_COMMON_FORMAT(),
-	.name			= "m3upi",
-	.constraints		= icx_uncore_m3upi_constraints,
-};
-
 static struct intel_uncore_type spr_uncore_mdf = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "mdf",
@@ -6158,7 +6140,13 @@ static struct intel_uncore_type spr_uncore_mdf = {
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
+#define UNCORE_SPR_UPI				8
+#define UNCORE_SPR_M3UPI			9
 
+/*
+ * The uncore units, which are supported by the discovery table,
+ * are defined here.
+ */
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
 	&spr_uncore_iio,
@@ -6168,12 +6156,56 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	&spr_uncore_imc,
 	&spr_uncore_m2m,
-	&spr_uncore_upi,
-	&spr_uncore_m3upi,
+	NULL,
+	NULL,
 	NULL,
 	&spr_uncore_mdf,
 };
 
+/*
+ * The uncore units, which are not supported by the discovery table,
+ * are implemented from here.
+ */
+#define SPR_UNCORE_UPI_NUM_BOXES	4
+
+static unsigned int spr_upi_pci_offsets[SPR_UNCORE_UPI_NUM_BOXES] = {
+	0, 0x8000, 0x10000, 0x18000
+};
+
+static struct intel_uncore_type spr_uncore_upi = {
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.format_group		= &spr_uncore_raw_format_group,
+	.ops			= &spr_uncore_pci_ops,
+	.name			= "upi",
+	.attr_update		= spr_upi_attr_update,
+	.get_topology		= spr_upi_get_topology,
+	.set_mapping		= spr_upi_set_mapping,
+	.cleanup_mapping	= spr_upi_cleanup_mapping,
+	.type_id		= UNCORE_SPR_UPI,
+	.num_counters		= 4,
+	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
+	.perf_ctr_bits		= 48,
+	.perf_ctr		= ICX_UPI_PCI_PMON_CTR0,
+	.event_ctl		= ICX_UPI_PCI_PMON_CTL0,
+	.box_ctl		= ICX_UPI_PCI_PMON_BOX_CTL,
+	.pci_offsets		= spr_upi_pci_offsets,
+};
+
+static struct intel_uncore_type spr_uncore_m3upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m3upi",
+	.type_id		= UNCORE_SPR_M3UPI,
+	.num_counters		= 4,
+	.num_boxes		= SPR_UNCORE_UPI_NUM_BOXES,
+	.perf_ctr_bits		= 48,
+	.perf_ctr		= ICX_M3UPI_PCI_PMON_CTR0,
+	.event_ctl		= ICX_M3UPI_PCI_PMON_CTL0,
+	.box_ctl		= ICX_M3UPI_PCI_PMON_BOX_CTL,
+	.pci_offsets		= spr_upi_pci_offsets,
+	.constraints		= icx_uncore_m3upi_constraints,
+};
+
 enum perf_uncore_spr_iio_freerunning_type_id {
 	SPR_IIO_MSR_IOCLK,
 	SPR_IIO_MSR_BW_IN,
@@ -6304,6 +6336,7 @@ static struct intel_uncore_type spr_uncore_imc_free_running = {
 
 #define UNCORE_SPR_MSR_EXTRA_UNCORES		1
 #define UNCORE_SPR_MMIO_EXTRA_UNCORES		1
+#define UNCORE_SPR_PCI_EXTRA_UNCORES		2
 
 static struct intel_uncore_type *spr_msr_uncores[UNCORE_SPR_MSR_EXTRA_UNCORES] = {
 	&spr_uncore_iio_free_running,
@@ -6313,6 +6346,17 @@ static struct intel_uncore_type *spr_mmio_uncores[UNCORE_SPR_MMIO_EXTRA_UNCORES]
 	&spr_uncore_imc_free_running,
 };
 
+static struct intel_uncore_type *spr_pci_uncores[UNCORE_SPR_PCI_EXTRA_UNCORES] = {
+	&spr_uncore_upi,
+	&spr_uncore_m3upi
+};
+
+int spr_uncore_units_ignore[] = {
+	UNCORE_SPR_UPI,
+	UNCORE_SPR_M3UPI,
+	UNCORE_IGNORE_END
+};
+
 static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 					struct intel_uncore_type *from_type)
 {
@@ -6413,9 +6457,69 @@ void spr_uncore_cpu_init(void)
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 
+#define SPR_UNCORE_UPI_PCIID		0x3241
+#define SPR_UNCORE_UPI0_DEVFN		0x9
+#define SPR_UNCORE_M3UPI_PCIID		0x3246
+#define SPR_UNCORE_M3UPI0_DEVFN		0x29
+
+static void spr_update_device_location(int type_id)
+{
+	struct intel_uncore_type *type;
+	struct pci_dev *dev = NULL;
+	u32 device, devfn;
+	u64 *ctls;
+	int die;
+
+	if (type_id == UNCORE_SPR_UPI) {
+		type = &spr_uncore_upi;
+		device = SPR_UNCORE_UPI_PCIID;
+		devfn = SPR_UNCORE_UPI0_DEVFN;
+	} else if (type_id == UNCORE_SPR_M3UPI) {
+		type = &spr_uncore_m3upi;
+		device = SPR_UNCORE_M3UPI_PCIID;
+		devfn = SPR_UNCORE_M3UPI0_DEVFN;
+	} else
+		return;
+
+	ctls = kcalloc(__uncore_max_dies, sizeof(u64), GFP_KERNEL);
+	if (!ctls) {
+		type->num_boxes = 0;
+		return;
+	}
+
+	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
+		if (devfn != dev->devfn)
+			continue;
+
+		die = uncore_device_to_die(dev);
+		if (die < 0)
+			continue;
+
+		ctls[die] = pci_domain_nr(dev->bus) << UNCORE_DISCOVERY_PCI_DOMAIN_OFFSET |
+			    dev->bus->number << UNCORE_DISCOVERY_PCI_BUS_OFFSET |
+			    devfn << UNCORE_DISCOVERY_PCI_DEVFN_OFFSET |
+			    type->box_ctl;
+	}
+
+	type->box_ctls = ctls;
+}
+
 int spr_uncore_pci_init(void)
 {
-	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL);
+	/*
+	 * The discovery table of UPI on some SPR variant is broken,
+	 * which impacts the detection of both UPI and M3UPI uncore PMON.
+	 * Use the pre-defined UPI and M3UPI table to replace.
+	 *
+	 * The accurate location, e.g., domain and BUS number,
+	 * can only be retrieved at load time.
+	 * Update the location of UPI and M3UPI.
+	 */
+	spr_update_device_location(UNCORE_SPR_UPI);
+	spr_update_device_location(UNCORE_SPR_M3UPI);
+	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI,
+						UNCORE_SPR_PCI_EXTRA_UNCORES,
+						spr_pci_uncores);
 	return 0;
 }
 
-- 
2.35.1

