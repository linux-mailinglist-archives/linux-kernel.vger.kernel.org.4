Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337262D148
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiKQCws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiKQCwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:52:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A456B235;
        Wed, 16 Nov 2022 18:52:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRQD3j+m916UGmfMJVF9wURQiYO1q2YUmWkn28qEl+joe4gepxbbVLr0PkGMx80fjHRSZ/3XWc6AeWS+fpDA3VPv/V0rBCpfFIJh5X1rgO0uWFlyuiCxjfmFNILu3TmYpnuFLwJL4a87P1OEJIwCApNdOZTT3jwjFzmWovs67/QRtbS3fvEFuP6uyusCWb79JbeuvSue2VEgn6zA/CGrfyIeN9w42I0xUEIYbE29LE+qwMh3Gj/6DRb746CSkjQ1d52i+6hsqF7sBGsFqUpsD2xkH+l73vNax9LbqOwkpKDqWthno83E9c0Vj2Z4bbu/1TV85yNLvqgfDOFylbliIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjeACgwjgrx8S3K9aWL8w70AGW4JjCzQ3yg1/2SQElk=;
 b=EPbzPncyZD7TbUWeYxKzmyDljOzv3z/45sc6PouOJPT1aR3UJwJ7xCo5QL5BLgHbQUuUzG36NycPUx7k3Deb6K3ijejx7cBydE4epSMdQtoRXuavI/aqDwBxR0j3kvj3kbZUCR6Ukg23cHw0wmh559Lwz4W8ez87EF8g2Veyn9mimGqUpKA27K89P9uz9A9zX3Eh8vy/ZSuIpT8Oi+0q9yVzgSxkPOVpERZYG8ApUtMWs3h0y9YYaUqmzeehCbAsmdpNB485jvnt2VYtn5O2S+f5FEK+cj2f4N5BkEVJ2R8/GkBHZmzd2gPO7ap+omuoS82c67Gdja2E8q9/mE9vTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjeACgwjgrx8S3K9aWL8w70AGW4JjCzQ3yg1/2SQElk=;
 b=Fgyo6JhYkFTRM5u7uECeMRKT3/pfqvUiZYOmFOlFkPUAdlL2gwYU01U1q28FrK76OGGdLasaVgRuXjN8inn7AEZ88lHmVLVecomzaoA49ItItLMlw297ibCos9PqWIlnEtRqasM5Cl0CH2gayYSllGNfILiwfVjRKq9CvpDUkCY=
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 02:52:27 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::15) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Thu, 17 Nov 2022 02:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 02:52:25 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 16 Nov 2022 20:52:20 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 5/5] Documentation: add amd-pstate kernel command line options
Date:   Thu, 17 Nov 2022 10:49:55 +0800
Message-ID: <20221117024955.3319484-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117024955.3319484-1-Perry.Yuan@amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a55a373-412c-4b80-d198-08dac846c1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFKWRGCT0NLbXkUKzrukZ9RnAUI0kE45pQQC8uMT/5dsrTykMPl0rr8QyDAsaAdbO08D60C0VY1rVadiKSByBW9NghNX1WvI/hbeCUfZUdg7LKWkduwTtL32rykSLLH7uwXN/KZv62lvaJqxnRnRgkMb4feXYJeGp6hQFhefKU3gvp/rNL+4uiIcnMI9czaundnFbUWaWDMVwQ5/SNnOeL3wGE1M+yDCbAJ1K9gmFYQ7iXmrxRmZnhOz+/ezXMQam+ODM3qPBrbjuGH8TxB3YZ/78OImTe4Ii3gxWxt9YFmMLagv2c75uLYDkc9rDaTP0U98Rq4tvYLPcavKfXOptFGHsIbeHrr9QSCN+C0iMeHKZcH2uGUGCyua3W58GoWdOynGVTP2RBe3lRbuKjYitm0mO7KuMtolH1FLxgT/oZmUnfk3MS7F1y05As7OOMoS0vUzbKwev3AQcnoI8iIhz+lhzVvYdUmruzNiXXohT90C/9waz4Ksvjb7WFGVVv3ELxapYk6NoNFTAFEeA6gNNXUpED8B+52Ge7JBLhFE4l/Svn5rCG/KFg68VkJ8wx43n9jMb6fvnWSosF6KKoRP5p89GMUfVecLoxJw72NtUVUrbYP0cOZ0ixymnNngcmQ8asoAdcpcIBBpGtjJF4H0U92iLWeIY5MqDIk05LyBr7A53oapzumuDLqN633yHxpdwHxIqsUkwJkM8J0MPo+C8yktsNrMu3lD36+9jrHLIkQOoaqwSxTORcjuvzcQBgoMOwYEtQdY4ytQ4PN0DgkbJYuC/kQABuJ2esYiXgFWsCLjElAS4XcWl6PxplnX9svQ6yAM/eW0B/2Y2Yu6CYMuDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(36860700001)(82740400003)(1076003)(2616005)(186003)(478600001)(16526019)(82310400005)(6666004)(83380400001)(86362001)(40460700003)(36756003)(40480700001)(26005)(81166007)(356005)(8936002)(41300700001)(2906002)(5660300002)(7696005)(110136005)(6636002)(54906003)(4326008)(70206006)(8676002)(316002)(70586007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 02:52:25.0493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a55a373-412c-4b80-d198-08dac846c1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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

