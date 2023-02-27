Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D26A45D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjB0PTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0PS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:18:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B34EB74;
        Mon, 27 Feb 2023 07:18:54 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 062296602FA1;
        Mon, 27 Feb 2023 15:18:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677511133;
        bh=cMHt6PnmCwdV3HhU5FSZOVL8khQ8AWB90bFY2XZ9v2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrLRYYZChK0AcN2rUlWOS7rMf2AfNrpLRua+3uqUjrfxJTpoU5sAVSn54q+IR9fwT
         noB2/BZ/PtgGz9RapVsxqL12vX5h0jBtWtbA+osulnHj6+r6Mm7xfRRT12seOPfB7n
         u7SYQdGK0GMvPak9fr5vZsjgkBJ9Rlj3+VGXIDAiX7PCyhJretK2Ioh5hJQHRym2MR
         0yWIrhnwtfqUJ+0V9Y5zSbDIrIw3EpQoYd1hy7ncBRC6z/3+qfc7BmTcCEa9JhPU1b
         azHpkURaTga2f8iYQZADsVRxNdLETencPClZu94mssB5oXPkotqJmTdM1gtvnaDPdK
         9tnPrM0M06Deg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [RFC 1/1] irqchip/gic-v3: Add RK3588 GICR and GITS no share workaround
Date:   Mon, 27 Feb 2023 15:18:47 +0000
Message-Id: <20230227151847.207922-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230227151847.207922-1-lucas.tanure@collabora.com>
References: <20230227151847.207922-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC600 integration in RK356x, used in rk3588, doesn't support
any of the shareability or cacheability attributes, and requires
both values to be set to 0b00 for all the ITS and Redistributor
tables.

Based on work of Peter Geis for the Quartz64 board.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 13 ++++++++
 drivers/irqchip/irq-gic-v3-its.c       | 42 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ec5f889d7681..b26cf8ca7d5c 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -209,3 +209,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+
++----------------+-----------------+-----------------+-----------------------------+
+| RockChip       | RK3588          | N/A             | ROCKCHIP_NO_SHARE           |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27b2592698b0..ad3f1742052b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1150,6 +1150,19 @@ config NVIDIA_CARMEL_CNP_ERRATUM
 
 	  If unsure, say Y.
 
+config ROCKCHIP_NO_SHARE
+	bool "Rockchip RK3588 GIC6000 No shareability or cacheability attributes"
+	default y
+	help
+	  The GIC600 integration in RK356x doesn't support any of the shareability or
+	  cacheability attributes, and requires both values to be set to 0b00 for all 
+	  the ITS and Redistributor tables.
+
+	  Work around the issue by clearing the GICR_PROPBASER_SHAREABILITY_MASK from
+	  register reads at GICR and GITS.
+
+	  If unsure, say Y.
+
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 586271b8aa39..637e2e2a1ab1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,6 +42,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE	(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
@@ -2359,6 +2360,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
+#if CONFIG_ROCKCHIP_NO_SHARE
+	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE) {
+		if (tmp & GITS_BASER_SHAREABILITY_MASK)
+			tmp &= ~GITS_BASER_SHAREABILITY_MASK;
+		else
+			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+	}
+#endif
+
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -3057,6 +3067,7 @@ static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
+	struct its_node *its;
 	phys_addr_t paddr;
 	u64 val, tmp;
 
@@ -3096,6 +3107,12 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
+#if CONFIG_ROCKCHIP_NO_SHARE
+	its = list_first_entry(&its_nodes, struct its_node, entry);
+	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
+		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
+#endif
+
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
 			/*
@@ -3120,6 +3137,11 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 
+#if CONFIG_ROCKCHIP_NO_SHARE
+	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
+		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
+#endif
+
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
 		/*
 		 * The HW reports non-shareable, we must remove the
@@ -4710,6 +4732,14 @@ static bool __maybe_unused its_enable_quirk_hip07_161600802(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_quirk_rk356x(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE;
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4755,6 +4785,14 @@ static const struct gic_quirk its_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= its_enable_quirk_hip07_161600802,
 	},
+#endif
+#ifdef CONFIG_ROCKCHIP_NO_SHARE
+	{
+		.desc	= "ITS: Rockchip RK356X/RK3588 doesn't support shareability",
+		.iidr	= 0x0201743b,
+		.mask	= 0xffffffff,
+		.init	= its_enable_quirk_rk356x,
+	},
 #endif
 	{
 	}
@@ -5096,6 +5134,10 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
+#if CONFIG_ROCKCHIP_NO_SHARE
+	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
+		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
+#endif
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
-- 
2.39.2

