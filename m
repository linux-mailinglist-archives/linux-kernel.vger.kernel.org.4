Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE345F700D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiJFVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiJFVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:15:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0481EB274E;
        Thu,  6 Oct 2022 14:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsUFB5w5c+dC9ZF5Ww4QgCxfvu4erC5XO8MXdT8zXec81R76vd40T5+UmFAG1kPcYnjOIiI+sOcBR26ThqEFJ5nUfzmeLU6udbXKC9kAxLYhrxsq67BV9dkJPfu9qnfdu6Zm4kbYdSCIzsaMXMHx1E3i0FYcHFyTn3LbJ3yHSzZoPRQVVi7AwgDrdU+VMEEmnf1clGPMvtN7ScB76vFtaJQZWduchxP8juhPB0O5EKbOrZeLZs7Xlokqi7BZx/aswmhHu0/XzRFUgXiQ75x1kc5om3Bni7ABKW4io/ravqTLmAvaX6b3hz7gyLhFlc4PAIV/YJ1CWeDtkRURfFHDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy7II8PwCaJKzoOpY6yjmJMrU1zimTllkXxXT00hyWs=;
 b=e6tO3rdcqav63FQs3s7TrC79yqHc71xjg3VzCaNZDRq+/Ch9b0mXzmIPelxxkhc8tSOc8Azp4p2KRhxoZlOC5+LjEXEHKsWx+cUNMVQWfR8Ka/9FhCi/6BT/mxPZ4iXtNb4gXGf1IVaqXa6zXbbeAnRrV8Rho6OC7hSsy/+mZAEEqAE1YX7F9CCkni9AWZqjTBJTG+/5fcwgg7RfmKBngE+gDQy/awgp2CfAUQ+cqvxAxBGZSGLBNqJYkP0bQQXFu6+BZr+Cv/39zOh5eiFGtX1pGUUwJalG6sve/gvkBNS+01AS5m0sL/iRMsqEPsFWHmTU/9MOcr1pRFfR/L3R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy7II8PwCaJKzoOpY6yjmJMrU1zimTllkXxXT00hyWs=;
 b=UXjzXQWyeFwQh1WHmqOtl6aDkm0+1sSSYh6SVE0NiD4/30kXX4SuFhEfrmwHMj/v5L8QAEAJEw9DlhCpFI15cbzntw4OzXJh8sbAX06yd5oVyBM33i9YMwgJzSSPin1QM6hcAAvjEkEMbNqKMLyoCmzlAoUBKUTdMOCayPgBFkA=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 21:15:40 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::a5) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:15:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:15:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        <mika.westerberg@linux.intel.com>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all xHC 1.2 or later devices
Date:   Thu, 6 Oct 2022 16:15:28 -0500
Message-ID: <20221006211529.1858-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006211529.1858-1-mario.limonciello@amd.com>
References: <20221006211529.1858-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: a1185982-d377-4039-7fe3-08daa7dfec10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLNQQwTeujZdN9UgrvHEgtLqdpye0dAv5tMIzNIfIhzoriL0NAwuSXBGqosQABMK1WlprDM3aaAq2rtqZf4zJqLqphamDRzP5DrYafdCs7g5vxkbpG7KCfieZNVllSaOw0rSkw4WB3gF9x1rUTcMcwTWPidYPpkkU4GujiVxYdeAakb+d79RW4RGpstOxXzF0+JtriQjpKxhJbDmXzwWWX5ua7bOox9uxNnonxyahxE9GVPk5GA4uWlCxWQNtyAoow9PFyiDtBE3DWmX5j3PrfFQSjKLu1bY5rIuKeDsV2aa7YuPNpFkLn9ymeFMVx61Zk59jjgMjhEg8qUAUd11lOcWxK5ykQ76TlNuEjTkqskUnF94+a11jbu1w/kq6O2UcoWWibrV9Oi+yiAN0SN/Dm2FOiqp6QvunkEbp86oLIXo28zcPZsNapC6jASgjNvIH6iMdS5FnAVVBjJG3xK9ds9JC3yawlCmhVoL+yxKW9Q6wW5dNDo5+ISrE9q+YPh8zn3NaCa0XlEnU+DB0P8bPorgovsTrLrX52LqJg1qoNSl5NnKyvQYiN3dS5yj3hy3OiUS9ZvEXZFt2P+/SUKb14/qUK+IF0yfQNgWFJE4TZya6lNMrIlfIDUeJJ+yg2rVKaW3rjOjhe2ylAhsgdCAThIflJsRIqWZDoreVgP/RJqadc8aG9dKEPpZuKQOxK2P1IQRXLKzli7tadVe/0CRzTooukBSJmnfTewi9oyEry7TUD+V49/B/XPHC2nduTycq/DnLmzn/vVzXpZgg3JsWzjdYjd3f35MoND4QE0L1QhuhD02j3sb3G3A9L3P1of1DrmCZ//n3dR/sbUkxTAcMaz0pDJ3h1VnxJ1ft+WPGgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(44832011)(5660300002)(316002)(36756003)(110136005)(478600001)(36860700001)(70206006)(70586007)(6666004)(54906003)(7696005)(4326008)(8676002)(426003)(2616005)(86362001)(41300700001)(356005)(83380400001)(8936002)(40480700001)(81166007)(966005)(47076005)(82310400005)(82740400003)(26005)(336012)(186003)(1076003)(16526019)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:15:40.5459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1185982-d377-4039-7fe3-08daa7dfec10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For optimal power consumption of USB4 routers the XHCI PCIe endpoint
used for tunneling must be in D3.  Historically this is accomplished
by a long list of PCIe IDs that correspond to these endpoints because
the xhci_hcd driver will not default to allowing runtime PM for all
devices.

As both AMD and Intel have released new products with new XHCI controllers
this list continues to grow. In reviewing the XHCI specification v1.2 on
page 607 there is already a requirement that the PCI power management
states D3hot and D3cold must be supported.

In the quirk list, use this to indicate that runtime PM should be allowed
on XHCI controllers.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d340..0d2d1cea94a4f 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -69,14 +69,6 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1		0x161a
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2		0x161b
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3		0x161d
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4		0x161e
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5		0x15d6
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6		0x15d7
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7		0x161c
-#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8		0x161f
 
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
@@ -336,15 +328,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
-	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
+	if (xhci->hci_version >= 0x102)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
-- 
2.34.1

