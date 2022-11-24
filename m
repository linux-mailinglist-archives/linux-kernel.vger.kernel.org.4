Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15B637874
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKXMD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiKXMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6695EFBA;
        Thu, 24 Nov 2022 04:03:03 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDc4hpoWTM+Swf+cIT/FNwFe4+nco1UxwXmEaOj+79g=;
        b=F2QFW54dX+ph0kswcPb+0VQ9pS0Yg/Bs1t5JQGppvxtoCt4MI+iFy8UQ6jdZGzpx1Wp+mu
        Shl40QV0wZpsawRJoaqyEQIvZxmgTjIWxH7PQGbl+jSP3nyjx9AE/q3HL5FYDMhwfrpRlk
        zFvyBSoP1iJwQFYrpMvBE7C06dKHxTrrTLWBU6jvIu0ViTExT/ZpRNF3qycgFCj2SVu5Si
        OlKHx0o+W01TuLJIS1EK5cL9N9tQxxvrMamF9ihELUIvU8Wd1uZUIQuXAO3JYiqp6IKSGj
        WKTjRi9VzaCB0BA45nL8pGUwcSykwuhKacxCEqevRaVz/z80hYpIPYCkATgV6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291382;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDc4hpoWTM+Swf+cIT/FNwFe4+nco1UxwXmEaOj+79g=;
        b=57ZDBrMejfPsvdy0rb/X6xooiqnDBxiFvPu4hrVL3ygTgasoOo2L+mAG1lBAQ3lcn0eRhM
        Hmw0saTJIk4u6hDA==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generalize IIO topology support
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-2-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929138132.4906.15481429872602884736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4d13be8ab5d4aa6106331baa9674632a75b884b0
Gitweb:        https://git.kernel.org/tip/4d13be8ab5d4aa6106331baa9674632a75b884b0
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:23 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:20 +01:00

perf/x86/intel/uncore: Generalize IIO topology support

Current implementation of uncore mapping doesn't support different types
of uncore PMUs which have its own topology context. This patch generalizes
Intel uncore topology implementation to be able easily introduce support
for new uncore blocks.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-2-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.h       |  14 +-
 arch/x86/events/intel/uncore_snbep.c | 152 ++++++++++++++++++--------
 2 files changed, 122 insertions(+), 44 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 2adeaf4..917cff1 100644
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
index ed86944..469ff88 100644
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
@@ -3849,14 +3922,14 @@ err:
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
