Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285DB6334B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKVFb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKVFbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:31:25 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4552ED68;
        Mon, 21 Nov 2022 21:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0QPuvOM/cGp4DSU5bJ4ebpuKsEbh9t7Ob7akW/RtC+dhv5oIbNxZOFSgsxZDAhKn/q2WRZuIXz4kevjZ2Wze3QQbWl3xLIVtGzmRlZBZelEBCDNiFrifJ6wcKUJe2UjvaATKHr3QTy/cjxCPiM/RMuDUX19yPM+SHf7Nqz/k/d+3H9yvvi1k/r0GFcstmDN93TOVFCmP/Pf8QaXohGyXbCqNW6Icgk50uBFeF/3zJNWwTI2waZZgvYae7y1VUZKeCoKMfrlVs4d+Cg9pkoWrqibd7XtdBEvVVT7l6GU1fXnG41t6aNqFuh63OlOh06qjCYCHumS7Dbg6eGW6/gCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozsta06o56SkUJ0hEmKXI5A48xXhycERUjaF0sGFCgs=;
 b=A128yrCoegxNVBDxdrvUy7zeICbNcXbJHb322VA/DH8WggdXYRmDaAxYPWN5gwpftcAC5DOFzc/p+LJ1Kr0VsUW3s2bROkI/fuO9NXsxLpldY8OK6Q8ZRhTPpA6Os0e3IHq3mEcfy3sWDSrr0z6tdss9uBIZNvaE4DtxwnTdh2Usphxl4CT+SQrJmLIqrRMyK5P86HgudeYwQEHDh/oMwG+rIfADWYIl3CKajk7NMNtpEhZwmQsSHsqzJLVc3chJEz9xmLQBCGIwCjpOkOHEQlyLXL2QiJQFtC6zIi3igs9WuGC5erDV+I6zdWFuC+z02mG2q4yVYIkTvwtytJmiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozsta06o56SkUJ0hEmKXI5A48xXhycERUjaF0sGFCgs=;
 b=CizQ2WDL6RdGUMoNeHkcDxT3hEx4jFsAf2i4hAuXtHntcQ+bDK9WBpxo3t6G/X5ax1BrFonlq6lQcX/EEKE1LckFW62Jnn6wR2HcfAoy5NuNA30l6xUvxmw8IkIcD83nwYBeZaXHWSpSS4vh2dGLEXxIvD9/V4iV5yPaxNd4dKwANPjVCUlGmZtf8sOpL9fNk5B/i50ESunNIMJG9i9/OzaS7M+D4r3CWbJh5hF9TSmX52HRnbCxbDwrrXk3nYeGQpP0+x3z1aDbBeqpEgigGNO4iCM88Z5XIqGwQngSVf2u5ettQ37mx01OhijDShUQbozhVVi8lUIW+L/FUQ/UOA==
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:31:22 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::eb) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:31:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 21:31:16 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 21:31:15 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 21 Nov 2022 21:31:13 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch V2] memory: tegra: Remove clients SID override programming
Date:   Tue, 22 Nov 2022 11:01:03 +0530
Message-ID: <20221122053103.17895-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: b89b3807-af73-4164-82ec-08dacc4aca65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CxenHIPNXiFKqdyKYNO89uvVtEXD8xTnzNkfIEua6MtLwlUuqGIMj+4J8BFYzaKKg4aFviGOfoiQTIa5yfiFRg6fee0Gjy239aqwyWE0t39rHXPmMM0/nsz2m2em0lX2klHuLVrOJYeXXbXx064ioXTCJUJvuK9r1rFB07FlDnX2C2+87GgxQsKbprx4KTArocfrENBmS1EAnpFb1wIR/QsUcU5oy/0hnjlJZ3C7DlhjjdisqNqZ7FugL4NmjV9EfOC+uAMBUbjQGaQbhNJLggdTZcqYFsEZxRO16j3nOceCnnr/rwQlzqvSqt1qhTZBMF3buIda1ZvGWKxtrv9ttfVbw1ki0zJ57VD88FtAC/y6mgOPU7VdyaRRtS0wMnkNqLbc153LK7SFClks9lZQ1I4vikLFoOpD6jxDvWTkOVGk8sQGWnrhqxUOBNcFWP1EnQw+eDrZIsW4Kbh0LV4oiFo7u64CRJOIkDtV+6wydeCn4M+ncZ9EFJeGPOgWnu7W24Y+d27Jnuv3UWYd+0sfiBlZZKtRxugA4Gog3L2lP54UGeYAAVEy9E1JYcpnaccYrPR6RZ1bKEZrvU1yKE+tCz8PkjAdBp5TpVMXJlm8rdKv1k+p8puEIkiC4CUqUw3VkkqunBqn3vew/EPWs36w7VvEJ2hmi8P1WHovbqu+R8IrHj5isMSGWVoJgdFZVy5PxPBUPRAjT8fDbLSksp0s3w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(86362001)(7636003)(356005)(26005)(82310400005)(36860700001)(82740400003)(2616005)(336012)(186003)(83380400001)(1076003)(426003)(110136005)(40460700003)(47076005)(40480700001)(2906002)(8936002)(5660300002)(7696005)(6666004)(107886003)(478600001)(41300700001)(316002)(70586007)(4326008)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:31:22.0080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89b3807-af73-4164-82ec-08dacc4aca65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer Tegra releases, early boot SID override programming and SID
override programming during resume is handled by bootloader.
Also, SID override is programmed on-demand during probe_finalize() call
of IOMMU which is done in tegra186_mc_client_sid_override() in this same
file. This function does it more correctly by checking if write is
permitted on SID override register. It also checks if SID override
register is already written with correct value and skips re-writing it
in that case.
Hence, removing the SID override programming of all clients.

Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v2:
- After offline discussions with Thierry and Jonathan, removed SID
  override programming during resume as well.


 drivers/memory/tegra/tegra186.c | 36 ---------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 62477e592bf5..7bb73f06fad3 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -22,32 +22,6 @@
 #define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
 #define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
 
-static void tegra186_mc_program_sid(struct tegra_mc *mc)
-{
-	unsigned int i;
-
-	for (i = 0; i < mc->soc->num_clients; i++) {
-		const struct tegra_mc_client *client = &mc->soc->clients[i];
-		u32 override, security;
-
-		override = readl(mc->regs + client->regs.sid.override);
-		security = readl(mc->regs + client->regs.sid.security);
-
-		dev_dbg(mc->dev, "client %s: override: %x security: %x\n",
-			client->name, override, security);
-
-		dev_dbg(mc->dev, "setting SID %u for %s\n", client->sid,
-			client->name);
-		writel(client->sid, mc->regs + client->regs.sid.override);
-
-		override = readl(mc->regs + client->regs.sid.override);
-		security = readl(mc->regs + client->regs.sid.security);
-
-		dev_dbg(mc->dev, "client %s: override: %x security: %x\n",
-			client->name, override, security);
-	}
-}
-
 static int tegra186_mc_probe(struct tegra_mc *mc)
 {
 	struct platform_device *pdev = to_platform_device(mc->dev);
@@ -85,8 +59,6 @@ static int tegra186_mc_probe(struct tegra_mc *mc)
 	if (err < 0)
 		return err;
 
-	tegra186_mc_program_sid(mc);
-
 	return 0;
 }
 
@@ -95,13 +67,6 @@ static void tegra186_mc_remove(struct tegra_mc *mc)
 	of_platform_depopulate(mc->dev);
 }
 
-static int tegra186_mc_resume(struct tegra_mc *mc)
-{
-	tegra186_mc_program_sid(mc);
-
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_IOMMU_API)
 static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
 					    const struct tegra_mc_client *client,
@@ -173,7 +138,6 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
-	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.handle_irq = tegra30_mc_handle_irq,
 };
-- 
2.17.1

