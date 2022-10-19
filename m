Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F708604BED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiJSPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiJSPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:43:13 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8D60C87
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:38:51 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olB8j-00015j-Gi; Wed, 19 Oct 2022 17:37:53 +0200
Date:   Wed, 19 Oct 2022 16:37:44 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phy: phy-mtk-tphy: Add PCIe 2 lane efuse support
Message-ID: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhanyong Wang <zhanyong.wang@mediatek.com>

Add PCIe 2 lane efuse support in tphy driver.

Signed-off-by: Jie Yang <jieyy.yang@mediatek.com>
Signed-off-by: Zhanyong Wang <zhanyong.wang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 112 ++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index e906a82791bdaa..b0c9834efec7ef 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -43,6 +43,15 @@
 #define SSUSB_SIFSLV_V2_U3PHYD		0x200
 #define SSUSB_SIFSLV_V2_U3PHYA		0x400
 
+/* version V4 sub-banks offset base address */
+/* pcie phy banks */
+#define SSUSB_SIFSLV_V4_SPLLC		0x000
+#define SSUSB_SIFSLV_V4_CHIP		0x100
+#define SSUSB_SIFSLV_V4_U3PHYD		0x900
+#define SSUSB_SIFSLV_V4_U3PHYA		0xb00
+
+#define SSUSB_LN1_OFFSET		0x10000
+
 #define U3P_MISC_REG1		0x04
 #define MR1_EFUSE_AUTO_LOAD_DIS		BIT(6)
 
@@ -268,6 +277,7 @@ enum mtk_phy_version {
 	MTK_PHY_V1 = 1,
 	MTK_PHY_V2,
 	MTK_PHY_V3,
+	MTK_PHY_V4,
 };
 
 struct mtk_phy_pdata {
@@ -317,6 +327,9 @@ struct mtk_phy_instance {
 	u32 efuse_intr;
 	u32 efuse_tx_imp;
 	u32 efuse_rx_imp;
+	u32 efuse_intr_ln1;
+	u32 efuse_tx_imp_ln1;
+	u32 efuse_rx_imp_ln1;
 	int eye_src;
 	int eye_vrt;
 	int eye_term;
@@ -760,6 +773,36 @@ static void phy_v2_banks_init(struct mtk_tphy *tphy,
 	}
 }
 
+static void phy_v4_banks_init(struct mtk_tphy *tphy,
+			      struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	struct u3phy_banks *u3_banks = &instance->u3_banks;
+
+	switch (instance->type) {
+	case PHY_TYPE_USB2:
+		u2_banks->misc = instance->port_base + SSUSB_SIFSLV_V2_MISC;
+		u2_banks->fmreg = instance->port_base + SSUSB_SIFSLV_V2_U2FREQ;
+		u2_banks->com = instance->port_base + SSUSB_SIFSLV_V2_U2PHY_COM;
+		break;
+	case PHY_TYPE_USB3:
+		u3_banks->spllc = instance->port_base + SSUSB_SIFSLV_V2_SPLLC;
+		u3_banks->chip = instance->port_base + SSUSB_SIFSLV_V2_CHIP;
+		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V2_U3PHYD;
+		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V2_U3PHYA;
+		break;
+	case PHY_TYPE_PCIE:
+		u3_banks->spllc = instance->port_base + SSUSB_SIFSLV_V4_SPLLC;
+		u3_banks->chip = instance->port_base + SSUSB_SIFSLV_V4_CHIP;
+		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V4_U3PHYD;
+		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V4_U3PHYA;
+		break;
+	default:
+		dev_err(tphy->dev, "incompatible PHY type\n");
+		return;
+	}
+}
+
 static void phy_parse_property(struct mtk_tphy *tphy,
 				struct mtk_phy_instance *instance)
 {
@@ -951,6 +994,40 @@ static int phy_efuse_get(struct mtk_tphy *tphy, struct mtk_phy_instance *instanc
 
 		dev_dbg(dev, "u3 efuse - intr %x, rx_imp %x, tx_imp %x\n",
 			instance->efuse_intr, instance->efuse_rx_imp,instance->efuse_tx_imp);
+
+		if (tphy->pdata->version != MTK_PHY_V4)
+			break;
+
+		ret = nvmem_cell_read_variable_le_u32(dev, "intr_ln1", &instance->efuse_intr_ln1);
+		if (ret) {
+			dev_err(dev, "fail to get u3 lane1 intr efuse, %d\n", ret);
+			break;
+		}
+
+		ret = nvmem_cell_read_variable_le_u32(dev, "rx_imp_ln1", &instance->efuse_rx_imp_ln1);
+		if (ret) {
+			dev_err(dev, "fail to get u3 lane1 rx_imp efuse, %d\n", ret);
+			break;
+		}
+
+		ret = nvmem_cell_read_variable_le_u32(dev, "tx_imp_ln1", &instance->efuse_tx_imp_ln1);
+		if (ret) {
+			dev_err(dev, "fail to get u3 lane1 tx_imp efuse, %d\n", ret);
+			break;
+		}
+
+		/* no efuse, ignore it */
+		if (!instance->efuse_intr_ln1 &&
+		    !instance->efuse_rx_imp_ln1 &&
+		    !instance->efuse_tx_imp_ln1) {
+			dev_warn(dev, "no u3 lane1 efuse, but dts enable it\n");
+			instance->efuse_sw_en = 0;
+			break;
+		}
+
+		dev_info(dev, "u3 lane1 efuse - intr %x, rx_imp %x, tx_imp %x\n",
+			 instance->efuse_intr_ln1, instance->efuse_rx_imp_ln1,
+			 instance->efuse_tx_imp_ln1);
 		break;
 	default:
 		dev_err(dev, "no sw efuse for type %d\n", instance->type);
@@ -990,6 +1067,31 @@ static void phy_efuse_set(struct mtk_phy_instance *instance)
 
 		mtk_phy_update_field(u3_banks->phya + U3P_U3_PHYA_REG0, P3A_RG_IEXT_INTR,
 				    instance->efuse_intr);
+		if (instance->type == PHY_TYPE_USB3 || (
+		    !instance->efuse_intr_ln1 &&
+		    !instance->efuse_rx_imp_ln1 &&
+		    !instance->efuse_tx_imp_ln1))
+			break;
+
+		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET + U3P_U3_PHYD_RSV,
+				 P3D_RG_EFUSE_AUTO_LOAD_DIS);
+
+		mtk_phy_update_field(u3_banks->phyd + SSUSB_LN1_OFFSET + U3P_U3_PHYD_IMPCAL0,
+				     P3D_RG_TX_IMPEL, instance->efuse_tx_imp_ln1);
+		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET + U3P_U3_PHYD_IMPCAL0,
+				 P3D_RG_FORCE_TX_IMPEL);
+
+		mtk_phy_update_field(u3_banks->phyd + SSUSB_LN1_OFFSET + U3P_U3_PHYD_IMPCAL1,
+				     P3D_RG_RX_IMPEL, instance->efuse_rx_imp_ln1);
+		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET + U3P_U3_PHYD_IMPCAL1,
+				 P3D_RG_FORCE_RX_IMPEL);
+
+		mtk_phy_update_field(u3_banks->phya + SSUSB_LN1_OFFSET + U3P_U3_PHYA_REG0,
+				     P3A_RG_IEXT_INTR, instance->efuse_intr_ln1);
+
+		dev_info(dev, "%s set LN1 efuse, tx_imp %x, rx_imp %x intr %x\n",
+			 __func__, instance->efuse_tx_imp_ln1,
+			 instance->efuse_rx_imp_ln1, instance->efuse_intr_ln1);
 		break;
 	default:
 		dev_warn(dev, "no sw efuse for type %d\n", instance->type);
@@ -1129,6 +1231,9 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 	case MTK_PHY_V3:
 		phy_v2_banks_init(tphy, instance);
 		break;
+	case MTK_PHY_V4:
+		phy_v4_banks_init(tphy, instance);
+		break;
 	default:
 		dev_err(dev, "phy version is not supported\n");
 		return ERR_PTR(-EINVAL);
@@ -1169,6 +1274,12 @@ static const struct mtk_phy_pdata tphy_v3_pdata = {
 	.version = MTK_PHY_V3,
 };
 
+static const struct mtk_phy_pdata tphy_v4_pdata = {
+	.avoid_rx_sen_degradation = false,
+	.sw_efuse_supported = true,
+	.version = MTK_PHY_V4,
+};
+
 static const struct mtk_phy_pdata mt8173_pdata = {
 	.avoid_rx_sen_degradation = true,
 	.version = MTK_PHY_V1,
@@ -1188,6 +1299,7 @@ static const struct of_device_id mtk_tphy_id_table[] = {
 	{ .compatible = "mediatek,generic-tphy-v1", .data = &tphy_v1_pdata },
 	{ .compatible = "mediatek,generic-tphy-v2", .data = &tphy_v2_pdata },
 	{ .compatible = "mediatek,generic-tphy-v3", .data = &tphy_v3_pdata },
+	{ .compatible = "mediatek,generic-tphy-v4", .data = &tphy_v4_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_tphy_id_table);
-- 
2.37.3

