Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF776E5FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDRLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDRLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:36:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317B49D9;
        Tue, 18 Apr 2023 04:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHyneTFzgVhES651ixyh+5Qle9Zz8qT2H+nPcQG+5xnCtnr6RHu3t3gvFkjDXXnWlvtS2FKXGCj7WXREvpCkm4j4GtdXqlCs28reyAnyjzXEdPkGU7x9x82GU7PS/NlkgYS54t0DuwKISqL0N/1BubeHSyefKfUECcW17LBxDpguM87WmS9uFIykljr2biiDDdj9p6naPVN/15flDKkgvNhZaQxmU01iEXfdKSEdNqU1P3H1HbSWtMb8lx39krar9dmgAzqaAgYFTX7v8TBOY4bZttAEAdHhgk3yNrUmGM0FsGbPUyXvAMxZxlLZ8Y3+KJV1Xc17Q2DSwcN64hVG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k+bEkt5RDqztAdxzqxHIwHzJm6hMa7GABcVPzZ3aBI=;
 b=b719Mgjc0Mn7yb704pvIoaaM8SAchbGCuka54CHX1UBoCPF2NIDvxdmKrLfenDHfYHX4FIhDrs0krmMHELy6orhT45ygIwDMu0Vl8C3U9ijFcqsszJ2zhNGZ6iIjxdkEAcNpZw2+Tr5T7P++Z2zizMah159Zr6LTPAHfb7dnfA1kM7BVlt5lRdPWtHypZKUcyI4Q5UDcMQMrNjlWZGcsySH8FNShK81fxdivF0xiHNMBCJYY3pjZu4UsrvJo49PXAwoq6KSUn5Z/6z/6elz8LxMJRgqeUdv2wJyiOj/5AuWKbpS79MDapJuL7dwebVIbt/QFogecxaBwsIhMvgMq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k+bEkt5RDqztAdxzqxHIwHzJm6hMa7GABcVPzZ3aBI=;
 b=Uaq9CLrR7cpGv/sshFHgKJMe4R/W1129ET85gzNBVCt+17w6b1NuCSj0s2ncpAhjzFE5TiSFJyWmeIMcXbzK5j8NmL2pTbI4rb8gnojXFBjlkL8L7aF7wB0+GOncQD1wNTv2od8L2+dNT7EK5MpewZQ4fLUGa2aVdS09nxIGebVy+tmV7fKUGrxmE84O0x+jOcM8+BGQx4pGjJa9xm2gok4Hy2psSkcYqiFGJTc53fZjqBF+JNmPm3/bQC24ZpiXV107qbhmn7IjHAE38ExFfS0WEkkaRAjFfGIsqjorqiKLerOW0ah1uTVxTB7HmBN5iznui0duTcWf93mYmx//LA==
Received: from BN0PR02CA0060.namprd02.prod.outlook.com (2603:10b6:408:e5::35)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:36:06 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::18) by BN0PR02CA0060.outlook.office365.com
 (2603:10b6:408:e5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 11:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:36:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:35:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:35:53 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:35:48 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 3/6] irqchip/gicv3: Export arm_smccc_get_soc_id_xx funcs
Date:   Tue, 18 Apr 2023 17:04:56 +0530
Message-ID: <20230418113459.12860-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8ab61c-bcb5-4082-8f5c-08db400118f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAxee32bW8mTzQtRktY3rVzZLGKRQDTL8RTKxlyOMqZtZWpwQuAn0iu1rIiRc+rF4P8chJESto3dGr+8rXuF3UaZceuDnwopJqvD0DeteaaBu7iLxZ0hHLr69wzul+ejhYm2jpycfqqwy58IWeBrYopl1avq91FYFkce+Lqz1c2jbdOv8LzDw2ee54CquldtHstTG0R+GdOqQOHhHtwDk+RegcArdng3EDbHcaoZCVPlNXtxkoRma0I8KmxwdChf/OV0/EEIVUTqfKzCTa4T0TNQvEcekiGZRJA/drspTmnukntYfNfX5wmhrcJzANES4wTamyfWPM8rTTkJnImSZ5T7xU+tpUeL2MzOfsqIPrgxFmLFQap/5/ZEbxfd3bpDBIuY9ecLZUfP7Skzru5U8Aq3ZlX301VuHjOQ1ENOX7ET6DqpM3HsNWNnt+x+JVpKRGFLTuAP4SOCYRVFzAM/CFtoOzwEpQF527esyhTFux2/Cml6VATOcfWRxIMHCbrsPp8Z4q0nPnks7wolYwAJf6LGTJyPLtZHGw34m1y/kpF3pOcm+VpqKWVNO2ghpuFw+huI5iNTHEfxtypTGKpiBNCVydfDBoqpXUm6G9BiCRgEPijywOicmi/839B5LRIhiLbfybL/TaKI0EUdMsBGdxLX0R1kLYKQudKAl6Aqn70ZfQKe4NYBXvV+OgKww9/RSxl4xu1b4JoNLW8LbAZp8Km0Cy2VXGBBpMcipvgDa4uQjVBNEIDspP0j0g9GqG5sgEAPGTbGpqZpNSiIUHi95HcPg+Vmg3PTRaxy+gliLMI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(26005)(1076003)(186003)(40460700003)(41300700001)(107886003)(82310400005)(110136005)(34020700004)(54906003)(40480700001)(86362001)(426003)(336012)(47076005)(2616005)(4326008)(316002)(70586007)(70206006)(36860700001)(4744005)(2906002)(7416002)(8676002)(8936002)(6666004)(7696005)(7636003)(82740400003)(356005)(36756003)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:36:05.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8ab61c-bcb5-4082-8f5c-08db400118f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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

Export arm_smccc_get_soc_id_version() function which is needed
in CPPC_CPUFREQ to check and apply workaround for Tegra241 SoC.
Also, exporting arm_smccc_get_soc_id_revision() function as it
might be needed in future.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/firmware/smccc/smccc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index db818f9dcb8e..b4224da46988 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -64,11 +64,13 @@ s32 arm_smccc_get_soc_id_version(void)
 {
 	return smccc_soc_id_version;
 }
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
 
 s32 arm_smccc_get_soc_id_revision(void)
 {
 	return smccc_soc_id_revision;
 }
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
 static int __init smccc_devices_init(void)
 {
-- 
2.17.1

