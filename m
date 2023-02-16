Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3382C698E87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjBPITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBPITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:19:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC13B666;
        Thu, 16 Feb 2023 00:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV/7PZJ6P8GKqXeFncADlcEdGzCME2SCaS0+CZmHZcwYkiVvzqzuCCUE2zs0OljYREQrc3p1+3pqo1fwcY6LASnLlXVanWZSD/b1YQYe79mITveSAoY31VWsGVYMYgrT7y5ZWsnGpB16Dc2gWtlxSrzTQPBwbB003veItRs5UDP8yb9r7It7ZHTnI2KU5S8FftrK6299RKrego1Xl7rYMNvbsTUCHDbaIllPZePv/tSbc8u5NCRy6aW0w57OuqiPoOCVXy3kVWE686IUco5BAkAMM2J616rHnJCWZaTr/GseWUX3I+6FXc0nbUPJlS0ldIrdC+Oorv+rXIgKSfK3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i9nqTb4I2fb47vJVCPnK7PmkPVf096xB7bxM02GaEo=;
 b=EPBvPtCVSQJIvSuBz4EBllwaIXX0WqTl5Ypu9XOqUyCvp/MN4wBEAvet8cHxswz7FsqxN8htTgk8lKuchvoln4NystVMtzTWK/I7qjZq1XcS1Kpc9rh6Att63OTSewnICj0d98sLxl69Hnem12ZqPmW0XDFOfF4TG+d+2l+T9U+xJa7eHmJos1L/zZZoJQV23yiElnr1vbZqBAvdp9LiHWLewXu5JqprRr5DS8xbzu44fJIMJHBKtX/03sswn3qPDuUZq1kUDOFp1GS7bG0CeK+sLMD6DK1PzI1meaujYN93U9DdJ3TZJvq8aRSNMsjKNSeK4uKHXJRDRlLZLdfhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i9nqTb4I2fb47vJVCPnK7PmkPVf096xB7bxM02GaEo=;
 b=ZNgp+53s/mwGdn6MHc8JSB8ZyXBhVDfv5Rn0xqmEW5ryonRRHLoKf5b88BFyj49ypgYTnrFFk/eRC4UiBxWe/jdjqEv78DGUIF2inC5ExiAA6MMUH7kTSPTVHKBGjdu5ybJyG22cVaOFK1rE0pJcu/0NRszfhXzd6nx9LacjMWg=
Received: from BN9PR03CA0792.namprd03.prod.outlook.com (2603:10b6:408:13f::17)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:19:43 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::50) by BN9PR03CA0792.outlook.office365.com
 (2603:10b6:408:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 08:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 08:19:42 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 02:19:37 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 3/6] Documentation: cpufreq: amd-pstate: Move amd_pstate param to alphabetical order
Date:   Thu, 16 Feb 2023 08:17:59 +0000
Message-ID: <20230216081802.38007-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5ec181-cba6-4fb1-043c-08db0ff68e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPKfyTpVwkG0pzRuTCVBk4WbicvL/m0U2OP9CyRXE7KVDiPdDQiSjtMcLEOLuSO/+bn/bnKchxzAfGRIbwk1n5IebFCClEf1bs/qgG/NEReWt3f2lr/LPo89Qhn96hAlzM3846GlChhKSGdfb7rk4y8NJn7z3xkjmwCMTnhlIi9hrbuPOugO59tjuUpoqlQBnD74ZX7UF2zNLw8OH3o6hehz0AbrNIszi7l/GQNSO+PG6rIn1EZ3eHoNladr+cHlcltfvTHKW2Bsur/FDXBhFKzeQcggyYfy9kYb9+i9dZtcIaLfohFyEBGHnhZAqDYqCdqGDxwkpbtjrGw6QFKR+kBnjZz9vXwwYzGL+9CGdOYi4tlo8UNI0AWH+O4IGNFGsxkz/f9QjQ9NzNssIZcxlJlSEQhM46xnGgVBowTCJkfrGcXah8lvuPdpDL6Bd1gvTX6Gj7FvfxZzEeQnJKpl9CmD9i84WLOHAJDFuDmqVDQ+fUwpTpNnn/UxZsRbjcg+vbPFGL8weyzhdv6zRe0yvkZpZlrv6DrO62dJPJiyaqlMGCExuiLzzL6idDsYGpCv1FL2DJUywfz8PVoQH8iFHZwfdcjrez+4xs9Ms4bKzjsJ92GbMCLEm6INe/dox+zh4HFYCNQzlZhy2a4IbTVUguqPtY1zWII4Ba1Fqb7Ktm9msONQcydsFrKWHhMnoRubmNmiyiwVhsmIQ2mUp6zZao35ZI5ucSV/cVulItz0ZJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(110136005)(6636002)(54906003)(83380400001)(478600001)(426003)(336012)(2616005)(6666004)(7696005)(1076003)(47076005)(36756003)(16526019)(26005)(186003)(44832011)(41300700001)(356005)(5660300002)(86362001)(40460700003)(7416002)(8936002)(81166007)(40480700001)(316002)(2906002)(82310400005)(70206006)(70586007)(36860700001)(4326008)(8676002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:19:42.8877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5ec181-cba6-4fb1-043c-08db0ff68e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move amd_pstate command line param description to correct alphabetical
order.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3618dfdb36a..6ffcfb73e62f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -339,6 +339,24 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
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
+			active
+			  Use amd_pstate_epp driver instance as the scaling driver,
+			  driver provides a hint to the hardware if software wants
+			  to bias toward performance (0x0) or energy efficiency (0xff)
+			  to the CPPC firmware. then CPPC power algorithm will
+			  calculate the runtime workload and adjust the realtime cores
+			  frequency.
+
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
@@ -7010,20 +7028,3 @@
 				xmon commands.
 			off	xmon is disabled.
 
-	amd_pstate=	[X86]
-			disable
-			  Do not enable amd_pstate as the default
-			  scaling driver for the supported processors
-			passive
-			  Use amd_pstate as a scaling driver, driver requests a
-			  desired performance on this abstract scale and the power
-			  management firmware translates the requests into actual
-			  hardware states (core frequency, data fabric and memory
-			  clocks etc.)
-			active
-			  Use amd_pstate_epp driver instance as the scaling driver,
-			  driver provides a hint to the hardware if software wants
-			  to bias toward performance (0x0) or energy efficiency (0xff)
-			  to the CPPC firmware. then CPPC power algorithm will
-			  calculate the runtime workload and adjust the realtime cores
-			  frequency.
-- 
2.34.1

