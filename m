Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98D068C198
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBFPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjBFPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:31:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356302BEE4;
        Mon,  6 Feb 2023 07:30:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B30A16602F97;
        Mon,  6 Feb 2023 15:30:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697437;
        bh=KePsqy5PqdeX7Wen9K1KIlUKfVKK1kzyd8Oo4StS3PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8kOQmImwSrcdIrrAsM+i7xgV22AL9pFAnFKGPWOPvVeLuAgMVwg1Apv9DqFRlrEh
         UEgay/2pp1rtj1Re1zXGNvH4iyga+20yHUC7YWtx/B3j2Gb7VO1Am54pT+bNXH5tnU
         IY4OMD/BOQRxAEbAfG6CqCwMjx0q+moLpYXEe3PEoHTSdzJO13K1LW/pITZH/QpAsN
         Ee96Ky/rphG5CoEJpglmFc3p/qXk6KxqU7OdVbho0P0emsMI/Q/IbP8k1GIyqEj+jZ
         YBXyOupksmeG0vGfa99+v9df/WB/Ep1msKQRwnvnb6LE59MC8fFiPoKmEN901F0qGN
         DQN2fy5FioNSQ==
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
Subject: [PATCH v1 37/45] clk: mediatek: Allow MT7622 clocks to be built as modules
Date:   Mon,  6 Feb 2023 16:29:20 +0100
Message-Id: <20230206152928.918562-38-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

Now that all drivers are using the simple probe mechanism change the
MT7622 clock drivers to tristate in Kconfig to allow module build.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index b5636b3225e8..55727889ebf5 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -336,7 +336,7 @@ config COMMON_CLK_MT6797_VENCSYS
 	  This driver supports MediaTek MT6797 vencsys clocks.
 
 config COMMON_CLK_MT7622
-	bool "Clock driver for MediaTek MT7622"
+	tristate "Clock driver for MediaTek MT7622"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
@@ -345,21 +345,21 @@ config COMMON_CLK_MT7622
 	  required for various periperals found on MediaTek.
 
 config COMMON_CLK_MT7622_ETHSYS
-	bool "Clock driver for MediaTek MT7622 ETHSYS"
+	tristate "Clock driver for MediaTek MT7622 ETHSYS"
 	depends on COMMON_CLK_MT7622
 	help
 	  This driver add support for clocks for Ethernet and SGMII
 	  required on MediaTek MT7622 SoC.
 
 config COMMON_CLK_MT7622_HIFSYS
-	bool "Clock driver for MediaTek MT7622 HIFSYS"
+	tristate "Clock driver for MediaTek MT7622 HIFSYS"
 	depends on COMMON_CLK_MT7622
 	help
 	  This driver supports MediaTek MT7622 HIFSYS clocks providing
 	  to PCI-E and USB.
 
 config COMMON_CLK_MT7622_AUDSYS
-	bool "Clock driver for MediaTek MT7622 AUDSYS"
+	tristate "Clock driver for MediaTek MT7622 AUDSYS"
 	depends on COMMON_CLK_MT7622
 	help
 	  This driver supports MediaTek MT7622 AUDSYS clocks providing
-- 
2.39.1

