Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27466ED6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjDXVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:49:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF904193;
        Mon, 24 Apr 2023 14:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm1iEE0iFvKgBilqJimxSu/YrdMZarc5s2QWXiZ+h/z4GTDdsFaslY36p1+fG6fFYm34+ZXibyzMe7blNcJPGXzKvwWgwM9x6tsseUqe1hN9h5U6uG0WMr/xQ4IAlEHs3WlcINOg6KhArMJcgylm+uLoliZMEFKGyU5UBHxkBJGL1eCawOv8LeHTXVvWdcCL7wowM/8rzyHxBD7XAUuLp67ehN08t/WAl52J8dB3Fo6tcPO6Z06cwuQbySbL8KLMv+3jon+7NwWZy15MHiJYGWNvVylP1hZ7qEyFJ97dP1xs0XdcGFnGihmRFyaduA4YUpq1qupYEthwU/vtRddMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND2R08TpsvAE2KxRP6Icolm7SdLSfmpFU+pcvWKFe3o=;
 b=S9+0Blc4iM+flocUByAmYurYBAVvPSmx1/aBug6r6GMuz4fOMWZgU1iqMjewPsNFmoszF1MF+T5+lRMCc5Nl1pT7PqWBxxYHJvLcTGRwm3Bh3tWwnQnWrlmQTHv7i/3Cmryhzx9Sha1GfI2Bpa+omH9zKKEPUNv4Sq7QUdY9/bHwxgjnq8Dv3mb1i4d9vOHVhZFKYyIyxLvLo8awsoC6/NjfIlOmCDUW65bJMk6b7++i9Cw0f+PjH9yVKGyDcUpR7BIUyzn85i/5Nd8OrzYB8dMY9zAv0rEXcJ9b4ZV+9YD5tEnDTBaFoShsASUMJYPLu02RZPGvwUUbueekGbPNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND2R08TpsvAE2KxRP6Icolm7SdLSfmpFU+pcvWKFe3o=;
 b=iHG2TWyeIIxgEEEuZQONIFiJ+wyFQyMU09Szfo5ka71j2ProyxfOcIom0OVme1yFYOgoM2O/5k1hyBTw3Z5Pz3i8f4B7qpiXV4CQpIrhQaHtVp0fOXFHYuaw0NYLHG7CBIOIX3LHOnX+xISIB5od4p9t/w25F53hHfr5gBQqyNo=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 21:49:13 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::51) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 21:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Mon, 24 Apr 2023 21:49:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 16:49:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] xhci-pci: Only run d3cold avoidance quirk for s2idle
Date:   Mon, 24 Apr 2023 16:48:59 -0500
Message-ID: <20230424214859.3109-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 479f8293-4b67-4657-0c69-08db450dbe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UatLAbqmXQ2XZQAdqFd17/PnkjrQgXFEmJomwWlBdOj3nimHvRFiJ5+RFX6Ubt0AFm4DNcRc0sXxfmD/VoEdEoUgH49ePhRy70lsykRwP+7khFQP65GnHnVmd1pJuDMz9kc9dhSK9R0ZLiPqJpEFWDMl3qg9Ra/QvsXOeO91+Hu6bqvV1S/yOdiZ6vhy7OWHGxS8h8MeDkUtF4aXBo2HMjYBpqc8uHJfdYNJ01wT63cddwP/jJHNye/A8AApjv7OCNr15m95HFYFpL50uuXtTMEX14BxI/OQScJklwZ0CY4WoY33NX5DWaWPv+fzy2dtkSuPEF9obZ/ZVyj7OOPfzOfwwyBNlGHCLlZE9fVQQEusaLiEEnnt1YVlFbhnKDpkDDBQkzyEsROcZuVXdHrFtMCoIIi++YC+l5rSKvGGbjRxevPqVjQzFhISs3OiT5Vgklf4KCw9UQS6jFZ+mdmh00PTSy3YaDbcyr80ZPdlGIWmwYqJRsAQSiJGQ1X/q3a42a0O4D//mTNXUoNSWOqj/W/gJFpaQu8VwvRN9O4JaHwD0Yji+dpMxac+97UX8Kndr8IatzkEAYCCokcHNt9TA3fNcv2mtapx8PrV8Vgm8oeBC0eo8WE1PPcRon39n6bhZAp5cV9j+Nkr5bk9sR+t3O7HxJDNDgT8MkgcMVobL5sX3zEmcjDGaHYcbY1SiPQ24eRvs0cEPM9ciHKruNSRVDQM8yhzbODntPtyYmikNbquI0LI3kLx3e/rxdH8whF7An2Cr0mf/xsgXm9fIRfpYai8DlGstZ4m1vaPe0/9ziI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(36756003)(110136005)(40460700003)(478600001)(82740400003)(316002)(4326008)(40480700001)(70206006)(70586007)(356005)(44832011)(81166007)(41300700001)(2906002)(8936002)(8676002)(5660300002)(2616005)(426003)(336012)(1076003)(26005)(86362001)(186003)(16526019)(6666004)(83380400001)(47076005)(7696005)(82310400005)(36860700001)(42413004)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:49:13.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479f8293-4b67-4657-0c69-08db450dbe51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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
v1->v2:
 * Guard against CONFIG_SUSPEND not being set
---
 drivers/usb/host/xhci-pci.c | 12 ++++++++++--
 drivers/usb/host/xhci.h     |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6db07ca419c3..1fb727f5c496 100644
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
@@ -609,9 +610,16 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	 * Systems with the TI redriver that loses port status change events
 	 * need to have the registers polled during D3, so avoid D3cold.
 	 */
-	if (xhci->quirks & (XHCI_COMP_MODE_QUIRK | XHCI_BROKEN_D3COLD))
+	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
 		pci_d3cold_disable(pdev);
 
+#ifdef CONFIG_SUSPEND
+	/* d3cold is broken, but only when s2idle is used */
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    xhci->quirks & (XHCI_BROKEN_D3COLD_S2I))
+		pci_d3cold_disable(pdev);
+#endif
+
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
 
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

