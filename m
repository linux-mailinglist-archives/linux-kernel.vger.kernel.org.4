Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7356930B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBKLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBKLwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:52:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5657227B7;
        Sat, 11 Feb 2023 03:52:11 -0800 (PST)
Date:   Sat, 11 Feb 2023 11:52:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676116329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wofOAcNOe0PexyWaDwti21aKsOg0nFefc80AMYFSY14=;
        b=pBt9ESaZz2iFsu1/AzEg6rVThKMvJP15VHP/8p/xlTMeY+pEFk9r1P8Gj0tAtUIHpcJp/V
        C1VRjriX/miwnMlWq1i/b3CJDSU2D2fx8e8CqKq6juXd2pQG/9Zwpmvq+jZ61ar2jZ0FQE
        NeVJY8mF9Dorn81svkPpMDiWl464jW6NCET0frDs5v0TGNypkqdvofFFFhEQIHjnvXkQr6
        GyDPraR2EAD1aYCDCLll5rWmc3c5dwqXk8ul2U6Yn+dTmggdLqa4tDyOu0HNOUycWksjw9
        w0x6FYJshwtYkK3L58u5FB7SNVFkEt3JDml6yrJosiZSL/Wck8lDb18MQATFrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676116329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wofOAcNOe0PexyWaDwti21aKsOg0nFefc80AMYFSY14=;
        b=m4JsbVRcyAsqnFEHnZ2QvJOS/bzWjukJLd8ZP9l9yEmHgk1Prnf+ub1Mmwv7OjhpHe2mCA
        cHlx3TtAcK3+AsDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Meteor Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230210190238.1726237-1-kan.liang@linux.intel.com>
References: <20230210190238.1726237-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167611632910.4906.6089442713007626940.tip-bot2@tip-bot2>
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

Commit-ID:     c828441f21ddc819a28b5723a72e3c840e9de1c6
Gitweb:        https://git.kernel.org/tip/c828441f21ddc819a28b5723a72e3c840e9de1c6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 10 Feb 2023 11:02:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 11 Feb 2023 12:39:03 +01:00

perf/x86/intel/uncore: Add Meteor Lake support

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230210190238.1726237-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |   7 +-
 arch/x86/events/intel/uncore.h     |   1 +-
 arch/x86/events/intel/uncore_snb.c | 161 ++++++++++++++++++++++++++++-
 3 files changed, 169 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 4030b0b..bc22660 100644
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
index e76b945..c30fb5b 100644
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
index 1f48692..7fd4334 100644
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
 
