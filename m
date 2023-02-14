Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452269652B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBNNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjBNNnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:43:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF385247;
        Tue, 14 Feb 2023 05:42:54 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CB1266021A0;
        Tue, 14 Feb 2023 13:42:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382158;
        bh=AXqX968TBKOM3eXq4Eobvq/6nMoQsQ7ZOJPn9J7khw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9K4g8htBOGB+7NFti9EC6Krjql+TR4K44mh14xNIdBrPY0dRxsiNsHF9HJzjyuj/
         U6nh7sECKKj0Sgbme3RQZSCVcEZVRaClmYf2DSKpYJ3id4zvfpHVayQyPfxVLxzatK
         /B2kngr6K0YciQNm6scejic/vYctH/in6G0xkCGrzL61jlJee0CsjQzlpAJxkKKy2K
         TZFkgXy8kaPJPTKx7Eb8+bd9uHlnGfuNoeqLuFgNauVuJPKpaYqHxpNbEmZLNPSDp9
         jinkFd5RgOvHomt917ysKE2x77sh81+2Eg/TvgK/NGG03ipPDZZjq0nPveotgVNunp
         ActWFM8A7AC7Q==
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
Subject: [PATCH v2 43/47] clk: mediatek: Allow building most MT6797 clock drivers as modules
Date:   Tue, 14 Feb 2023 14:41:23 +0100
Message-Id: <20230214134127.59273-44-angelogioacchino.delregno@collabora.com>
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

Most of the MT6797 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5444af1570ae..1497171a65ef 100644
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

