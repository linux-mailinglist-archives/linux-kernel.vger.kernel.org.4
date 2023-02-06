Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4F68C19F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjBFPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBFPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:32:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AB2A156;
        Mon,  6 Feb 2023 07:30:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9AC86602FA1;
        Mon,  6 Feb 2023 15:30:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697442;
        bh=Fj6wRRRqEs8IY2MV0RP2l4XtY1i3b2reHY98Krc418s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjiSW39ki7gq8ziHM6U6Noh2UJxyRXDn5WyET4QgtF6QcfR5ETugeZmr0xtA7Mndu
         DYgicI2C+gIg8ZiOR+3STIzVcEg5etZPWrQhJSPBmLPzQPk3BJs0rK71yADV5Mayqg
         CtSoT2kebATk0NVtj8bwzDYt7AeJHNQKhdIe7vqU9nkmMGyWqre0AZ1wUmP0CDo6XO
         sfS+CAykWNvHn3618whi1JTxiHCU5GaNomQDMgW9pMe0XxHmpQzDexm1I2G51SG6m3
         CfUmIZIZrSSpYxBQZMhznv17WL88bnpi8hsR2J3IOaNHafPymOB0tQwCASivi7XboH
         9Qk6ZDbhMPZsQ==
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
Subject: [PATCH v1 40/45] clk: mediatek: Allow building most MT6765 clock drivers as modules
Date:   Mon,  6 Feb 2023 16:29:23 +0100
Message-Id: <20230206152928.918562-41-angelogioacchino.delregno@collabora.com>
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

Most of the MT6765 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 4a05b210624d..5444af1570ae 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -133,79 +133,79 @@ config COMMON_CLK_MT6765
          This driver supports MediaTek MT6765 basic clocks.
 
 config COMMON_CLK_MT6765_AUDIOSYS
-       bool "Clock driver for MediaTek MT6765 audiosys"
+       tristate "Clock driver for MediaTek MT6765 audiosys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 audiosys clocks.
 
 config COMMON_CLK_MT6765_CAMSYS
-       bool "Clock driver for MediaTek MT6765 camsys"
+       tristate "Clock driver for MediaTek MT6765 camsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 camsys clocks.
 
 config COMMON_CLK_MT6765_GCESYS
-       bool "Clock driver for MediaTek MT6765 gcesys"
+       tristate "Clock driver for MediaTek MT6765 gcesys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 gcesys clocks.
 
 config COMMON_CLK_MT6765_MMSYS
-       bool "Clock driver for MediaTek MT6765 mmsys"
+       tristate "Clock driver for MediaTek MT6765 mmsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mmsys clocks.
 
 config COMMON_CLK_MT6765_IMGSYS
-       bool "Clock driver for MediaTek MT6765 imgsys"
+       tristate "Clock driver for MediaTek MT6765 imgsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 imgsys clocks.
 
 config COMMON_CLK_MT6765_VCODECSYS
-       bool "Clock driver for MediaTek MT6765 vcodecsys"
+       tristate "Clock driver for MediaTek MT6765 vcodecsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 vcodecsys clocks.
 
 config COMMON_CLK_MT6765_MFGSYS
-       bool "Clock driver for MediaTek MT6765 mfgsys"
+       tristate "Clock driver for MediaTek MT6765 mfgsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mfgsys clocks.
 
 config COMMON_CLK_MT6765_MIPI0ASYS
-       bool "Clock driver for MediaTek MT6765 mipi0asys"
+       tristate "Clock driver for MediaTek MT6765 mipi0asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0asys clocks.
 
 config COMMON_CLK_MT6765_MIPI0BSYS
-       bool "Clock driver for MediaTek MT6765 mipi0bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi0bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0bsys clocks.
 
 config COMMON_CLK_MT6765_MIPI1ASYS
-       bool "Clock driver for MediaTek MT6765 mipi1asys"
+       tristate "Clock driver for MediaTek MT6765 mipi1asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi1asys clocks.
 
 config COMMON_CLK_MT6765_MIPI1BSYS
-       bool "Clock driver for MediaTek MT6765 mipi1bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi1bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi1bsys clocks.
 
 config COMMON_CLK_MT6765_MIPI2ASYS
-       bool "Clock driver for MediaTek MT6765 mipi2asys"
+       tristate "Clock driver for MediaTek MT6765 mipi2asys"
        depends on COMMON_CLK_MT6765
       help
          This driver supports MediaTek MT6765 mipi2asys clocks.
 
 config COMMON_CLK_MT6765_MIPI2BSYS
-       bool "Clock driver for MediaTek MT6765 mipi2bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi2bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi2bsys clocks.
-- 
2.39.1

