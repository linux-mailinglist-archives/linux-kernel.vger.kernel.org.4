Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA165638305
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKYEIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYEIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:08:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199619C35;
        Thu, 24 Nov 2022 20:08:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwZK4ZMGU05beQpHryoMtyoN7sF2eImv1/75Qgbo24scyPW3JCccs/r2J4ZQxZsxburUr59V+KG8qc4U91Y5WO/e4MZ9u+JbryIrIi796XEy85rssIQpgGCiR2Xc3XqY1SO4QnseFxuyXzE2PUwrFurV8cwfTHvrj5X2V9sI26M87M26eBXeYEbybZpu/y8V5pTXBpog/i9bUz7jaVyBF/7otipOk3ybLW4XXlbBzDalfQeLC69hKRIyz5iZmtaxZc1KY9+VCdkPjMA4+7boAzubqznWxst8O+LOfcY6YonftaYc+1UCdje/fieSqCn8MLqMcIphi6LPv5Cybqs65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRs6TUYkHrtb49aLUdqynoF7k5v3qxupn22jgVODm24=;
 b=Lh+F4VqJB0iNe+Ckb+q35yTUSJdpxqaS2PHNlnkAYrP1rsvqyDFwaFYH64n2HCvZguJUb605Caakzw2sO29u+7n/BREBoQKrjLzWTPqlvvXOPROHWOTn+ePY1nSvC0qZUf9ugT779IP0EcDLGurSLxZ0o1ci3i+sIqI2BkPCMnba6vjOuZho5Tazi175WCycd8BmBHIwVFM1You4NEqhWzsh+ZYj8xCamDHc9O1gkQ87dXNBcbPxZuch73H5CUe4daKDeRXW9nAFZECvb1lPDeJzf9Ek11shwAVW8S9CJfLc6yVIUXtff2r8t45sF61lnU2L9xOdRpeNhicoQ2XJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRs6TUYkHrtb49aLUdqynoF7k5v3qxupn22jgVODm24=;
 b=jKe8Z5i/fZP7Rs2O4YjnOixZrb8doVmspelI19PHd+MHr8wRGVkbOjgwaRIMQAqeIImxVk+py7ld6S66oyofT8Az/f+xBefpzfX6FrIjwN3cWGRFiay4cz9/BeYjXtQkapeS/i51l5sFMIzE7iUpxnmcwlZpOAQm+Uw5VEwf4P0KMtu9mBpAk0LaCSTfH9sLTw54s1om8hT0zXpDeNKIAK7xuWTBpZKYcjp9/bavh58SNdCxZwp1zjnWkneInwKToABgg+nGcrLUt1hfMqZ3qQlmtF6X+RMoKB+UV+WaWWIScyIK3BzfkwLo1jxanpvSiN1AC72kK3t5+noNiSV+PA==
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 04:08:02 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::77) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Fri, 25 Nov 2022 04:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Fri, 25 Nov 2022 04:08:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 20:08:01 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 20:08:00 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 24 Nov 2022 20:07:58 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch V3] memory: tegra: Remove clients SID override programming
Date:   Fri, 25 Nov 2022 09:37:52 +0530
Message-ID: <20221125040752.12627-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 561c46c0-6f70-4644-b1c8-08dace9aa53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQAfQSJyLB+0D/9JGBy324qDutXyq1X/WFW35fkmi7rAIxHjmm7daJo6fZm6EPi+ITJT57sZJX4gzHpScIavaN+6j1Un/QNjtQTxzIW3VXLOGWgSVFlxLUhWETSgHzywINVjfZ33sOQfuy60ZUkZRsXM88Ieq1Q3XurZqzH3gY/5H7ZM1IBGam0E3xR5c/FBiCt+7aUOUayBl4f3zuUws5QXP01pO8hfYdOr2qvIv+qBDbCqk8IxMuzBN51GyPj+p+sKzgPX8v1Z+vUmbX804XLWYE7SATyhSRr7oeRL+JEmuUW+sgWf9HhOB3fvgVQahfrqO0hN3MY4SPOJ3AriDkGSbeRxAMA41B15SH3wx/jAWmOPywfQUaTBVIcUCGVWO0mybSkzq0kcS6LsAsGPVvTUkNC5BLH7rW+kRiRr9yKKZ9761D3fotbLKblH8gJ9kVZOFnxFBYpODt7SjlI4JMmf7P80g072Y7FekEQQR2OlxxGCQyB4OMvxD6FGyp9PRyjrg+WZFJO4CwWs6N+XCdEYMABvSWL/RtDzZNLQWddpFSF1LQgtAvTtdHekX7D+kJyQRxmC6BM6RlankhHhxcZ+7MeJk4jP4tOP64Lz1WMh/PJnBYnoMAqLo6+Q2xNMa79LJxW7e1Yru6qi1rjdnctSZDfDYW7SEv7oOJyCwF4jgdXuz404j4GqDiJYQ71vr7DR+1oAXAKMi9WnKAboDQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(107886003)(6666004)(478600001)(8676002)(186003)(4326008)(41300700001)(26005)(70206006)(40460700003)(2616005)(336012)(8936002)(36756003)(110136005)(5660300002)(70586007)(1076003)(7696005)(316002)(2906002)(40480700001)(83380400001)(47076005)(82740400003)(426003)(356005)(36860700001)(82310400005)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 04:08:01.7847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561c46c0-6f70-4644-b1c8-08dace9aa53b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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
In the function tegra186_mc_program_sid() which is getting removed, SID
override register of all clients is written without checking if secure
firmware has allowed write on it or not. If write is disabled by secure
firmware then it can lead to errors coming from secure firmware and hang
in kernel boot.
Also, SID override is programmed on-demand during probe_finalize() call
of IOMMU which is done in tegra186_mc_client_sid_override() in this same
file. This function does it correctly by checking if write is permitted
on SID override register. It also checks if SID override register is
already written with correct value and skips re-writing it in that case.

Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v3:
- Updated the commit message to point out the bug fix.

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

