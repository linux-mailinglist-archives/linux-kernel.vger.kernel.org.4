Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275862DAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiKQM3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbiKQM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED22716DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688128; x=1700224128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EPUf8Bflc7Y6pe+wdNVgXoQATuG+LzCvaEWFItwhHeg=;
  b=frR+fX9uPX3AlGCibVOLHwHhhg9vtGK2DuBFYbjXDlp4O/n1cJ3hvFhN
   vwftE2GdTp7MFEvq1MmKFJYK5aCA/nd2tuaPVP5rvu6IQ8YSTx9TWmx/Z
   DPXgB+rpyIYOwK5I5nywIrzPREg4/if6qbPR4oRtWuUXUfMU1mB6b9DUU
   iKpEH1tVYWE1LhKib1DeSvNMo7Tq4ujObrvmzOwt9SHRCQNnIg6AvpJKk
   MYy1oPDxmXRI46Nset6YYt5wIdG572qlc9I/mJcuqDSRrGub4QwYsT2lk
   fuljYydSyWPfdNNZxnJJeneufY2VLNIVUp1xpSHlAbuSQAGKE1e8XbJNQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199866"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604551"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604551"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 01/11] perf/x86/intel/uncore: Generalize IIO topology support
Date:   Thu, 17 Nov 2022 12:28:23 +0000
Message-Id: <20221117122833.3103580-2-alexander.antonov@linux.intel.com>
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

Current implementation of uncore mapping doesn't support different types
of uncore PMUs which have its own topology context. This patch generalizes
Intel uncore topology implementation to be able easily introduce support
for new uncore blocks.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.h       |  14 ++-
 arch/x86/events/intel/uncore_snbep.c | 152 +++++++++++++++++++--------
 2 files changed, 122 insertions(+), 44 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 2adeaf4de4df..917cff1e7815 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -88,7 +88,7 @@ struct intel_uncore_type {
 	 * to identify which platform component each PMON block of that type is
 	 * supposed to monitor.
 	 */
-	struct intel_uncore_topology *topology;
+	struct intel_uncore_topology **topology;
 	/*
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
@@ -178,11 +178,19 @@ struct freerunning_counters {
 	unsigned *box_offsets;
 };
 
-struct intel_uncore_topology {
-	u64 configuration;
+struct uncore_iio_topology {
+	int pci_bus_no;
 	int segment;
 };
 
+struct intel_uncore_topology {
+	int pmu_idx;
+	union {
+		void *untyped;
+		struct uncore_iio_topology *iio;
+	};
+};
+
 struct pci2phy_map {
 	struct list_head list;
 	int segment;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ed869443efb2..469ff889ea08 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3699,10 +3699,16 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
-static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
+static struct intel_uncore_topology *pmu_topology(struct intel_uncore_pmu *pmu, int die)
 {
-	return pmu->type->topology[die].configuration >>
-	       (pmu->pmu_idx * BUS_NUM_STRIDE);
+	int idx;
+
+	for (idx = 0; idx < pmu->type->num_boxes; idx++) {
+		if (pmu->type->topology[die][idx].pmu_idx == pmu->pmu_idx)
+			return &pmu->type->topology[die][idx];
+	}
+
+	return NULL;
 }
 
 static umode_t
@@ -3710,8 +3716,9 @@ pmu_iio_mapping_visible(struct kobject *kobj, struct attribute *attr,
 			 int die, int zero_bus_pmu)
 {
 	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(kobj_to_dev(kobj));
+	struct intel_uncore_topology *pmut = pmu_topology(pmu, die);
 
-	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx != zero_bus_pmu) ? 0 : attr->mode;
+	return (pmut && !pmut->iio->pci_bus_no && pmu->pmu_idx != zero_bus_pmu) ? 0 : attr->mode;
 }
 
 static umode_t
@@ -3727,9 +3734,10 @@ static ssize_t skx_iio_mapping_show(struct device *dev,
 	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
 	struct dev_ext_attribute *ea = to_dev_ext_attribute(attr);
 	long die = (long)ea->var;
+	struct intel_uncore_topology *pmut = pmu_topology(pmu, die);
 
-	return sprintf(buf, "%04x:%02x\n", pmu->type->topology[die].segment,
-					   skx_iio_stack(pmu, die));
+	return sprintf(buf, "%04x:%02x\n", pmut ? pmut->iio->segment : 0,
+					   pmut ? pmut->iio->pci_bus_no : 0);
 }
 
 static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
@@ -3764,18 +3772,77 @@ static int die_to_cpu(int die)
 	return res;
 }
 
+enum {
+	IIO_TOPOLOGY_TYPE,
+	TOPOLOGY_MAX
+};
+
+static const size_t topology_size[TOPOLOGY_MAX] = {
+	sizeof(*((struct intel_uncore_topology *)NULL)->iio)
+};
+
+static int pmu_alloc_topology(struct intel_uncore_type *type, int topology_type)
+{
+	int die, idx;
+	struct intel_uncore_topology **topology;
+
+	if (!type->num_boxes)
+		return -EPERM;
+
+	topology = kcalloc(uncore_max_dies(), sizeof(*topology), GFP_KERNEL);
+	if (!topology)
+		goto err;
+
+	for (die = 0; die < uncore_max_dies(); die++) {
+		topology[die] = kcalloc(type->num_boxes, sizeof(**topology), GFP_KERNEL);
+		if (!topology[die])
+			goto clear;
+		for (idx = 0; idx < type->num_boxes; idx++) {
+			topology[die][idx].untyped = kcalloc(type->num_boxes,
+							     topology_size[topology_type],
+							     GFP_KERNEL);
+			if (!topology[die][idx].untyped)
+				goto clear;
+		}
+	}
+
+	type->topology = topology;
+
+	return 0;
+clear:
+	for (; die >= 0; die--) {
+		for (idx = 0; idx < type->num_boxes; idx++)
+			kfree(topology[die][idx].untyped);
+		kfree(topology[die]);
+	}
+	kfree(topology);
+err:
+	return -ENOMEM;
+}
+
+static void pmu_free_topology(struct intel_uncore_type *type)
+{
+	int die, idx;
+
+	if (type->topology) {
+		for (die = 0; die < uncore_max_dies(); die++) {
+			for (idx = 0; idx < type->num_boxes; idx++)
+				kfree(type->topology[die][idx].untyped);
+			kfree(type->topology[die]);
+		}
+		kfree(type->topology);
+		type->topology = NULL;
+	}
+}
+
 static int skx_iio_get_topology(struct intel_uncore_type *type)
 {
 	int die, ret = -EPERM;
-
-	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
-				 GFP_KERNEL);
-	if (!type->topology)
-		return -ENOMEM;
+	u64 configuration;
+	int idx;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(die),
-					   &type->topology[die].configuration);
+		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &configuration);
 		if (ret)
 			break;
 
@@ -3783,12 +3850,12 @@ static int skx_iio_get_topology(struct intel_uncore_type *type)
 		if (ret < 0)
 			break;
 
-		type->topology[die].segment = ret;
-	}
-
-	if (ret < 0) {
-		kfree(type->topology);
-		type->topology = NULL;
+		for (idx = 0; idx < type->num_boxes; idx++) {
+			type->topology[die][idx].pmu_idx = idx;
+			type->topology[die][idx].iio->segment = ret;
+			type->topology[die][idx].iio->pci_bus_no =
+				(configuration >> (idx * BUS_NUM_STRIDE)) & 0xff;
+		}
 	}
 
 	return ret;
@@ -3804,7 +3871,9 @@ static const struct attribute_group *skx_iio_attr_update[] = {
 };
 
 static int
-pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
+pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
+		ssize_t (*show)(struct device*, struct device_attribute*, char*),
+		int topology_type)
 {
 	char buf[64];
 	int ret;
@@ -3812,10 +3881,14 @@ pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 	struct attribute **attrs = NULL;
 	struct dev_ext_attribute *eas = NULL;
 
-	ret = type->get_topology(type);
+	ret = pmu_alloc_topology(type, topology_type);
 	if (ret < 0)
 		goto clear_attr_update;
 
+	ret = type->get_topology(type);
+	if (ret < 0)
+		goto clear_topology;
+
 	ret = -ENOMEM;
 
 	/* One more for NULL. */
@@ -3828,13 +3901,13 @@ pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 		goto clear_attrs;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
-		sprintf(buf, "die%ld", die);
+		snprintf(buf, sizeof(buf), "die%ld", die);
 		sysfs_attr_init(&eas[die].attr.attr);
 		eas[die].attr.attr.name = kstrdup(buf, GFP_KERNEL);
 		if (!eas[die].attr.attr.name)
 			goto err;
 		eas[die].attr.attr.mode = 0444;
-		eas[die].attr.show = skx_iio_mapping_show;
+		eas[die].attr.show = show;
 		eas[die].attr.store = NULL;
 		eas[die].var = (void *)die;
 		attrs[die] = &eas[die].attr.attr;
@@ -3849,14 +3922,14 @@ pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 clear_attrs:
 	kfree(attrs);
 clear_topology:
-	kfree(type->topology);
+	pmu_free_topology(type);
 clear_attr_update:
 	type->attr_update = NULL;
 	return ret;
 }
 
 static void
-pmu_iio_cleanup_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
+pmu_cleanup_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
 	struct attribute **attr = ag->attrs;
 
@@ -3868,7 +3941,13 @@ pmu_iio_cleanup_mapping(struct intel_uncore_type *type, struct attribute_group *
 	kfree(attr_to_ext_attr(*ag->attrs));
 	kfree(ag->attrs);
 	ag->attrs = NULL;
-	kfree(type->topology);
+	pmu_free_topology(type);
+}
+
+static int
+pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
+{
+	return pmu_set_mapping(type, ag, skx_iio_mapping_show, IIO_TOPOLOGY_TYPE);
 }
 
 static int skx_iio_set_mapping(struct intel_uncore_type *type)
@@ -3878,7 +3957,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
 {
-	pmu_iio_cleanup_mapping(type, &skx_iio_mapping_group);
+	pmu_cleanup_mapping(type, &skx_iio_mapping_group);
 }
 
 static struct intel_uncore_type skx_uncore_iio = {
@@ -4461,11 +4540,6 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 	int die, stack_id, ret = -EPERM;
 	struct pci_dev *dev = NULL;
 
-	type->topology = kcalloc(uncore_max_dies(), sizeof(*type->topology),
-				 GFP_KERNEL);
-	if (!type->topology)
-		return -ENOMEM;
-
 	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, SNR_ICX_MESH2IIO_MMAP_DID, dev))) {
 		ret = pci_read_config_dword(dev, SNR_ICX_SAD_CONTROL_CFG, &sad_cfg);
 		if (ret) {
@@ -4483,13 +4557,9 @@ static int sad_cfg_iio_topology(struct intel_uncore_type *type, u8 *sad_pmon_map
 		/* Convert stack id from SAD_CONTROL to PMON notation. */
 		stack_id = sad_pmon_mapping[stack_id];
 
-		((u8 *)&(type->topology[die].configuration))[stack_id] = dev->bus->number;
-		type->topology[die].segment = pci_domain_nr(dev->bus);
-	}
-
-	if (ret) {
-		kfree(type->topology);
-		type->topology = NULL;
+		type->topology[die][stack_id].iio->segment = pci_domain_nr(dev->bus);
+		type->topology[die][stack_id].pmu_idx = stack_id;
+		type->topology[die][stack_id].iio->pci_bus_no = dev->bus->number;
 	}
 
 	return ret;
@@ -4526,7 +4596,7 @@ static int snr_iio_set_mapping(struct intel_uncore_type *type)
 
 static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
 {
-	pmu_iio_cleanup_mapping(type, &snr_iio_mapping_group);
+	pmu_cleanup_mapping(type, &snr_iio_mapping_group);
 }
 
 static struct event_constraint snr_uncore_iio_constraints[] = {
@@ -5144,7 +5214,7 @@ static int icx_iio_set_mapping(struct intel_uncore_type *type)
 
 static void icx_iio_cleanup_mapping(struct intel_uncore_type *type)
 {
-	pmu_iio_cleanup_mapping(type, &icx_iio_mapping_group);
+	pmu_cleanup_mapping(type, &icx_iio_mapping_group);
 }
 
 static struct intel_uncore_type icx_uncore_iio = {
-- 
2.25.1

