Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E06E5FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDRLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjDRLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:36:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7976AF;
        Tue, 18 Apr 2023 04:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChN8CQRlZigFgOSF+gy/4OuKzzzpqYHGcWxsK/DhW0e39WIPoUqo4w5vRpxydX85RNkjpathOBbJ+JFLXzlrvQFzMJAOZfgl3zAGbo05ZEI0yKDw12HAMy9qmbF0R/O0K0L0fsSSg8+lHTEHC4SmhYllcg6hf+V+dQAku7Ci519L1Xa5w7JKDa6XsSXNG4NFr/r9ebuUHfVREh0ZcuRJX/3bIRQQbct0Q58xc/icgARmrqKlB/L+TgxWTvBsjPqx19ABW7KDjdQ/O0pyiBPkAHYw6IeXwUsgBCs91df2zFNLceex0S/+8RO6uUrLr0ajxMxhGefKM+8aNRr2ZCcqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rahqSi0lxKjo4ecE7XdMLzWetALNSJxu0JOZbNFBoU=;
 b=FFbKNjSq4334oNq1JrCGCu3zpifc8QbvJNraXzepXsZ2jZc+r8zsKF/JhcvQ7Nj30PzkiZP6xt3z1X69BlLBoLGF6SH4z8ti50M9a+owX/ZgWEybbAsV4UHvbIie1Pi4NnZZoco0LNZ0zCMLQwHc+3WRYkViTtOx9/O6dmPKf96j7YElZhn5NG21KZuXplvdvbgMLOOTbnMkDxpxzAvPI0fmT0T+Y9q7IrP0cGQbPV2498s4S3Ee0Iv+ZV4XE48pX6uu0PU70dIXRCyVUy1Ve0q0MH7lFtTDbxzlZo9hUTT9dc1E4S+i/VSIcjYBSXIFKZ5Nm0Ej+OOnLPgTY2eBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rahqSi0lxKjo4ecE7XdMLzWetALNSJxu0JOZbNFBoU=;
 b=DNNYZXYbeOeoBXsgBX4Py2NaVMsoMcjFn0Xz1G55woI3Fqi9GQAgRnAX/pFkSc+5zBz/HFS5jKBxZphzsKZHjTXUQEj6BthQwX6vmbj4wB5UHsTJT83hV+Gtbt/jPbqiWbbv3BUyRqTisy2iXXFWM62hRsI4x0c0aUjFIB/jm3AS8bt8fdXD83KNuGFZIWOZxI4g/WippnwWNhfnuY0nLi7BSgW94+Ich0GmCosLonblf7gdF1FStGBZVqS7SUCTd8kFlVDoHVcxN9KDt9B5Gl0xV07AquMQp3ntiNEDytcbMZ8652rOSxQ5UZ9895LBA0pvsWyZlN705ArsytgaCg==
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:36:14 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::bf) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 11:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 11:36:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 04:36:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 18 Apr 2023 04:36:11 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 18 Apr 2023 04:36:07 -0700
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
Subject: [Patch 5/6] arm64: cpufeature: Export get_cpu_with_amu_feat func
Date:   Tue, 18 Apr 2023 17:04:58 +0530
Message-ID: <20230418113459.12860-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418113459.12860-1-sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 1831378e-dd9b-4a39-b9e7-08db40011df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlnWLich6hJsPjApHLubZ3Z0GUiKAZ5DFIbbjpfNIMt/oPjW5PJHJmZf1aL/4DdmqoSq99oOHdLpd6vIPnFcy4LPmFGQsAZG7dtW1+h4xG2RUJtMJbNd3n3qRCMJjJgnKtn7/bCsC1nnbwoZo84yamRaQ6cHCtD3RV+YtZOzUmtjrxzn4wkqFCdsySePg67zJ+tW6RdhkGd9rByDCExCGeXilCLw2cfzv290qqdgXENhXNmOopPArSShDzeRMTs6W1gVCVtRm8rYZDYZVxKfP21cujtxzFp2XCkdiZF8s8iJuO/dDpchZ+327zrgcz6H7AZ0qfI2K6iTlwNZUcuYFo7j8qRXPNcVZF29qjF8Yem6yPbog31DD3cNgoy+nkrJH0vSb7UyPrC5ak3iZ75zDmSgJuI7qOhcEy8b8z5Foq1hLqRnHNl3+PUrdZZSItqLRPT5QjNOnt3fQla/vwmxSqAbU2p5jVdb7C1ZHE3BaTaD4WkU2ergSjlWEFlexejFblcunz1CKUrAL5dkP1ZqRDHusv4qz6fE4YQwqW+4rVEIOA7QV4TG0GgzRat0KmOH9ptlcmHQsh/pZU1/UROJMaPwGoM3PU9Zg4qAB4B+6gySDuZFlJrBapojfbLse8ivCoNaTj/Z9agmxifFrkc3PJIvChZSfdhsBDRDcEmRewt5u+HcrNk8Cc5Z5smfL2IvjeMSfd/oYM4lB3Bea+hqb33kyIEIj2E9JIQCymIVN0LM68U5NTToKsu3ykHD7Q+NcTOyPf+U1wd7gCjr1bIS53ow/m87m7/8jIhC6+F7lhs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(110136005)(54906003)(316002)(70586007)(70206006)(7696005)(478600001)(6666004)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(40480700001)(2906002)(7416002)(4744005)(34020700004)(82740400003)(86362001)(356005)(426003)(2616005)(336012)(107886003)(40460700003)(1076003)(26005)(186003)(36860700001)(47076005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:36:14.3267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1831378e-dd9b-4a39-b9e7-08db40011df0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

Export the get_cpu_with_amu_feat() function for use by
"cppc_cpufreq" to check if any CPU implements ARM's
Activity Monitor Unit (AMU). If AMU is available, then
for re-constructing the current CPU freq from its
counters, queue work on target CPU to read the counters
in a single call instead of reading them in separate
smp calls.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d9345e9c0226..ec31da7043eb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1917,6 +1917,7 @@ int get_cpu_with_amu_feat(void)
 {
 	return cpumask_any(&amu_cpus);
 }
+EXPORT_SYMBOL_GPL(get_cpu_with_amu_feat);
 
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
-- 
2.17.1

