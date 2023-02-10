Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AEC6925FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjBJTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBJTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:02:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD1303FC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676055751; x=1707591751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2XwALqFgumYHSrQIAqVE7a/d4bNS3UfMO1q4ImIfj70=;
  b=P+IP1lAYbtZEXdWFg1F6XqopRH82gKlycUc9qvK7pg8vrzSSEZqdZDH1
   q5ZMvVkA2fkRAooI19DnUME1F5GEdkXvTNpZnVm9ZA0aMNT/Q4jVCUiad
   Yt6k6iZFiWvs0a216/+hTp4H3WMHGe2jEnJBMR3WHP7I3LoUQqsQu9ZjM
   HiuVZhwh3hLELGo6QdJn63h22NWewXJ+62Ts1WNJThh7OW8uDB2bxBpkJ
   6TIqIecA+vrnrpJea9c30lr0Qzg3ppnAeKcRBh/U9NnXs7H4i9xQdCCkA
   VRm8uY+vZm/y2kxErVw1EatILKXM9RfhSExygwgx0cW0eEx5Q21nWorh5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="357899393"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="357899393"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 11:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="670095920"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="670095920"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2023 11:02:30 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add Meteor Lake support
Date:   Fri, 10 Feb 2023 11:02:38 -0800
Message-Id: <20230210190238.1726237-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore subsystem for Meteor Lake is similar to the previous Alder
Lake. The main difference is that MTL provides PMU support for different
tiles, while ADL only provides PMU support for the whole package. On
ADL, there are CBOX, ARB, and clockbox uncore PMON units. On MTL, they
are split into CBOX/HAC_CBOX, ARB/HAC_ARB, and cncu/sncu which provides
a fixed counter for clockticks. Also, new MSR addresses are introduced
on MTL.

The IMC uncore PMON is the same as Alder Lake. Add new PCIIDs of IMC for
Meteor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |   7 ++
 arch/x86/events/intel/uncore.h     |   1 +
 arch/x86/events/intel/uncore_snb.c | 161 +++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 4030b0b2ef97..bc226603ef3e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1789,6 +1789,11 @@ static const struct intel_uncore_init_fun adl_uncore_init __initconst = {
 	.mmio_init = adl_uncore_mmio_init,
 };
 
+static const struct intel_uncore_init_fun mtl_uncore_init __initconst = {
+	.cpu_init = mtl_uncore_cpu_init,
+	.mmio_init = adl_uncore_mmio_init,
+};
+
 static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
 	.cpu_init = icx_uncore_cpu_init,
 	.pci_init = icx_uncore_pci_init,
@@ -1857,6 +1862,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&mtl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&mtl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e76b945a079e..c30fb5bb1222 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -606,6 +606,7 @@ void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
 void tgl_uncore_cpu_init(void);
 void adl_uncore_cpu_init(void);
+void mtl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 void adl_uncore_mmio_init(void);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 1f4869227efb..7fd4334e12a1 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -109,6 +109,19 @@
 #define PCI_DEVICE_ID_INTEL_RPL_23_IMC		0xA728
 #define PCI_DEVICE_ID_INTEL_RPL_24_IMC		0xA729
 #define PCI_DEVICE_ID_INTEL_RPL_25_IMC		0xA72A
+#define PCI_DEVICE_ID_INTEL_MTL_1_IMC		0x7d00
+#define PCI_DEVICE_ID_INTEL_MTL_2_IMC		0x7d01
+#define PCI_DEVICE_ID_INTEL_MTL_3_IMC		0x7d02
+#define PCI_DEVICE_ID_INTEL_MTL_4_IMC		0x7d05
+#define PCI_DEVICE_ID_INTEL_MTL_5_IMC		0x7d10
+#define PCI_DEVICE_ID_INTEL_MTL_6_IMC		0x7d14
+#define PCI_DEVICE_ID_INTEL_MTL_7_IMC		0x7d15
+#define PCI_DEVICE_ID_INTEL_MTL_8_IMC		0x7d16
+#define PCI_DEVICE_ID_INTEL_MTL_9_IMC		0x7d21
+#define PCI_DEVICE_ID_INTEL_MTL_10_IMC		0x7d22
+#define PCI_DEVICE_ID_INTEL_MTL_11_IMC		0x7d23
+#define PCI_DEVICE_ID_INTEL_MTL_12_IMC		0x7d24
+#define PCI_DEVICE_ID_INTEL_MTL_13_IMC		0x7d28
 
 
 #define IMC_UNCORE_DEV(a)						\
@@ -205,6 +218,32 @@
 #define ADL_UNC_ARB_PERFEVTSEL0			0x2FD0
 #define ADL_UNC_ARB_MSR_OFFSET			0x8
 
+/* MTL Cbo register */
+#define MTL_UNC_CBO_0_PER_CTR0			0x2448
+#define MTL_UNC_CBO_0_PERFEVTSEL0		0x2442
+
+/* MTL HAC_ARB register */
+#define MTL_UNC_HAC_ARB_CTR			0x2018
+#define MTL_UNC_HAC_ARB_CTRL			0x2012
+
+/* MTL ARB register */
+#define MTL_UNC_ARB_CTR				0x2418
+#define MTL_UNC_ARB_CTRL			0x2412
+
+/* MTL cNCU register */
+#define MTL_UNC_CNCU_FIXED_CTR			0x2408
+#define MTL_UNC_CNCU_FIXED_CTRL			0x2402
+#define MTL_UNC_CNCU_BOX_CTL			0x240e
+
+/* MTL sNCU register */
+#define MTL_UNC_SNCU_FIXED_CTR			0x2008
+#define MTL_UNC_SNCU_FIXED_CTRL			0x2002
+#define MTL_UNC_SNCU_BOX_CTL			0x200e
+
+/* MTL HAC_CBO register */
+#define MTL_UNC_HBO_CTR				0x2048
+#define MTL_UNC_HBO_CTRL			0x2042
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
@@ -598,6 +637,115 @@ void adl_uncore_cpu_init(void)
 	uncore_msr_uncores = adl_msr_uncores;
 }
 
+static struct intel_uncore_type mtl_uncore_cbox = {
+	.name		= "cbox",
+	.num_counters   = 2,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= MTL_UNC_CBO_0_PER_CTR0,
+	.event_ctl	= MTL_UNC_CBO_0_PERFEVTSEL0,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type mtl_uncore_hac_arb = {
+	.name		= "hac_arb",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= MTL_UNC_HAC_ARB_CTR,
+	.event_ctl	= MTL_UNC_HAC_ARB_CTRL,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type mtl_uncore_arb = {
+	.name		= "arb",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= MTL_UNC_ARB_CTR,
+	.event_ctl	= MTL_UNC_ARB_CTRL,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static struct intel_uncore_type mtl_uncore_hac_cbox = {
+	.name		= "hac_cbox",
+	.num_counters   = 2,
+	.num_boxes	= 2,
+	.perf_ctr_bits	= 48,
+	.perf_ctr	= MTL_UNC_HBO_CTR,
+	.event_ctl	= MTL_UNC_HBO_CTRL,
+	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
+	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &adl_uncore_format_group,
+};
+
+static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
+{
+	wrmsrl(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
+}
+
+static struct intel_uncore_ops mtl_uncore_msr_ops = {
+	.init_box	= mtl_uncore_msr_init_box,
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
+static struct intel_uncore_type mtl_uncore_cncu = {
+	.name		= "cncu",
+	.num_counters   = 1,
+	.num_boxes	= 1,
+	.box_ctl	= MTL_UNC_CNCU_BOX_CTL,
+	.fixed_ctr_bits = 48,
+	.fixed_ctr	= MTL_UNC_CNCU_FIXED_CTR,
+	.fixed_ctl	= MTL_UNC_CNCU_FIXED_CTRL,
+	.single_fixed	= 1,
+	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
+	.format_group	= &icl_uncore_clock_format_group,
+	.ops		= &mtl_uncore_msr_ops,
+	.event_descs	= icl_uncore_events,
+};
+
+static struct intel_uncore_type mtl_uncore_sncu = {
+	.name		= "sncu",
+	.num_counters   = 1,
+	.num_boxes	= 1,
+	.box_ctl	= MTL_UNC_SNCU_BOX_CTL,
+	.fixed_ctr_bits	= 48,
+	.fixed_ctr	= MTL_UNC_SNCU_FIXED_CTR,
+	.fixed_ctl	= MTL_UNC_SNCU_FIXED_CTRL,
+	.single_fixed	= 1,
+	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
+	.format_group	= &icl_uncore_clock_format_group,
+	.ops		= &mtl_uncore_msr_ops,
+	.event_descs	= icl_uncore_events,
+};
+
+static struct intel_uncore_type *mtl_msr_uncores[] = {
+	&mtl_uncore_cbox,
+	&mtl_uncore_hac_arb,
+	&mtl_uncore_arb,
+	&mtl_uncore_hac_cbox,
+	&mtl_uncore_cncu,
+	&mtl_uncore_sncu,
+	NULL
+};
+
+void mtl_uncore_cpu_init(void)
+{
+	mtl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	uncore_msr_uncores = mtl_msr_uncores;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
@@ -1264,6 +1412,19 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 	IMC_UNCORE_DEV(RPL_23),
 	IMC_UNCORE_DEV(RPL_24),
 	IMC_UNCORE_DEV(RPL_25),
+	IMC_UNCORE_DEV(MTL_1),
+	IMC_UNCORE_DEV(MTL_2),
+	IMC_UNCORE_DEV(MTL_3),
+	IMC_UNCORE_DEV(MTL_4),
+	IMC_UNCORE_DEV(MTL_5),
+	IMC_UNCORE_DEV(MTL_6),
+	IMC_UNCORE_DEV(MTL_7),
+	IMC_UNCORE_DEV(MTL_8),
+	IMC_UNCORE_DEV(MTL_9),
+	IMC_UNCORE_DEV(MTL_10),
+	IMC_UNCORE_DEV(MTL_11),
+	IMC_UNCORE_DEV(MTL_12),
+	IMC_UNCORE_DEV(MTL_13),
 	{ /* end: all zeroes */ }
 };
 
-- 
2.35.1

