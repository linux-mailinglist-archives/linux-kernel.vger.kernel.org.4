Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078AC74759A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGDPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGDPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42542E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AEC61267
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C360C433C7;
        Tue,  4 Jul 2023 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688485840;
        bh=M58r3SZLUR3jJZCkSsGqxT3mIy99qz0dkvfm7o21cCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVdKsaN0lAH5iWfbHDGLRhmWA+UlSIOQkivWDJwdfLNPqz4JKbajdafdnXcBz7Gho
         /r9p8dOjNfPJAIqpbLfFmJomDei+ShpUQ+nUE/2F+SLGFUaO2+IykhQN8YTeZSFWDE
         oJ5fYwRuapoVgolFl9gUlRyH2gqa9//6ijVSiRDfsTQIKg9Q+v4Z0nQh8hqB48y3d+
         cIDSQE2+Zg9nk1fxesskdsq3qaNqkYvv4oqZNCrc4jLyiRik82aR1+5F6d0O1+0A7m
         /hINDGotQZUDYS5hGKvA7OzIOJvg32w9x6iWQkoJ+OsvvzYmlFLPcbC8l1MCi6QWac
         UxYKgkSjwT7zw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Cheng-Yuh.Wu@mediatek.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Date:   Tue,  4 Jul 2023 17:50:34 +0200
Message-Id: <20230704155034.148262-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704123436.127449-1-lpieralisi@kernel.org>
References: <20230704123436.127449-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Work around the erratum by de-activating the SPI using the
redistributor GICD_ICACTIVER register if the runtime
conditions require it (ie the IRQ was retargeted between
activation and de-activation).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
v1 -> v2:

- Updated trigger condition check in
  gic_arm64_erratum_2941627_needed() according to review
- Removed !CONFIG_CPU_IDLE workaround enablement check

 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/irqchip/irq-gic-v3.c           | 62 +++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

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
index a605aa79435a..5dc73c5d2d60 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -68,6 +68,8 @@ struct gic_chip_data {
 static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
 static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
 
+static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -591,10 +593,39 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
 }
 
+static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
+{
+	enum gic_intid_range range;
+
+	if (!static_branch_unlikely(&gic_arm64_2941627_erratum))
+		return false;
+
+	range = get_intid_range(d);
+
+	/*
+	 * The workaround is needed if the IRQ is an SPI and
+	 * the target cpu is different from the one we are
+	 * executing on.
+	 */
+	return (range == SPI_RANGE || range == ESPI_RANGE) &&
+		!cpumask_test_cpu(raw_smp_processor_id(),
+				  irq_data_get_effective_affinity_mask(d));
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
@@ -605,7 +636,11 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
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
@@ -1796,6 +1831,12 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_arm64_2941627(void *data)
+{
+	static_branch_enable(&gic_arm64_2941627_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1838,6 +1879,25 @@ static const struct gic_quirk gic_quirks[] = {
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

