Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E35E5E83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiIVJ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiIVJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:25:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85097D078A;
        Thu, 22 Sep 2022 02:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R17iILH3bsOytl1Bgc+Q8AuEQqQeudRtx4qKeRhOvfWJ6/FYVq6h9w9MBmFgzurCic1gJ8mgPyHP0y+YTuAPGIoB/BoJohOWDm9IIVWxq9FEhV0CrSImIrDGhpAMQtAabBLoYrn9DtDyd2MLVJMFi1hCCe+jT0S3cvdTya3jagEk5lNDx0nSJc6TfPHw5YWcA9kkDkT5sL7sM3LqrnxSmGL0jZWWBsVAUJqUjEaPpoRHf4pZCAxkwkFZVF3VUYbJBb2g4Uue/pr9TnlIiJnDzq+m32IhKX5mk3JSIpQAOl8UTtfobmCM2XdApk5EO8gJO6RMryPFVcEM/bZm8tGlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOVyGSPPcp+bf631Wnn/uXs0IVRtI3tLlIK1AeKPFvQ=;
 b=XhVNPBlq8jx0LmE5rmrgU6eq4fpSLDEyVdZh3M7zO8vjx/FHjBk536HiKNBUKij476SAQmvnLwqQfcsGS4ImiIskNuON0js9lhb+mINZavm/crG4SCeEmcAAxkuKk4BPiSHsqvQviSv0Mo0qSLXikkcN0qgaTDHHkUptNV8m21Dcx3djpPZQOt56XK7f1Vxq4bDoHVW9Y6JgkqxMKe2KOstt0VrVaJW5MgvkkXZK0Go3oSKO6/OJC1WeRtVLMNEvu+/epstKzHgUQhCdqejdt6YBZN5VkQCI4cbjGeMoYKwDLpniWxf2a1jheASnK5O8rK8sufAPYkKbj8K1LNCsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOVyGSPPcp+bf631Wnn/uXs0IVRtI3tLlIK1AeKPFvQ=;
 b=gEExT/vwMfq8TTSlh3keQ5w50P2uUyYIL3XgZAYAG3de5Rm49NE8wVRBZ64R9vBVLb29kJ6IRnszrXM9vMwiRmFfLIzEvxDXuete2etWRvh8dy/BX2XEbE8DneTXs0xLxcMVlJ5B+GxezaaPyhqrhTr6Q2Wkj7reEo+1256VRpQ2J4AFQPRDAj/Y4T9quA2S+PmVX8Zf6aou24jnHZtUswhbFMDsJn0WXXuE2X6WNImXUVIS1Jvjw/xA2BRRgiGYiO5Rr12jWiJsKDu0p+MmHFnDt2HzvmFEs7hFo3lrVVC6DsTqgUe5T9WGtviaxNVLzEXb2lPcpmdcbH458MTfAA==
Received: from BN0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:e7::33)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 09:25:54 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::2d) by BN0PR03CA0058.outlook.office365.com
 (2603:10b6:408:e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 09:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 09:25:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 02:25:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 02:25:35 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 02:25:34 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH] xhci: tegra: USB2 pad power controls
Date:   Thu, 22 Sep 2022 17:24:56 +0800
Message-ID: <20220922092456.12264-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2910d052-2fcc-477a-f83c-08da9c7c7297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THnGJUXT9qSF9kX4zI4w7XUTnTYZsByW3eeoD5nCFN9D2GRbY3mfAx62S32VdTEZ/7XlXXWNxiGKvQLwpI3ABIdZU57leusOqnntSVYpG+2vkU6dTK6clQd8O7ynLLwR1lIvLw2Lx3r5yr0u+1DtG4DPopYEkZ5PkGzfDa9PuGlPTGXDjXdAFqeaaZtCGgfUeeCs4mT6LXo4u4iu3z1C1m2K6AByGuQli3SvU6ctk+SuNGFGUYMBEARXgHTkPx0KRet7TpIf8aoEic73+xy11LdXLMPxpGj31x5o73mp2X9iYC26UmCi2M12wAwWMc/wZTA1RTjqGx3YuPxBLjBhvFlnPGujzf4JjDQ/MjMSQw1Nw2mrQ+S6DunFayQLRPTZP84HVWorwa2qcUchkLSwTWm2JjFSNdcLFb7XLv8S/Klfjv5lpd0gu2UT3gC9l+PUivCRhEh+epXRWlVtWUJWe3hCuYNIawIHWzu/9T6VTnSAWxCZil68QoqdeJNMa5gdm/VVTPGc5/ZUWqRwQlR/jNe1NiSU7iKwFwlZE5E4o5To0F7buYriJl68hAU7+CTZqPHXbq3ZA93dIfozjtydlhs9WWX0kpWICsnNs0dYIBTjAxSIGHnF/+07GbWLSwqTo720rPFrLL22NYJrhJHIi+qEnjCkE54FkdOQTQ7rbckIl0AOz9QXjhgXxfTXdOSszX4zk+QRrhETGMrovFJ0QcjEu+1ycO9Yk0tjLleisN8NGqXS2fnTyEFKvun0qBwzDwyelGsiGhnIPeIWqe2Rqw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(6666004)(107886003)(82310400005)(478600001)(4326008)(36756003)(70586007)(70206006)(41300700001)(110136005)(8936002)(40460700003)(54906003)(8676002)(316002)(186003)(36860700001)(7636003)(2616005)(40480700001)(86362001)(82740400003)(426003)(336012)(7696005)(26005)(356005)(83380400001)(1076003)(47076005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 09:25:53.6755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910d052-2fcc-477a-f83c-08da9c7c7297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
suspend/resume, to reduce power consumption on disconnect or suspend.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 130 +++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 1ed46642abd5..9ebd68373bd5 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
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
@@ -1949,12 +1964,27 @@ static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
 static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 {
 	struct tegra_xusb_padctl *padctl = tegra->padctl;
-	unsigned int i;
+	unsigned int i, j;
 
 	for (i = 0; i < tegra->num_phys; i++) {
 		if (!tegra->phys[i])
 			continue;
+		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i])) {
+			if (i < (tegra->soc->ports.usb3.offset + tegra->soc->ports.usb3.count)) {
+				j = i;
+			} else if (i < (tegra->soc->ports.usb2.offset +
+					tegra->soc->ports.usb2.count)) {
+				j = i - tegra->soc->ports.usb2.offset;
+				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[i]);
+			} else {
+				j = i - (tegra->soc->ports.usb2.offset +
+					 tegra->soc->ports.usb2.count);
+			}
+			dev_dbg(tegra->dev,
+				"%s port %u (0 based) remote wake detected\n",
+				dev_name(&tegra->phys[i]->dev), j);
 
+		}
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
 }
@@ -1972,6 +2002,22 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
 	}
 }
 
+static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb *tegra)
+{
+	unsigned int i;
+
+	for (i = 0; i < tegra->soc->ports.usb2.count; i++) {
+		if (!is_host_mode_phy(tegra, USB2_PHY, i))
+			continue;
+		if (tegra->enable_utmi_pad_after_lp0_exit & BIT(i))
+			tegra_phy_xusb_utmi_pad_power_on(
+				tegra->phys[tegra->soc->ports.usb2.offset + i]);
+		else
+			tegra_phy_xusb_utmi_pad_power_down(
+				tegra->phys[tegra->soc->ports.usb2.offset + i]);
+	}
+}
+
 static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
@@ -1980,6 +2026,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 	unsigned int i;
 	int err;
 	u32 usbcmd;
+	u32 portsc;
 
 	dev_dbg(dev, "entering ELPG\n");
 
@@ -1993,6 +2040,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 		goto out;
 	}
 
+	for (i = 0; i < tegra->soc->ports.usb2.count; i++) {
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
@@ -2066,6 +2122,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 
 		phy_power_on(tegra->phys[i]);
 	}
+	if (tegra->suspended)
+		tegra_xhci_program_utmi_power_lp0_exit(tegra);
 
 	tegra_xusb_config(tegra);
 	tegra_xusb_restore_context(tegra);
@@ -2437,6 +2495,74 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
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
+	int port_index;
+	struct xhci_port **ports;
+	u32 portsc;
+	int ret;
+
+	rhub = &xhci->usb2_rhub;
+	bus_state = &rhub->bus_state;
+	if (bus_state->resuming_ports && hcd->speed == HCD_USB2) {
+		ports = rhub->ports;
+		port_index = rhub->num_ports;
+		while (port_index--) {
+			if (!test_bit(port_index, &bus_state->resuming_ports))
+				continue;
+			portsc = readl(ports[port_index]->addr);
+			if ((portsc & PORT_PLS_MASK) == XDEV_RESUME)
+				tegra_phy_xusb_utmi_pad_power_on(
+					tegra->phys[tegra->soc->ports.usb2.offset + port_index]);
+		}
+	}
+
+	if (hcd->speed == HCD_USB2) {
+		port_index = tegra->soc->ports.usb2.offset + port;
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_SUSPEND))
+			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[port_index]);
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_RESET)) {
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (portsc & PORT_CONNECT)
+				tegra_phy_xusb_utmi_pad_power_on(tegra->phys[port_index]);
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
+				tegra_phy_xusb_utmi_pad_power_down(tegra->phys[port_index]);
+
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_C_CONNECTION)) {
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (!(portsc & PORT_CONNECT)) {
+				/* We don't suspend the PAD while HNP role swap happens on the OTG
+				 * port
+				 */
+				if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
+					tegra_phy_xusb_utmi_pad_power_down(tegra->phys[port_index]);
+			}
+		}
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_TEST))
+			tegra_phy_xusb_utmi_pad_power_on(tegra->phys[port_index]);
+	}
+
+	return ret;
+}
+
 static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 	.reset = tegra_xhci_setup,
 };
@@ -2444,6 +2570,8 @@ static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 static int __init tegra_xusb_init(void)
 {
 	xhci_init_driver(&tegra_xhci_hc_driver, &tegra_xhci_overrides);
+	original_xhci_hub_control = tegra_xhci_hc_driver.hub_control;
+	tegra_xhci_hc_driver.hub_control = tegra_xhci_hub_control;
 
 	return platform_driver_register(&tegra_xusb_driver);
 }
-- 
2.17.1

