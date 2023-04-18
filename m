Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBD6E5FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjDRLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRLfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:35:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0055469E;
        Tue, 18 Apr 2023 04:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUNj5vumTytZRKOpmSaSVogDvqhgo7dJEYMDFXBaiVgNn0xMyk4/Gh4yPbNLMnFBmeg7R5rA1Mcyt5eKRsUhPBIkgi3I7WdJ7Hd+ZXYW1YJMG/AEvgSmje399FoZlt4Tpwr3Po77FzkMnSNeVDCRPxXcRVfygpA/uevz1NlMd3mg21ikMG/YnSHke+bBcv4q4z6ozuVm7xEsXFyvGI6P7/vEluuvKrxBjK5BUm31Lcyw3o22NPv77aQaoGE5ur+uA6NQZNytBN2kGmae7ID68evTNveXPND/PB7i6lIRjS26bGV5rf2K3LtpJ2x4r4YVlK60gi62doJbtNeQxKeUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qjly0cb5gRUnOWUNdQ4IjiJI21JtUnruafD2gDYLuA=;
 b=UODfieqaYNExSNOzTUkktAR6ky8Etid/WTDF1XjPg8fpCpybmap4sJ0kwFNSSPGpPh/ooveJWUvJI5k59l9+yhCMWkEl4tYnBdbtvgYfcgNN3FJ/RTrwJJJiHTR8CEaMqET4vaR75wVSEOLpahOUjlzgG+IOVEkCRrkD/CXXVtePTd0jgEGhcM6bdLT1enD1dMQKln7DrdW3flBaecuhm/ObeCxI6vSHG2rUkiEFLej2WSVwH+DzRcdSp64m5rUkcYa56l0+p8LZirZU5AgiZ1ERP1dahTp+BHj0U2jBSlS+tLFVo3YKGH2I89ts/enWXP0Km8/RRQj39G5mTVnYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qjly0cb5gRUnOWUNdQ4IjiJI21JtUnruafD2gDYLuA=;
 b=j6E/LajpyFTMm38SRu+plmFgxLkRnZpnVknBGDEcUM3hbvSUmZATLhk2lKgtgeUyUp/mH2E0gp/ZQTzOkGIl268nLnP61+zVox+gRmeSUUbnW9KG/rdhcI3pbNnxm/J7DkhpJC4TmDexc8NTE32yjVx6a5ntpAmaCG6EDaeu1yqJJ0kBzEcVmgXznEDPE9auZXED8lm/UmaEr5D1viW6KtEAv6AfaTeYv3jk0StJkt9lNvqbq+Jt7xgx6qWvw/VGA+Ublv6a3JzeTRWcMJ/2yw4a9Ew9xdsYfcqIfjHGvF7FHV8ifSNvjiTBO/9HLZO2xDaqTNupthLRFSWtjSpCGw==
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:35:37 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::1e) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 11:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:35:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:35:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:35:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:35:28 -0700
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
Subject: [Patch 1/6] cpufreq: use correct unit when verify cur freq
Date:   Tue, 18 Apr 2023 17:04:54 +0530
Message-ID: <20230418113459.12860-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8705403d-37c3-4767-d523-08db400107b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WE4LURFlPF93VDBtRL0ZceYPfGn2eNRuv5MkCyrV9BJJLG7XvH/p/HHiSwKXBs5iDoME8CgP+O+DYoGE/44Wj4xCnpYr0DffzLAAdSBA7E9srRD3IiYopprfAG9FFfcGUhCxjv99g+TtHrGE7WyZwQF4tJcZMlanxCDmnAnXb/EtDmXrejEVZ/bnK/dtXPvMfKb07o7Ile3BAmiX0jmJes9EB35WDlh3SqUr4WL0tW4QkVwk/tOZBc7mRb5C7ol65drWy87cLIptz2sFS2nU6jUqbTqB7jyoGD7pexVRpV+ShBr/b+jUnYHakNpepTUTgpGPqNBHdLpzizd1dG2orvajHXiUMZSKmb3aOohTP/JLaMQYBeRHIgPqZVt5ZwRk+eNihBKWYIxzwcVdmRK0hwv9mrZ6rnNp1WTA5bDPquMhvn01MzVGqXIDKE1tEcjN7JilfoCpslLsT0BWyTKtXXS7Ej/xLGg11yLoyuqblN64yaPYA1bBua6DhlFym/KwCfHufoiWc6o1SsPOr3g/y009kHo5jssihVJS1v/Oe6osfVldu9Vm0ki6wPxWHTVdPAJAPQHU6jdDxvwSma88lGc1VxiVfwp1V88RVsYriahPy7J4Ok+Czwp/HseZvrlSgxUD3nIF2Z6raYDCIjoYG89S2V9uZxHFYUY4JBB6BFl4gbiXEkmBjdPPFKxH3UA633oiKLYpS7510PNyQBe0gMc6QUQqjnDvXXhh74kk5WbnnE4YgbPUSFOdpBlXQi4G9LMYuTVbOo6lx6++2jExSEx0SltwT1/JPayd6dLEgts=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(356005)(82740400003)(7696005)(7636003)(34020700004)(6666004)(40460700003)(110136005)(54906003)(2906002)(478600001)(40480700001)(83380400001)(426003)(336012)(47076005)(107886003)(186003)(2616005)(26005)(82310400005)(36860700001)(36756003)(4326008)(5660300002)(70586007)(316002)(7416002)(15650500001)(1076003)(70206006)(86362001)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:35:36.9684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8705403d-37c3-4767-d523-08db400107b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

From: Sanjay Chandrashekara <sanjayc@nvidia.com>

cpufreq_verify_current_freq checks if the frequency returned by
the hardware has a slight delta with the valid frequency value
last set and returns "policy->cur" if the delta is within "1 MHz".
In the comparison, "policy->cur" is in "kHz" but it's compared
against HZ_PER_MHZ. So, the comparison range becomes "1 GHz".
Fix this by comparing against KHZ_PER_MHZ instead of HZ_PER_MHZ.

Fixes: f55ae08c8987 ("cpufreq: Avoid unnecessary frequency updates due to mismatch")
Signed-off-by: Sanjay Chandrashekara <sanjayc@nvidia.com>
[ sumit gupta: Commit message update ]
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8b0509f89f1b..6b52ebe5a890 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1732,7 +1732,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 		 * MHz. In such cases it is better to avoid getting into
 		 * unnecessary frequency updates.
 		 */
-		if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
+		if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
 			return policy->cur;
 
 		cpufreq_out_of_sync(policy, new_freq);
-- 
2.17.1

