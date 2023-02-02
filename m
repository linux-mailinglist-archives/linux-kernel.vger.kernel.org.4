Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9668828B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjBBPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjBBPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:31:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE906F717;
        Thu,  2 Feb 2023 07:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBVw/rsq2mCKdpEXAFbIstvoEoVC5TamVpMmsV8Mmr7RMWGSc86DNqYfVO0Tl46Gl/jTzjtevh9gmluLbPw382mswqEhMN+V/ZueXUyu6KQooiTg0vOWkIsVpLqD1la4B3Qgk4q7X9vG1XnR6qTzIIQ1Fr2iDhWKobiCxxM7T3ztgqsuHxj3EeNKvvuSqldfc9HILdvqTLgdWZuFaaGmnamJjgqMLoaeL1pAeX+QF0yt4KBRyNxNJhB0k0GnqOba0RofwIZxwQQmAdZlqhe1ScjTkSGLW1NxAcszwXNvqsROV221appvTxiL80k/kNpp0vhh4DpJdMb3ipI7umHdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHps8/8q+4FvdXwX8U2hAXoaMN/W6Np1nrCdIguq3+I=;
 b=oUKT3i9GRmG7uKiMwntUU5LxJtJ0DleNz0YGl8OA1IenU+2T/OwzjSGC6/V9na6onAso2fz15aoN8kpD3a1sNrEAOQsGLsGm2b4ZUJKUn7pL3jZQXo46qP0mGbD/tGTYF0oWDrCw+M7LMv3WoaSqb9OWmwKL4X8sBS66Dmv8PdAvC7/vaswnT1rlVXohuWW2eHRQoLmrf7mMe1A4wklFPjHCV1k4OVY9zBBe1F6HwbLY2TMh0+Nxk+Lx9sl2w+PrPuoj/m59TjGt20R87JUP/g52lRZZqHdCzItz8H4I5fYWYUDevff+zU9OFAZFIyCf8g0fzfkvs4SHpmNHOFYEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHps8/8q+4FvdXwX8U2hAXoaMN/W6Np1nrCdIguq3+I=;
 b=pGmcQFEAsIDXg0Q6Wba5l66nOD2ozetMdY4MURsoRWCbtXtR3arliuXg2suCYVPNYxalMYbjOQHA+8BmUbIQD+CF+ckezh6YXZAAU6EGs6Jip68VVIKIBn1aPWBTqRRvTXZpGPcMnqxEvniqJqZxBOd8uU9a4/6+Ml8EVd7SxOhQJhTXDVkglncmAGigZyJ0XOsyQwxy3NsVy+rdf0OilYgYoaw+TAdZc1DEsSFQeWS2vRYfG280R1aE4LX/rD6wQ8YyRyxLjWL3ht4Y99RBf8CdkWZCH9zQNJiq9ZKgL45ko+ulGb0cEFF22MVmuPMMj/W10XHgLc+k2xPoZ7sAzg==
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Thu, 2 Feb
 2023 15:29:32 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ec) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Thu, 2 Feb 2023 15:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 15:29:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 07:29:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 07:29:30 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 07:29:29 -0800
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: add the missing device table IDs for acpi
Date:   Thu, 2 Feb 2023 10:29:15 -0500
Message-ID: <f57ad0f8fdf663465bca74467c344dfa305a3199.1675305696.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|BN9PR12MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: b7767c90-245d-4cdc-6051-08db053247d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gd+qfqPtCoFVyLE/uQ+Iomo6AT+Cpk/nQdOm5eF4ns/YrSqb8A8nKdl2oHcYYxiBsfYrikZi0dHMEmEf0W3QVrju7bxKqBcJTWK+pZJSIxJBFuBNcvuktDc9lAD/eT+8q78/L26CmJ9K4qFBEKAPQL6HTjgGUTHFdIYi+0YQh08ZcgQl73v9+AIGbptZSqGU91Dy2Q6XFICAXLqoIP1RCwg0tZtzjzDdD1y3MdZ2/+HNgl7z9bKDlx3UXeFy5pFjdA2y8vAG2ubD4VJL2kP4okF2p9PLi0jLo/sY3eHXgI1CQMKNRBBPUT9WEUUJrvmJkrAI78tWJKt5o71F+VxRxy366NulV1iPgCu0ZSH40jO9bDMtxouJK802M+CGpio8NDz0U94L3oebhvASaWUR8fns1Tbol/bsIK84o4nDBFP7nwN4nePLB51BuhqWUbi4PwXsVOSstkci5TtndIl5gy3HlrEp+dangQmQ+qkEB9A+662Hv5f34evVP1OM04+PHPlT1VuSJ3ap3W5UPsdTxoxMRUDA1t0ZwaJu0bRZ5D87mfmJCISB3fdHPwwvT2jJT4GoqX6ZzzC73t4yTfG2/TQ4PTLZYw9uw8Y+Qbs+19dkoA7pOtk1m8q4inpQ9zNXrzAtGI1HYfEqoxNRBaP/gVCGN7mdAmXLgPrE6hlBpb19GMcbO4fcypWZvYdkx1bmM/VAB+FNSsGh1KX54N2RAqO1LHu3sBq8h7o0IMcIisM=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(2906002)(186003)(426003)(4744005)(336012)(41300700001)(36860700001)(8936002)(5660300002)(478600001)(7696005)(54906003)(8676002)(6666004)(26005)(4326008)(47076005)(2616005)(40460700003)(82740400003)(86362001)(40480700001)(316002)(82310400005)(6636002)(110136005)(36756003)(70586007)(7636003)(356005)(70206006)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:29:31.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7767c90-245d-4cdc-6051-08db053247d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the missing MODULE_DEVICE_TABLE for acpi, or else
it won't be loaded automatically when compiled as a kernel module.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 49338670c89f..eddaed07755a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -446,6 +446,7 @@ static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(acpi, sdhci_dwcmshc_acpi_ids);
 #endif
 
 static int dwcmshc_probe(struct platform_device *pdev)
-- 
2.30.1

