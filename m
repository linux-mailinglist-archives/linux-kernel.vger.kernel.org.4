Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691DF62D3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiKQHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiKQHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:21:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4F6EB6C;
        Wed, 16 Nov 2022 23:21:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHdiTMqwLnlrb5Fck6H5/7F+Fz65fQRTK2tahlqd8tq+kjGP4yxHl6vh6fQEtauUhMpA7xyug4Y1o+uVrWPvprVPFWNERCflemcVDEYpcLv1uWsvHVC7m9pngH1/4/+dBwg2k8/Z33KDVt0ag1ci76UWukXXWYLFwUTNoyeb4q/OnLbvn0BW1KbFtzRem+I2mknzQTNFXpfdWQan+yygP6ExTrBTm/pJ38UudkNYzvXTQ51mslxZUQ6W/c2sAFwQxOhV68BdtqMdQjZDX5E94dzrujA1/B9nMPwN1szHcrBCsuG8B6XBu/oPHARugAnTFHPTc5veEAb1NcfA0k19zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twNCEF+3Cm30wI7GPDmqmf+pT9ExxrwwuLBiy4lneVs=;
 b=N7WD6PQf9mT1Mwk0s66PkEeZV/i6JbuKqWckbZUMZGkqIdO2wuymXZmBifquhjCROdu1XGbfol6CVQXHom47jG4t2h7cMj80EpsrGtQkyBfkyuDlr9wZ0VuouZMADJjzwgB1+UgpISp/d8yq7ncDwCc1KmWbMOasLOF80NllmnYuty8d6J4hkLbVlVEBkV4ORff5Qif2M5rgXvcnzRpDQN0GWNULaA5XCiowLgoVfIGhyzNMFXeMiHdY2/ATc+D04a3Am0Wcj4Dac4DWIPVoF5PioFEO6yspgV52G9nDbhYX58EjRv/rhWeWyLQiL0375KzNWLWBZVvn5PLqwZyTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twNCEF+3Cm30wI7GPDmqmf+pT9ExxrwwuLBiy4lneVs=;
 b=sLyNlWprdIywhQ0d7lzf9hY/BRUh+a6ptcspjea7ydq0AMFQZBF9tdZSYdx9OMctLIip7tH0GtwXIiIHH9YKEopQBDIt0J47vTtfF8p2/8oQpwbut+rUU+zg6IBiuoydW8/eWkAPFSo6XJszI0FFkMQQ4/pN4fUEGc7CSERpzNQ=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 07:20:59 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::8f) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Thu, 17 Nov 2022 07:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:20:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:19:55 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 5/5] Documentation: add amd-pstate kernel command line options
Date:   Thu, 17 Nov 2022 15:19:10 +0800
Message-ID: <20221117071910.3347052-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117071910.3347052-1-Perry.Yuan@amd.com>
References: <20221117071910.3347052-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd7b304-7656-4a04-1289-08dac86c4658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+vurTr6sfEERVlJ1u0aNR3Oaay3DHtH1VkHaSey08ajszMT7UW6tEJG0HfkXgMLnfAkmjV1HjWAq8OnghK8eef4+52/qrYeAQ4GPeAMm7W1wuXUmIm7/B9JhNNw3whEm+5YzkwkUGyhB6kyFueKSFJqZqXpiGMd1UTNvOV/DLQMhO7UUhITVlGchv8KD7Ii0m06ZpxWtxKdNFLBMTyLAfk53EJC7LXwlyuQ2bi1lJqwMck8BfMCQaQ2LGoVHfdThFbYO9lQTCalUkBCVTypiLPvNUi2/FBnGYBBjlSiInHwl9cSQxCaHVycXU5rTGMJceQS1ec14+nvAqYfpAOmS5MKDmVimoNfSO+mGKraqUXf/lA4mXymmzl4JUTt3UaZC5Xuqq7VBcxZC7rSfxLzxlxOf2JyD4NAhGFGqM02GTE/Grur6iWef84y8iag9FyllLqKWdnP8FDFBsC/ZXQTgk7sZXTbX6FhPUWASt5meEojRsLe35kuRM8l6S8TYUa6h9Q7MApGOOPO/pvFBzfZQ6GJ4XIQw+GH82xvZGrvhQl7s6TGGUYh6LKsBG6tZFTS0B6tvI6semqnw2SydnIy7tIe6fY7V8LdYaip0+I1c1jRQepqlTtUdou5K5ONTJjkEV5UGqdaaIpp3jht5tEdrHIBKa5ad5BJJ0wAeWjfpbsGDbFXJb1/MK1ouvB96lbYuJ4fRHj2Hmd/UxSjJTPf8dAQLIedwFPEAzcuCYNRv+4os8mHV1rmWVv1n9WHTBCL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(186003)(1076003)(16526019)(40460700003)(5660300002)(336012)(7696005)(110136005)(316002)(54906003)(6636002)(41300700001)(2616005)(8936002)(26005)(70586007)(70206006)(36756003)(8676002)(4326008)(82310400005)(36860700001)(81166007)(356005)(82740400003)(2906002)(40480700001)(83380400001)(47076005)(426003)(86362001)(478600001)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:20:24.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7b304-7656-4a04-1289-08dac86c4658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new amd pstate driver command line option to enable driver passive
working mode via MSR and shared memory interface to request desired
performance within abstract scale and the power management firmware
(SMU) convert the perf requests into actual hardware pstates.

Also the `disable` parameter can disable the pstate driver loading by
adding `amd_pstate=disable` to kernel command line.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..42af9ca0127e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6959,3 +6959,14 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
+
+	amd_pstate=	[X86]
+			disable
+			  Do not enable amd_pstate as the default
+			  scaling driver for the supported processors
+			passive
+			  Use amd_pstate as a scaling driver, driver requests a
+			  desired performance on this abstract scale and the power
+			  management firmware translates the requests into actual
+			  hardware states (core frequency, data fabric and memory
+			  clocks etc.)
-- 
2.25.1

