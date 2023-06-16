Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB827330CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbjFPMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbjFPMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:07:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF32D73;
        Fri, 16 Jun 2023 05:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYzBElM84eAUbTWMaH/5NarcmfDXxrk9hDwkG8jjD2SPGI52CakNCD1hRqRjGSa8NdybLPZ9wqSlzQPsL4emF6t0mO97sb1cGD6awFphD+/+u8+ocagErybJscYORExOSkIpkTliilaxjLGt3ImMjqs2k0iQ9ByQc9J72ogBFQd0xLr0Fh3wwgEEdusAox73YysakJmi46NjBwic0XAcVOUUEYRsP9jMwLssEm4Z0qyldK88pUxE+njqufHv8qfs7xSN9AU0WIj3leYYGoegaJSyifaxGhMkKdx7PdhA9FBZ0iyNphdeJk3tMKCQDCy7L5os3xJ9boMxBn4ckbSCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlYkodrzglfXDTN5fkJDf+04scGep/JAEY4NiAyB7BU=;
 b=dqCzcpxo8OrpWsWaq4vR9iFx+y9wWzNoT7DFZzds4XZUySnDbICSRo2MmC6Tx1GEZEGA3R/2p+tAHpuJxJ+reNYAw/ZOt7lJgv7INodxRsgI0z2Wz6ET0eGx9blgbkqXcLHeAlXMXeOI+MpDgsiXD7jFw83dO9Qel1AXxOqSEA9yR6kg8WHLyZcjkMIwBV/xxThmvgAT9ODEDL05CjbjJDv8H1CDJM20Re9dvRPsErrHcx+9l+fwmHqLrbFmnMg/EvguWT7qzFlEcy3LLiUGl7SF4+n58aFRT23J36AQp/P0qUdMGF/4UkifyaOTfVYzA/WF4teYGIs22QXTIeyjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlYkodrzglfXDTN5fkJDf+04scGep/JAEY4NiAyB7BU=;
 b=CCEVxH7RMARH0JCFnAX2qDar2zfAROMHQUIMSz04iuYTsWkfm7JohHdwoQ9ySr65sbzfPcDzghAjwVWLLKJu9Qv9RBzHWTCVMcsKL9jmC+h0jSGNhy22DQfuturhxOwMKyerfTt9ZRP/KC7+yEXAukRlAxEdv+WtRPiDTFyB7V8=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 12:07:16 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::78) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 12:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Fri, 16 Jun 2023 12:07:15 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 07:07:12 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <trenn@suse.com>, <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <gautham.shenoy@amd.com>,
        <Mario.Limonciello@amd.com>, <Ray.Huang@amd.com>,
        <Perry.Yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 1/5] cpupower: Recognise amd-pstate active mode driver
Date:   Fri, 16 Jun 2023 12:06:16 +0000
Message-ID: <20230616120620.147643-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616120620.147643-1-wyes.karny@amd.com>
References: <20230616120620.147643-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d2400a-62b6-45fe-53d5-08db6e6239d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GhpWJzdaG9beKHgrNZcdl+Lkamae3PZBt0mRE4RFHZDf8K88lzWZvoeOVw8i+hU69YZPGuTEUrScThz0WENpyCgQfpdxZxODJ2x9fh/JcWCzWOjFTucOva2FrbULgLwYwBV1AYlWgr1HCQTjcvSEpKeYPvFUGsiYzszeLheC/jfLmmW0kg1vTvaseXQSQNs4Ca81VY4rHxQrKwLKymYkBsu25y86KN6KOB2VheaAEZA57t1IdZgUwOhZ55G3w/sCKxRA/90T2SJTaUrDyp1AtMIQWk/9u0aKM/kX6Rvk7rt0HfGYmUnkEM4ougSoV9GkPEDHIjzBELRBY7/PsctlDcJAC7rIIeSKSpo+eq38Ryx9dhrZGmonbEahMpD+LxP4qufee9VJ3P21jyHSBdu50WmFPDgFNybl0zIF952oYMX5ayZNSfce7fsf9SuLp3L3+ZIxwGO7VjDu2GPeGFDKypNGAkQinkq/FB8n+9sGHPB/t3SgB7lH3wbBf0iwDWlKncHx9zAgp0O6Z4w3AyPnQB6qPDytpMVP9PZ5hNiUCm0bDY3rRtqKPhCJAXJcY3UzCCgUxbSGQ+yCkMl2EEH5Sx+yIqyq9E0P2TNUTs2mQbdRE7znd6t+BeUL45yQATNC8+qlkd6mNvvlDKDZhf86Cs8xIXupZH+FACgQJFcmLq1M3M1tUdPIHDF79UXgmd4zsxLaT6EVivlI004Zev65+mXF4Vzh+cuPbIhNKPRxqnN4lohDb1seL3g1qLRG/9VzHW6MoOgNl3NI3Xg8Ac0UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(478600001)(54906003)(8936002)(40480700001)(8676002)(41300700001)(316002)(7696005)(1076003)(110136005)(16526019)(44832011)(186003)(4326008)(70586007)(70206006)(26005)(2616005)(47076005)(83380400001)(40460700003)(36860700001)(336012)(426003)(4744005)(2906002)(81166007)(356005)(82740400003)(82310400005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:07:15.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d2400a-62b6-45fe-53d5-08db6e6239d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd-pstate active mode driver name is "amd-pstate-epp".  Add this to the
string matching condition to recognise amd-pstate active mode driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..21f653cd472c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
 	if (!driver)
 		return ret;
 
-	if (!strcmp(driver, "amd-pstate"))
+	if (!strcmp(driver, "amd-pstate") || !strcmp(driver, "amd-pstate-epp"))
 		ret = true;
 
 	cpufreq_put_driver(driver);
-- 
2.34.1

