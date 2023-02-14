Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F14696544
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjBNNpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjBNNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:45:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29927991;
        Tue, 14 Feb 2023 05:44:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2A1566021B0;
        Tue, 14 Feb 2023 13:42:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382154;
        bh=VKBrumrs2Sux84CcTsQzhD+nobtsdV7Rc1oS6rm0aLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E77s1B2P6dTeYn3l4x7Ei5b97WIk4uxEqGk0kBFnMDRhVMtgKMm/Wq14fVKPDMnv9
         dC37H9KfHl586tGtySkOhEKj+hQtRF4OKKDrUbyGKoNvj9LUH50Dm0GqVSH3tc+L6K
         MOj90j2883IVfP+/pbAhOYG9VUwc9z2PX8ZAJwXQDHKY7e15dDGY5mBIZaskywHW5E
         x0jfpekmv1yQgXfFig5CryvavfRWI+1mWkMtQkmE4NJY+JCpbky+Fi1hlOKDSiiEwz
         wu+lA3Bx6oqGZF2UvJwOo+b0iUe7l04EGMaHUjW4qXgxRjQww3srwJR/0H9ouKWXtW
         UqJ0Hcto3naMg==
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 40/47] clk: mediatek: Allow all MT8167 clocks to be built as modules
Date:   Tue, 14 Feb 2023 14:41:20 +0100
Message-Id: <20230214134127.59273-41-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
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

Almost all MT8167 clocks have been converted to use the common probe
mechanism, moreover, now all of them are platform drivers: allow
building as modules.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 55727889ebf5..54f59f4b2b1a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -406,7 +406,7 @@ config COMMON_CLK_MT7981_ETHSYS
 	  required on MediaTek MT7981 SoC.
 
 config COMMON_CLK_MT7986
-	bool "Clock driver for MediaTek MT7986"
+	tristate "Clock driver for MediaTek MT7986"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
@@ -415,7 +415,7 @@ config COMMON_CLK_MT7986
 	  required for various peripherals found on MediaTek.
 
 config COMMON_CLK_MT7986_ETHSYS
-	bool "Clock driver for MediaTek MT7986 ETHSYS"
+	tristate "Clock driver for MediaTek MT7986 ETHSYS"
 	depends on COMMON_CLK_MT7986
 	default COMMON_CLK_MT7986
 	help
@@ -431,7 +431,7 @@ config COMMON_CLK_MT8135
 	  This driver supports MediaTek MT8135 clocks.
 
 config COMMON_CLK_MT8167
-	bool "Clock driver for MediaTek MT8167"
+	tristate "Clock driver for MediaTek MT8167"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
@@ -439,35 +439,35 @@ config COMMON_CLK_MT8167
 	  This driver supports MediaTek MT8167 basic clocks.
 
 config COMMON_CLK_MT8167_AUDSYS
-	bool "Clock driver for MediaTek MT8167 audsys"
+	tristate "Clock driver for MediaTek MT8167 audsys"
 	depends on COMMON_CLK_MT8167
 	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 audsys clocks.
 
 config COMMON_CLK_MT8167_IMGSYS
-	bool "Clock driver for MediaTek MT8167 imgsys"
+	tristate "Clock driver for MediaTek MT8167 imgsys"
 	depends on COMMON_CLK_MT8167
 	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 imgsys clocks.
 
 config COMMON_CLK_MT8167_MFGCFG
-	bool "Clock driver for MediaTek MT8167 mfgcfg"
+	tristate "Clock driver for MediaTek MT8167 mfgcfg"
 	depends on COMMON_CLK_MT8167
 	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 mfgcfg clocks.
 
 config COMMON_CLK_MT8167_MMSYS
-	bool "Clock driver for MediaTek MT8167 mmsys"
+	tristate "Clock driver for MediaTek MT8167 mmsys"
 	depends on COMMON_CLK_MT8167
 	default COMMON_CLK_MT8167
 	help
 	  This driver supports MediaTek MT8167 mmsys clocks.
 
 config COMMON_CLK_MT8167_VDECSYS
-	bool "Clock driver for MediaTek MT8167 vdecsys"
+	tristate "Clock driver for MediaTek MT8167 vdecsys"
 	depends on COMMON_CLK_MT8167
 	default COMMON_CLK_MT8167
 	help
-- 
2.39.1

