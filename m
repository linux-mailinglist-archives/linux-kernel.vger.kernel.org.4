Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1975E5E60
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiIVJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIVJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:19:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F317D1E8F;
        Thu, 22 Sep 2022 02:19:13 -0700 (PDT)
X-UUID: b9e4dc4136694cdd871de9b874bf9821-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DvwuvMPR+HiPCrZor2sUODVehSPwfTD03G3Wkp5HJcQ=;
        b=XyHmNSx8jhuoc9iyBIqVLctrGouS23Iqm5SnAZGFFoSWvTL2hUm+jvXvfFMjRGggvkxOLFK56+NELMVBqtkb75gL1JjXlagwBFHnaTvE6Kt1TazgFNr7CqPXSJug1Vx/daNK19Lj3IexiINt2bEP0UbKVfE+HxCbZ51UzzEz+gM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:db478aea-6084-4233-9740-ed6fc05c0612,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:db478aea-6084-4233-9740-ed6fc05c0612,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:f0beab06-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220922171908DVFSXOBT,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b9e4dc4136694cdd871de9b874bf9821-20220922
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2082868035; Thu, 22 Sep 2022 17:19:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 17:19:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Sep 2022 17:19:04 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 7/7] clk: mediatek: mt8192: add mtk_clk_simple_remove
Date:   Thu, 22 Sep 2022 17:18:35 +0800
Message-ID: <20220922091841.4099-8-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220922091841.4099-1-miles.chen@mediatek.com>
References: <20220922091841.4099-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8192 is already using mtk_clk_simple_probe,
but not mtk_clk_simple_remove.

Let's add mtk_clk_simple_remove for mt8192.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8192-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 1 +
 drivers/clk/mediatek/clk-mt8192-ipe.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-mdp.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-msdc.c         | 1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c     | 1 +
 drivers/clk/mediatek/clk-mt8192-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8192-venc.c         | 1 +
 10 files changed, 10 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index fc74cd80b4b0..90b57d46eef7 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -98,6 +98,7 @@ static const struct of_device_id of_match_clk_mt8192_cam[] = {
 
 static struct platform_driver clk_mt8192_cam_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-cam",
 		.of_match_table = of_match_clk_mt8192_cam,
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index 7ce3abe42577..da82d65a7650 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -61,6 +61,7 @@ static const struct of_device_id of_match_clk_mt8192_img[] = {
 
 static struct platform_driver clk_mt8192_img_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-img",
 		.of_match_table = of_match_clk_mt8192_img,
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index 700356ac6a58..ff8e20bb44bb 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -110,6 +110,7 @@ static const struct of_device_id of_match_clk_mt8192_imp_iic_wrap[] = {
 
 static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8192_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 730d91b64b3f..0225abe4170a 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -48,6 +48,7 @@ static const struct of_device_id of_match_clk_mt8192_ipe[] = {
 
 static struct platform_driver clk_mt8192_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-ipe",
 		.of_match_table = of_match_clk_mt8192_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index 93c87ae2f332..4675788d7816 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -73,6 +73,7 @@ static const struct of_device_id of_match_clk_mt8192_mdp[] = {
 
 static struct platform_driver clk_mt8192_mdp_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mdp",
 		.of_match_table = of_match_clk_mt8192_mdp,
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index 3bbc7469f0e4..24108229793d 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -41,6 +41,7 @@ static const struct of_device_id of_match_clk_mt8192_mfg[] = {
 
 static struct platform_driver clk_mt8192_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-mfg",
 		.of_match_table = of_match_clk_mt8192_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index 635f7a0b629a..a72e1b73fce8 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -55,6 +55,7 @@ static const struct of_device_id of_match_clk_mt8192_msdc[] = {
 
 static struct platform_driver clk_mt8192_msdc_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-msdc",
 		.of_match_table = of_match_clk_mt8192_msdc,
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index 58725d79dd13..18a8679108b8 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -41,6 +41,7 @@ static const struct of_device_id of_match_clk_mt8192_scp_adsp[] = {
 
 static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-scp_adsp",
 		.of_match_table = of_match_clk_mt8192_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index b1d95cfbf22a..e149962dbbf9 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -85,6 +85,7 @@ static const struct of_device_id of_match_clk_mt8192_vdec[] = {
 
 static struct platform_driver clk_mt8192_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-vdec",
 		.of_match_table = of_match_clk_mt8192_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index c0d867bff09e..80b8bb170996 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -44,6 +44,7 @@ static const struct of_device_id of_match_clk_mt8192_venc[] = {
 
 static struct platform_driver clk_mt8192_venc_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-venc",
 		.of_match_table = of_match_clk_mt8192_venc,
-- 
2.18.0

