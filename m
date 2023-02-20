Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89B69D021
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjBTPEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBTPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:04:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3020D0D;
        Mon, 20 Feb 2023 07:02:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90475660217D;
        Mon, 20 Feb 2023 15:02:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905340;
        bh=qNjIvg0DPQshUABYHxEL6t8PvZGn3/N8UqW924VnahA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBm7IERtMtk8KDGMqwk43nbr5LpwubgauGz48XSFxZdS56MK7GPwodi7N+Q+CFaV0
         77zVwnkHfRWHCNKSiurfw7JJ+SiqZwHq4kA/VP1oBCkfQS0s5sccfW5kmrcVCaBkLR
         qLHCAjWGhCG4dZJ+3SOGcG9QZG+sX/S8fqEKHeO8d2RcOUCsWSHJyXHPNWKxxuEpw/
         SzHlswKEGC0WJLbZrblUuR7RzRMAiLVILEliVn4/VdPFWLU1UEIRSmun6NwpoiIOLl
         lRilqpFYuzX8gUzUe3JnD2BFicozemMPuIsFg49Ylhil+5iKJ/ejmLQ8Ao0dS8urAy
         bfQdExhaxzhbw==
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
Subject: [PATCH v3 46/55] clk: mediatek: Split configuration options for MT8186 clock drivers
Date:   Mon, 20 Feb 2023 16:01:02 +0100
Message-Id: <20230220150111.77897-47-angelogioacchino.delregno@collabora.com>
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

When building clock drivers for MT8186, some may want to build in only
some of them to, for example, get CPUFreq up faster, and some may want
to leave out some clock drivers entirely as a machine may not need the
Warp Engine or the camera ISP (hence, their clock drivers).

Split the various clock drivers in their own configuration options,
keeping MT8186 configuration options consistent with other MediaTek
SoCs.

While at it, also allow building the remaining clock drivers as modules
by switching COMMON_CLK_MT8186 to tristate.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig  | 79 ++++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/Makefile | 18 +++++---
 2 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index a558e951d759..6f970d54a2cd 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -596,7 +596,7 @@ config COMMON_CLK_MT8183_VENCSYS
 	  This driver supports MediaTek MT8183 vencsys clocks.
 
 config COMMON_CLK_MT8186
-	bool "Clock driver for MediaTek MT8186"
+	tristate "Clock driver for MediaTek MT8186"
 	depends on ARM64 || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	select COMMON_CLK_MEDIATEK_FHCTL
@@ -604,6 +604,83 @@ config COMMON_CLK_MT8186
 	help
 	  This driver supports MediaTek MT8186 clocks.
 
+config COMMON_CLK_MT8186_CAMSYS
+	tristate "Clock driver for MediaTek MT8186 camsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 camsys and camsys_raw clocks.
+
+config COMMON_CLK_MT8186_IMGSYS
+	tristate "Clock driver for MediaTek MT8186 imgsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 imgsys and imgsys2 clocks.
+
+config COMMON_CLK_MT8186_IPESYS
+	tristate "Clock driver for MediaTek MT8186 ipesys"
+	depends on COMMON_CLK_MT8186_IMGSYS
+	default COMMON_CLK_MT8186_IMGSYS
+	help
+	  This driver supports MediaTek MT8186 ipesys clocks.
+
+config COMMON_CLK_MT8186_WPESYS
+	tristate "Clock driver for MediaTek MT8186 wpesys"
+	depends on COMMON_CLK_MT8186_IMGSYS
+	default COMMON_CLK_MT8186_IMGSYS
+	help
+	  This driver supports MediaTek MT8186 Warp Engine clocks.
+
+config COMMON_CLK_MT8186_IMP_IIC_WRAP
+	tristate "Clock driver for MediaTek MT8186 imp_iic_wrap"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 imp_iic_wrap clocks.
+
+config COMMON_CLK_MT8186_MCUSYS
+	tristate "Clock driver for MediaTek MT8186 mcusys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 mcusys clocks.
+
+config COMMON_CLK_MT8186_MDPSYS
+	tristate "Clock driver for MediaTek MT8186 mdpsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 mdpsys clocks.
+
+config COMMON_CLK_MT8186_MFGCFG
+	tristate "Clock driver for MediaTek MT8186 mfgcfg"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 mfgcfg clocks.
+
+config COMMON_CLK_MT8186_MMSYS
+	tristate "Clock driver for MediaTek MT8186 mmsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 mmsys clocks.
+
+config COMMON_CLK_MT8186_VDECSYS
+	tristate "Clock driver for MediaTek MT8186 vdecsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 vdecsys and vdecsys_soc clocks.
+
+config COMMON_CLK_MT8186_VENCSYS
+	tristate "Clock driver for MediaTek MT8186 vencsys"
+	depends on COMMON_CLK_MT8186
+	default COMMON_CLK_MT8186
+	help
+	  This driver supports MediaTek MT8186 vencsys clocks.
+
 config COMMON_CLK_MT8192
 	bool "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 63351957f862..6204ad17b7ca 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -87,11 +87,19 @@ obj-$(CONFIG_COMMON_CLK_MT8183_MFGCFG) += clk-mt8183-mfgcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8183_MMSYS) += clk-mt8183-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
-obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
-				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
-				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
-				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o \
-				   clk-mt8186-cam.o clk-mt8186-mdp.o clk-mt8186-ipe.o
+obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-apmixedsys.o clk-mt8186-infra_ao.o \
+				   clk-mt8186-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT8186_CAMSYS) += clk-mt8186-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8186_IMGSYS) += clk-mt8186-img.o
+obj-$(CONFIG_COMMON_CLK_MT8186_IMP_IIC_WRAP) += clk-mt8186-imp_iic_wrap.o
+obj-$(CONFIG_COMMON_CLK_MT8186_IPESYS) += clk-mt8186-ipe.o
+obj-$(CONFIG_COMMON_CLK_MT8186_MCUSYS) += clk-mt8186-mcu.o
+obj-$(CONFIG_COMMON_CLK_MT8186_MDPSYS) += clk-mt8186-mdp.o
+obj-$(CONFIG_COMMON_CLK_MT8186_MFGCFG) += clk-mt8186-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8186_MMSYS) += clk-mt8186-mm.o
+obj-$(CONFIG_COMMON_CLK_MT8186_VDECSYS) += clk-mt8186-vdec.o
+obj-$(CONFIG_COMMON_CLK_MT8186_VENCSYS) += clk-mt8186-venc.o
+obj-$(CONFIG_COMMON_CLK_MT8186_WPESYS) += clk-mt8186-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
-- 
2.39.1

