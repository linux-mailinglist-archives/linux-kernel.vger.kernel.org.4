Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA8696542
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjBNNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjBNNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:45:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A46298D5;
        Tue, 14 Feb 2023 05:43:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26A186602169;
        Tue, 14 Feb 2023 13:42:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382152;
        bh=ZnfoTMQQDXq6N0dPOwzbWOj0mGm+pJduR4wcP7jWZaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1wiFFiU4vZ+oI1DSYge4jePjuvK5E/6R6HVCXrgfD0Ib0ir3ErVrM7COKRDFNzOp
         gZQgnRQp+ITI4CxF9ozmmRhelazREgbl0hZ97xkodldHKvZRMzXvYkejd5ZbclwG29
         SYblXXQv7HAa+d0YA7SfwYYLG2vHMFnX704Fyb3klWY40k/Sb/rcZzygqTDbC44KEk
         eUDg5DdfiRvLMz/wLlFMVrFeT196YEZCZtXxXlee51kDvFMzIuzFU+Usm/hbH6wJyG
         /T9ucHtMs0CotYLmJDCar1jKc4h2N1G7iEpAgVgO23Ajmh/aC0v36oNzagCm3CZPMH
         G46KkG0i56XPw==
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
Subject: [PATCH v2 38/47] clk: mediatek: Allow building MT8192 non-critical clocks as modules
Date:   Tue, 14 Feb 2023 14:41:18 +0100
Message-Id: <20230214134127.59273-39-angelogioacchino.delregno@collabora.com>
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

Allow building non boot critical clocks for MT8192 SoC as modules by
changing them to tristate.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 88937d111e98..b5636b3225e8 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -613,73 +613,73 @@ config COMMON_CLK_MT8192
 	  This driver supports MediaTek MT8192 basic clocks.
 
 config COMMON_CLK_MT8192_AUDSYS
-	bool "Clock driver for MediaTek MT8192 audsys"
+	tristate "Clock driver for MediaTek MT8192 audsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 audsys clocks.
 
 config COMMON_CLK_MT8192_CAMSYS
-	bool "Clock driver for MediaTek MT8192 camsys"
+	tristate "Clock driver for MediaTek MT8192 camsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 camsys and camsys_raw clocks.
 
 config COMMON_CLK_MT8192_IMGSYS
-	bool "Clock driver for MediaTek MT8192 imgsys"
+	tristate "Clock driver for MediaTek MT8192 imgsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 imgsys and imgsys2 clocks.
 
 config COMMON_CLK_MT8192_IMP_IIC_WRAP
-	bool "Clock driver for MediaTek MT8192 imp_iic_wrap"
+	tristate "Clock driver for MediaTek MT8192 imp_iic_wrap"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 imp_iic_wrap clocks.
 
 config COMMON_CLK_MT8192_IPESYS
-	bool "Clock driver for MediaTek MT8192 ipesys"
+	tristate "Clock driver for MediaTek MT8192 ipesys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 ipesys clocks.
 
 config COMMON_CLK_MT8192_MDPSYS
-	bool "Clock driver for MediaTek MT8192 mdpsys"
+	tristate "Clock driver for MediaTek MT8192 mdpsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mdpsys clocks.
 
 config COMMON_CLK_MT8192_MFGCFG
-	bool "Clock driver for MediaTek MT8192 mfgcfg"
+	tristate "Clock driver for MediaTek MT8192 mfgcfg"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mfgcfg clocks.
 
 config COMMON_CLK_MT8192_MMSYS
-	bool "Clock driver for MediaTek MT8192 mmsys"
+	tristate "Clock driver for MediaTek MT8192 mmsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 mmsys clocks.
 
 config COMMON_CLK_MT8192_MSDC
-	bool "Clock driver for MediaTek MT8192 msdc"
+	tristate "Clock driver for MediaTek MT8192 msdc"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 msdc and msdc_top clocks.
 
 config COMMON_CLK_MT8192_SCP_ADSP
-	bool "Clock driver for MediaTek MT8192 scp_adsp"
+	tristate "Clock driver for MediaTek MT8192 scp_adsp"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 scp_adsp clocks.
 
 config COMMON_CLK_MT8192_VDECSYS
-	bool "Clock driver for MediaTek MT8192 vdecsys"
+	tristate "Clock driver for MediaTek MT8192 vdecsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 vdecsys and vdecsys_soc clocks.
 
 config COMMON_CLK_MT8192_VENCSYS
-	bool "Clock driver for MediaTek MT8192 vencsys"
+	tristate "Clock driver for MediaTek MT8192 vencsys"
 	depends on COMMON_CLK_MT8192
 	help
 	  This driver supports MediaTek MT8192 vencsys clocks.
-- 
2.39.1

