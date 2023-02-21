Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E269DFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjBUL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjBUL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:58:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2D29170;
        Tue, 21 Feb 2023 03:57:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2723D66021E5;
        Tue, 21 Feb 2023 11:56:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980613;
        bh=fzooKQvESYuPtk0g9y109NqeJFBrEDX+1PU8Xf+76yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjdAjOriPDuLnwnVaH4+Tg8ADm+5199u8VlKJI0UaGcbdUGQ948/IhRhR5ugn2cRp
         vIs22sLlxKq/mBizKsZSkhThuo8j41wrNZetCg8Q9g0qa3RlZ9KgyXZbF5yVa3Zp28
         Vsnea2EiSgGgm9HWDj5dRRrz0tKycWXTEFZszsa8qB7OUObnuz3kCJuWJRenQ/w50F
         rAEdBUKOzLxYCq+US18TIR6IOP7Sn+bSfK1K+bHK7dBERFVaa3XJTfO3AyUVcKUjZO
         UeVP3vyUi8vfmwCVb1xxCDmbOjJ9ORtWjK2TY3mM/u7nFu7FmL0vt6WG180r4dWXjV
         ziftP5ETPQ61g==
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
Subject: [PATCH v4 44/54] clk: mediatek: Allow building most MT6765 clock drivers as modules
Date:   Tue, 21 Feb 2023 12:55:39 +0100
Message-Id: <20230221115549.360132-45-angelogioacchino.delregno@collabora.com>
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

Most of the MT6765 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index a8c2d4bace9a..a3260675cafc 100644
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

