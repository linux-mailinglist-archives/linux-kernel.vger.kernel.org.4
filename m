Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B46B1B49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCIGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCIGSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:18:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62825E194;
        Wed,  8 Mar 2023 22:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcjHJlGnilQ4tUrAlGpN6GSh+pGb68u6owLUzvD2cBb2d3xgFtIFloJXmN2PhzbJUO9VYmwAJTcaCEgYHq6HDFpdH0dwzD0uX+EyJ7/jn6XKZZ4/7Ix7PGBWMs6sdm3wODRACwkM0AIwVsmt7akJx+7W6Jd4PD3r5usM7+BLcndEAsyGT1IgJmvfDTzAIeP2oZOF+KOU0M3V0LQo3wmoBpCmOUOHG+itPNCbJtRI1nEATMFWB+Y6O32jypn7VPk2LrJ6+p8wAS20ox3a6LuXNK1WNoFDk5+i5lYoTCSdJLRIQOnUvQCuIG6K4rb1KivFu2Ez1X1L/7dKFxoGURM24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/w0fpVorq0Ul+NeMg1CUoIQdPfqxM6d1zbiK3ggKDE=;
 b=XT8G5qQxj2ax4l1gsJaopIs6oNFp9rQA57QoHli+OkK+Dfs1Zv3SlS+DocoOebAqbXLpBwdwvPm8kZdt1Pa48r9rQpQrt3/rDuFYmNW9KY+CESvG4R1GOfOZCDgM7alPAaI1is7x1/eoS3kr62Gvkf38EyvJkQ09OO30xZ/z2ymfoVhMBMGy1/Cy68vb8bJMbxUqfy/oYU+k+5fIr691w6eFFjpFJGETVvLloQl9zeeVgNSxKTpkUhP1+KGvIN+jl7O4fw6nvmCrNfKEsOv2b9E3D2EsyDK8OaJsBebBdomVl88se6Bg4ITam4W58iyJHRnFhZdofkxvYLqP0UTpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/w0fpVorq0Ul+NeMg1CUoIQdPfqxM6d1zbiK3ggKDE=;
 b=rvdgJS14Tcz4/VuWRDUXnKIbxMdZLBW7hZrgFcZQc5pFIhwkbYiOQkNA2HaTfv5CQKIN0kzUTzo3zLUdVbXsjzA6GWXwNxkAyLKky/xYR3+FIOjcyIfl6X/EWnO8Tsx1ja9z0kWzuFu5vrRGMKj56cVghy5oTZwSZSGWeDgF7OLkraZQg9J1Oz72hPPvJYv3w+ZkLe+UaZLBviYBFPxagDahA7jcT+qVy8AXzcasUweeNQbod+QK0+OSVAxxY8wDV4xGvnZApS7Sqxa0VLId7gRdikzZi5D/2VmgjPoBsSN2pNoqAdMf5uEZoDTh5an5ZAl5Lga2f4LGBY9iwy38UQ==
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 06:17:47 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::d6) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 06:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Thu, 9 Mar 2023 06:17:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 22:17:31 -0800
Received: from 0e64808-lcelt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 22:17:28 -0800
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
CC:     JC Kuo <jckuo@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Henry Lin <henryl@nvidia.com>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH] phy: tegra: xusb: Support sleepwalk for Tegra234
Date:   Thu, 9 Mar 2023 14:17:08 +0800
Message-ID: <20230309061708.4156383-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: b6eb8e1f-00a3-4c24-ce7f-08db206600c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVsDxBMT6aPJI4iguKuU94gTyY4VNPXJoJIh16kX99UXlkxRLqdWSYGx8C/MW1dVqtKcsJoBbBFb9nK/67npAAU87i4E/Q7M1OHglYJpbRTDZTtqiDWm7G3/mUkt49tJyz4M7LoQ4PQRTeNUmfejaH+ioO4lkeqAUC31psr3BQyRwfDDqLzpdHitIl6o6PIQIbV/bd1WIibXSYgEMJAJvBvmie0bxSDYLgzYRZWsYcHWclN347Kws1KTH8oJYUuIGhBYU6703h5lGia39wZolo7x2gLu7/8EDC0cObwiBEw63c3W3xVVzKIa6R7vTOXTJZWHXe0LiJ+oleWJoHLAar3FrS/rAVu/++yko4KsV+jbGdhHFzdgGWxAQN0nxappU1f6yMWImQop9hdSArb7ap+C0M69leSW0xdZHLMbTAosWZT8k1uJPUwpakynz9g3vNHumc4RLGA0ZZNOIsa9f9YSHrnrixdB+4H7IYuwC2xY9Yoy7tdna+6W2jRaGwwyKaP2CekI64tfKaQ1fwLB66YJHYsERTcvX8SDAzhnVgHWkdsAe0hrz06UxcGltV0QBRYXhbcMIe6uNZEwP0A75t/y9oJLvhIy55+QgZyrx3EPVd8DF1gOp5zxR5YGF9oe14mv/X3LIetPRJiBTUSbcmWERneu9RbnRYEPS4UP/RBGtd+e0n1CIY5AkM5w5zCh1j3TrNvxv72Y/5MQBncicrV5IqLWpQeB/M7bu1SrSenBDlEhRTQnR4CYoLHW6AU5
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(426003)(336012)(2906002)(82310400005)(2616005)(70586007)(70206006)(8676002)(7696005)(5660300002)(36860700001)(186003)(26005)(16526019)(41300700001)(7636003)(82740400003)(36756003)(107886003)(6666004)(40460700003)(1076003)(478600001)(4326008)(54906003)(356005)(8936002)(86362001)(110136005)(316002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 06:17:47.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb8e1f-00a3-4c24-ce7f-08db206600c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

Add new registers programming in sleepwalk sequence for Tegra234:
MASTER_ENABLE_A/B/C/D in XUSB_AO_UTMIP_SLEEPWALK.

Signed-off-by: Henry Lin <henryl@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 20 ++++++++++++++++++++
 drivers/phy/tegra/xusb.h          |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 1aae8535f452..0f60d5d1c167 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -145,6 +145,8 @@
 #define   MODE_HS				MODE(0)
 #define   MODE_RST				MODE(1)
 
+#define XUSB_AO_UTMIP_SLEEPWALK_STATUS(x)	(0xa0 + (x) * 4)
+
 #define XUSB_AO_UTMIP_SLEEPWALK_CFG(x)		(0xd0 + (x) * 4)
 #define XUSB_AO_UHSIC_SLEEPWALK_CFG(x)		(0xf0 + (x) * 4)
 #define   FAKE_USBOP_VAL			BIT(0)
@@ -172,24 +174,30 @@
 #define   AP_A					BIT(4)
 #define   AN_A					BIT(5)
 #define   HIGHZ_A				BIT(6)
+#define   MASTER_ENABLE_A			BIT(7)
 /* phase B */
 #define   USBOP_RPD_B				BIT(8)
 #define   USBON_RPD_B				BIT(9)
 #define   AP_B					BIT(12)
 #define   AN_B					BIT(13)
 #define   HIGHZ_B				BIT(14)
+#define   MASTER_ENABLE_B			BIT(15)
 /* phase C */
 #define   USBOP_RPD_C				BIT(16)
 #define   USBON_RPD_C				BIT(17)
 #define   AP_C					BIT(20)
 #define   AN_C					BIT(21)
 #define   HIGHZ_C				BIT(22)
+#define   MASTER_ENABLE_C			BIT(23)
 /* phase D */
 #define   USBOP_RPD_D				BIT(24)
 #define   USBON_RPD_D				BIT(25)
 #define   AP_D					BIT(28)
 #define   AN_D					BIT(29)
 #define   HIGHZ_D				BIT(30)
+#define   MASTER_ENABLE_D			BIT(31)
+#define   MASTER_ENABLE_B_C_D					\
+	 (MASTER_ENABLE_B | MASTER_ENABLE_C | MASTER_ENABLE_D)
 
 #define XUSB_AO_UHSIC_SLEEPWALK(x)		(0x120 + (x) * 4)
 /* phase A */
@@ -417,6 +425,8 @@ static int tegra186_utmi_enable_phy_sleepwalk(struct tegra_xusb_lane *lane,
 		value |= HIGHZ_A;
 		value |= AP_A;
 		value |= AN_B | AN_C | AN_D;
+		if (padctl->soc->supports_lp_cfg_en)
+			value |= MASTER_ENABLE_B_C_D;
 		break;
 
 	case USB_SPEED_LOW:
@@ -424,6 +434,8 @@ static int tegra186_utmi_enable_phy_sleepwalk(struct tegra_xusb_lane *lane,
 		value |= HIGHZ_A;
 		value |= AN_A;
 		value |= AP_B | AP_C | AP_D;
+		if (padctl->soc->supports_lp_cfg_en)
+			value |= MASTER_ENABLE_B_C_D;
 		break;
 
 	default:
@@ -488,6 +500,13 @@ static int tegra186_utmi_disable_phy_sleepwalk(struct tegra_xusb_lane *lane)
 	value |= WAKE_VAL_NONE;
 	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
 
+	if (padctl->soc->supports_lp_cfg_en) {
+		/* disable the four stages of sleepwalk */
+		value = ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK(index));
+		value &= ~(MASTER_ENABLE_A | MASTER_ENABLE_B_C_D);
+		ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK(index));
+	}
+
 	/* power down the line state detectors of the port */
 	value = ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
 	value |= USBOP_VAL_PD | USBON_VAL_PD;
@@ -1673,6 +1692,7 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
 	.trk_hw_mode = true,
+	.supports_lp_cfg_en = true,
 };
 EXPORT_SYMBOL_GPL(tegra234_xusb_padctl_soc);
 #endif
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 71b8dcedb646..6bbd88245b9d 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -434,6 +434,7 @@ struct tegra_xusb_padctl_soc {
 	bool need_fake_usb3_port;
 	bool poll_trk_completed;
 	bool trk_hw_mode;
+	bool supports_lp_cfg_en;
 };
 
 struct tegra_xusb_padctl {
-- 
2.25.1

