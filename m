Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479C66ECF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjDXNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjDXNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:50:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB9FA5E5;
        Mon, 24 Apr 2023 06:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlSY8vJLRsxMxE/90qpw1Ns9TkYWIP16YVU/IeWRQ8p2CIPW41XaybbYg8dDDiZqEvsnqvukjt3kM92376/UAJxMW3im7N6h8edYdM7Et0X3sTUh+/e/mDxUPbWkd2zZS2TS1AzeFuzEhIDwau+TQnWDBEj4fJb6rJfM+Ml+RUGwLbeNHW/aLSxDKiZaO/lCiNc0hUyE+kuTNPuGMsNuY8YFRPFF9oQxQoHc92goYhag68MShF2qekvKnLaBNW8h816UGGYI4f/c+2koXAKIik8l8A4UBpfakvOHKpFIlODev5tnrSYkC9r4jnRvUlJ86rX5utx/K15UdH9yMCHTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aam3CSQtJHj1U8s0KxhM7d6269T0LClljQP094TpLH0=;
 b=oSHVr069aeAm50kIKBSqDXDr0iJz5laZmMFdGq3rD2R3xQ81bi+LXVqcB0Hj89hh4k1g3NpXyHsZobfDRI2VXYkEjKFVJQ+bhL7BMOebUJe0JlCS9dnTNX6Il8VusUJ2L0ig14pLKVxb+V4OfZTAilQQap5v483h4WZSISRUPWhdufu+kkMztzeUYL41W5hmHupWnHT963oGLGUF6H989ciNciziBddxJGY6jERzmEbAjjFjhHpKGXf5KnE4EUWvAZZbGbO7ecWCyCxKXECxzNP2rCsNO94fdlq+EBSxIfQal1QBRST5PgHISCNiujwkl6SVxVyIeu/we1ZALOnSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aam3CSQtJHj1U8s0KxhM7d6269T0LClljQP094TpLH0=;
 b=QFNjoK2TWhjztZN4lbHseXNSyuPMha3dyToXeGBQUhtyUAKlV4MLfNL6eXMk/OsZ5CXfFA08GiTyqGWWUsZijw4PnLaUIHx4iY8x+wuT5vP1g6AwJ35mfi5n5bE1Lpmned4xkUaRhp1+jnEnUmbw7wCuhdjMN5PoZUWFJIA2e6I=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 13:49:28 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::6c) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 13:49:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 08:49:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] xhci-pci: Only run d3cold avoidance quirk for s2idle
Date:   Mon, 24 Apr 2023 08:49:25 -0500
Message-ID: <20230424134926.1416-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7ba74c-3792-449e-110b-08db44cab906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnigS8vxfCy7K8z6pu4UeIuhOK2m95XBj2L3RliT3JW89kp87WHwzercppD7YetP/TMgtdzXOAHLAGMPof/Kz5k4B0pCsy/9dsnS1X9BSB164mnJaNMlR9YNeu8S2hlpPHb+SIDJ4/klQNgiGKo9tbOWERjrrutHFnkJgukl014uRiS8de1LW08nVoejW6lfH4G2DkkzLNcfih842FO6e8wWxXPRSCRLLE4nogDHh2Y+0qlHSyjygjrZ78CJgYl99JkI8gKvBws4/nDYZYaDvwALHnYZ3pxpx/mOLPioXHibEklFGaixR4WVQAtq+Akoyy57i+eo830DbEdpy1LRw0Sp4gGOopGyEUv7LxrKi6Gd7rHJvJSJBTa4kvZDSuytMgTAuLOHBnQjioEke9f49DyJhpen5tVBuZBRW/kuUAhDNWLAlMHHFIVtEVThGzWA+AGM26+ST08qy1cx2zpF72dRfKGyhIbyfZF878ZsBxPSK0Jy4erfazpFi5mKGGKCETHXSiVOfje4URkOqUdxuYY4+ZCHtN+9QeKj8i7uDbz4HOLlqrloao6XHcKubXn0f+7TfBM4r4Dp13DFOkkIpWkUCuh9Mm57cN1yH7lNrb/+qfhlgroMOydsoyKyVyVX2C/He0ArhZhuHH6O5NGW4/0kdB0xPXAKGW2V16SLf2Inrtbx0t+09docYpbmeLfJZr/bef2YuGiGum8Yp7xd/f5oXV1Us6pLinypxX+jQJBW0lVQ/Wl2gHuaB9ND5vNQTrEMv7DngnJqhMVv6j9sNz8mXyX7kzkrhXIup7xRi7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(7049001)(336012)(40480700001)(426003)(2616005)(36756003)(83380400001)(36860700001)(47076005)(186003)(16526019)(40460700003)(356005)(82740400003)(81166007)(70206006)(70586007)(478600001)(86362001)(8676002)(8936002)(54906003)(44832011)(110136005)(5660300002)(7696005)(41300700001)(2906002)(82310400005)(4326008)(316002)(42413004)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:49:28.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7ba74c-3792-449e-110b-08db44cab906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Donghun reports that a notebook that has an AMD Ryzen 5700U but supports
S3 has problems with USB after resuming from suspend. The issue was
bisected down to commit d1658268e439 ("usb: pci-quirks: disable D3cold on
xhci suspend for s2idle on AMD Renoir").

As this issue only happens on S3, narrow the broken D3cold quirk to only
run in s2idle.

Fixes: d1658268e439 ("usb: pci-quirks: disable D3cold on xhci suspend for s2idle on AMD Renoir")
Reported-and-tested-by: Donghun Yoon <donghun.yoon@lge.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/usb/host/xhci-pci.c | 7 +++++--
 drivers/usb/host/xhci.h     | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index fb988e4ea924..c2c850e8abc2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/reset.h>
+#include <linux/suspend.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -194,7 +195,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD;
+		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
@@ -609,7 +610,9 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	 * Systems with the TI redriver that loses port status change events
 	 * need to have the registers polled during D3, so avoid D3cold.
 	 */
-	if (xhci->quirks & (XHCI_COMP_MODE_QUIRK | XHCI_BROKEN_D3COLD))
+	if (xhci->quirks & XHCI_COMP_MODE_QUIRK ||
+	    (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	     xhci->quirks & (XHCI_BROKEN_D3COLD_S2I)))
 		pci_d3cold_disable(pdev);
 
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 786002bb35db..3818359603cc 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1901,7 +1901,7 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-- 
2.34.1

