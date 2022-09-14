Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF115B8543
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiINJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiINJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:39:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CBEB3;
        Wed, 14 Sep 2022 02:39:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dQXg098677;
        Wed, 14 Sep 2022 04:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148366;
        bh=IAIDS6zZRvqjsEEOsbFFjeDVR1Bx8cSXOYtHR8E1teA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=v22Fqjr6EPJwcx/34DmT+6Op9c/GhhDYLei1cSytdUijx5RodGrlKkgybdBaN6Scy
         34HMibKvz8mLWPR4k4nc2C4my4ezTYzbZV9bkLCeM0dOQH5W1wA8CvY0iQQ15//9PP
         C4QNSecucGut/aa/KOVG41u4+O0+avMe2zTg/RZI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9dQom063795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:26 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:26 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHF111966;
        Wed, 14 Sep 2022 04:39:21 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/6] phy: ti: gmii-sel: Add support for configuring CPSW5G ports in SGMII mode
Date:   Wed, 14 Sep 2022 15:09:07 +0530
Message-ID: <20220914093911.187764-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093911.187764-1-s-vadapalli@ti.com>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPSW5G ports on J7200 support SGMII mode. Add support to the phy-gmii-sel
driver to configure the CPSW5G ports in SGMII mode.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 0bcfd6d96b4d..f0b2ba7a9c96 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -23,6 +23,7 @@
 #define AM33XX_GMII_SEL_MODE_RGMII	2
 
 /* J72xx SoC specific definitions for the CONTROL port */
+#define J72XX_GMII_SEL_MODE_SGMII	3
 #define J72XX_GMII_SEL_MODE_QSGMII	4
 #define J72XX_GMII_SEL_MODE_QSGMII_SUB	6
 
@@ -105,6 +106,13 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
 		break;
 
+	case PHY_INTERFACE_MODE_SGMII:
+		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_SGMII)))
+			goto unsupported;
+		else
+			gmii_sel_mode = J72XX_GMII_SEL_MODE_SGMII;
+		break;
+
 	default:
 		goto unsupported;
 	}
@@ -212,7 +220,7 @@ static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
 	.regfields = phy_gmii_sel_fields_am654,
-	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
 };
 
 static const struct of_device_id phy_gmii_sel_id_table[] = {
-- 
2.25.1

