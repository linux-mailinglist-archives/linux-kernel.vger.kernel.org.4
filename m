Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AC6E670C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjDROVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjDROV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:21:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B6B752;
        Tue, 18 Apr 2023 07:21:13 -0700 (PDT)
Received: from jupiter.universe (unknown [91.248.213.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5907766030AB;
        Tue, 18 Apr 2023 15:21:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681827671;
        bh=m877D/TxsZrp9XLtw16Qt27hUjtJBPprUJAA6uattZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk00XlEONKIIy+VfOTXTGyE80fNcCYkmIFVQa5H0l+Rmr1RpxmsdQIejty86SdKaO
         oNXHyCmK0LurwOgCmt1EwFramyMJc57njill52Bar0bhBOnBfYUG3oLwYsPfZcS87V
         1+eo+XnVUTpxoTdFUB9i8nu6IsnYNyc4EqifkQUyO99/6U860x1p2L1Lm0vUex7hY8
         b2wJS2/i3YuxrbwinkwalAAvP+MAVD3yu10iY9r98uV/g6OX0ZYTlOCtDZfOTptUcD
         c3zmrBlJRu9kXokMAuUyryyGAf0pAqaSKLhpEw+wAeFmy5oVNiC/N04LwwtmaUqpKA
         WLbvM4oJh5yUg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8716C480073; Tue, 18 Apr 2023 16:21:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 1/2] irqchip/gic-v3: Add Rockchip 3588001 erratum workaround
Date:   Tue, 18 Apr 2023 16:21:08 +0200
Message-Id: <20230418142109.49762-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418142109.49762-1-sebastian.reichel@collabora.com>
References: <20230418142109.49762-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip RK3588/RK3588s GIC600 integration does not support the
sharability feature. Rockchip assigned Erratum ID #3588001 for this
issue.

Note, that the 0x0201743b ID is not Rockchip specific and thus
there is an extra of_machine_is_compatible() check.

The flags are named FORCE_NON_SHAREABLE to be vendor agnostic,
since apparently similar integration design errors exist in other
platforms and they can reuse the same flag.

Co-developed-by: XiaoDong Huang <derrick.huang@rock-chips.com>
Signed-off-by: XiaoDong Huang <derrick.huang@rock-chips.com>
Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Co-developed-by: Lucas Tanure <lucas.tanure@collabora.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/arm64/silicon-errata.rst |  3 +++
 arch/arm64/Kconfig                     | 10 ++++++++
 drivers/irqchip/irq-gic-v3-its.c       | 35 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ec5f889d7681..46d06ed3e4f4 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -205,6 +205,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo4xx Gold    | N/A             | ARM64_ERRATUM_1286807       |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
++----------------+-----------------+-----------------+-----------------------------+
 
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..02789215d251 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1150,6 +1150,16 @@ config NVIDIA_CARMEL_CNP_ERRATUM
 
 	  If unsure, say Y.
 
+config ROCKCHIP_ERRATUM_3588001
+	bool "Rockchip 3588001: GIC600 can not support shareability attributes"
+	default y
+	help
+	  The Rockchip RK3588 GIC600 SoC integration does not support ACE/ACE-lite.
+	  This means, that its sharability feature may not be used, even though it
+	  is supported by the IP itself.
+
+	  If unsure, say Y.
+
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 586271b8aa39..fa4641a5dfd8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,9 +42,11 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
+#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
 
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
@@ -2359,6 +2361,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
+
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -3096,6 +3101,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
+	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
 			/*
@@ -3120,6 +3128,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 
+	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
+
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
 		/*
 		 * The HW reports non-shareable, we must remove the
@@ -4710,6 +4721,19 @@ static bool __maybe_unused its_enable_quirk_hip07_161600802(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_rk3588001(void *data)
+{
+	struct its_node *its = data;
+
+	if (!of_machine_is_compatible("rockchip,rk3588"))
+		return false;
+
+	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+	gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4755,6 +4779,14 @@ static const struct gic_quirk its_quirks[] = {
 		.mask	= 0xffffffff,
 		.init	= its_enable_quirk_hip07_161600802,
 	},
+#endif
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3588001
+	{
+		.desc   = "ITS: Rockchip erratum RK3588001",
+		.iidr   = 0x0201743b,
+		.mask   = 0xffffffff,
+		.init   = its_enable_rk3588001,
+	},
 #endif
 	{
 	}
@@ -5096,6 +5128,9 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
-- 
2.39.2

