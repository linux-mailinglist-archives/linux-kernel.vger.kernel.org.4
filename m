Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2565F89E6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJIHLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24795BE;
        Sun,  9 Oct 2022 00:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfhP7yDvo9/ffbUp0rcEhLtIbIaNkpY6JiJLDggZR3zRE73ujv2KSEXWyDZ4VN4Bk5PfLTuNJCQ7srVH/6/Wi8aP+2JzYUXFhaw/C8NLW7RxD/KpcFNsqrrFs5FnwNdjPMdIQL4ztsXEUesfR2R6BP4xRI90Kv1lrtobCLISLK4pYvNt36uOchSAIcg/xaJa1eB6jTRW5R5SMxaI2zhBBT3KoD5xpqS5xQ20fPj0RBYhGbVpXrv4fTZYsE9sxvJXQ97LP+orjvUVz8ns6nIZgpR/JSyQMWEMPo53/bBKDqVuJoKjdgAhIjKwbjB++nzFHml09BHOs3QOcl5AFvFkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvLV8b2WBCHL4JYNEZv5XZDmOonX3mlPcA7RHdrvDA8=;
 b=MIK8PRD/CMAI+ucNIVJM8I271EHm/39xG5B0CznkHZCHMfek2j8IfRzUf/qxLajPK0org0l796kTCi2/TTPWCwK72Jto0QMXvHCFcH7kOUGpE4DlClR/nlq+V+nNYHSHKEoLUdkGvNQ7l6OMY7ownnmgicIIkoFg0/1eWR+pGZJu1sfGHklD/7UH9eg9QMF0NWPJwUeph+8Vm08C+5LITWdaNAMjXfqFQ4gMdWmBGriNx2DzCKcJ3ZG1cCAhUcppfKdXit/vkgDTGyrc3f/A9mAp05teU0/aJDOz99EB0y9L3z7nNtXkGBQbrdsMn2TGZfMXGk54n4atL8Hhsl+zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvLV8b2WBCHL4JYNEZv5XZDmOonX3mlPcA7RHdrvDA8=;
 b=y7OgjtfVwqygq2uggPz2XP/XdGTtDKKOmiXLoilgmvJylwU1z2L9FBr81Z4Efi9G/nH0VQNpD+Np3yIBTV3haM5owFAkaC0iMtxqn9t6hJmjP3H0ckxmR/f/i7IOWK4TEyi1vE2ihwjILxXufW5ctoKxsoUfiawoFamARnkMujM=
Received: from DM6PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:333::33)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:25 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::cf) by DM6PR03CA0100.outlook.office365.com
 (2603:10b6:5:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:25 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:11 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 2/9] cpufreq: amd_pstate: add module parameter to load amd pstate EPP driver
Date:   Sun, 9 Oct 2022 15:10:26 +0800
Message-ID: <20221009071033.21170-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f7b351-bbb5-464c-73ca-08daa9c57a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: andjh9TUSt47Qc6VO4kbKA9/AP6dp5t/Aitw3FVB10SXl2xnZtR1wzWdPm9XfZLOlgQ50SBSALKopBeQm8+vPiI0HhLXWsP6BNGnwbZONYijggWODIRCWkUPYICw2cpxoUoxeYtyBDXSA9yPHAUobMiSCMe1CsqQFaCniY3y/Sj5tqV7acT7DSL/w2qaIOoyn/DnJN+++VSzW2wHdasphW7h2rO+kM2Uo8QTghOmz4TCv9H0aUeIDi3lvSFOQMPkiUsjyyzYC3hl9SG2S3++65yRfDdlXEHbN83VYwT5F90O3mDx4N3zKiW9V83Fgj4OAOq69zufxmFNGiQZRwtZJG5TeKJsrLpndnJNE+snYrmLioga8SG2Mb2itl9l+yNMWvb5Z6P9sJo1rBE+5lQCK7WR8uYyGUmQzohKX8ldKlYwWKZDMqmJRKmHSIA73Ahx41sXKYLP6j6dqKvCTsiRQem5zike10n7l1uc6VSBpIc3Alk5uoRqTORsiUgzyyncSas0ioVI8PKKfE7wSrKGk4kbVZWcsz7Gd/BbFoK7XjIqqHJLK1ZiLmiQ6nxTJl0IlihDcJFxwDBvFH8urVmGW5nwTG47EHDcS1+zZlxfTzvm355f/7jn0JLkK755jyJkQIMqkeONOYAoana3Vdk8Zrloa/0Qv8esZJbw4+qBbz2WqpGoju81ULro3S74/27QkLnJ9iTSzy73FjIUgMiCW9sOfzaHsmuDuf4ijNvFpG4Lee6SiddyeF8c4E9y+ggxiU4Pte+ybm62xaZx9kKB8DSD0LasDlLPhdQsFKDs41bOTVg3/bTtnBllIkiiSkD6uQHCFk/G4uhrBLH5XF1AGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(7696005)(2616005)(356005)(316002)(2906002)(26005)(36756003)(36860700001)(82740400003)(8936002)(41300700001)(81166007)(86362001)(70206006)(6666004)(70586007)(82310400005)(40480700001)(4326008)(54906003)(478600001)(5660300002)(8676002)(110136005)(40460700003)(83380400001)(47076005)(426003)(16526019)(1076003)(186003)(336012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:25.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f7b351-bbb5-464c-73ca-08daa9c57a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd_pstate mode parameter will allow user to select which amd pstate
working mode as booting mode, amd_pstate instance or amd_pstate_epp instance.

1) amd_pstate instance is depending on the target operation mode.
2) amd_pstate_epp instance is depending on the set_policy operation mode.It
   is also called active mode that AMD SMU has EPP algorithm to control the
   CPU runtime frequency according to the EPP set value and workload.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f52b8f2fe529..14a275c22aff 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,10 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+static bool epp_enabled = false;
+module_param(epp_enabled, bool, 0444);
+MODULE_PARM_DESC(epp_enabled, "Enable energy performance preference (EPP) control");
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
-- 
2.34.1

