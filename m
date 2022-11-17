Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059762D42D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiKQHgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiKQHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:36:12 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B586EB66;
        Wed, 16 Nov 2022 23:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6qHj0GhtQYJlT1zwe6i30Yv/gAmIJ7GHxF+KxAyVXvGiLM91Lx2mF14OcPdwUKJKEqYonNHVKOEpCIluSiirhcqeIACjVTTXNCDhiutQnTO7hLc1szjwxPvpfu0KluHhxOBlGoNDAhKwMK1kiMHjILGPwNZIAwAOPp9l383CpHQdtNHzZCbVFJl0S66cj6+g/bDyl9++Si85NB/HhCuLYeTAodYnmuzjNfd5o3eJRqy9I9CPIffeBceuUcwOkxY0T/H5yTq3mgFsmTzHbETJiE/rXn7PULpS9IV4FsULvX44BDCO1HBUC4HH/FTxzWYFkh9i1lnKn1IVV89vyvyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDb0CacepZsRMOzcEBhU2P94Pnro0Eu2LXZqz9EHkH0=;
 b=Xu/G3salz6QVRNfr7rFZRO3UHJz9MgKxmEB0DSnu7sLLJtIFII9f4S9bJp+wGRK6UeECEsxonA34CmC3JVXTw8NQwuP/btOV1CJbNaC0BuR/1RCo7zt9la60N9XyKmWFZuarkPEh/ID9Qt5Pma3K0ZTEJxuNBeOfcXn4ZnPvAdyuYbJ/ZFRbQpg1wDLdZsZ3TYNNKsZ0hr+TZU7JpwoHNpfehMAGN9fnFL8nMnshJ/Gn4LiWJJ/UOxjCLRfZBsWWai+mSs56MyY3bJ3brV/kVkFHEupD/6ZIq0hLX5uYbjm6oLiredDiYV/AkfUMBjyYtruCbxc1Nzrwud/yHXyUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDb0CacepZsRMOzcEBhU2P94Pnro0Eu2LXZqz9EHkH0=;
 b=xl2NYFtjt9dx8Tsp8KIUK2o6WHkwrS+9dq9w2mmn/xhdbXf6JWOX1IFIHuG+L4lCOaDwSrL0GlqNsU6ZyGIFcjaoMrSAiXAiWxEVBNC6ByXNs3ZRsrWvGyFXZUz1vby4VAV2kY4woJgpwZPnvoSoq5lduqTKAOH1tTTltbANhjQ=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 07:36:09 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::74) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 07:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:36:09 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:36:04 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 0/5] AMD Pstate driver Urgent Change
Date:   Thu, 17 Nov 2022 15:35:36 +0800
Message-ID: <20221117073541.3350600-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae67820-c948-43b1-6e42-08dac86e6507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VMhsVg1hFdIIZI8rl+/DOB8yjw4HifGxm171Kzxq5w5aHX9bIAhZdD1mpLaBlyQO7CpWWUJK1LNP7/b6nNjo3ib5vxvP1rje/78jYsEetgCyayOzTalgvZ4XTIAObdrxfg5C2H8zpgxj3xOeh0NzKv+JfjpjbqdfH4HNQJ5bNmEOf+6qICJ83E1cWmmAw8rlIWWqR2IqbzeLxAc6tSNWW3ipsRcfUngZ0H02NQ4INFf3d7AXS4EIoGjjtRhVivKYW87ckv93fYxwLNyDFngf5is8d9TDj6yzC2huRGvbgVcSEia6hEf0OLjzNJLeMtiG/DRaoluqScr3wEPO3SLfNRaVKTRfR1dWnDLtBANxGsaqEe1FnO/k+5fjdXlE5QkWgiN4PiZa65Z3QClt0j/5SmgrJDBlrtuOEqi9YYXu3OTj8IUMnVTxnHiQqxVAdbf2+bjKNv5wmFBWw80Me7hYfTmbPhkMYUXTb1uFiBzzD21uzF2s8TrPBOWFSukvjf4JEVIx4aKr7McTkuRmXLGC5qdTsCMhMLvhGcUnKezHtlc+0kAi3u7ZDjw00wAIl0MhH7IfnKCZESgbTbJi410Lv+9jZWIQG6yzWLydoIwgUX4pWucF/ZkotXTnAtsBcKpEEldbSIRQCDP8gmrReIH8BAXvq1oVg2lf4tn2L1xFD/02fyynvquP2PCS7itgPSueRYt4DfueY+JpopDDIQTUed67e0bHDgTCGzpIH4gmmuIW1n3YxjB1NkfsKwhTjAot5o2S3iWzXR8v+2F2WLK00MtMMMo2OYf6Vj2l38SuOlJJgusRnj3EKH9qZkATvcbcSJp7k0ZuW62kx01r35Dyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(426003)(36860700001)(478600001)(6666004)(8676002)(36756003)(110136005)(54906003)(70206006)(316002)(6636002)(26005)(70586007)(41300700001)(966005)(4326008)(81166007)(8936002)(2616005)(336012)(40460700003)(82740400003)(5660300002)(47076005)(86362001)(356005)(1076003)(186003)(16526019)(7696005)(2906002)(83380400001)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:36:09.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae67820-c948-43b1-6e42-08dac86e6507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset changed amd-pstate driver as built-in type to resolve the
driver loading sequence problem, otherwise the acpi-cpufreq driver will
be loaded as the default cpufreq scaling driver instead of amd-pstate.

Some new kernel parameters are added to allow user to disable pstate driver
and load driver with passive mode which use governors to do the
frequency scaling control.

* `amd_pstate=disabled` or no parameters will not load pstate driver.
* `amd_pstate=passive` will load pstate driver with passive mode.

Set the `amd_pstate` driver disabled by default because of performance
degradation on a number of AMD ASICs in the passive mode driver,
especially the shared memory support processors.

EPP support for the amd_pstate driver is under review. With EPP support,
the said performance issue is resolved. Once that gets upstream,
the `active` mode amd_pstate_epp driver may be enabled by default.

Changes from v2:
 * pick up Acked-by flag of Huang Rui
 * fix typo in the cover letter

Changes from v1:
 * fix commit info in v1 patch PATCH 4/5
 * pick up Reviewed-by flag of Gautham R. Shenoy
 * pick up Tested-by flag of  Wyes Karny

v2: https://lore.kernel.org/lkml/20221117071910.3347052-1-Perry.Yuan@amd.com/
v1: https://lore.kernel.org/lkml/20221117024955.3319484-1-Perry.Yuan@amd.com/

Perry Yuan (4):
  cpufreq: amd-pstate: change amd-pstate driver to be built-in type
  cpufreq: amd-pstate: add amd-pstate driver parameter for mode
    selection
  Documentation: amd-pstate: add driver working mode introduction
  Documentation: add amd-pstate kernel command line options

Wyes Karny (1):
  cpufreq: amd-pstate: cpufreq: amd-pstate: reset MSR_AMD_PERF_CTL
    register at init

 .../admin-guide/kernel-parameters.txt         | 11 +++++
 Documentation/admin-guide/pm/amd-pstate.rst   | 30 +++++-------
 drivers/cpufreq/Kconfig.x86                   |  2 +-
 drivers/cpufreq/amd-pstate.c                  | 49 +++++++++++++------
 4 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.25.1

