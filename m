Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC0700243
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjELIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjELIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 04:09:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FA611B56;
        Fri, 12 May 2023 01:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i45mtqPOH4AjiMl0DUHivWkxzAVxT3Tudq4S3ekyMXKfGAQTptpaYTPcOAUkBzYARGBUAlRRD0C8oRlV5epjEz2KYkCGPZA8bFsQD2en7nxG4zk1RiGAZqnwSd7fMifkE2cxC89Pi3x6d0IgR1UG5EFmqaVdp0c7OS7qqJqYjH7jHIrz2ClY7Pe3FCA/vcnhNNn68BNfwPTqViCe/sNUMCdKdA3osgC24NKWI+kuiu5Itlz/q8xvZpikuyhAd6SGT4xyRIXm6egCJN31k2PiAfgPU3m1gJ2regohfhENwi5DwqjFIiJFeyvKk68adcGytfmEGAy8oX4GWzFYE+eIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4//we3IhoNGzyNeBkW96AV0EdeKGiIT7YrztSsfn8iM=;
 b=AVC+0HDGcf6nRBvVfvLNGdiGptpG9vRFbx7Lf2AS+l6rBqIu70ZqZ8oZsbF2umlhNI/qq8NYazTn9LXbQIDyF4fvz6bWBiQczbrLbIUWUfn/EpN73wqO3MVFWMCDu2Sb7P2U3WXJFaxVP/n1TBCCcSHszFxexPnTpgs/qC9oloXDDawdbiYNJ8xl+fIEkQ6A9wOOwRm/0G/8RZjWiHH+HppT0ekr15Qj1WMUH582z+FC1UE6QNslCLB+2B2djXVOkgmEQU/f8TNReprLEYooNvEB7XD6zofRAMH1GE3eWunbAU8a4iwsnVXli1O6aCIrb/CHCKuA+PyNeSNwb0EUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4//we3IhoNGzyNeBkW96AV0EdeKGiIT7YrztSsfn8iM=;
 b=WJzm5ApHTAshr4UypF8c2/x0R9mdIrPlFYcLET0sUjkqsTqZoWD5A+PECoB8QG413xXcf8JazCFPed3EdoVkSljmCVRMoH1KMEMLycc5/WPlkyHUGzxP9IHyPRMjhGNbBY84D2FHLlrSJakvI8peFYWR6mQz87eXVQXaadshPQMaHOTJxA3IXnfZB6/N53MM/OORubZeyOhzPnD8gTaN5Hw+vPSz89T1vLi+8noVMAsP4un43rGIBNXXRLRcHjLhinYVl4ZrZeKENk9QRsFMugFFn4BoB79XK7Nga5KSkvMnh/uONavbaVco0STRo3g8FU2Z7ENQc/Rp0SWfGNuNAw==
Received: from CY5PR15CA0140.namprd15.prod.outlook.com (2603:10b6:930:67::10)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 08:05:39 +0000
Received: from CY4PEPF0000C969.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::23) by CY5PR15CA0140.outlook.office365.com
 (2603:10b6:930:67::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000C969.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Fri, 12 May 2023 08:05:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:05:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:05:26 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 12 May 2023 01:05:25 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Henry Lin <henryl@nvidia.com>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH] usb: xhci: tegra: enable stream protocol support
Date:   Fri, 12 May 2023 16:04:23 +0800
Message-ID: <20230512080423.27978-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C969:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bc18fe-e3a5-4acb-ef5e-08db52bfac46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnoHcrprqzblLXOMlLVkOogsLLs4QLdNvHL8Hv4LYrIu/3BJd5t16DaCiVCw62PkJTiSW/NVWJ7ZlkkzomJiQ+mCIxjXeFxHr8IAy9WWangkuegRmCQCHKavdj/sf5PwEnd2eewednCFtkGrar+Vt3+T2DnXToasn/So7LPWQr2pNkKE3jOZpDuQ8P1oJuWW4fmXNII0RClTaeejr1iQh6dSlXnvZKPK2TOQm1sLN+O++tlQIPq0ihEb7Iiavr+GzhcVPhOV3oh44qi39aWRU1yN4KXbQXmNOfHKuEhrQI3i50JGfpLf3tBhxp9UGl01plbyibX3tPjzcfyXtMUwUq8Z5vxU4+PK8Fz63tmCfyZSouCYEYwa3HG4PvBx1fegAnb+ycPfjk4kZTVt9+UcyqeJcXTjL2ENmGsiMusjtoI8uy0pLXepBuW6H2Esfoo/iBNFYMkmUSUhuvRWPnMbkYiO8PnX3q4OygMuYJVDgcvgO+5BsfPBZKF4PpiPgVm6s8XpIG5mHVzZQ1dSr9V2OqecHf4amoIAFXzIpnsizwvcBwuwhLwpEUgHI5gK7dy4PWM5zDGF+xz7/KkmKFXSMUlje9zxSxEOziCu0w74mOZrsmEEYk4bJPY55VDyoZzzY7B+pofjbK/swCO9QUJk5XKiduOF5nBwZ2pq/rG1HY+YbSAZD8uuWeb+mdIuBwqEKnQ+RHcLLbcfDcv1YvrMk0xCPa/zTC1p5GwOI5PTqNOj3mCY2L9Pk+h7zaEkrOvh
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(54906003)(70586007)(70206006)(316002)(6916009)(4326008)(478600001)(7696005)(82310400005)(4744005)(40480700001)(5660300002)(8676002)(8936002)(2906002)(7636003)(41300700001)(356005)(82740400003)(2616005)(107886003)(26005)(1076003)(36860700001)(426003)(336012)(47076005)(186003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:05:38.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc18fe-e3a5-4acb-ef5e-08db52bfac46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C969.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

This commit enables stream transfer protocol for Tegra XHCI.

Signed-off-by: Henry Lin <henryl@nvidia.com>
Signed-off-by: Jim Lin <jilin@nvidia.com>
---

 drivers/usb/host/xhci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c75d93244143..ea55e401c70e 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1828,6 +1828,9 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto remove_usb2;
 	}
 
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+		xhci->shared_hcd->can_do_streams = 1;
+
 	err = usb_add_hcd(xhci->shared_hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add shared HCD: %d\n", err);
-- 
2.17.1

