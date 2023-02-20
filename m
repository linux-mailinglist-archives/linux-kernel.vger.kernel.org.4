Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4269669D033
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjBTPFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjBTPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:05:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9741F935;
        Mon, 20 Feb 2023 07:03:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C60966021C6;
        Mon, 20 Feb 2023 15:02:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905333;
        bh=359HCE2F82NoU72fBczXZLXG7a2FJTqYmJkaO8gQsAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8IugqbYbyEzVumbULnOrzVCntO87sHB0RCOU5dGTpOSnnoC/h2pHuVClUyoEhb2n
         wzPB0u10yjTSxHGJYTZHfnGSMZLhnuNTM7my6ScEymKBsKSMPMs5/bUTt3WrQlzQCf
         PINRe2rmdD3r6Vpt/zpOeCrLIyhoMH5vsdBxExgDe2XgPtfE/VW0iUBa6O1Em21kL8
         kv1f7j+doucjqjVuddsw7RyJISK+NpGEODt1yD4s7cFRvdP6qws48rH/pC9ubmvcw/
         sUaB57spz2VULUstFpmV3Vyn+jLhKtjnLHAHuQnfuYrOJpRw6pWX0tyxDIGjO1i3o4
         G+KGp1bfoaz7w==
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
Subject: [PATCH v3 41/55] clk: mediatek: Allow MT7622 clocks to be built as modules
Date:   Mon, 20 Feb 2023 16:00:57 +0100
Message-Id: <20230220150111.77897-42-angelogioacchino.delregno@collabora.com>
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

Now that all drivers are using the simple probe mechanism change the
MT7622 clock drivers to tristate in Kconfig to allow module build.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ac90b304d422..5f3894ce2418 100644
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

