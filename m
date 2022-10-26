Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3560DC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJZHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiJZHqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:46:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF817392B;
        Wed, 26 Oct 2022 00:46:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29Q7jnPM006079;
        Wed, 26 Oct 2022 02:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666770349;
        bh=bIyVP0S98Q+cV6lYX+CKx/3vm13O8g2H7ynwT5bXbMk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LM5cjyPRndYN+anE1Jc5Xo3cqHZwtWsa12R14oahkbOWjQTiV5qel+LgZLcWg1sXk
         wuACuwRv0jal60QRzqo1oYPZeThHd65L6ke99QC5fJOJQ5oyLRzg0RKA26LWEgYSO+
         AOJ6rU7BN/0OiupHXLXFQPzHLGGsmgWSz20fDsF0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29Q7jnAX071813
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Oct 2022 02:45:49 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 26
 Oct 2022 02:45:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 26 Oct 2022 02:45:49 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29Q7jXFm005631;
        Wed, 26 Oct 2022 02:45:45 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v3 3/3] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J721e
Date:   Wed, 26 Oct 2022 13:15:32 +0530
Message-ID: <20221026074532.109220-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026074532.109220-1-s-vadapalli@ti.com>
References: <20221026074532.109220-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each of the CPSW9G ports in J721e support additional modes like QSGMII.
Add a new compatible for J721e to support the additional modes.

In TI's J721e, each of the CPSW9G ethernet interfaces can act as a
QSGMII main or QSGMII-SUB port. The QSGMII main interface is responsible
for performing auto-negotiation between the MAC and the PHY while the rest
of the interfaces are designated as QSGMII-SUB interfaces, indicating that
they will not be taking part in the auto-negotiation process.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index c8f30d2e1f46..8c667819c39a 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -218,6 +218,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.num_qsgmii_main_ports = 1,
 };
 
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
+	.use_of_data = true,
+	.regfields = phy_gmii_sel_fields_am654,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
+	.num_ports = 8,
+	.num_qsgmii_main_ports = 2,
+};
+
 static const struct of_device_id phy_gmii_sel_id_table[] = {
 	{
 		.compatible	= "ti,am3352-phy-gmii-sel",
@@ -243,6 +252,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
 		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
 		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
 	},
+	{
+		.compatible	= "ti,j721e-cpsw9g-phy-gmii-sel",
+		.data		= &phy_gmii_sel_cpsw9g_soc_j721e,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
-- 
2.25.1

