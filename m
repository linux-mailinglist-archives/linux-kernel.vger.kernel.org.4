Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D2676575
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjAUJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982335B580;
        Sat, 21 Jan 2023 01:49:31 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rj8PvzHfOuBKLLZSGlm1O3L5+JGWZPjFW9+VfiVhcY4=;
        b=Bybq4HeL/1FSyhStZVSTAmnrBhaVJzE2U3EGXf0YYgkcvIB5cHQ+UhUTATdP7Mw+sO8WH9
        IalJwV7l2FLIeTXGBJ6Sc1go2IFtUr/lbMOB+SyOSnY7yTuqQnNC801Sjq7fAQ2KRJt0ED
        2v2MxrOD7DAnCyegP6Wn+HGySdH531gS/2wpKlDG3yFu3BcmKXXHXjqxehX4DjcbKA9JIo
        OQsqVS0LulEgGG3bAK05o7/JfzfjBr+ha0qG3ul6y2ygdMg4jbOkN2ryx91vBLeiPN4UpD
        RWISNgitP3k4XtPAIb7uQNNWwiN602rD2oXc7coqf2Zfk5qatxkDhYO8bPPc2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rj8PvzHfOuBKLLZSGlm1O3L5+JGWZPjFW9+VfiVhcY4=;
        b=rKsbiEhrGBBVI1wXBjcqq+5EO4JaReM+hQ/cEEKFpHik2tkg5vdcaPUuIwU0mZA4lOiBDV
        xy8VGl1mHxSmkNBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Add a quirk for UPI on SPR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112200105.733466-5-kan.liang@linux.intel.com>
References: <20230112200105.733466-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167429456572.4906.2975977001013774901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     65248a9a9ee1ea2e6aad8f35253ffd9096ab81b7
Gitweb:        https://git.kernel.org/tip/65248a9a9ee1ea2e6aad8f35253ffd9096ab81b7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jan 2023 12:01:04 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:13 +01:00

perf/x86/uncore: Add a quirk for UPI on SPR

The discovery table of UPI on some SPR variants, e.g., MCC, is broken.
The third UPI table may includes a wrong address which points to a
non-exists device. The bug impacts both UPI and M3UPI uncore PMON.

Use a pre-defined UPI and M3UPI table to replace the broken table.

Different BIOS may populate a device into a different domain or a
different BUS. The accurate location can only be retrieved at load time.
Add spr_update_device_location() to update the location of the UPI and
M3UPI in the pre-defined table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Link: https://lore.kernel.org/r/20230112200105.733466-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |   1 +-
 arch/x86/events/intel/uncore.h           |   1 +-
 arch/x86/events/intel/uncore_discovery.h |  12 +-
 arch/x86/events/intel/uncore_snbep.c     | 146 ++++++++++++++++++----
 4 files changed, 136 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d9a2ef5..4030b0b 100644
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
index bbaa57c..e76b945 100644
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
index 4163702..6ee80ad 100644
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
index 31acc96..7d11995 100644
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
 
