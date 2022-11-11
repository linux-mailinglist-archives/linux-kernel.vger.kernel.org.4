Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825A462649E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKKWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiKKWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:25:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C5686A8;
        Fri, 11 Nov 2022 14:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1rzFvYTnCycH4p3rIlZ9tKGuar78ITulCdakW5KFxKqyXCwjJKVNgFrOhwjip0opC0AAwg5FoNr+gj6F+OOvbUmZE5De6poAOqqYgkBthSYjx6MBriRYWKEIjErU46W6oG2Nx6w6MwEbh3tNpjFKxduf5V2BoM4IpG6HqbrxYeTERrlBk7B1VlGeiLVgN+FnZWAudSZBGLsTLwBkGGCAVPZVXe4XNcWkPK44dE/G6gWeus43r08AJKrxbrVVP/DsfvpLlBhsWlmvir2ycNaiyuNfOH74OwcpagW7D10zUYIFd0D5RiAkPXp5/t1eo6H3xC/EHcTx6JTi1aemjZeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlxuoOAgE6Rq821g2XBvzzDEOAPmAnrRn1dxESZTM+0=;
 b=WaB+KEQXpFCHL4h3U/aLIpCS3IZ/4iSiZYFKOG3Mq+gSgbh6fy/CrilEtke62ToTpmDmi89FFsmVUi/oc8gM5Jz/o0zA5pca9qr6xrsyysK1zzPnhOL/1NZ57heR64B2eTsSyRdqG0n4HV/rHDeJWUsdqatksv6NPQTcOUbuSRXwUFjP/y9FVwLLUCd52pcP9zFgjdFjAiQ0Y5MYvkgd/WPFguaJ2gZP+AAhusbZp4c/YXd7mkh3os9fS2dkpJqnq3tsKVIuFvvxvuTNj7v0Goo9VQphyyenG+nxkbvnKY9bM4RszJi0sXfShvNPzOvOCyGDmSHy8LveTy9zFhlKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxuoOAgE6Rq821g2XBvzzDEOAPmAnrRn1dxESZTM+0=;
 b=mnSqPpqtszJXK1GPylfoEU8kW4bY35vZMupEFSr6tyVzVPR9l9ma17YsdlsOJhlZJBTDPJlbfukWDeYdgHurpHAnk2M7U8UT8xTjszjcOljY+/EkMSy3L42pkzT548zD2OKkOtooAArHJiEWudX4ap3zMjk3FtGikxjfK0AGn+fyQlw5szB2v1LtJJCPJdk1qwE5YDKMXNCbQQBe3s92nrLW6i04E5HVvv+YQuRs56zUgrdtJ9JmsdpjOmMgYL3/nvLQLb6pDiveG8Y1/clwiTRlqF9VNcd2FFr8nO9nJA5kCbDwpN2FEWf2TTvQILpBZvG6PqJj4lMYB4c2FWAf6g==
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Fri, 11 Nov
 2022 22:25:32 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::cd) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 22:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 22:25:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 14:25:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 11 Nov 2022 14:25:31 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 14:25:30 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <robin.murphy@arm.com>, <sudeep.holla@arm.com>,
        <thanu.rangarajan@arm.com>, <Michael.Williams@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v7 3/3] arm64: defconfig: enable ARM CoreSight PMU driver
Date:   Fri, 11 Nov 2022 16:23:30 -0600
Message-ID: <20221111222330.48602-4-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111222330.48602-1-bwicaksono@nvidia.com>
References: <20221111222330.48602-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 48511e55-5800-4fc1-3162-08dac433a547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLgwnq5f4OqoQyJag73YZmhWKOXjo5jnddioN3OQ9ziNxTnP+HRuIUf9jS7lVY/ZsH5KkiY+ABLdb+ypX1RdNtMDixCX6ZVCZQo47GOVooBFpb5tmVrzUcNw/X2tWvJgdSKKagFFFjF0q1JOKPi1QC53ZzBB7vL2fIZQVdjOlIRCcwWpUkPsQNlinj2A94kcC9l3edsEQ6B+cdgU5DcMOsgA0EnOWGYywvyqmpyo2PDU2hmmMfCAe0DfTT8vdzNeGiAyc1h3qU+ZgqrUT47p+fO9p/14124/jZOUSVRhebDgsbZuTlpmcW5CrVlTp+bpIBHMcaLcdzsBunGcOXFQPtv7TApRcGN0efAreiM6aKDBnU8Wl2UqWdDstM0jAAKoKqglB49isvgaAQLmLPsemAHd4oWC1eMmlKrkCk8FTV13RJ5j6W1kSN/Vb19KrECQ7g51Uvn5LdbFFJRZwjGDGsIyOiaGdoATOn3sY9m7oNWLbyNDWa02Ie5FwTdadbAHJxfjEnLcYWZkvBl9xnobaZT2wXIsQObFbzuK0jCzmXUiuvsM+in3ayPjM6F/oMr4hjVd3k0aTjZN0M/GLd1iajYTgeeV4GyAeD+OWTlYv84JNu8E7AwygmOmZQqa7OoU25PK44/sSbcjs6YgFDOaOoPX+ckSm1FLLWmJJyJMuTLLqE8epOD2l0BCXaIVfqjePFxkNeojD3UhNYS3dy1fQzTDAA4CdM8jvmL/s+ah/4BZfkiPLG8S9l2mDPPIa8E5k2jjTI9++ZKnZ2gANTqyXQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(7416002)(82310400005)(47076005)(5660300002)(86362001)(7636003)(8936002)(356005)(70206006)(41300700001)(478600001)(316002)(54906003)(4326008)(1076003)(2616005)(8676002)(110136005)(2906002)(186003)(426003)(40480700001)(26005)(40460700003)(70586007)(82740400003)(4744005)(7696005)(36756003)(336012)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:25:32.0066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48511e55-5800-4fc1-3162-08dac433a547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Coresight PMU arch device.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0b6af3348e79..8f3f7593dc5f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1262,6 +1262,7 @@ CONFIG_ARM_DSU_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_ARM_SPE_PMU=m
 CONFIG_ARM_DMC620_PMU=m
+CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
 CONFIG_HISI_PMU=y
-- 
2.17.1

