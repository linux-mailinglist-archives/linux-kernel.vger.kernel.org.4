Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6835697906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjBOJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBOJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:32:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68B30D2;
        Wed, 15 Feb 2023 01:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij/YzEfi/8QY8yMgXUCLTIwtzJWD4h8dnxoLs0ehrgD10pqHUqqa5NwqXnW97BBWMefE+3xaef8oN4l45WZaFMkQfm+3bZIlVULh02ZLhJkanJyOyGnB8r87+y7PSOCP3LkwQKv0Y78Yl0EY8YyGPppjWY3EF3tbR8L+EjRWbUi8f0maSmAXL1OGXinMWebY3dogCu0dcthWFavrM5S9o39LlYuPmu4HUEqtTwpiNK/O3TRIaoUtqu8yQH8DkKq8XzIEM77JxSk/nVS3qwcDtmIwZiWs7gvAIPIFmrnc/PaXsNcfbBzs0R/dx+5Nfjg1Mgbb09OSRsWhyVjAQDYljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9pa1yxBJDFumHOLqoBb+j/zVFgq+h3dIUqCOkO27ok=;
 b=NttUcmj8EFffVb5KOOta/4pxl15PLVfv2Kfsg/zFSEiEzjXf8sE+CRZ9q6uswSW+DZGqKbQ1RO5UzlzMzGllmmoGREoWLiZM46ht1hSwi6oov8dpd3OiSvsxPWHlCL3FQ3C41d+GizVceAjdMYad/J9PTSJfEM1J5dseO2d5bW0G5PA4GxjH3tyJm8WabcBETixAWsKXJDsy8iZ4HsILqHy6nTPclkgJe9x11GAiQojegPIW72HPLQbcliOKhW3r4+sVxlR984n3HhQaV1XHc5rR9IRx4fujj4NshOmzCTpp9YFKDjjnWmAw4oiqqzL6YhHKo9mOqdmH7HtY/kDK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9pa1yxBJDFumHOLqoBb+j/zVFgq+h3dIUqCOkO27ok=;
 b=RpNRFJBT0RQ/cIAOvqzg0JgAgrODnTo4y6TLSU7FYBTbXnapGSIrfWtDBVXip8ie/k9Jcge1epmwJ5n7xRkAfbBmK9Sro4t7/jhuypi/CnbEWs1IE2Xjgnb3geSxxc6JLZlzd36xFQt/iXrFRCpQr3eDmZdEYj1Ton1lukq0okc=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 09:32:16 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::5b) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 09:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Wed, 15 Feb 2023 09:32:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 03:32:15 -0600
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 15 Feb 2023 03:32:12 -0600
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 2/2] usb: dwc3: core: add external vBus supply support for ulpi phy
Date:   Wed, 15 Feb 2023 15:01:46 +0530
Message-ID: <20230215093146.5812-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230215093146.5812-1-piyush.mehta@amd.com>
References: <20230215093146.5812-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: f289ac6a-f07a-4dcd-dfdb-08db0f3786e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8SiNH4sNsnz+fQecWE/h8fbkZ74/xu4vAphQrrqItqRvuBcwEhdwvzA+lugESQP152/o8ybe3Ft/kNTg+VyEcsBR4Igeg8/EwhtqNiF5Eu+fyWRSrGLzAZa0ory70VuFkhc+rmGtwXHmrgIEhHj2BaRHZgm22zE/FUWr8dTS64Ck3snWyETdFABBfhCLa/wyAbX57YRqihTCRRnEqUuxSMKQOAoJWMzwWv9yRldCAqJcWf5PC36GoB0JyMQeE+WZONDYXFaKGhDX45USVWtgMFsp0XRptduqQpzWPa865iqI8Ewefb3TTsY5/exOveV2owsKlwt66nMR+ZxrzfynNCNYshGdX9dWz44iJyK3vjWHZLmcLo2t68p6qLQ1VOsVZ2Y1z/RLDqtyzQ7tVi+06EwU1ynsl0iZ9gLGuFqdAinYX5gIN3+dkuo+pMClehKCcFugVlyhYtf++6w07kU4TffEBVw3ZLqdBm9MGGdQaxHby5QRPUlTV9SsImd9wxBxnbI3OT4m8loV2YHfwpaBSETe3W67JR6huwGBHjg6N1aRCg071XhD4YD/MPTCk5Gm45mkq5SDe0v6L9QOGkIg3zQ2/TUbG7MVdxkY4keldK8ZlnnIiv3vu0u5FUxGC9mmKRTElbxNIbrL3Ee0PK4L1qHM2+hkgSaF74xQzaabnpBZkr+LpVGgYbjxBOI7sOlm1ejjt0NQ2IgVoIpSWHq97r7PymUFdAY6oN+308+wjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(44832011)(5660300002)(426003)(83380400001)(8936002)(41300700001)(356005)(36860700001)(36756003)(70206006)(70586007)(8676002)(4326008)(316002)(40460700003)(110136005)(54906003)(47076005)(186003)(82310400005)(478600001)(40480700001)(336012)(1076003)(86362001)(82740400003)(2616005)(26005)(6666004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 09:32:16.3038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f289ac6a-f07a-4dcd-dfdb-08db0f3786e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ULPI USB PHY does not support internal VBUS supply, to drive the CPEN
pin, which requires the configuration of the ULPI DRVVBUSEXTERNAL bit of
OTG_CTRL register.

Added 'snps,ulpi-ext-vbus-drv' a DT property to configure the USB2 PHY to
drive VBUS with an external supply, by setting the USB2 PHY ULPIEXTVBUSDRV
bit[:17] of the GUSB2PHYCFG register to drive VBUS with an external supply.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/core.c | 12 ++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..ed0ab90d3fac 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -800,6 +800,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
+	/*
+	 * Some ULPI USB PHY does not support internal VBUS supply, to drive
+	 * the CPEN pin requires the configuration of the ULPI DRVVBUSEXTERNAL
+	 * bit of OTG_CTRL register. Controller configures the USB2 PHY
+	 * ULPIEXTVBUSDRV bit[17] of the GUSB2PHYCFG register to drive vBus
+	 * with an external supply.
+	 */
+	if (dwc->ulpi_ext_vbus_drv)
+		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	return 0;
@@ -1553,6 +1563,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-tx-ipgap-linecheck-quirk");
 	dwc->resume_hs_terminations = device_property_read_bool(dev,
 				"snps,resume-hs-terminations");
+	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
+				"snps,ulpi-ext-vbus-drv");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
 	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..9d5487b377b7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -280,6 +280,7 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	BIT(31)
 #define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	BIT(30)
+#define DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV	BIT(17)
 #define DWC3_GUSB2PHYCFG_SUSPHY		BIT(6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	BIT(4)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	BIT(8)
@@ -1100,6 +1101,8 @@ struct dwc3_scratchpad_array {
  *			check during HS transmit.
  * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
+ * @ulpi_ext_vbus_drv: Set to confiure the upli chip to drives CPEN pin
+ *			VBUS with an external supply.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1316,6 +1319,7 @@ struct dwc3 {
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		resume_hs_terminations:1;
+	unsigned		ulpi_ext_vbus_drv:1;
 	unsigned		parkmode_disable_ss_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
 
-- 
2.17.1

