Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBC69FACD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBVSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBVSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:09:42 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5F83C78F;
        Wed, 22 Feb 2023 10:09:40 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtYf-0008Ke-0W;
        Wed, 22 Feb 2023 19:09:37 +0100
Date:   Wed, 22 Feb 2023 18:09:31 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH RFC 2/4] dt-bindings: clock: break out mediatek,ethsys into
 its own header
Message-ID: <db58bdb35e68f5e57b79e0d3560618ef86f10459.1677089171.git.daniel@makrotopia.org>
References: <cover.1677089171.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677089171.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethsys clocks of MT7981 and MT7986 are identical. In order to
de-duplicate both clock drivers, start with putting ethsys into a
header files of its own, so it can be used by both SoCs.
Propagate this change also to mt7986a.dtsi which is the only user.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  1 +
 drivers/clk/mediatek/clk-mt7986-eth.c         |  2 +-
 include/dt-bindings/clock/mediatek,ethsys.h   | 32 +++++++++++++++++++
 .../dt-bindings/clock/mediatek,mt7981-clk.h   | 18 -----------
 .../dt-bindings/clock/mediatek,mt7986-clk.h   | 22 -------------
 5 files changed, 34 insertions(+), 41 deletions(-)
 create mode 100644 include/dt-bindings/clock/mediatek,ethsys.h

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index a53993fe457ca..5159ff8673501 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mediatek,mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,ethsys.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 0681988960cc3..aace5a9f0f1f4 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -14,7 +14,7 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
-#include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,ethsys.h>
 
 static const struct mtk_gate_regs sgmii0_cg_regs = {
 	.set_ofs = 0xe4,
diff --git a/include/dt-bindings/clock/mediatek,ethsys.h b/include/dt-bindings/clock/mediatek,ethsys.h
new file mode 100644
index 0000000000000..adcf14c661c09
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,ethsys.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MEDIATEK_ETHSYS_H
+#define _DT_BINDINGS_CLK_MEDIATEK_ETHSYS_H
+
+/* SGMIISYS_0 */
+
+#define CLK_SGMII0_TX250M_EN		0
+#define CLK_SGMII0_RX250M_EN		1
+#define CLK_SGMII0_CDR_REF		2
+#define CLK_SGMII0_CDR_FB		3
+
+/* SGMIISYS_1 */
+
+#define CLK_SGMII1_TX250M_EN		0
+#define CLK_SGMII1_RX250M_EN		1
+#define CLK_SGMII1_CDR_REF		2
+#define CLK_SGMII1_CDR_FB		3
+
+/* ETHSYS */
+
+#define CLK_ETH_FE_EN			0
+#define CLK_ETH_GP2_EN			1
+#define CLK_ETH_GP1_EN			2
+#define CLK_ETH_WOCPU1_EN		3
+#define CLK_ETH_WOCPU0_EN		4
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt7981-clk.h b/include/dt-bindings/clock/mediatek,mt7981-clk.h
index 192f8cefb589f..8f39248dcd34d 100644
--- a/include/dt-bindings/clock/mediatek,mt7981-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt7981-clk.h
@@ -194,22 +194,4 @@
 #define CLK_APMIXED_MPLL		6
 #define CLK_APMIXED_APLL2		7
 
-/* SGMIISYS_0 */
-#define CLK_SGM0_TX_EN			0
-#define CLK_SGM0_RX_EN			1
-#define CLK_SGM0_CK0_EN			2
-#define CLK_SGM0_CDR_CK0_EN		3
-
-/* SGMIISYS_1 */
-#define CLK_SGM1_TX_EN			0
-#define CLK_SGM1_RX_EN			1
-#define CLK_SGM1_CK1_EN			2
-#define CLK_SGM1_CDR_CK1_EN		3
-
-/* ETHSYS */
-#define CLK_ETH_FE_EN			0
-#define CLK_ETH_GP2_EN			1
-#define CLK_ETH_GP1_EN			2
-#define CLK_ETH_WOCPU0_EN		3
-
 #endif /* _DT_BINDINGS_CLK_MT7981_H */
diff --git a/include/dt-bindings/clock/mediatek,mt7986-clk.h b/include/dt-bindings/clock/mediatek,mt7986-clk.h
index 5a9b169324b06..67179a18589a9 100644
--- a/include/dt-bindings/clock/mediatek,mt7986-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt7986-clk.h
@@ -144,26 +144,4 @@
 #define CLK_INFRA_IPCIEB_CK		54
 #define CLK_INFRA_TRNG_CK		55
 
-/* SGMIISYS_0 */
-
-#define CLK_SGMII0_TX250M_EN		0
-#define CLK_SGMII0_RX250M_EN		1
-#define CLK_SGMII0_CDR_REF		2
-#define CLK_SGMII0_CDR_FB		3
-
-/* SGMIISYS_1 */
-
-#define CLK_SGMII1_TX250M_EN		0
-#define CLK_SGMII1_RX250M_EN		1
-#define CLK_SGMII1_CDR_REF		2
-#define CLK_SGMII1_CDR_FB		3
-
-/* ETHSYS */
-
-#define CLK_ETH_FE_EN			0
-#define CLK_ETH_GP2_EN			1
-#define CLK_ETH_GP1_EN			2
-#define CLK_ETH_WOCPU1_EN		3
-#define CLK_ETH_WOCPU0_EN		4
-
 #endif /* _DT_BINDINGS_CLK_MT7986_H */
-- 
2.39.2

