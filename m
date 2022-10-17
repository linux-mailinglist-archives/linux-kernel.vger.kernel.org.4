Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4F600F35
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJQM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJQM2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:28:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E833741A;
        Mon, 17 Oct 2022 05:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rma27k4dWvnXU1ii1GQIYBL804V/kO/gxbE8eTBi5JszJrOl/Ew09mtUNxn87A1Ja26xU3l2wTZoqGcuwh3th+eHHW8iORQIt3N68D68TYVmlINjplO6zJv8quMWkNTtzOt/DCtBP8Jx5lrSrnsUmrG/HbMaroK6TIC9PQbOH2jgtHoF5SqF7FFTMo2HlGEgyj2e5ncnX+s73WAWxRTxFKO5u48faUEsWsborsTX/RDCiD43F0BkYbSd0RtTqduSDShFp9pbsvT0rixCAlAAUj2OC5frY89MjhrUVXnchW08PYF22xMIXBvkVMz2KcZ1kwVY/xpvyZ7QwowgWSuolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDFje+vXq10mBg3uriKC0vbeyUHdcQcx+LxgwuAU2lQ=;
 b=M8QIDKjXWXHyesd18/7o/8leXnIua6cylHwuIiaabF6z8EDOiqFDM4zj5ANcru5s0edr8Oj1kF7NFqW6HnjUCgxY4DoPhhbTUEYEhEeFVZLdNG9aYWoHxk/j6qONbH4qqwxuCix0F6E9hoAhqvpsmAA+5mRgNZXXcFkmURjx09HnmPZl4ZeeOe4Qn9umfB62f/vZlc/CE5gSpKV7frC+pPXE0Tc7TYGxYrKp6bNP8pFO58P7rPqff6j+T8heKgfnZpv6ytH9kstZElMotEtLWZICaIHrUfJ4A4mkldLIG3Q1vjOEn6DPzVy0dlm8Fgky/wBLGoftyyg9Gs/wL9sxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDFje+vXq10mBg3uriKC0vbeyUHdcQcx+LxgwuAU2lQ=;
 b=Dqfy7j9c+ZoLj0rSFBHfaF74aq4QoxIC2aYRqrBTkGFfOK8IqqvTbhLZshvy8gf1DJj7lo71w53SEVPMR+uTMVA5PC55M0fuYnqyXDIV4WYSbdZl8I2wyUvlKpdWc64l7LutTo4z+5LvIVLTNgTJjO5YxubkQkFlyw7PaC14zzP8DLmvumwLO2Zm8VEWm0mXjsdSOUTo/8BriHRNnQU+Fr7FjYgZ3b/h30BB16o3zm/yPpUbigc+xdhoiZW1SmdQw3L1yu6UPO2T7ix0If0Wql0sWGf87MbStCbG8wdG5+oRHULvz2jtMno5XiSunqQy3M2ikL61hxvyHe4W4YmOOA==
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 12:28:50 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::12) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 12:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 12:28:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 05:28:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 05:28:49 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 05:28:47 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jilin@nvidia.com>
Subject: [PATCH v4] xhci: tegra: USB2 pad power controls
Date:   Mon, 17 Oct 2022 20:25:31 +0800
Message-ID: <20221017122531.9923-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: c450ce88-eb33-4d34-91af-08dab03b25a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUOqJPEMSX5lPlK+cPdalLMnj2Hn6pWUsLuI2P5bjtXVwGiBGDIP6RWv2DEi4D7yoPbCvoTeBn2IuwGU8ThLaDEX7l5NHTVZgV54BRaIHqL5uonYTTMQCqvOyymMarq9h5J0X6T6FJvJpTbySMS9Q1wdl5z6yN8i7kSZihNETYQlg7N0mEqDuKCWJ85c0i4d59ckpXI/hXOFeVVLZ/OAtc76ywO4TlxZtTxxAcTiu8WwkitT0ytg7qcwLoPYjrqyfr28Vil548UT5AeL7jJjJ//cI5HJ9rnCmmFmTVa4Sj1O8zRQ0/OTIz/BR/iFinpJcb88VgANicBKuNprxKnQa7EqD67FhEY6Qr0ABuzDm2HM4XXtPqdxUJBjmUqBaoAtej5KMEy9IEL9eFFkAifc+P33FKBIPGO8UytpA+P54kAhSvv6NghyOKsWBrlPTjz4lhcyuBtI8SGC+m6B/3P04Sb83RsW52NCWWaGXr+NxU8duhyQ6Y0kSBJUQZO1yFKmEMiZvZ2IzNvFW5sGYC8STPnhXZri90VHiHce5kltgNKSouE2lAk8Cgi2ec19wbSdfwMVmtl0mIPyItkzMHvLc1nVr26UFgEO7VzkX9B0oKfSHA2YoFkCKo9Njbvm7yfL7eSLzN08SoKp2/kl7KhHIrAY5UDaTs2MQ+E9I/HCNCE1231U8SFL9V7RnORjK6nvi3+xCeKOTdTfV4MNQ3Cf0xXHP4OsGVhbQaCgCT6t8Ss8HjUYZ4B7JA5KDAZjrmp6R+UBM8ueHDX/Ho0K928JTg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(110136005)(5660300002)(54906003)(8676002)(316002)(478600001)(7696005)(41300700001)(26005)(1076003)(186003)(2906002)(336012)(4326008)(2616005)(8936002)(82740400003)(36756003)(356005)(7636003)(82310400005)(426003)(47076005)(83380400001)(107886003)(36860700001)(6666004)(70206006)(70586007)(40460700003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:28:50.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c450ce88-eb33-4d34-91af-08dab03b25a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v4: Remove hcd_to_tegra_xusb() function which is used only once.

 drivers/usb/host/xhci-tegra.c | 134 +++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c8af2cd2216d..a47454503d9e 100644
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
@@ -274,9 +281,12 @@ struct tegra_xusb {
 
 	bool suspended;
 	struct tegra_xusb_context context;
+	u32 enable_utmi_pad_after_lp0_exit;
 };
 
 static struct hc_driver __read_mostly tegra_xhci_hc_driver;
+static int (*original_xhci_hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
+	    char *buf, u16 wLength);
 
 static inline u32 fpci_readl(struct tegra_xusb *tegra, unsigned int offset)
 {
@@ -1949,12 +1959,30 @@ static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
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
@@ -1972,6 +2000,23 @@ static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
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
@@ -1980,6 +2025,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
 	unsigned int i;
 	int err;
 	u32 usbcmd;
+	u32 portsc;
 
 	dev_dbg(dev, "entering ELPG\n");
 
@@ -1993,6 +2039,15 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
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
@@ -2066,6 +2121,8 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 
 		phy_power_on(tegra->phys[i]);
 	}
+	if (tegra->suspended)
+		tegra_xhci_program_utmi_power_lp0_exit(tegra);
 
 	tegra_xusb_config(tegra);
 	tegra_xusb_restore_context(tegra);
@@ -2437,6 +2494,79 @@ static int tegra_xhci_setup(struct usb_hcd *hcd)
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
@@ -2444,6 +2574,8 @@ static const struct xhci_driver_overrides tegra_xhci_overrides __initconst = {
 static int __init tegra_xusb_init(void)
 {
 	xhci_init_driver(&tegra_xhci_hc_driver, &tegra_xhci_overrides);
+	original_xhci_hub_control = tegra_xhci_hc_driver.hub_control;
+	tegra_xhci_hc_driver.hub_control = tegra_xhci_hub_control;
 
 	return platform_driver_register(&tegra_xusb_driver);
 }
-- 
2.17.1

