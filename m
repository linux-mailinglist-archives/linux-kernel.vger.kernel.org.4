Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4A69D038
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjBTPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjBTPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:05:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502820569;
        Mon, 20 Feb 2023 07:03:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B45266021C7;
        Mon, 20 Feb 2023 15:02:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905336;
        bh=zK57pu6YreEhk+8+0/wsk/oSJuvEwA1BCrX0LjW9yCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbNTnmaGgiRU1R5tSO6gZHxGlWb8PPOQTQrSOoketnQD6Ukz74zBkGOqBEPx70LtM
         sxsPx854BprmifxmozCFhsaWFUj8nswrPXGESmaQbAJAhxffWfyIMMVjk+ubnlXWqw
         0Mc3v6TCt7zrPV1Df3mal+8G+UiuMibMx4DgWLsyoYPZxxqsiKT9XwOhzVlx+137mi
         HFjGrIXlPgqZnv9vH6o3Q79Hzdt8hY8UyZOitbJRF/9okFjRTzG+5L0CO1HBJeTw7Y
         qgwQFteXzeLjeI+FyP22GjIm5KNEsVjOrh4K2DTFGw6M9av0EW9JNUSlOMWlWpgQFk
         H6X1rX/9oG4ZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 43/55] clk: mediatek: Allow all MT8183 clocks to be built as modules
Date:   Mon, 20 Feb 2023 16:00:59 +0100
Message-Id: <20230220150111.77897-44-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

All MT8183 clocks are platform drivers now! Allow module build for
all of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 6cbc69e713dd..ff04d82278eb 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -511,7 +511,7 @@ config COMMON_CLK_MT8173_VENCSYS
 	  This driver supports MediaTek MT8173 vencsys clocks.
 
 config COMMON_CLK_MT8183
-	bool "Clock driver for MediaTek MT8183"
+	tristate "Clock driver for MediaTek MT8183"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM64
@@ -519,77 +519,77 @@ config COMMON_CLK_MT8183
 	  This driver supports MediaTek MT8183 basic clocks.
 
 config COMMON_CLK_MT8183_AUDIOSYS
-	bool "Clock driver for MediaTek MT8183 audiosys"
+	tristate "Clock driver for MediaTek MT8183 audiosys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 audiosys clocks.
 
 config COMMON_CLK_MT8183_CAMSYS
-	bool "Clock driver for MediaTek MT8183 camsys"
+	tristate "Clock driver for MediaTek MT8183 camsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 camsys clocks.
 
 config COMMON_CLK_MT8183_IMGSYS
-	bool "Clock driver for MediaTek MT8183 imgsys"
+	tristate "Clock driver for MediaTek MT8183 imgsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 imgsys clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE0
-	bool "Clock driver for MediaTek MT8183 ipu_core0"
+	tristate "Clock driver for MediaTek MT8183 ipu_core0"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core0 clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE1
-	bool "Clock driver for MediaTek MT8183 ipu_core1"
+	tristate "Clock driver for MediaTek MT8183 ipu_core1"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core1 clocks.
 
 config COMMON_CLK_MT8183_IPU_ADL
-	bool "Clock driver for MediaTek MT8183 ipu_adl"
+	tristate "Clock driver for MediaTek MT8183 ipu_adl"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_adl clocks.
 
 config COMMON_CLK_MT8183_IPU_CONN
-	bool "Clock driver for MediaTek MT8183 ipu_conn"
+	tristate "Clock driver for MediaTek MT8183 ipu_conn"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_conn clocks.
 
 config COMMON_CLK_MT8183_MFGCFG
-	bool "Clock driver for MediaTek MT8183 mfgcfg"
+	tristate "Clock driver for MediaTek MT8183 mfgcfg"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mfgcfg clocks.
 
 config COMMON_CLK_MT8183_MMSYS
-	bool "Clock driver for MediaTek MT8183 mmsys"
+	tristate "Clock driver for MediaTek MT8183 mmsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mmsys clocks.
 
 config COMMON_CLK_MT8183_VDECSYS
-	bool "Clock driver for MediaTek MT8183 vdecsys"
+	tristate "Clock driver for MediaTek MT8183 vdecsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 vdecsys clocks.
 
 config COMMON_CLK_MT8183_VENCSYS
-	bool "Clock driver for MediaTek MT8183 vencsys"
+	tristate "Clock driver for MediaTek MT8183 vencsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
-- 
2.39.1

