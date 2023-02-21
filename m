Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAD169E002
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjBUMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjBUMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:10:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92628D35;
        Tue, 21 Feb 2023 04:10:17 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D9BC66021E7;
        Tue, 21 Feb 2023 11:56:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980614;
        bh=yq06ANsjvjRAT7eIY5kjWA4faChY1E7NlgpHrnMWDKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/XpjXfPy5/s/hdDdtMYvF1pFMnEuZ8S9EDOEgW/kgHzHG6gr8aVEvJ0aUgjm7oFI
         NuX3BOUbzJKYywVfySFJEhZas1p9G3LjGr2La9pXlQlhoRJZTsE3KWwHRMJORM8au3
         QlCsKracVi5Zmw3P2j9SBOKNBX57sFTjcMm7aSCMkCb2PRZv3B75BLn+C4RcWMhc7T
         EyP7qSOne0AFZURnO8BBgPhcGy00fFhuKqqg0lIlEszu9B3umdHSHFDombZ9hV7Vb5
         s4EGkqoYR3L0xf2B6vr9FxNlwlWkm5gaHNzQzggxrP+9SX87kfsAWNfJ20UdOhqMtR
         xPY4xzX6ui1ww==
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
Subject: [PATCH v4 45/54] clk: mediatek: Allow building most MT6797 clock drivers as modules
Date:   Tue, 21 Feb 2023 12:55:40 +0100
Message-Id: <20230221115549.360132-46-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
References: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
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

Most of the MT6797 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index a3260675cafc..0240c1039d64 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -312,25 +312,25 @@ config COMMON_CLK_MT6797
 	  This driver supports MediaTek MT6797 basic clocks.
 
 config COMMON_CLK_MT6797_MMSYS
-	bool "Clock driver for MediaTek MT6797 mmsys"
+	tristate "Clock driver for MediaTek MT6797 mmsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 mmsys clocks.
 
 config COMMON_CLK_MT6797_IMGSYS
-	bool "Clock driver for MediaTek MT6797 imgsys"
+	tristate "Clock driver for MediaTek MT6797 imgsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 imgsys clocks.
 
 config COMMON_CLK_MT6797_VDECSYS
-	bool "Clock driver for MediaTek MT6797 vdecsys"
+	tristate "Clock driver for MediaTek MT6797 vdecsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 vdecsys clocks.
 
 config COMMON_CLK_MT6797_VENCSYS
-	bool "Clock driver for MediaTek MT6797 vencsys"
+	tristate "Clock driver for MediaTek MT6797 vencsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 vencsys clocks.
-- 
2.39.1

