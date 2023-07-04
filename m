Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E750B747178
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGDMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC05DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007E76122F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D14CC433C8;
        Tue,  4 Jul 2023 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688474083;
        bh=CLYTShX+13Uc0T3WbTGjbjidrz9XL6yyYZZkbOoFqS4=;
        h=From:To:Cc:Subject:Date:From;
        b=j0JKRpIloZtUzaa7bRFgT5LWh2az75UaGEty2op4oTvJ5TlpHOCAFsKS184jxoZ0u
         ay4fEtnOOh81kCdyZOL4TATT5YmIPOJ5ntoFo7N0bZj/UkbdsLMahiBRtmy+ExNd0l
         yl18xulpXWpgifukmW8JXVwcAus8qpOLiBcTehVMfSLYodSpxHF48/w7Cgjlba/J0a
         A72ZKS0bZBrsKbCm55E6H+YnP0GN9WLeq3WcHAbBBuA9hNNCpBDUp4Cv1nROg4u0Uc
         P6Qj17YATQZczJtaYYoVkmipH1o8l2e1olRKca9eeiDlOGCPOTCYf2vuvTJ85pTmY2
         fFVaSX5wiz9nw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Cheng-Yuh.Wu@mediatek.com, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Date:   Tue,  4 Jul 2023 14:34:36 +0200
Message-Id: <20230704123436.127449-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC700 erratum 2941627 may cause GIC-700 missing SPIs wake
requests when SPIs are deactivated while targeting a
sleeping CPU - ie a CPU for which the redistributor:

GICR_WAKER.ProcessorSleep == 1

This runtime situation can happen if an SPI that has been
activated on a core is retargeted to a different core, it
becomes pending and the target core subsequently enters a
power state quiescing the respective redistributor.

When this situation is hit, the de-activation carried out
on the core that activated the SPI (through either ICC_EOIR1_EL1
or ICC_DIR_EL1 register writes) does not trigger a wake
requests for the sleeping GIC redistributor even if the SPI
is pending.

Fix the erratum by de-activating the SPI using the
redistributor GICD_ICACTIVER register if the runtime
conditions require it (ie the IRQ was retargeted between
activation and de-activation).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/irqchip/irq-gic-v3.c           | 71 +++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9e311bc43e05..e77c57a0adf8 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -141,6 +141,9 @@ stable kernels.
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a605aa79435a..a0a9ccf23742 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -68,6 +68,8 @@ struct gic_chip_data {
 static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
 static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
 
+static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -591,10 +593,35 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
 }
 
+static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
+{
+	if (!static_branch_unlikely(&gic_arm64_2941627_erratum))
+		return false;
+
+	/*
+	 * The workaround is needed if the IRQ is an SPI and
+	 * the target cpu is different from the one we are
+	 * executing on.
+	 */
+	return !((gic_irq_in_rdist(d)) || gic_irq(d) >= 8192 ||
+		  cpumask_equal(irq_data_get_effective_affinity_mask(d),
+				cpumask_of(smp_processor_id())));
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
 	isb();
+
+	if (gic_arm64_erratum_2941627_needed(d)) {
+		/*
+		 * Make sure the GIC stream deactivate packet
+		 * issued by ICC_EOIR1_EL1 has completed before
+		 * deactivating through GICD_IACTIVER.
+		 */
+		dsb(sy);
+		gic_poke_irq(d, GICD_ICACTIVER);
+	}
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
@@ -605,7 +632,11 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 */
 	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
-	gic_write_dir(gic_irq(d));
+
+	if (!gic_arm64_erratum_2941627_needed(d))
+		gic_write_dir(gic_irq(d));
+	else
+		gic_poke_irq(d, GICD_ICACTIVER);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -1796,6 +1827,25 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_arm64_2941627(void *data)
+{
+	/*
+	 * If CPUidle is not enabled the erratum runtime
+	 * conditions can't be hit, since that requires:
+	 *
+	 * - A core entering a deep power state with
+	 *   the associated GIC redistributor asleep
+	 *   and an IRQ active and pending targeted at it
+	 * - A different core handling the IRQ and
+	 *   related GIC operations at the same time
+	 */
+	if (!IS_ENABLED(CONFIG_CPU_IDLE))
+		return false;
+
+	static_branch_enable(&gic_arm64_2941627_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1838,6 +1888,25 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= gic_enable_quirk_nvidia_t241,
 	},
+	{
+		/*
+		 * GIC-700: 2941627 workaround - IP variant [0,1]
+		 *
+		 */
+		.desc	= "GICv3: ARM64 erratum 2941627",
+		.iidr	= 0x0400043b,
+		.mask	= 0xff0e0fff,
+		.init	= gic_enable_quirk_arm64_2941627,
+	},
+	{
+		/*
+		 * GIC-700: 2941627 workaround - IP variant [2]
+		 */
+		.desc	= "GICv3: ARM64 erratum 2941627",
+		.iidr	= 0x0402043b,
+		.mask	= 0xff0f0fff,
+		.init	= gic_enable_quirk_arm64_2941627,
+	},
 	{
 	}
 };
-- 
2.34.1

