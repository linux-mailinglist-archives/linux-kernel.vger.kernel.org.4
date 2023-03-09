Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F16B1B59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCIGXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCIGW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:22:59 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0059D4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:22:56 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3296MiWD130014;
        Thu, 9 Mar 2023 00:22:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678342964;
        bh=AKWxc2g8zn/BO+bAx6NLTSzuFHfkrm4HUaOji3JbZvw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bdi9oVd2Mj5OW2JvmWNLkJ5tNQAW3x9ew63fmUIz9eofFTcAM49Whqoka9VDrg1Er
         DXKfFX/ZnexFf+WYLdUeHJpQJa0+gAm1JJCwPQmM7pwW6h9OkKQQeZZ0nd1LIuyQ41
         01epJwmYhvBG/z7jSS4FHuQ8K5YeccDfIQadsULg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3296Mibv004282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 00:22:44 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 00:22:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 00:22:44 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3296Mca2088683;
        Thu, 9 Mar 2023 00:22:41 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/3] phy: ti: phy-gmii-sel: Add support for SGMII mode
Date:   Thu, 9 Mar 2023 11:52:35 +0530
Message-ID: <20230309062237.389444-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309062237.389444-1-s-vadapalli@ti.com>
References: <20230309062237.389444-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure the CPSW MAC's PHY in SGMII mode if the SoC
supports it. The extra_modes member of the phy_gmii_sel_soc_data struct
corresponding to the SoC is used to determine whether or not the SoC
supports SGMII mode.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 8c667819c39a..351173aeb0a6 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -23,6 +23,7 @@
 #define AM33XX_GMII_SEL_MODE_RGMII	2
 
 /* J72xx SoC specific definitions for the CONTROL port */
+#define J72XX_GMII_SEL_MODE_SGMII	3
 #define J72XX_GMII_SEL_MODE_QSGMII	4
 #define J72XX_GMII_SEL_MODE_QSGMII_SUB	6
 
@@ -106,6 +107,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
 		break;
 
+	case PHY_INTERFACE_MODE_SGMII:
+		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_SGMII)))
+			goto unsupported;
+		else
+			gmii_sel_mode = J72XX_GMII_SEL_MODE_SGMII;
 	default:
 		goto unsupported;
 	}
-- 
2.25.1

