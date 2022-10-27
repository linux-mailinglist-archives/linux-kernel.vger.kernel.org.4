Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC560F918
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiJ0NcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiJ0NcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:32:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DB125034;
        Thu, 27 Oct 2022 06:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMeSwA0S9sp9AFvyqgqiefXSx/wPN0yM0kCKZ2x+1TSNmrTKhUOMtOEB4F5c3c+oQWiXJbZcr79L0EDyzjqVA6HeWuZhUorjTE7M+G7mcf3oA1QKZYItgno8aFeooIsjfUdptZqsnqPgGjOxI0WPNJYLw5qKUN2TtqimzwhjtQkhLM4mPE5LHETtF5KSyzFL6wrmDLSsndDoqy7M4cpXMGW7kCeIoJ9b0iPa7/FicKsxa+317uTmyGMHgo4rA40ZLuhVYKxmUaIQNEc8iY2nN5UVlnnYLlK2h/+qTKp0eNYoE7lXT/vdY2furRngiohGH7sA63ttDGYEINLVE3ouiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaJvydLKwOFfBftUxYrwO82mJPPZXDYpli/nKld76Us=;
 b=boOdQueoKqi0rL9dzc46WgsxdMEXSPwk5vYs7DxD0/Sj577SzRuvCBWkS7Dtw5P8sMmcvMdUOtqO75cU/Mcbn5Mc4feOOEsnawEhCqS+Txo1xCHdQqfDRb2LvH7HAu+7EZS3LiAkHx5UyZJmdnRLpJC7VsgyblR+7DmCdYqEnznvQLzFHXpXEvLTE+MDVxgth5PgdL8Bk4mjWkDBjqDBpfjIlsoczEOyfwNMKcDeBEpznHfRyvCp0GGWGiJdTPYicjtZbdrsTCeJ/jZIGVrz1es7vLAyVMb0qSkJhWqDrV0vWpllXw23LkexNgSVKtQJ7p2FXugtD40qd49gh8ayKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaJvydLKwOFfBftUxYrwO82mJPPZXDYpli/nKld76Us=;
 b=BrITjSVMZBvpQjtjoo2WNfcSKlBpWmcYctUKUBA5HroqyLN93DsiP6hJQfwqr5vKk6l+yW3YhHFnA60T9bvPL1zXNKNkVc85vEK7KWy5eHuP+LNmH4zFHcq0eXjShLum8Lx0//4yP6rEvWUUCs/nQ7WVdV614C+fZvFO36WAR7XuqZa18mJ9+E+3w0dkG4U0jWsWFb/5X0GBxpg9Q5+dGMDqhkje0s+jfaM0w7425UWuGukVyeWVTo++RMqc2jFIqvfM6T8B3yZNE/PZ7kC68EJAkkjZBFqswm60J6fNNRBJrhi2D6XrsnIiBXZD/RcBpIRjlzC7xwkoS8NbgC/ifg==
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Thu, 27 Oct
 2022 13:31:59 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190::4) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 13:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 13:31:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 27 Oct
 2022 06:31:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 06:31:45 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 27 Oct 2022 06:31:43 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <jilin@nvidia.com>,
        Petlozu Pravareshwar <petlozup@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 3/3] xhci: tegra: USB2 pad power controls
Date:   Thu, 27 Oct 2022 21:31:27 +0800
Message-ID: <20221027133127.27592-4-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221027133127.27592-1-jilin@nvidia.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|CH0PR12MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cdfea5-1ade-4698-93d3-08dab81fa019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8r2oOu+4G21yPk2Rjat6Wqrgns8diWxwQTXjU+8yyERcbZAMGSaxDxS8EkHJlX7NjEJLKw8bax3J41PK4k+4qdGDnU+mOS+tFNZnV4agY24vxTcv7WmmxScCQU32bYxJi1n6IAvlSlJi9pCWG75hPr8F6dXExKYvIhkBsMlcaK/5ecpKsXFIDis2mE0cxLsDe20IugcaQnjaioebmpY9mc4ydd5NoLy0D/0+HRax9KvOyFrZaUex+yqjGwC9sMax/EgTZBTbK9E8z2/3Hh9oOhjYNtx5iOW0XRw1csWpGCMEbOtLhy+WHMJodNlyHwO+WFlAhW0RpKcLhOjqinP7ptYtpMObqlXMvAyZzed95z8exld05iG458aYdbxcFt7ijubw+wjfhNfKzdiKmIvJPjKe6P7fGRebWrFpJWy+Tg5fu8jeoI0JNs1aBCHnQA//un1HFYpYUvbvkRI8mY2ITZyl/l8IDAG1IupcU9BcqhAaXydfLioKA/XJMLYhhkm2eU6OH4JNGLOM/+D0hjxi0VU4eJnz8usUwZluz9UTPGz3lW/9fws1RZfYgz+Wfy5MeCGyLatGXYQEDV9krvUd2k6mxgsnue/b3Q3TsnA9XBmDx71QExAEYDN789IcT3w5UBQ7gA7ZhNxwQ9MwmW1hDF0wYZi4puSJg6SN6SFG4cFSesgTPbBnvB8Vy3rnMlPbsFt3HPwj4F+Zb8/mO1Z3boA9HsP1GfvivPF4MKiFfuGDEYUlYYnDIdEnxJn5ar0h3GvediFciLGRqoZzqR23Kw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(356005)(7636003)(8676002)(82740400003)(40460700003)(107886003)(40480700001)(8936002)(36860700001)(36756003)(5660300002)(2906002)(82310400005)(426003)(70206006)(70586007)(47076005)(336012)(186003)(4326008)(6666004)(83380400001)(41300700001)(86362001)(110136005)(6636002)(54906003)(2616005)(478600001)(1076003)(26005)(7696005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:31:59.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cdfea5-1ade-4698-93d3-08dab81fa019
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
Signed-off-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Jim Lin <jilin@nvidia.com>

---
v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
v3: No change on copyright
v4: Remove hcd_to_tegra_xusb() function which is used only once.
v5: Update .hub_control in tegra_xhci_overrides (xhci-tegra.c)
    Invoke xhci_hub_control() directly (xhci-tegra.c)

 drivers/usb/host/xhci-tegra.c | 131 +++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c8af2cd2216d..f685bb7459ba 100644
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
@@ -274,6 +281,7 @@ struct tegra_xusb {
 
 	bool suspended;
 	struct tegra_xusb_context context;
+	u32 enable_utmi_pad_after_lp0_exit;
 };
 
 static struct hc_driver __read_mostly tegra_xhci_hc_driver;
@@ -1949,12 +1957,30 @@ static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
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
@@ -1972,6 +1998,23 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
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
@@ -1980,6 +2023,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 	unsigned int i;
 	int err;
 	u32 usbcmd;
+	u32 portsc;
 
 	dev_dbg(dev, "entering ELPG\n");
 
@@ -1993,6 +2037,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
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
@@ -2066,6 +2119,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 
 		phy_power_on(tegra->phys[i]);
 	}
+	if (tegra->suspended)
+		tegra_xhci_program_utmi_power_lp0_exit(tegra);
 
 	tegra_xusb_config(tegra);
 	tegra_xusb_restore_context(tegra);
@@ -2437,8 +2492,82 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
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
+	ret = xhci_hub_control(hcd, type_req, value, index, buf, length);
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
+	.hub_control = tegra_xhci_hub_control,
 };
 
 static int __init tegra_xusb_init(void)
-- 
2.17.1

