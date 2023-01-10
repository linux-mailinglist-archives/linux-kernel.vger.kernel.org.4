Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E086640E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbjAJMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjAJMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:49:55 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454C47321;
        Tue, 10 Jan 2023 04:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEiW4kgkyHwIRtO+nES1uKU06gGpZjAcXFZwy2zyX4wUqJ/GuCQZ5sVFs5kWnRLt0n9XINeh3j26TW+9/aobjTxQvBFyVxfSJWPG+39nEwtYEXO40V9bPcDnFRubUMir4vFUhbOI56BAjjClQuuG8FggH/cfYJp2u2lql9g6k9OfA3EaWWLjeQvavK+xqLfmDsDh1bbkPkXbhqKDThv52t/o9YdT+j91LhZ5ozxQpWdbkq7YFLRT2DANFbPYYjghqNYUbIXK07PqhFxm4VQY/QsJFwXEiBv6CdCiJ8HdLW9qEaIJZNS3mU1GyQte6E5CfF1yHTku0cWQSR3VSPIhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpWnrQxpCaqxlSLuLRK1qafhhMGmwai3lN6gZzAKagw=;
 b=fD+vd/ZyAfL6LSrZFOpqHmlSlaPq1NurxOG/4UuAwazZKM13ev30PrKZyxtzAk+wkW4QIQLny66orlkGinZMvd0+KDvsYhGTgCIQfUnTfCAT8v/N3CxM4em68rA1xwxAGmPvczcuAiVB0Z0rFe0qUOphw7VSolppRCgHNW3tsk9dJRgrb7NoBuYwGroFjxMBStqwZaHdyNNViH4AOe39TXfpPmn8n0Ml/3MHzbdIwGKei+EjVOGl6UD0F+k8rkRagpR4/OSgxwWTsoe1RJ7Th7oWn1prdheG/fYiUmzbVhFUmTJ5hqBYRqZa0ZHRAOVyz5KOCe7anwEpIdALF/wYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpWnrQxpCaqxlSLuLRK1qafhhMGmwai3lN6gZzAKagw=;
 b=UjGrhyCmGCrOsPOSbqx3p6wNS3E7NV7ihOaAfmhwNYuB5qElS5LgWUOmkZ5FqhGQwcacY+Vh8MsDAh52YFjzcRSHmpamSyCAu+ohf4OhbeP0GNmfBBsAjMPWriIAjDQZFKVIWryd4Wap/ofqJ4NEwuzWGTLwp7RORAuaY5wXiVA=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 12:49:52 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::73) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 12:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 12:49:52 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 06:49:47 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Tue, 10 Jan 2023 20:49:40 +0800
Message-ID: <20230110124940.1622798-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d748a65-c4b6-494e-361c-08daf3092ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIyhUhV85nyAXHrZG40be0IYlM1dkO7No+a+7waBzuyi04DsZAlZ80s8Pj6CHS5pP+EjbJphciKpZGqNIvD2J19ICV3zOqHwMUdiUSC5z3d0QU8gy3a88dbAUCuF7ctI24Zb8pnw/qGMv5ZUtcyvdWCD890KM9s7bGblsHUgvFS5LOpw8Xqp5bEtbfBIZdKdlm1qxx7qEVnFuJMcvbWOMw7mA5fENh4Kb9qRLFkICs0MS/cj/QYIT88VnHTXc9cEdfiWbIDCFIZ1zYM0i8uOsltAB72APnL/UvQJhTdkfpwEgKSO/VoRUG/W4P8g5f0YzS2non73dPuc9t9rDNJx2GDlyIGJXtNAmCE6vUXvc03mGAbJfSX2X32QvBjX0PgDKHSrSfjumeue7sYV4sDN0GqF8rPc3sL56wqLmyRfKNVIt7y6fHySmt/1OnJex6p5JzQt7G1kGinALfgsCCkjSI2dDEAb4TYXiK0PBZ98TiL++CYi4wI8RZkj+owYCEwLpxrsETA6aszpElbbIAa0GKmGEXAmBHTWGO/uNFSImbVo1nAjL3kLH7HyQLGEEJ4ZYEogBHPTSYyT1fcSNccdmTIv0qjjIFTlcrYFaaHeY7+0vteNY60mYmpB1s31tEM+efe2jiOsUlp/T/LGbBwkioZhFPxuKTAb2AE19ndLYf+3Kfr2IeepYsyyhU8IFW9ElBYf32Lka0FfrGarcwtPu5/iHCkxIzdVdnAjH9p8AdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(2906002)(81166007)(356005)(2616005)(1076003)(26005)(44832011)(7696005)(186003)(16526019)(40480700001)(478600001)(316002)(5660300002)(82310400005)(8936002)(83380400001)(36756003)(86362001)(426003)(47076005)(40460700003)(41300700001)(70586007)(8676002)(70206006)(4326008)(54906003)(336012)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 12:49:52.1452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d748a65-c4b6-494e-361c-08daf3092ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
increase increments the kobject reference count of policy and make it as
busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
decrement the kobject reference count back, it will resolve the kernel
hang issue when unregistering the amd-pstate driver and register the
`amd_pstate_epp` driver instance.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..c17bd845f5fc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 		max_perf = min_perf;
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
-- 
2.34.1

