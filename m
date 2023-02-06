Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4868C192
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBFPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjBFPbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:31:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E82BEDE;
        Mon,  6 Feb 2023 07:30:34 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C7876602F9F;
        Mon,  6 Feb 2023 15:30:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697432;
        bh=MMxOx9/T1rsiTKEF2rEmQXY4IrOILCdaZrzbsUlC4to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQAEng1O2k2UovyV27pKxlIZZGOeHYJhCqC0rdWWDn1P+kT87692NceXUYkXNqlxC
         PkH7+k1nS20ulPZ3e/rM1pya2+ry4zAdn89Ms9kJIEwKPTjXfYQaO/joeqJS0+/fFI
         jQqg6R7atY12e9dOdWR/uBP09G5k7LTcLFeLvvIISbyQi6xBTXGPlK7V/PMracanH2
         G4tecbKY0UHNWxdZ42pLj1JoarHOC6nOjLA51xdUlKoXzFdQwxaM8a09ZmhPyY0K1C
         3Dgdh/uHNA51x8LNPeGqpWzBam5Ir6ttoAyv9wBRDJfhqWJ1uTfEg+B/N1kuJwYhwx
         ZX5adDX+iw9uQ==
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
Subject: [PATCH v1 33/45] clk: mediatek: Switch to module_platform_driver() where possible
Date:   Mon,  6 Feb 2023 16:29:16 +0100
Message-Id: <20230206152928.918562-34-angelogioacchino.delregno@collabora.com>
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

Lots of clock drivers have got both .probe() and a .remove() callbacks:
switch from builtin_platform_driver() to module_platform_driver() so
that we actually register the .remove() callback.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-aud.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-bdp.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-eth.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-g3d.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-hif.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt2701-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt2701-vdec.c         | 3 +--
 drivers/clk/mediatek/clk-mt2712-bdp.c          | 3 +--
 drivers/clk/mediatek/clk-mt2712-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt2712-jpgdec.c       | 3 +--
 drivers/clk/mediatek/clk-mt2712-mfg.c          | 3 +--
 drivers/clk/mediatek/clk-mt2712-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt2712-vdec.c         | 3 +--
 drivers/clk/mediatek/clk-mt2712-venc.c         | 3 +--
 drivers/clk/mediatek/clk-mt6765-audio.c        | 3 +--
 drivers/clk/mediatek/clk-mt6765-cam.c          | 3 +--
 drivers/clk/mediatek/clk-mt6765-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt6765-mipi0a.c       | 3 +--
 drivers/clk/mediatek/clk-mt6765-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt6765-vcodec.c       | 3 +--
 drivers/clk/mediatek/clk-mt6797-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt6797-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt6797-vdec.c         | 3 +--
 drivers/clk/mediatek/clk-mt6797-venc.c         | 3 +--
 drivers/clk/mediatek/clk-mt7622-aud.c          | 3 +--
 drivers/clk/mediatek/clk-mt7622-eth.c          | 3 +--
 drivers/clk/mediatek/clk-mt7622-hif.c          | 3 +--
 drivers/clk/mediatek/clk-mt7629-eth.c          | 1 -
 drivers/clk/mediatek/clk-mt7629-hif.c          | 3 +--
 drivers/clk/mediatek/clk-mt7981-infracfg.c     | 2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c           | 2 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt8183-audio.c        | 3 +--
 drivers/clk/mediatek/clk-mt8183-cam.c          | 3 +--
 drivers/clk/mediatek/clk-mt8183-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt8183-ipu0.c         | 3 +--
 drivers/clk/mediatek/clk-mt8183-ipu1.c         | 3 +--
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c      | 3 +--
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c     | 3 +--
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c       | 3 +--
 drivers/clk/mediatek/clk-mt8183-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt8183-vdec.c         | 3 +--
 drivers/clk/mediatek/clk-mt8183-venc.c         | 3 +--
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c   | 2 +-
 drivers/clk/mediatek/clk-mt8186-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c     | 2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c           | 2 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-cam.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-img.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 3 +--
 drivers/clk/mediatek/clk-mt8192-ipe.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-mdp.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-mfg.c          | 3 +--
 drivers/clk/mediatek/clk-mt8192-mm.c           | 3 +--
 drivers/clk/mediatek/clk-mt8192-msdc.c         | 3 +--
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c     | 3 +--
 drivers/clk/mediatek/clk-mt8192-vdec.c         | 3 +--
 drivers/clk/mediatek/clk-mt8192-venc.c         | 3 +--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c   | 2 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c   | 2 +-
 drivers/clk/mediatek/clk-mt8195-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-img.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c     | 2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c      | 2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c     | 2 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c     | 2 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c         | 3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c         | 3 ++-
 drivers/clk/mediatek/clk-mt8195-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c         | 2 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c          | 2 +-
 drivers/clk/mediatek/clk-mt8365-mm.c           | 2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c         | 2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c         | 2 +-
 drivers/clk/mediatek/clk-mt8516-aud.c          | 2 +-
 98 files changed, 99 insertions(+), 151 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 9059e5aa473e..8ec2397f4ccb 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -167,5 +167,4 @@ static struct platform_driver clk_mt2701_aud_drv = {
 		.of_match_table = of_match_clk_mt2701_aud,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_aud_drv);
+module_platform_driver(clk_mt2701_aud_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 3e5a2241ee1d..16a28103a479 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -106,5 +106,4 @@ static struct platform_driver clk_mt2701_bdp_drv = {
 		.of_match_table = of_match_clk_mt2701_bdp,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_bdp_drv);
+module_platform_driver(clk_mt2701_bdp_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 54d9b57f308f..b4715f6911ee 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -59,5 +59,4 @@ static struct platform_driver clk_mt2701_eth_drv = {
 		.of_match_table = of_match_clk_mt2701_eth,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_eth_drv);
+module_platform_driver(clk_mt2701_eth_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index f071728a0ea4..abd6e07eb37b 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -58,5 +58,4 @@ static struct platform_driver clk_mt2701_g3d_drv = {
 		.of_match_table = of_match_clk_mt2701_g3d,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_g3d_drv);
+module_platform_driver(clk_mt2701_g3d_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 1ca42a3c5190..b7b96d221c96 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -56,5 +56,4 @@ static struct platform_driver clk_mt2701_hif_drv = {
 		.of_match_table = of_match_clk_mt2701_hif,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_hif_drv);
+module_platform_driver(clk_mt2701_hif_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index eb172473f075..776f470623ca 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -52,5 +52,4 @@ static struct platform_driver clk_mt2701_img_drv = {
 		.of_match_table = of_match_clk_mt2701_img,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_img_drv);
+module_platform_driver(clk_mt2701_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 993d904d619f..f23208b8dcba 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -85,5 +85,4 @@ static struct platform_driver clk_mt2701_mm_drv = {
 	},
 	.id_table = clk_mt2701_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt2701_mm_drv);
+module_platform_driver(clk_mt2701_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index 1a0504b04c22..aaed76513b54 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -59,5 +59,4 @@ static struct platform_driver clk_mt2701_vdec_drv = {
 		.of_match_table = of_match_clk_mt2701_vdec,
 	},
 };
-
-builtin_platform_driver(clk_mt2701_vdec_drv);
+module_platform_driver(clk_mt2701_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index b6d8086f8067..66517c0cc54b 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -75,5 +75,4 @@ static struct platform_driver clk_mt2712_bdp_drv = {
 		.of_match_table = of_match_clk_mt2712_bdp,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_bdp_drv);
+module_platform_driver(clk_mt2712_bdp_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 3ffa51384e6b..c16453c6b421 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -52,5 +52,4 @@ static struct platform_driver clk_mt2712_img_drv = {
 		.of_match_table = of_match_clk_mt2712_img,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_img_drv);
+module_platform_driver(clk_mt2712_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 97dc2ec8d9cf..8702b3b33028 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -49,5 +49,4 @@ static struct platform_driver clk_mt2712_jpgdec_drv = {
 		.of_match_table = of_match_clk_mt2712_jpgdec,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_jpgdec_drv);
+module_platform_driver(clk_mt2712_jpgdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 8949315c2dd2..d91d788babcf 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -47,5 +47,4 @@ static struct platform_driver clk_mt2712_mfg_drv = {
 		.of_match_table = of_match_clk_mt2712_mfg,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_mfg_drv);
+module_platform_driver(clk_mt2712_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 850cef9f2009..6245b79bab90 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -126,5 +126,4 @@ static struct platform_driver clk_mt2712_mm_drv = {
 	},
 	.id_table = clk_mt2712_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt2712_mm_drv);
+module_platform_driver(clk_mt2712_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 9519cec19a99..418193f8e12b 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -62,5 +62,4 @@ static struct platform_driver clk_mt2712_vdec_drv = {
 		.of_match_table = of_match_clk_mt2712_vdec,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_vdec_drv);
+module_platform_driver(clk_mt2712_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 2043b6d3ff1c..0e534733057a 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -50,5 +50,4 @@ static struct platform_driver clk_mt2712_venc_drv = {
 		.of_match_table = of_match_clk_mt2712_venc,
 	},
 };
-
-builtin_platform_driver(clk_mt2712_venc_drv);
+module_platform_driver(clk_mt2712_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 310dd32f4baa..55bbf94a8739 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -76,5 +76,4 @@ static struct platform_driver clk_mt6765_audio_drv = {
 		.of_match_table = of_match_clk_mt6765_audio,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_audio_drv);
+module_platform_driver(clk_mt6765_audio_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 7904f5f44e24..fe45f843de02 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -56,5 +56,4 @@ static struct platform_driver clk_mt6765_cam_drv = {
 		.of_match_table = of_match_clk_mt6765_cam,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_cam_drv);
+module_platform_driver(clk_mt6765_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index cfbc907988af..7c605dc155eb 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -51,5 +51,4 @@ static struct platform_driver clk_mt6765_img_drv = {
 		.of_match_table = of_match_clk_mt6765_img,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_img_drv);
+module_platform_driver(clk_mt6765_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index d6866a66ccef..01af9ff50482 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -49,5 +49,4 @@ static struct platform_driver clk_mt6765_mipi0a_drv = {
 		.of_match_table = of_match_clk_mt6765_mipi0a,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_mipi0a_drv);
+module_platform_driver(clk_mt6765_mipi0a_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index a4570c9dbefa..ec2b287cf1a3 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -77,5 +77,4 @@ static struct platform_driver clk_mt6765_mm_drv = {
 		.of_match_table = of_match_clk_mt6765_mm,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_mm_drv);
+module_platform_driver(clk_mt6765_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 3ce955bbeee2..ee035d8c97b9 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -51,5 +51,4 @@ static struct platform_driver clk_mt6765_vcodec_drv = {
 		.of_match_table = of_match_clk_mt6765_vcodec,
 	},
 };
-
-builtin_platform_driver(clk_mt6765_vcodec_drv);
+module_platform_driver(clk_mt6765_vcodec_drv);
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 06441393478f..d46a3a3ac3ad 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -48,5 +48,4 @@ static struct platform_driver clk_mt6797_img_drv = {
 		.of_match_table = of_match_clk_mt6797_img,
 	},
 };
-
-builtin_platform_driver(clk_mt6797_img_drv);
+module_platform_driver(clk_mt6797_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index e7a5a43f91f1..899a0e6fa988 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -98,5 +98,4 @@ static struct platform_driver clk_mt6797_mm_drv = {
 	},
 	.id_table = clk_mt6797_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt6797_mm_drv);
+module_platform_driver(clk_mt6797_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 1ed5da5c7286..1b6c14aef135 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -61,5 +61,4 @@ static struct platform_driver clk_mt6797_vdec_drv = {
 		.of_match_table = of_match_clk_mt6797_vdec,
 	},
 };
-
-builtin_platform_driver(clk_mt6797_vdec_drv);
+module_platform_driver(clk_mt6797_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 3da96e177ca5..d3b812d8f4e9 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -51,5 +51,4 @@ static struct platform_driver clk_mt6797_venc_drv = {
 		.of_match_table = of_match_clk_mt6797_venc,
 	},
 };
-
-builtin_platform_driver(clk_mt6797_venc_drv);
+module_platform_driver(clk_mt6797_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index f676581edbfe..92b93c469f02 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -158,5 +158,4 @@ static struct platform_driver clk_mt7622_aud_drv = {
 		.of_match_table = of_match_clk_mt7622_aud,
 	},
 };
-
-builtin_platform_driver(clk_mt7622_aud_drv);
+module_platform_driver(clk_mt7622_aud_drv);
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index bd248277cef7..f15ab29a4c7b 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -88,5 +88,4 @@ static struct platform_driver clk_mt7622_eth_drv = {
 		.of_match_table = of_match_clk_mt7622_eth,
 	},
 };
-
-builtin_platform_driver(clk_mt7622_eth_drv);
+module_platform_driver(clk_mt7622_eth_drv);
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 33a34576d726..78c0a1aa419e 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -100,5 +100,4 @@ static struct platform_driver clk_mt7622_hif_drv = {
 		.of_match_table = of_match_clk_mt7622_hif,
 	},
 };
-
-builtin_platform_driver(clk_mt7622_hif_drv);
+module_platform_driver(clk_mt7622_hif_drv);
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index cc605cd2d376..7c7292fd521a 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -154,5 +154,4 @@ static struct platform_driver clk_mt7629_eth_drv = {
 		.of_match_table = of_match_clk_mt7629_eth,
 	},
 };
-
 builtin_platform_driver(clk_mt7629_eth_drv);
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 497628bd8c29..35fb2e5ca95c 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -95,5 +95,4 @@ static struct platform_driver clk_mt7629_hif_drv = {
 		.of_match_table = of_match_clk_mt7629_hif,
 	},
 };
-
-builtin_platform_driver(clk_mt7629_hif_drv);
+module_platform_driver(clk_mt7629_hif_drv);
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 8cf5057419e8..35cd126408b6 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -204,4 +204,4 @@ static struct platform_driver clk_mt7981_infracfg_drv = {
 		.of_match_table = of_match_clk_mt7981_infracfg,
 	},
 };
-builtin_platform_driver(clk_mt7981_infracfg_drv);
+module_platform_driver(clk_mt7981_infracfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 74634d65f5f6..f4c31cb1c74e 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -419,4 +419,4 @@ static struct platform_driver clk_mt7981_topckgen_drv = {
 		.of_match_table = of_match_clk_mt7981_topckgen,
 	},
 };
-builtin_platform_driver(clk_mt7981_topckgen_drv);
+module_platform_driver(clk_mt7981_topckgen_drv);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index dff9976fa689..dacaf5492286 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -313,4 +313,4 @@ static struct platform_driver clk_mt7986_topckgen_drv = {
 		.of_match_table = of_match_clk_mt7986_topckgen,
 	},
 };
-builtin_platform_driver(clk_mt7986_topckgen_drv);
+module_platform_driver(clk_mt7986_topckgen_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 5a5192d0dc45..de6c2283b695 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -92,4 +92,4 @@ static struct platform_driver clk_mt8167_mm_drv = {
 	},
 	.id_table = clk_mt8167_mm_id_table,
 };
-builtin_platform_driver(clk_mt8167_mm_drv);
+module_platform_driver(clk_mt8167_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index f4ae8d98c43a..1980269ba30a 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -62,4 +62,4 @@ static struct platform_driver clk_mt8167_vdec_drv = {
 		.of_match_table = of_match_clk_mt8167_vdec,
 	},
 };
-builtin_platform_driver(clk_mt8167_vdec_drv);
+module_platform_driver(clk_mt8167_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 435cfae25492..ba51c22cbe7a 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -107,8 +107,7 @@ static struct platform_driver clk_mt8173_mm_drv = {
 	.probe = mtk_clk_pdev_probe,
 	.remove = mtk_clk_pdev_remove,
 };
-
-builtin_platform_driver(clk_mt8173_mm_drv);
+module_platform_driver(clk_mt8173_mm_drv);
 
 MODULE_DESCRIPTION("MediaTek MT8173 MultiMedia clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 3f1630290b93..24cc2178c769 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -106,5 +106,4 @@ static struct platform_driver clk_mt8183_audio_drv = {
 		.of_match_table = of_match_clk_mt8183_audio,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_audio_drv);
+module_platform_driver(clk_mt8183_audio_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index 6907b1a6a824..7ff183da0075 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -56,5 +56,4 @@ static struct platform_driver clk_mt8183_cam_drv = {
 		.of_match_table = of_match_clk_mt8183_cam,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_cam_drv);
+module_platform_driver(clk_mt8183_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 8d884425d79f..e4a9d3201e33 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -56,5 +56,4 @@ static struct platform_driver clk_mt8183_img_drv = {
 		.of_match_table = of_match_clk_mt8183_img,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_img_drv);
+module_platform_driver(clk_mt8183_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index 953a8a33d048..68d4cda89d6f 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -49,5 +49,4 @@ static struct platform_driver clk_mt8183_ipu_core0_drv = {
 		.of_match_table = of_match_clk_mt8183_ipu_core0,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_ipu_core0_drv);
+module_platform_driver(clk_mt8183_ipu_core0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 221d12265974..50950bed9226 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -49,5 +49,4 @@ static struct platform_driver clk_mt8183_ipu_core1_drv = {
 		.of_match_table = of_match_clk_mt8183_ipu_core1,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_ipu_core1_drv);
+module_platform_driver(clk_mt8183_ipu_core1_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 8c4fd96df821..2044d5c664b8 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -47,5 +47,4 @@ static struct platform_driver clk_mt8183_ipu_adl_drv = {
 		.of_match_table = of_match_clk_mt8183_ipu_adl,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_ipu_adl_drv);
+module_platform_driver(clk_mt8183_ipu_adl_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index 14a4c3ff82a1..6e7833656c9a 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -116,5 +116,4 @@ static struct platform_driver clk_mt8183_ipu_conn_drv = {
 		.of_match_table = of_match_clk_mt8183_ipu_conn,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_ipu_conn_drv);
+module_platform_driver(clk_mt8183_ipu_conn_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 730c9ae5ea12..5a71ef094e03 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -48,5 +48,4 @@ static struct platform_driver clk_mt8183_mfg_drv = {
 		.of_match_table = of_match_clk_mt8183_mfg,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_mfg_drv);
+module_platform_driver(clk_mt8183_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 669dcdd66efb..25a04f311dc3 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -100,5 +100,4 @@ static struct platform_driver clk_mt8183_mm_drv = {
 	},
 	.id_table = clk_mt8183_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt8183_mm_drv);
+module_platform_driver(clk_mt8183_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index c294e50b96b7..4c56d02a9d34 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -60,5 +60,4 @@ static struct platform_driver clk_mt8183_vdec_drv = {
 		.of_match_table = of_match_clk_mt8183_vdec,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_vdec_drv);
+module_platform_driver(clk_mt8183_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 0051c5d92fc5..5b86d7d42613 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -52,5 +52,4 @@ static struct platform_driver clk_mt8183_venc_drv = {
 		.of_match_table = of_match_clk_mt8183_venc,
 	},
 };
-
-builtin_platform_driver(clk_mt8183_venc_drv);
+module_platform_driver(clk_mt8183_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index 9fded5020ca4..ab500b985900 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -192,4 +192,4 @@ static struct platform_driver clk_mt8186_apmixed_drv = {
 		.of_match_table = of_match_clk_mt8186_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt8186_apmixed_drv);
+module_platform_driver(clk_mt8186_apmixed_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
index 9ec345a2ce66..220c8af7848e 100644
--- a/drivers/clk/mediatek/clk-mt8186-cam.c
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -87,4 +87,4 @@ static struct platform_driver clk_mt8186_cam_drv = {
 		.of_match_table = of_match_clk_mt8186_cam,
 	},
 };
-builtin_platform_driver(clk_mt8186_cam_drv);
+module_platform_driver(clk_mt8186_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
index 08a625475aee..bac0e52bd51c 100644
--- a/drivers/clk/mediatek/clk-mt8186-img.c
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -65,4 +65,4 @@ static struct platform_driver clk_mt8186_img_drv = {
 		.of_match_table = of_match_clk_mt8186_img,
 	},
 };
-builtin_platform_driver(clk_mt8186_img_drv);
+module_platform_driver(clk_mt8186_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 47f2e480a05e..9301dc3e86fb 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -64,4 +64,4 @@ static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
 		.of_match_table = of_match_clk_mt8186_imp_iic_wrap,
 	},
 };
-builtin_platform_driver(clk_mt8186_imp_iic_wrap_drv);
+module_platform_driver(clk_mt8186_imp_iic_wrap_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index df2a6bd1aefa..e705d57032a6 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -236,4 +236,4 @@ static struct platform_driver clk_mt8186_infra_ao_drv = {
 		.of_match_table = of_match_clk_mt8186_infra_ao,
 	},
 };
-builtin_platform_driver(clk_mt8186_infra_ao_drv);
+module_platform_driver(clk_mt8186_infra_ao_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
index 8fca148effa6..36f6338f8237 100644
--- a/drivers/clk/mediatek/clk-mt8186-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -52,4 +52,4 @@ static struct platform_driver clk_mt8186_ipe_drv = {
 		.of_match_table = of_match_clk_mt8186_ipe,
 	},
 };
-builtin_platform_driver(clk_mt8186_ipe_drv);
+module_platform_driver(clk_mt8186_ipe_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
index 05174088ef20..faf5cdc7523f 100644
--- a/drivers/clk/mediatek/clk-mt8186-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -77,4 +77,4 @@ static struct platform_driver clk_mt8186_mdp_drv = {
 		.of_match_table = of_match_clk_mt8186_mdp,
 	},
 };
-builtin_platform_driver(clk_mt8186_mdp_drv);
+module_platform_driver(clk_mt8186_mdp_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index 0142d741053a..468fa7e37074 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -46,4 +46,4 @@ static struct platform_driver clk_mt8186_mfg_drv = {
 		.of_match_table = of_match_clk_mt8186_mfg,
 	},
 };
-builtin_platform_driver(clk_mt8186_mfg_drv);
+module_platform_driver(clk_mt8186_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 6506a8b848a9..03dfb4d99930 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -75,4 +75,4 @@ static struct platform_driver clk_mt8186_mm_drv = {
 	},
 	.id_table = clk_mt8186_mm_id_table,
 };
-builtin_platform_driver(clk_mt8186_mm_drv);
+module_platform_driver(clk_mt8186_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index c6786c8b315f..7f2a59347166 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -730,4 +730,4 @@ static struct platform_driver clk_mt8186_topck_drv = {
 		.of_match_table = of_match_clk_mt8186_topck,
 	},
 };
-builtin_platform_driver(clk_mt8186_topck_drv);
+module_platform_driver(clk_mt8186_topck_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
index 5ad7e1ae0bac..76e226be8f72 100644
--- a/drivers/clk/mediatek/clk-mt8186-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -85,4 +85,4 @@ static struct platform_driver clk_mt8186_vdec_drv = {
 		.of_match_table = of_match_clk_mt8186_vdec,
 	},
 };
-builtin_platform_driver(clk_mt8186_vdec_drv);
+module_platform_driver(clk_mt8186_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
index f5519f794c45..96c15b859e37 100644
--- a/drivers/clk/mediatek/clk-mt8186-venc.c
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -48,4 +48,4 @@ static struct platform_driver clk_mt8186_venc_drv = {
 		.of_match_table = of_match_clk_mt8186_venc,
 	},
 };
-builtin_platform_driver(clk_mt8186_venc_drv);
+module_platform_driver(clk_mt8186_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
index 8db3e9178a1e..dbd8a81b170d 100644
--- a/drivers/clk/mediatek/clk-mt8186-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
@@ -48,4 +48,4 @@ static struct platform_driver clk_mt8186_wpe_drv = {
 		.of_match_table = of_match_clk_mt8186_wpe,
 	},
 };
-builtin_platform_driver(clk_mt8186_wpe_drv);
+module_platform_driver(clk_mt8186_wpe_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 29affb68e854..deb292cc9da1 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -116,5 +116,4 @@ static struct platform_driver clk_mt8192_aud_drv = {
 		.of_match_table = of_match_clk_mt8192_aud,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_aud_drv);
+module_platform_driver(clk_mt8192_aud_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index 90b57d46eef7..00dbd0d27fbc 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -104,5 +104,4 @@ static struct platform_driver clk_mt8192_cam_drv = {
 		.of_match_table = of_match_clk_mt8192_cam,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_cam_drv);
+module_platform_driver(clk_mt8192_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index da82d65a7650..00abbec6c666 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -67,5 +67,4 @@ static struct platform_driver clk_mt8192_img_drv = {
 		.of_match_table = of_match_clk_mt8192_img,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_img_drv);
+module_platform_driver(clk_mt8192_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index ff8e20bb44bb..6663b70a5d47 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -116,5 +116,4 @@ static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 		.of_match_table = of_match_clk_mt8192_imp_iic_wrap,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_imp_iic_wrap_drv);
+module_platform_driver(clk_mt8192_imp_iic_wrap_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 0225abe4170a..6a8d3fb7e0c5 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -54,5 +54,4 @@ static struct platform_driver clk_mt8192_ipe_drv = {
 		.of_match_table = of_match_clk_mt8192_ipe,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_ipe_drv);
+module_platform_driver(clk_mt8192_ipe_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index 4675788d7816..782f83fbe97b 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -79,5 +79,4 @@ static struct platform_driver clk_mt8192_mdp_drv = {
 		.of_match_table = of_match_clk_mt8192_mdp,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_mdp_drv);
+module_platform_driver(clk_mt8192_mdp_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index ec5b44ffa458..c007e561f008 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -49,5 +49,4 @@ static struct platform_driver clk_mt8192_mfg_drv = {
 		.of_match_table = of_match_clk_mt8192_mfg,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_mfg_drv);
+module_platform_driver(clk_mt8192_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 638e6faae84c..184d7fb82abc 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -98,5 +98,4 @@ static struct platform_driver clk_mt8192_mm_drv = {
 	},
 	.id_table = clk_mt8192_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt8192_mm_drv);
+module_platform_driver(clk_mt8192_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index a72e1b73fce8..cb21a40dfe83 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -61,5 +61,4 @@ static struct platform_driver clk_mt8192_msdc_drv = {
 		.of_match_table = of_match_clk_mt8192_msdc,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_msdc_drv);
+module_platform_driver(clk_mt8192_msdc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 18a8679108b8..b7aa68e6c555 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -47,5 +47,4 @@ static struct platform_driver clk_mt8192_scp_adsp_drv = {
 		.of_match_table = of_match_clk_mt8192_scp_adsp,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_scp_adsp_drv);
+module_platform_driver(clk_mt8192_scp_adsp_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index e149962dbbf9..9ddc6e99c8d7 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -91,5 +91,4 @@ static struct platform_driver clk_mt8192_vdec_drv = {
 		.of_match_table = of_match_clk_mt8192_vdec,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_vdec_drv);
+module_platform_driver(clk_mt8192_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index 80b8bb170996..67136a341d77 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -50,5 +50,4 @@ static struct platform_driver clk_mt8192_venc_drv = {
 		.of_match_table = of_match_clk_mt8192_venc,
 	},
 };
-
-builtin_platform_driver(clk_mt8192_venc_drv);
+module_platform_driver(clk_mt8192_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index c0db31ce0741..29124ed9398b 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -230,4 +230,4 @@ static struct platform_driver clk_mt8195_apmixed_drv = {
 		.of_match_table = of_match_clk_mt8195_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt8195_apmixed_drv);
+module_platform_driver(clk_mt8195_apmixed_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 0b52f6a009c4..ca60d90e5257 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -110,4 +110,4 @@ static struct platform_driver clk_mt8195_apusys_pll_drv = {
 		.of_match_table = of_match_clk_mt8195_apusys_pll,
 	},
 };
-builtin_platform_driver(clk_mt8195_apusys_pll_drv);
+module_platform_driver(clk_mt8195_apusys_pll_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index e4d00fe6e757..c0fd32270a8e 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -140,4 +140,4 @@ static struct platform_driver clk_mt8195_cam_drv = {
 		.of_match_table = of_match_clk_mt8195_cam,
 	},
 };
-builtin_platform_driver(clk_mt8195_cam_drv);
+module_platform_driver(clk_mt8195_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index 4e326b6301ba..9e8220bcdf9f 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -48,4 +48,4 @@ static struct platform_driver clk_mt8195_ccu_drv = {
 		.of_match_table = of_match_clk_mt8195_ccu,
 	},
 };
-builtin_platform_driver(clk_mt8195_ccu_drv);
+module_platform_driver(clk_mt8195_ccu_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index 12f5c436d075..822efce6f79b 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -94,4 +94,4 @@ static struct platform_driver clk_mt8195_img_drv = {
 		.of_match_table = of_match_clk_mt8195_img,
 	},
 };
-builtin_platform_driver(clk_mt8195_img_drv);
+module_platform_driver(clk_mt8195_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index fbc809d05072..01f8fab27c22 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -64,4 +64,4 @@ static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
 	},
 };
-builtin_platform_driver(clk_mt8195_imp_iic_wrap_drv);
+module_platform_driver(clk_mt8195_imp_iic_wrap_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index fcd410461d3b..75084251ea74 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -238,4 +238,4 @@ static struct platform_driver clk_mt8195_infra_ao_drv = {
 		.of_match_table = of_match_clk_mt8195_infra_ao,
 	},
 };
-builtin_platform_driver(clk_mt8195_infra_ao_drv);
+module_platform_driver(clk_mt8195_infra_ao_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index b0d745cf7752..b713fea470dd 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -49,4 +49,4 @@ static struct platform_driver clk_mt8195_ipe_drv = {
 		.of_match_table = of_match_clk_mt8195_ipe,
 	},
 };
-builtin_platform_driver(clk_mt8195_ipe_drv);
+module_platform_driver(clk_mt8195_ipe_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index c94cb71bd9b9..fcd2d0b7e3c9 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -47,4 +47,4 @@ static struct platform_driver clk_mt8195_mfg_drv = {
 		.of_match_table = of_match_clk_mt8195_mfg,
 	},
 };
-builtin_platform_driver(clk_mt8195_mfg_drv);
+module_platform_driver(clk_mt8195_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index 2f6b3bb657db..f66fbea2e080 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -60,4 +60,4 @@ static struct platform_driver clk_mt8195_peri_ao_drv = {
 		.of_match_table = of_match_clk_mt8195_peri_ao,
 	},
 };
-builtin_platform_driver(clk_mt8195_peri_ao_drv);
+module_platform_driver(clk_mt8195_peri_ao_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index e16c383f631b..1987172c98a4 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -45,4 +45,4 @@ static struct platform_driver clk_mt8195_scp_adsp_drv = {
 		.of_match_table = of_match_clk_mt8195_scp_adsp,
 	},
 };
-builtin_platform_driver(clk_mt8195_scp_adsp_drv);
+module_platform_driver(clk_mt8195_scp_adsp_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index cf520f85de73..a9bb7e4687ec 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1340,4 +1340,4 @@ static struct platform_driver clk_mt8195_topck_drv = {
 		.of_match_table = of_match_clk_mt8195_topck,
 	},
 };
-builtin_platform_driver(clk_mt8195_topck_drv);
+module_platform_driver(clk_mt8195_topck_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index a1446b666385..a75ea99a9a4c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -102,4 +102,4 @@ static struct platform_driver clk_mt8195_vdec_drv = {
 		.of_match_table = of_match_clk_mt8195_vdec,
 	},
 };
-builtin_platform_driver(clk_mt8195_vdec_drv);
+module_platform_driver(clk_mt8195_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 492c1e133d0d..1ed152b072bd 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -102,6 +102,7 @@ static const struct platform_device_id clk_mt8195_vdo0_id_table[] = {
 	{ .name = "clk-mt8195-vdo0", .driver_data = (kernel_ulong_t)&vdo0_desc },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(platform, clk_mt8195_vdo0_id_table);
 
 static struct platform_driver clk_mt8195_vdo0_drv = {
 	.probe = mtk_clk_pdev_probe,
@@ -111,4 +112,4 @@ static struct platform_driver clk_mt8195_vdo0_drv = {
 	},
 	.id_table = clk_mt8195_vdo0_id_table,
 };
-builtin_platform_driver(clk_mt8195_vdo0_drv);
+module_platform_driver(clk_mt8195_vdo0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 76e9f4496e43..cbd0a34884c7 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -129,6 +129,7 @@ static const struct platform_device_id clk_mt8195_vdo1_id_table[] = {
 	{ .name = "clk-mt8195-vdo1", .driver_data = (kernel_ulong_t)&vdo1_desc },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(platform, clk_mt8195_vdo1_id_table);
 
 static struct platform_driver clk_mt8195_vdo1_drv = {
 	.probe = mtk_clk_pdev_probe,
@@ -138,4 +139,4 @@ static struct platform_driver clk_mt8195_vdo1_drv = {
 	},
 	.id_table = clk_mt8195_vdo1_id_table,
 };
-builtin_platform_driver(clk_mt8195_vdo1_drv);
+module_platform_driver(clk_mt8195_vdo1_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 622f57804f96..8b46cbe9ce83 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -67,4 +67,4 @@ static struct platform_driver clk_mt8195_venc_drv = {
 		.of_match_table = of_match_clk_mt8195_venc,
 	},
 };
-builtin_platform_driver(clk_mt8195_venc_drv);
+module_platform_driver(clk_mt8195_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index bf2939c3a023..32d1e8a16c18 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -108,4 +108,4 @@ static struct platform_driver clk_mt8195_vpp0_drv = {
 		.of_match_table = of_match_clk_mt8195_vpp0,
 	},
 };
-builtin_platform_driver(clk_mt8195_vpp0_drv);
+module_platform_driver(clk_mt8195_vpp0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index ffd52c762890..2d2f7c22ec5c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -106,4 +106,4 @@ static struct platform_driver clk_mt8195_vpp1_drv = {
 		.of_match_table = of_match_clk_mt8195_vpp1,
 	},
 };
-builtin_platform_driver(clk_mt8195_vpp1_drv);
+module_platform_driver(clk_mt8195_vpp1_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index b483fab10e18..8878b5ef9e44 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -141,4 +141,4 @@ static struct platform_driver clk_mt8195_wpe_drv = {
 		.of_match_table = of_match_clk_mt8195_wpe,
 	},
 };
-builtin_platform_driver(clk_mt8195_wpe_drv);
+module_platform_driver(clk_mt8195_wpe_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-apu.c b/drivers/clk/mediatek/clk-mt8365-apu.c
index 91ffe89d9721..5a594f8eccdc 100644
--- a/drivers/clk/mediatek/clk-mt8365-apu.c
+++ b/drivers/clk/mediatek/clk-mt8365-apu.c
@@ -51,5 +51,5 @@ static struct platform_driver clk_mt8365_apu_drv = {
 		.of_match_table = of_match_clk_mt8365_apu,
 	},
 };
-builtin_platform_driver(clk_mt8365_apu_drv);
+module_platform_driver(clk_mt8365_apu_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-cam.c b/drivers/clk/mediatek/clk-mt8365-cam.c
index 31d5b5cd6de1..ed1d8dd7043c 100644
--- a/drivers/clk/mediatek/clk-mt8365-cam.c
+++ b/drivers/clk/mediatek/clk-mt8365-cam.c
@@ -53,5 +53,5 @@ static struct platform_driver clk_mt8365_cam_drv = {
 		.of_match_table = of_match_clk_mt8365_cam,
 	},
 };
-builtin_platform_driver(clk_mt8365_cam_drv);
+module_platform_driver(clk_mt8365_cam_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-mfg.c b/drivers/clk/mediatek/clk-mt8365-mfg.c
index 587b49128b03..b3d10b017f0d 100644
--- a/drivers/clk/mediatek/clk-mt8365-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8365-mfg.c
@@ -59,5 +59,5 @@ static struct platform_driver clk_mt8365_mfg_drv = {
 		.of_match_table = of_match_clk_mt8365_mfg,
 	},
 };
-builtin_platform_driver(clk_mt8365_mfg_drv);
+module_platform_driver(clk_mt8365_mfg_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 9569be54127c..7ae33997ba86 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -90,5 +90,5 @@ static struct platform_driver clk_mt8365_mm_drv = {
 	},
 	.id_table = clk_mt8365_mm_id_table,
 };
-builtin_platform_driver(clk_mt8365_mm_drv);
+module_platform_driver(clk_mt8365_mm_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-vdec.c b/drivers/clk/mediatek/clk-mt8365-vdec.c
index cdc678e8941c..d5caddcc5932 100644
--- a/drivers/clk/mediatek/clk-mt8365-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8365-vdec.c
@@ -59,5 +59,5 @@ static struct platform_driver clk_mt8365_vdec_drv = {
 		.of_match_table = of_match_clk_mt8365_vdec,
 	},
 };
-builtin_platform_driver(clk_mt8365_vdec_drv);
+module_platform_driver(clk_mt8365_vdec_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-venc.c b/drivers/clk/mediatek/clk-mt8365-venc.c
index 0e080c22119d..08b7c0ee52e7 100644
--- a/drivers/clk/mediatek/clk-mt8365-venc.c
+++ b/drivers/clk/mediatek/clk-mt8365-venc.c
@@ -48,5 +48,5 @@ static struct platform_driver clk_mt8365_venc_drv = {
 		.of_match_table = of_match_clk_mt8365_venc,
 	},
 };
-builtin_platform_driver(clk_mt8365_venc_drv);
+module_platform_driver(clk_mt8365_venc_drv);
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 25ffdba741d8..9baa498f1711 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -61,7 +61,7 @@ static struct platform_driver clk_mt8516_aud_drv = {
 		.of_match_table = of_match_clk_mt8516_aud,
 	},
 };
-builtin_platform_driver(clk_mt8516_aud_drv);
+module_platform_driver(clk_mt8516_aud_drv);
 
 MODULE_DESCRIPTION("MediaTek MT8516 audiosys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.39.1

