Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024D6E69BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjDRQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDRQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA7173B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:41:15 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:41:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681836074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cRnvtpjH9+6TQbpL93sJPj7FNWyCzS76ma2aAuxOwU=;
        b=LgKgTH2Pju7qeAcv9GRbvTtGDymwoRBzmbvtRhEt0VQgyZcGaIigjg6VPaBv8G2xsTsdFd
        xjjmYiWO82gE2AIy3E52RaQtq90HgNMQUovewZHtloHykobnJQ/JwEB5uwleUtytf+UfR7
        /65xi6OFN1zFjTJRIFC2xU1IOJnLWnLLCqR6U59s17bX8Rm3517FZHTodWxi8+KUxdd6c4
        JkQLA6xhtO65YIQf/YoH1Q9dVLGQpHv5zL6NgW3wFQc6L1GmGinwjuzKKYkdtzdNzmfYN6
        LkJ+7SlDf0/uDWpsR0SzvSjiJ+CpXCukv8VzVxXQDllEtwQZOu1orVdaieSevw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681836074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cRnvtpjH9+6TQbpL93sJPj7FNWyCzS76ma2aAuxOwU=;
        b=hoHDU1CDO8wpoX/BekVTtpYksqkIf8If3R5tIY+zZo1HoS+7QgGT9nUB73cZJqdtT0Vosj
        9Ud6jljFCCv2ZLCA==
From:   "irqchip-bot for Sebastian Reichel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Add Rockchip 3588001
 erratum workaround
Cc:     XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Lucas Tanure <lucas.tanure@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230418142109.49762-2-sebastian.reichel@collabora.com>
References: <20230418142109.49762-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Message-ID: <168183607322.404.5670700847015937556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a8707f5538846611c90116c14f72539ad5fb37da
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a8707f5538846611c90116c14f72539ad5fb37da
Author:        Sebastian Reichel <sebastian.reichel@collabora.com>
AuthorDate:    Tue, 18 Apr 2023 16:21:08 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 18 Apr 2023 17:31:17 +01:00

irqchip/gic-v3: Add Rockchip 3588001 erratum workaround

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230418142109.49762-2-sebastian.reichel@collabora.com
---
 Documentation/arm64/silicon-errata.rst |  3 ++-
 arch/arm64/Kconfig                     | 10 +++++++-
 drivers/irqchip/irq-gic-v3-its.c       | 35 +++++++++++++++++++++++++-
 3 files changed, 48 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index e31f6c0..9e311bc 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -207,6 +207,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Qualcomm Tech. | Kryo4xx Gold    | N/A             | ARM64_ERRATUM_1286807       |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
++----------------+-----------------+-----------------+-----------------------------+
 
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e89..0278921 100644
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
index 586271b..fa4641a 100644
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
@@ -2359,6 +2361,9 @@ retry_baser:
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
@@ -4756,6 +4780,14 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_hip07_161600802,
 	},
 #endif
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3588001
+	{
+		.desc   = "ITS: Rockchip erratum RK3588001",
+		.iidr   = 0x0201743b,
+		.mask   = 0xffffffff,
+		.init   = its_enable_rk3588001,
+	},
+#endif
 	{
 	}
 };
@@ -5096,6 +5128,9 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
