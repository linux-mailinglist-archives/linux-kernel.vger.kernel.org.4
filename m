Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C5A69FAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjBVSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBVSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:10:03 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173C3B860;
        Wed, 22 Feb 2023 10:09:53 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtYu-0008Kw-0b;
        Wed, 22 Feb 2023 19:09:52 +0100
Date:   Wed, 22 Feb 2023 18:09:47 +0000
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
Subject: [PATCH RFC 3/4] dt-bindings: clock: break out
 mediatek,filogic-apmixed
Message-ID: <177707569882ff308d375aae3e2936a60ea483c7.1677089171.git.daniel@makrotopia.org>
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

The apmixed clocks of MT7981 and MT7986 are identical. In order to
de-duplicate both clock drivers, start with putting apmixed into a
header files of its own, so it can be used by both SoCs.
Propagate this change also to mt7986a.dtsi which is the only user.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  1 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c     |  2 +-
 .../clock/mediatek,filogic-apmixed.h          | 21 +++++++++++++++++++
 .../dt-bindings/clock/mediatek,mt7981-clk.h   | 10 ---------
 .../dt-bindings/clock/mediatek,mt7986-clk.h   | 11 ----------
 5 files changed, 23 insertions(+), 22 deletions(-)
 create mode 100644 include/dt-bindings/clock/mediatek,filogic-apmixed.h

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 5159ff8673501..051a3e95f3141 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mediatek,mt7986-clk.h>
 #include <dt-bindings/clock/mediatek,ethsys.h>
+#include <dt-bindings/clock/mediatek,filogic-apmixed.h>
 #include <dt-bindings/reset/mt7986-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 6767e9c438866..89112c1c476e1 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -16,7 +16,7 @@
 #include "clk-mux.h"
 #include "clk-pll.h"
 
-#include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/clock/mediatek,filogic-apmixed.h>
 #include <linux/clk.h>
 
 #define MT7986_PLL_FMAX (2500UL * MHZ)
diff --git a/include/dt-bindings/clock/mediatek,filogic-apmixed.h b/include/dt-bindings/clock/mediatek,filogic-apmixed.h
new file mode 100644
index 0000000000000..459a402c76f66
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,filogic-apmixed.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MEDIATEK_FILOGIC_APMIXED_H
+#define _DT_BINDINGS_CLK_MEDIATEK_FILOGIC_APMIXED_H
+
+/* APMIXEDSYS */
+
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_NET2PLL		1
+#define CLK_APMIXED_MMPLL		2
+#define CLK_APMIXED_SGMPLL		3
+#define CLK_APMIXED_WEDMCUPLL		4
+#define CLK_APMIXED_NET1PLL		5
+#define CLK_APMIXED_MPLL		6
+#define CLK_APMIXED_APLL2		7
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt7981-clk.h b/include/dt-bindings/clock/mediatek,mt7981-clk.h
index 8f39248dcd34d..c3546daae7717 100644
--- a/include/dt-bindings/clock/mediatek,mt7981-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt7981-clk.h
@@ -184,14 +184,4 @@
 #define CLK_INFRA_IPCIER_CK		59
 #define CLK_INFRA_IPCIEB_CK		60
 
-/* APMIXEDSYS */
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_NET2PLL		1
-#define CLK_APMIXED_MMPLL		2
-#define CLK_APMIXED_SGMPLL		3
-#define CLK_APMIXED_WEDMCUPLL		4
-#define CLK_APMIXED_NET1PLL		5
-#define CLK_APMIXED_MPLL		6
-#define CLK_APMIXED_APLL2		7
-
 #endif /* _DT_BINDINGS_CLK_MT7981_H */
diff --git a/include/dt-bindings/clock/mediatek,mt7986-clk.h b/include/dt-bindings/clock/mediatek,mt7986-clk.h
index 67179a18589a9..a307ae4960077 100644
--- a/include/dt-bindings/clock/mediatek,mt7986-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt7986-clk.h
@@ -7,17 +7,6 @@
 #ifndef _DT_BINDINGS_CLK_MT7986_H
 #define _DT_BINDINGS_CLK_MT7986_H
 
-/* APMIXEDSYS */
-
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_NET2PLL		1
-#define CLK_APMIXED_MMPLL		2
-#define CLK_APMIXED_SGMPLL		3
-#define CLK_APMIXED_WEDMCUPLL		4
-#define CLK_APMIXED_NET1PLL		5
-#define CLK_APMIXED_MPLL		6
-#define CLK_APMIXED_APLL2		7
-
 /* TOPCKGEN */
 
 #define CLK_TOP_XTAL			0
-- 
2.39.2

