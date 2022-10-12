Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC95FC331
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJLJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:40:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E6357C9;
        Wed, 12 Oct 2022 02:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NntxNO8TIe+5VQYAE9JoZk4elUYET/HkZNB4f+1IDhVEeT5+tGfsyjRvnZybgSaANLi6VSZhEeR2Xg2Uw0zjs0ePomA4ELkAOWDFanF8IScgbyn0ezmumHMaWEgLu7QFIhh54pLWl4iUhg/96BX2WLtY966kWP8QuyfDAJP/5SFbqBJJrpAB91hk22Sg4qRLztrU6oBytBcHi+3Gx+OYZ9aYOBUPpLCR41ksDcxVgEzIIlbq4eFc9xpliiSnrrXyNGKJfNE99txEOU29KrPtjqOXxt8q9kFONlP1Cb6x5x8nLwUpJO1UPTnpCskS1ZphkRcWJHKWD42/zPKqAGEIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO3APibJx7aaA7a+/xRxMwOT+8HRO4lY0I4goHPpLcE=;
 b=KTiH+cJEOCme2v3eJ/mPfeK1u3UIXY1z4W8fGZmp+zUeZBRyWjn/06CoSNQROK7fxqZUk4sEAcvwTIk7cYZmiAxIzKE1ItthqqOdgi8adXC9yrSIjkPmsDqsXIhZAizzUTINd/z6DYrbKm2ysKg5CUWKhQXIElh3Tp6XI6fftpBU3QD4GZZMC6yi9ChWZk0ZVF6hcK+crSuEVxqSdLg8HsmMhmFUaFtGf/tIYk+jEmuXJlqo1fSXvZWFeatUqhaX5wsBK5MhOrrSQpZ4pM+xPbPvyF03I2nhrnTICsuJ2KE/OrFNW76hFyvq7Cs2+Kfiywrbo5xqtAYP4LMLxrazCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO3APibJx7aaA7a+/xRxMwOT+8HRO4lY0I4goHPpLcE=;
 b=SCnyujzfc8GZD5kS8U+7qix2eDSVNjyajnzuia7Gpd2WpHhWC3BKW5n3NgDr1BgK6c3R1AnL4z7ksLzET9F2PlrJqz7SuyKy/C9SOAMs4j5y/98VK1rl63eYJ+8oPfVA7FndBT/Ma2m6NIXYQVOjL4uliZGxC7fAGUrwYKaSotQrsLM0e4DZJbTrE/noWILyoKcRHwammfU7aIf/y7OrOEUsvUtWqkkKiZY0RMpwLRbE+sG48gKTKJHjyu0pNLyHgN/ozglAMABC/HM1l8aztqgZ1oWtdRgMINM5xCRJyFlZU6I8h0WRTumTAGsgEkE1hV2aL2xdyWG88/gyRUL2aA==
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 12 Oct
 2022 09:40:47 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::5f) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Wed, 12 Oct 2022 09:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 09:40:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 12 Oct
 2022 02:40:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 02:40:32 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 12 Oct 2022 02:40:31 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH v2] xhci: tegra: USB2 pad power controls
Date:   Wed, 12 Oct 2022 17:40:20 +0800
Message-ID: <20221012094020.2442-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: de533379-8a77-4f5c-4f19-08daac35d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+wJhEBhlTMas6G+NIxK4WmX2d813pLOLC3KB12FHYTZZnLyNbrIZd81TS+YvJdkGcL9UxJI1RHwOSdpMb0Wzp7yjsmrV2IpvGcHadOa7KlTj/iTHfgtXCjfFLt75ml9+Kokk6TXLbZ8a4Oqt2OgdugiEKIIhqdoYj5RCtnB87Fc2nFkPccxTjy8G3RNLncA/yt8aOF7ruOIwfeitRdDSVlf/uR/vf7bYfm22WjOfcgqb7bWplbZQFMkVw9u7h8ODmKAaKNTT6PO/yUluw/srkrPmNaH1aDJ5i9GbkAIk4VZtNGk8M0uiPNe83iRKt6vBnLJNtibonPWgpx8LPgiXF4/hnUbqg3MLgt0OComX6QTsVkgVmf/Xdoac/rzyILvgaYJZOXTJ3kES3xfNkBOh/IP89xjAKhbb6QbMnsbLs6saePauIVEnQM794kbxBi2xH3Dy3fKAQ9KMPI275H0++tfPaQ7nLjS4TWJvmTJAK0QuPvMsnlnnSlIzdHHQjO7Jzf1avtqCFzYvduvrt+JQhyVZGPXOA8wm6hxgekR+li6gWdbY+CXHH1bq+x5O3EjXLQJnw8J/yYUzL6n2OInfq+F6WL+E6Ej+MmVGOPTZSt3OLWEehosolmapbDEkhGF82ytJGvXpsEwd3mBHgw1JkDx7vOsgi2pQ1fA/hte5iqvshXQttYyB1WQsFCrgqH6bFRYz+dBSc///nW2jIjcUzRKQQhREcnsGb+r+wieE0NvCqSWw3nbeos9LNCrJYU0LugN0UJtuyANf8M+ximzmw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(356005)(41300700001)(186003)(7636003)(82740400003)(86362001)(82310400005)(36860700001)(426003)(4326008)(8936002)(8676002)(6666004)(83380400001)(5660300002)(7696005)(40480700001)(54906003)(70586007)(26005)(478600001)(40460700003)(110136005)(336012)(107886003)(2616005)(316002)(70206006)(1076003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 09:40:47.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de533379-8a77-4f5c-4f19-08daac35d767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program USB2 pad PD controls during port connect/disconnect, port
suspend/resume, and test mode, to reduce power consumption on
disconnect or suspend.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124


 drivers/usb/host/xhci-tegra.c | 141 +++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c8af2cd2216d..316585068ab5 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2,7 +2,7 @@
 /*
  * NVIDIA Tegra xHCI host controller driver
  *
- * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2014-2022, NVIDIA CORPORATION. All rights reserved.
  * Copyright (C) 2014 Google, Inc.
  */
 
@@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
 	} fpci;
 };
 
+enum tegra_xhci_phy_type {
+	USB3_PHY,
+	USB2_PHY,
+	HSIC_PHY,
+	MAX_PHY_TYPES,
+};
+
 struct tegra_xusb_soc {
 	const char *firmware;
 	const char * const *supply_names;
@@ -274,9 +281,17 @@ struct tegra_xusb {
 
 	bool suspended;
 	struct tegra_xusb_context context;
+	u32 enable_utmi_pad_after_lp0_exit;
 };
 
 static struct hc_driver __read_mostly tegra_xhci_hc_driver;
+static int (*original_xhci_hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
+	    char *buf, u16 wLength);
+
+static inline struct tegra_xusb *hcd_to_tegra_xusb(struct usb_hcd *hcd)
+{
+	return (struct tegra_xusb *) dev_get_drvdata(hcd->self.controller);
+}
 
 static inline u32 fpci_readl(struct tegra_xusb *tegra, unsigned int offset)
 {
@@ -1949,12 +1964,30 @@ static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
 static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 {
 	struct tegra_xusb_padctl *padctl = tegra->padctl;
-	unsigned int i;
+	unsigned int i, j;
 
 	for (i = 0; i < tegra->num_phys; i++) {
 		if (!tegra->phys[i])
 			continue;
+		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i])) {
+			if (i < tegra->soc->phy_types[USB3_PHY].num) {
+				/* USB3 */
+				j = i;
+			} else if (i < (tegra->soc->phy_types[USB3_PHY].num +
+					tegra->soc->phy_types[USB2_PHY].num)) {
+				/* USB2 */
+				j = i - tegra->soc->phy_types[USB3_PHY].num;
+				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
+			} else {
+				/* HSIC */
+				j = i - (tegra->soc->phy_types[USB3_PHY].num +
+					 tegra->soc->phy_types[USB2_PHY].num);
+			}
+			dev_dbg(tegra->dev,
+				"%s port %u (0 based) remote wake detected\n",
+				dev_name(&tegra->phys[i]->dev), j);
 
+		}
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
 }
@@ -1972,6 +2005,23 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
 	}
 }
 
+static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb *tegra)
+{
+	unsigned int i;
+
+	for (i = 0; i < tegra->soc->phy_types[USB2_PHY].num; i++) {
+		if (!is_host_mode_phy(tegra, USB2_PHY, i))
+			continue;
+		/* USB2 */
+		if (tegra->enable_utmi_pad_after_lp0_exit & BIT(i))
+			tegra_phy_xusb_utmi_pad_power_on(
+				tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);
+		else
+			tegra_phy_xusb_utmi_pad_power_down(
+				tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);
+	}
+}
+
 static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
@@ -1980,6 +2030,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 	unsigned int i;
 	int err;
 	u32 usbcmd;
+	u32 portsc;
 
 	dev_dbg(dev, "entering ELPG\n");
 
@@ -1993,6 +2044,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 		goto out;
 	}
 
+	for (i = 0; i < tegra->soc->phy_types[USB2_PHY].num; i++) {
+		if (!xhci->usb2_rhub.ports[i])
+			continue;
+		portsc = readl(xhci->usb2_rhub.ports[i]->addr);
+		tegra->enable_utmi_pad_after_lp0_exit &= ~BIT(i);
+		if (((portsc & PORT_PLS_MASK) == XDEV_U3) || ((portsc & DEV_SPEED_MASK) == XDEV_FS))
+			tegra->enable_utmi_pad_after_lp0_exit |= BIT(i);
+	}
+
 	err = xhci_suspend(xhci, wakeup);
 	if (err < 0) {
 		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
@@ -2066,6 +2126,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 
 		phy_power_on(tegra->phys[i]);
 	}
+	if (tegra->suspended)
+		tegra_xhci_program_utmi_power_lp0_exit(tegra);
 
 	tegra_xusb_config(tegra);
 	tegra_xusb_restore_context(tegra);
@@ -2437,6 +2499,79 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
 	return xhci_gen_setup(hcd, tegra_xhci_quirks);
 }
 
+static int tegra_xhci_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
+				  char *buf, u16 length)
+{
+	struct tegra_xusb *tegra = hcd_to_tegra_xusb(hcd);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_hub *rhub;
+	struct xhci_bus_state *bus_state;
+	int port = (index & 0xff) - 1;
+	int i;
+	struct xhci_port **ports;
+	u32 portsc;
+	int ret;
+
+	rhub = &xhci->usb2_rhub;
+	bus_state = &rhub->bus_state;
+	if (bus_state->resuming_ports && hcd->speed == HCD_USB2) {
+		ports = rhub->ports;
+		i = rhub->num_ports;
+		while (i--) {
+			if (!test_bit(i, &bus_state->resuming_ports))
+				continue;
+			portsc = readl(ports[i]->addr);
+			if ((portsc & PORT_PLS_MASK) == XDEV_RESUME)
+				tegra_phy_xusb_utmi_pad_power_on(
+					tegra->phys[tegra->soc->phy_types[USB3_PHY].num + i]);
+		}
+	}
+
+	if (hcd->speed == HCD_USB2) {
+		i = tegra->soc->phy_types[USB3_PHY].num + port;
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_SUSPEND)) {
+			if (!index || index > rhub->num_ports)
+				return -EPIPE;
+			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
+		}
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_RESET)) {
+			if (!index || index > rhub->num_ports)
+				return -EPIPE;
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (portsc & PORT_CONNECT)
+				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
+		}
+	}
+
+	ret = (*original_xhci_hub_control)(hcd, type_req, value, index, buf, length);
+	if (ret < 0)
+		return ret;
+
+	if (hcd->speed == HCD_USB2) {
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_SUSPEND))
+			/* We don't suspend the PAD while HNP role swap happens on the OTG port */
+			if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
+				tegra_phy_xusb_utmi_pad_power_down(tegra->phys[i]);
+
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_C_CONNECTION)) {
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (!(portsc & PORT_CONNECT)) {
+				/* We don't suspend the PAD while HNP role swap happens on the OTG
+				 * port
+				 */
+				if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
+					tegra_phy_xusb_utmi_pad_power_down(tegra->phys[i]);
+			}
+		}
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_TEST))
+			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
+	}
+
+	return ret;
+}
+
 static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 	.reset = tegra_xhci_setup,
 };
@@ -2444,6 +2579,8 @@ static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 static int __init tegra_xusb_init(void)
 {
 	xhci_init_driver(&tegra_xhci_hc_driver, &tegra_xhci_overrides);
+	original_xhci_hub_control = tegra_xhci_hc_driver.hub_control;
+	tegra_xhci_hc_driver.hub_control = tegra_xhci_hub_control;
 
 	return platform_driver_register(&tegra_xusb_driver);
 }
-- 
2.17.1

