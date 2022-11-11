Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6F625820
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiKKKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiKKKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043713D40;
        Fri, 11 Nov 2022 02:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h83g+PR56DuiphD8Kybf14ovNAEbyeIj+EuP/L/eyK4yS0EjG/gF5aENXmZbagz3vDd82Wgg7tMHiYwlWmzof9SDaopYJ647H7u1phEjiucvs5aH93MgZ6PyjFAD9lPDxljPL2Ctnjdx5tnazAY8ANx5yWDX1MPJTaXTUhLEP+XXpklx3Jaa3yA0RnI9hWJz5creHvT3MrCLRtscM4h3GtvbDJPA3a7RrM3J8GCoH13hQ98K/fcKygK35LSZbXwuzWIcuKMiV5Ylb7HWw3I45zI47tIyG0RxK9XSN8OErxt1OWRRR8f+APDWXJmXp2y2yZ1+HrGoMMorjM6hn9BZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzoRqvLZptzlUJGIvYAXwvy2O9WYPVPpeVtkFgp892g=;
 b=A6k29G7XuAXQQK7gAAw/S45haKnvHW4UtGZZzb+aAWGAZ2I/dvwNuV9HyVRsUOZUwE+hW+3FS9VJ9zk1LjSmRSczyjUzbloeGf6jpFq3KrVjzY6Cjbq83UZ1jX2r4YOt4uxMtbDfG/xngWVLucoJt3tvzJmQiMzER48q/JEy7iN+2HSLeXBlrIr5c1NIrGSfs4pcjsTilgcjpKg6iVbxmVcXyUR8BmK3nc+BIVFwj4wHvgp22iy1w3xQZG92/mApPjFOSLLI0MA+o8dEUD951XxXfYTlg8bmxSwIF4cFnda5MpXEyr83IgYvFVjMu9dKr6mUXRMRthaZ0NqQj11thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzoRqvLZptzlUJGIvYAXwvy2O9WYPVPpeVtkFgp892g=;
 b=jlzj0FG6UPRmNayqqvFeKOdjX2o4F3VKn6H5fZ7i8iUxDAiDfUnWwj9dcMB2QBVy383326XCqo6dySawUv6JxmhEySChTpGGJDN2qmpVUD7fFpQ0/OeeWu3pSMiXWUDPlWVlNnlczt9sGfqcVGQXqyb2PTMvMhNzHNcoidvfMrKys2YmBYyVh66o0a/0qwNJjbQVJciAqpI25aDltGgWK1tViVfAu4ePROp2UiWs53dTPPQ3NzsffJx0ojxkFrRt+QhE4tLPbSMpXNrDVVPrNYEWGQnq7KZjjHdvbhyXJFrU3qIL3ZUTaPJ/AFo0zK7n1QN90TIZWjboz3Erk+0ThA==
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:20:40 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::4b) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 11 Nov 2022 10:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:20:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 02:20:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 11 Nov
 2022 02:20:28 -0800
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 02:20:26 -0800
From:   Jim Lin <jilin@nvidia.com>
To:     <thierry.reding@gmail.com>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        "Petlozu Pravareshwar" <petlozup@nvidia.com>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v7 3/3] xhci: tegra: USB2 pad power controls
Date:   Fri, 11 Nov 2022 18:18:13 +0800
Message-ID: <20221111101813.32482-4-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111101813.32482-1-jilin@nvidia.com>
References: <20221111101813.32482-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed96838-49a2-4627-ebbb-08dac3ce6227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0kvDG3wM/a5ufjF3dNiz7haWpmJBoaszSpQTuCRISNBT4RnVr5SXiO6gpjk1RjSlEeDbbfIQAqnSXTGBYOO9EvQgt8NxP8t2xwkWXqcW5HJluJy0ZHfe+dAPo4gVL7kQQWSjjLRIHhwVagxfQR3t2mD5iWa2K/G0v2aeDKqfixKJba6eOZeZ8TA95CCKqoM+bCEnWqWcdDC9Etx3sqXqJmQCOYmnoYzxHzmRA2BtSE68yo42FR1cTb0Ju9NF0/Gd4WXj575MTr4+aLdsulr6vUEBkgpZNv28s2PZ2eGAQj4Oz+KjJBoqQrSjOQlW6I7SJFUyffJIt2hLAQ0NO7+PPxR4XjBL0GkbeBlUCoCOUphxC9E7jh9UcnwsimQx8QPhIbVYro366OvTPvpL0EDQmtaym52EkVri9SDdy2nL6v1fe3kw3BfHnUBXm3iJnyXodUE00UdFHgsEleqhOjpBe8OJVjiZcr5R7+fiNWLc2oKJ4JAcXHz9yRrEY/yg2PcYW793nsPh1tOrmEwIos0neJx7kfRuQl7Dy2UsdBjoiVmz7J3fTJwq8Wem1JlQ7ajdneCkNiW7rlThdCaJdPF78u+OtoxaUd2wg7vZbJ/VEu6GmDeaCqzODncSs6Q++p2AtSvYjn4Ihh4CU0qeIiiJTcEneyO34gm40ZjIRWjx1eP8tTtoVXrZJk9wcIbdEZvVtwZWt2rcT1/b46kv1ttQKLhqZf4ZatPom7E5pQp6OwPGDbjnox1yhDzqXA+6b3V+eL+Rg0bhkMWIf/7PKLVKQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(7636003)(356005)(82310400005)(36860700001)(86362001)(1076003)(70586007)(5660300002)(41300700001)(8676002)(186003)(40460700003)(70206006)(36756003)(26005)(4326008)(2616005)(110136005)(54906003)(107886003)(6666004)(7696005)(336012)(8936002)(82740400003)(83380400001)(6636002)(2906002)(316002)(47076005)(426003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:20:40.2871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed96838-49a2-4627-ebbb-08dac3ce6227
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petlozu Pravareshwar <petlozup@nvidia.com>

Program USB2 pad PD controls during port connect/disconnect, port
suspend/resume, and test mode, to reduce power consumption on
disconnect or suspend.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
Co-developed-by: Jim Lin <jilin@nvidia.com>
Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
v3: No change on copyright
v4: Remove hcd_to_tegra_xusb() function which is used only once.
v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
    Invoke xhci_hub_control() directly (xhci-tegra.c)
v6: Change author to Petlozu
    Changed from u32 to u8 for variable enable_utmi_pad_after_lp0_exit
    Modified tegra_xhci_disable_phy_wake(), tegra_xhci_program_utmi_power_lp0_exit(),
    tegra_xhci_hub_control()
v7: no change

 drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c8af2cd2216d..b5ed06ddbbac 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -274,6 +274,7 @@ struct tegra_xusb {
 
 	bool suspended;
 	struct tegra_xusb_context context;
+	u8 lp0_utmi_pad_mask;
 };
 
 static struct hc_driver __read_mostly tegra_xhci_hc_driver;
@@ -1951,10 +1952,24 @@ static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
 	struct tegra_xusb_padctl *padctl = tegra->padctl;
 	unsigned int i;
 
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
+
+		if (!phy)
+			continue;
+
+		if (tegra_xusb_padctl_remote_wake_detected(padctl, phy))
+			tegra_phy_xusb_utmi_pad_power_on(phy);
+	}
+
 	for (i = 0; i < tegra->num_phys; i++) {
 		if (!tegra->phys[i])
 			continue;
 
+		if (tegra_xusb_padctl_remote_wake_detected(padctl, tegra->phys[i]))
+			dev_dbg(tegra->dev, "%pOF remote wake detected\n",
+				tegra->phys[i]->dev.of_node);
+
 		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
 	}
 }
@@ -1972,6 +1987,28 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
 	}
 }
 
+static void tegra_xhci_program_utmi_power_lp0_exit(struct tegra_xusb *tegra)
+{
+	unsigned int i, index_to_usb2;
+	struct phy *phy;
+
+	for (i = 0; i < tegra->soc->num_types; i++) {
+		if (strcmp(tegra->soc->phy_types[i].name, "usb2") == 0)
+			index_to_usb2 = i;
+	}
+
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		if (!is_host_mode_phy(tegra, index_to_usb2, i))
+			continue;
+
+		phy = tegra_xusb_get_phy(tegra, "usb2", i);
+		if (tegra->lp0_utmi_pad_mask & BIT(i))
+			tegra_phy_xusb_utmi_pad_power_on(phy);
+		else
+			tegra_phy_xusb_utmi_pad_power_down(phy);
+	}
+}
+
 static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
@@ -1980,6 +2017,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 	unsigned int i;
 	int err;
 	u32 usbcmd;
+	u32 portsc;
 
 	dev_dbg(dev, "entering ELPG\n");
 
@@ -1993,6 +2031,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 		goto out;
 	}
 
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		if (!xhci->usb2_rhub.ports[i])
+			continue;
+		portsc = readl(xhci->usb2_rhub.ports[i]->addr);
+		tegra->lp0_utmi_pad_mask &= ~BIT(i);
+		if (((portsc & PORT_PLS_MASK) == XDEV_U3) || ((portsc & DEV_SPEED_MASK) == XDEV_FS))
+			tegra->lp0_utmi_pad_mask |= BIT(i);
+	}
+
 	err = xhci_suspend(xhci, wakeup);
 	if (err < 0) {
 		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
@@ -2066,6 +2113,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 
 		phy_power_on(tegra->phys[i]);
 	}
+	if (tegra->suspended)
+		tegra_xhci_program_utmi_power_lp0_exit(tegra);
 
 	tegra_xusb_config(tegra);
 	tegra_xusb_restore_context(tegra);
@@ -2437,8 +2486,84 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
 	return xhci_gen_setup(hcd, tegra_xhci_quirks);
 }
 
+static int tegra_xhci_hub_control(struct usb_hcd *hcd, u16 type_req, u16 value, u16 index,
+				  char *buf, u16 length)
+{
+	struct tegra_xusb *tegra = dev_get_drvdata(hcd->self.controller);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_hub *rhub;
+	struct xhci_bus_state *bus_state;
+	int port = (index & 0xff) - 1;
+	unsigned int i;
+	struct xhci_port **ports;
+	u32 portsc;
+	int ret;
+	struct phy *phy;
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
+					tegra_xusb_get_phy(tegra, "usb2", (int) i));
+		}
+	}
+
+	if (hcd->speed == HCD_USB2) {
+		phy = tegra_xusb_get_phy(tegra, "usb2", port);
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_SUSPEND)) {
+			if (!index || index > rhub->num_ports)
+				return -EPIPE;
+			tegra_phy_xusb_utmi_pad_power_on(phy);
+		}
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_RESET)) {
+			if (!index || index > rhub->num_ports)
+				return -EPIPE;
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (portsc & PORT_CONNECT)
+				tegra_phy_xusb_utmi_pad_power_on(phy);
+		}
+	}
+
+	ret = xhci_hub_control(hcd, type_req, value, index, buf, length);
+	if (ret < 0)
+		return ret;
+
+	if (hcd->speed == HCD_USB2) {
+		/* Use phy where we set previously */
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_SUSPEND))
+			/* We don't suspend the PAD while HNP role swap happens on the OTG port */
+			if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
+				tegra_phy_xusb_utmi_pad_power_down(phy);
+
+		if ((type_req == ClearPortFeature) && (value == USB_PORT_FEAT_C_CONNECTION)) {
+			ports = rhub->ports;
+			portsc = readl(ports[port]->addr);
+			if (!(portsc & PORT_CONNECT)) {
+				/* We don't suspend the PAD while HNP role swap happens on the OTG
+				 * port
+				 */
+				if (!((hcd->self.otg_port == (port + 1)) && hcd->self.b_hnp_enable))
+					tegra_phy_xusb_utmi_pad_power_down(phy);
+			}
+		}
+		if ((type_req == SetPortFeature) && (value == USB_PORT_FEAT_TEST))
+			tegra_phy_xusb_utmi_pad_power_on(phy);
+	}
+
+	return ret;
+}
+
 static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 	.reset = tegra_xhci_setup,
+	.hub_control = tegra_xhci_hub_control,
 };
 
 static int __init tegra_xusb_init(void)
-- 
2.17.1

