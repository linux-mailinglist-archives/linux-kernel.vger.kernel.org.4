Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1311C6B1B97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCIGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCIGf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:35:28 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D70DBB6C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:35:28 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3296ZNrf062437;
        Thu, 9 Mar 2023 00:35:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678343723;
        bh=k50jCkv4S7wXSq8wTTdq+ChnRdDEMnnkoXT+Qd304j0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oaTpYJhWcED39jy+3DkBtmZkLxE7ke/68/bnX4TZrDuRBQiMaOKnBr+lauPqKCNJR
         R4WRM1rIpzpTpllTGFkQQcWgrYTe6OFSCSZjh22cEo7VfPOeoHrpzj0JMkasydZXLn
         +nyPFNOWRUaXui80XZYVqfxTIFNoHjten/bOQnZI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3296ZNSp012444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 00:35:23 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 00:35:22 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 00:35:22 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3296ZEQp099087;
        Thu, 9 Mar 2023 00:35:20 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 2/3] phy: ti: gmii-sel: Enable SGMII mode for J7200
Date:   Thu, 9 Mar 2023 12:05:13 +0530
Message-ID: <20230309063514.398705-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309063514.398705-1-s-vadapalli@ti.com>
References: <20230309063514.398705-1-s-vadapalli@ti.com>
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

TI's J7200 SoC supports SGMII mode with the CPSW5G instance of the CPSW
Ethernet Switch. Thus, enable it by adding SGMII mode to the list of the
corresponding extra_modes member.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 5e16d8dd5bee..f3da6b020247 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -221,7 +221,7 @@ static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
 	.regfields = phy_gmii_sel_fields_am654,
-	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
 	.num_ports = 4,
 	.num_qsgmii_main_ports = 1,
 };
-- 
2.25.1

