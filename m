Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844C16C31DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCUMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCUMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:39:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DFA4481;
        Tue, 21 Mar 2023 05:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dmfg2EDBRoPvyOPyEo4JsZ5h+R2Fp8KWUEiNRSsQJfiVCZKYlOpoCd8oMvLSHl0iprNaK1jnYPj0/mtiK0R2r6zVtnhh2wv4bapmx/5H/hFFZqEUuAVSKpsLEi8vfSa4hJ92CKf9TQ7Hgq6+CfacZECjkzc/p7QtfsLyfKEKnq+W4PTmm8uiwzwzq64R0ufuNA4LHmA4XVScLFXm7m6XjQPsa0XbMCQj5CkKgDGXqXlA7VhROZ9+AcnQrWeXE70CPysBC9xcwXYzr6Tzj/VVjU2CZe1IetzGeJHvAvtrzAB8xeIcg92AxMv38EG7pwriGKMGHmv39tIZJ1qm5OL6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi05toNJXz/rs0Dvqoiewl4UTdYJxCp8LhCVrGszmM0=;
 b=O2tDMVtP/I2uo0N9ySKFMTG2N9oZR2Q+OY7tB3CmMzcjhT5c942eVjrz1kjHCA8cHP2zHTo/3kl6BZd915QbQe8H9Irf4GL4rZXrsXgeKR6W+kvLBT/lF92SkN6U8S9bPKZM7Ag2wLGCtcxqHc163LtRfjT6ZXFmkzX75lSA74THV2MvXRNsz1LXs8DymIoE0HvnRJM1iLEgiqiJyNIyyKYx6BRjxeGantancj92yOmHraKBzFJjwQh6IhDeNPD+gMR05s/FFRSh/6Ws1K+lXugNLvLNGPVcJN7WBj8+p+X+nuvBVMYH+ZMZXB/LHuUHljystpk9xzSBeEBKKrStyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi05toNJXz/rs0Dvqoiewl4UTdYJxCp8LhCVrGszmM0=;
 b=2to/w2NTgt5UB2WJD6t8OBf2TP3HSqo35rBrXIHeR0cKlzEsilzaQGXX5LRRk/Zuo6Y2APVtuc9p9ETQORPHMz92gnDbb3XcdITsaFkeawiFmEz2O2c0OMcxw6ThwnvMTTZ2wuqyOxGe+q9yDQj5fsiDQi57xzrEp/ygZCAwdn4=
Received: from MW2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:907:1::40)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 12:38:47 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::38) by MW2PR16CA0063.outlook.office365.com
 (2603:10b6:907:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 12:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.204.84.17)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Fail (protection.outlook.com: domain of xilinx.com does not
 designate 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 12:38:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 07:38:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 05:38:45 -0700
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 07:38:41 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <robh+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>, <kuba@kernel.org>,
        <steen.hegelund@microchip.com>, <bjarni.jonasson@microchip.com>,
        <ioana.ciornei@nxp.com>, <likaige@loongson.cn>,
        <harini.katakam@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH net-next v2 1/2] net: macb: Enable PTP unicast
Date:   Tue, 21 Mar 2023 18:08:35 +0530
Message-ID: <20230321123836.6906-2-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230321123836.6906-1-harini.katakam@amd.com>
References: <20230321123836.6906-1-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb57b0c-dea9-4613-d678-08db2a093728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amHUDj2H7AeQ1rA1yw9cNXuRUYqXJRhlJgrxtIvV4CV+jkCxIg75++RFbhqOwg8QabcLpUSpxnSz4Cat03cwUUVG9mvd7hJ2brvQn4l//2yFmgkUczJX/64FGBKDuODWoARyNKXKm+ao3+PnU5VWcpkXxJ0J/YYeP0sQl0kKHt8miBO2KX4l5nx4XCg77nfBPlekzOe0eP7PVn+7HENj23jijio4JmOAVLO4lkDYUgApQgA4o0RgNxUqM8QR/42uZg6X1IT95tYpuOA+bLDQNLo7oDDbiC7gvjjqZxPkylJWYM9JxoDIEgwmIfAuPUaEHtgwk74rMInFGBwr55YOW90C11+LFJ5FA20kGyB/1YE0Wd0dmXCKW+pci9eX5U7RSphGsM+3F5VmslJHUgJS+QLi8DTBEurA7NwSdsjpA0fgEbn/R/76jpSYxmks746MKtIW9mix1vjuTAOSklxeZFo8UVCm/ocnP3IcgkeaZoz8v2KIurivfwQ9IDsIvfcTEpWKiclMt8sCKMF35GMgQ3WNRBStLv1DvQ4IEQ7r0lTKayGzQmjR57DQ/eFWDn7+7mr/jc5v1ECXkz+xybiDfFNoRmJr40ihFj1D1DToGFBI4k2aNgqYkYVetLAU3fWpzy2ZYrqF8YNZCop+gLqT9DTEtVZFe+JkTX+R2u+YTWd4G8H6xa6GIdwZQz/fHGHaSrpnaCJc90j8GMNjJqSaFtesPmBtNjzjcbKkrxCVCeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(46966006)(40470700004)(82310400005)(40460700003)(36756003)(40480700001)(35950700001)(83380400001)(316002)(4326008)(70206006)(498600001)(70586007)(8676002)(54906003)(26005)(336012)(2616005)(110136005)(42882007)(47076005)(921005)(426003)(6666004)(1076003)(356005)(83170400001)(8936002)(7416002)(44832011)(5660300002)(41300700001)(82740400003)(81166007)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:38:46.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb57b0c-dea9-4613-d678-08db2a093728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

Enable transmission and reception of PTP unicast packets by
updating PTP unicast config bit and setting current HW mac
address as allowed address in PTP unicast filter registers.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
v2:
Handle operation using a single write as suggested by Cladiu

 drivers/net/ethernet/cadence/macb.h      |  4 ++++
 drivers/net/ethernet/cadence/macb_main.c | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9c410f93a103..1aa578c1ca4a 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -95,6 +95,8 @@
 #define GEM_SA4B		0x00A0 /* Specific4 Bottom */
 #define GEM_SA4T		0x00A4 /* Specific4 Top */
 #define GEM_WOL			0x00b8 /* Wake on LAN */
+#define GEM_RXPTPUNI		0x00D4 /* PTP RX Unicast address */
+#define GEM_TXPTPUNI		0x00D8 /* PTP TX Unicast address */
 #define GEM_EFTSH		0x00e8 /* PTP Event Frame Transmitted Seconds Register 47:32 */
 #define GEM_EFRSH		0x00ec /* PTP Event Frame Received Seconds Register 47:32 */
 #define GEM_PEFTSH		0x00f0 /* PTP Peer Event Frame Transmitted Seconds Register 47:32 */
@@ -245,6 +247,8 @@
 #define MACB_TZQ_OFFSET		12 /* Transmit zero quantum pause frame */
 #define MACB_TZQ_SIZE		1
 #define MACB_SRTSM_OFFSET	15 /* Store Receive Timestamp to Memory */
+#define MACB_PTPUNI_OFFSET	20 /* PTP Unicast packet enable */
+#define MACB_PTPUNI_SIZE	1
 #define MACB_OSSMODE_OFFSET	24 /* Enable One Step Synchro Mode */
 #define MACB_OSSMODE_SIZE	1
 #define MACB_MIIONRGMII_OFFSET	28 /* MII Usage on RGMII Interface */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 51c9fd6f68a4..4c2c82573399 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -288,6 +288,13 @@ static void macb_set_hwaddr(struct macb *bp)
 	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
 	macb_or_gem_writel(bp, SA1T, top);
 
+#ifdef CONFIG_MACB_USE_HWSTAMP
+	if (gem_has_ptp(bp)) {
+		gem_writel(bp, RXPTPUNI, bottom);
+		gem_writel(bp, TXPTPUNI, bottom);
+	}
+#endif
+
 	/* Clear unused address register sets */
 	macb_or_gem_writel(bp, SA2B, 0);
 	macb_or_gem_writel(bp, SA2T, 0);
@@ -721,8 +728,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	/* Enable Rx and Tx */
-	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(RE) | MACB_BIT(TE));
+	/* Enable Rx and Tx; Enable PTP unicast */
+	ctrl = macb_readl(bp, NCR);
+	if (IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && gem_has_ptp(bp))
+		ctrl |= MACB_BIT(PTPUNI);
+
+	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	netif_tx_wake_all_queues(ndev);
 }
-- 
2.17.1

