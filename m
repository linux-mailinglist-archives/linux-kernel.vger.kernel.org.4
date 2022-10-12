Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA925FC3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJLKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:25:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C750F89;
        Wed, 12 Oct 2022 03:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV2sAzs5a+ZzfudJNEdKsThwV3zBDW2qwgnsoKMLoVEBP/XPI3cdvzJ5suoemjhkL5Uk85kkSB6ZHln6GCaSgAIyH3E94tNOSsr5LsG/QRUYN7QcAPZj5Uq583Gexhlv0u+9B6FGaLZy1KuiEDhmmK+Oibh4xaaKF+0OKFyrEhdZmm/tsPtTWTNK/PqukO002IKNglKmioU0nirLjFs6RAfKuO2QEc8s7KCFkYEa6UlrXwD3wWLa4R0U9QfS+XeywHP27JKg0oEoJUDmJSVfDXzAZ9MMNewLswSBi7BjXT1513qZbOiyFR9Vtz4mscE1B9kETS5krHyEgID6DqWtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hci8vjpMWbKsd2IghYkkRSow4Y6D7sVGAsUb5PFj450=;
 b=WYOKrJIgIcb5h0Twv4r7kfH58TG2QVgfixK3dhHGBv+NHADP9fA5SAVYmR8NnmkRPsy8V8th+0gK3MWs+E+PMC1RaySsxcXPxojp/L0vOamONfJt+wKmxwdrF2EynJt5xOtZNlcSFtbXDKlkxaa8cnhnioFQCDxQoH3h/Os4nNFC4HkAZzTzepRHkNuod2/ExbD/CKVVdUMKQCFL1Llcul0AA+c8q6INOITZ97/YMdtDskgdN2hHAX6w8vOR7EnJ0OiK91pu+PbyrX+shQ+njm+h7U5poWjWj7QeX2YzffoJQjsGg5qPvaAQ4r+Ib5pYNaRo2zz+0MoNfmq482Dg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hci8vjpMWbKsd2IghYkkRSow4Y6D7sVGAsUb5PFj450=;
 b=YwNDHKdH682LGNEsH5YhSbVP2mPHRhS2APqGgK04br5W6VNzzmWV9eQ8KlSCXDn8cxMLe7ue6fxpdFO6t5lto0dt4D6DnbRUMHFD5XMwAV1b6j+kUqownFgdyoC1V1CkEgE3vVGa4hTKvMSr/qHnURjQrhUsnQ5JaVm/YR7mHQ/22jLnblFoCQzqhSO96xwMltz2YMDV2VtGcJQrUh4OuKqsc4NL98K9CdVjcKLuWN1TEHoGvHYEoRH3YV1rMaPPBIx0Ari3pcKR4H8iWJuj5noEoiTKW1hb0Xk8ZjHQIxSRMVz9p8iDGFHTbFawUj+H+btentIuZLQXtu0FLEvBWw==
Received: from DM6PR06CA0025.namprd06.prod.outlook.com (2603:10b6:5:120::38)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 10:25:28 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::46) by DM6PR06CA0025.outlook.office365.com
 (2603:10b6:5:120::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Wed, 12 Oct 2022 10:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 10:25:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 12 Oct
 2022 03:25:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 03:25:15 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 12 Oct 2022 03:25:14 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jilin@nvidia.com>
Subject: [PATCH v3] xhci: tegra: USB2 pad power controls
Date:   Wed, 12 Oct 2022 18:25:11 +0800
Message-ID: <20221012102511.3093-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc3ef32-7ecd-42f1-1df7-08daac3c1502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4kyxKmeeuNqCgbU433aOaLPiiROF1vQQ7wPij2X+LJ/OjAjHVN3LRdARbxk5z93Obkr82qi4dIpYckxGyW7N7rE0Ga1/Sfda5pxa/4gkPoSc1f0SZElKC8CD/++SSgENn+bukmIzGNfwXnjeQ2ehl4h/0PLXUAHzLbra0uRElecDjZa8LhyLCJz4vp6SOG7h1Dbb2g2PTHDizZJrieWGok9n5pexyq5eC28R1XA9cSVqQis4XVWSiZGnwoXFBgeFYUfFBmI4+khugp15OeQbyWE6MlF4jioAIEaFkXrV8aQW9ye4om0fGvsauSK8+ffMGPAh4BmLMpWGRtKIOAFcYn+5gTh27WHLCEgWlqzrZ/oJOQp/F8O38yPOmiDkMgTEEaS8Qa2I0saY+KDlSyvyRvfoboC4l+ROvnHqfBLw+xkK/uOX3ydbV/pNnrOf2c416wrL44nBx4d0x9Rk6D5JifIlnNcLcuxKQ3y8JCmVXfHjpI1dmKCjcE+ult9LD02vYEkzpoa0W6f2p5fkiGrbpkGM8rd7p6/7sYG35xPkwTSFHxe4wYlEoiILbXsYTI791vDJn3JlPfiMkxpuiytgk9gnvAQ/Uc+BihBCIoZuw05uJejqhVOYeLz1SarNoIlxUGX4+lP26HK5K5FSm/1HgIf3dMiU4xr1681QeX8S9AFrwSW6KQRRl8bYM/08p1Rv2LBh2gXg6LP23kzpUDGNsFmgQ5LBUTG+kRodAxvMOsJ4/5wmmQRkcaphcB5lI73owuPifFoaOOWDuzTgLq77A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82740400003)(36860700001)(5660300002)(47076005)(1076003)(426003)(336012)(186003)(2616005)(7636003)(356005)(2906002)(7696005)(478600001)(70586007)(70206006)(26005)(6666004)(83380400001)(8676002)(316002)(8936002)(82310400005)(4326008)(107886003)(41300700001)(110136005)(40480700001)(40460700003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:25:27.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc3ef32-7ecd-42f1-1df7-08daac3c1502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
v3: No change on copyright

 drivers/usb/host/xhci-tegra.c | 139 +++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c8af2cd2216d..996182a1959f 100644
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

