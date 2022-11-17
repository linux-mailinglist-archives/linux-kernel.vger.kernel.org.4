Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C862D436
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbiKQHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiKQHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:36:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B56A69B;
        Wed, 16 Nov 2022 23:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF6JHRoWfKDpJt6s7IbHWENiZPUOsdbH2iKxsVZvjUcCkAGwsDpnqmbzXepi5u7XE9sybL42iEOXAUBjqo9tObyQ9vQ53LJmPj+Z7iIfFpZqO8j362iC8xTa2ErWwmi/MpUH+spSX73EqoWoBuDPkp7ZkpFfVMEghn3o/cDrDi6EZuqBelol/9hb/jIIX2xYR6ntJEYRdNw6ya8yH9R8wd4rYzqxvOPBKl/DlRvLFv06pS0tbTTLV4fOaCHH9uqzrtstsShVtZfJ3sHZE3jTRmVaCe3451Dm18mbM5+mFcScm57tJDkrDcVditxZ3VrN0Cq0xOQE22M1tLQI8pm6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORp+8ilCI2XEPpqvjSOMPFxkMyHIu+gSn9A/OobDhBA=;
 b=WQyKsGuSOnNeZ7eohQY1Hp8zt3l59+WCsoF6WJqjJdfxDMPmgh2fg707gukiY9aGPnyVoZivyaGzRhA4WSqRjZf+9rtR5DsgJvDvorqgXt9V0+IIzcAoRz+0YxaoEVo9Mu+Y+xBbm2NNhDIzQh400qJKwLCuDc7Zl/Rn/aM6R9H8DIwZwqIYdusVlPf5LN8rEbLe6D8OLrP+Xlzfb0fIbQ57NElze9sAbNJZbETXt1oVGh+TYzWdFSNHwlChuYxy+1uueIiESKEzt5oUAPY0A8srbbQkSeIPuKa7AQ/BxaOYISw7Yw9dU/I44ekxWM9Od9LCq4qFu/PH7zt0KbGiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORp+8ilCI2XEPpqvjSOMPFxkMyHIu+gSn9A/OobDhBA=;
 b=DZJPTX9YW9bPRM8S9EVP4HqJVBskdrhQ7oSzLFjCSOesxCgmzCw588d/xJz6vk0rubXmYM2YYqbinY4ddeVImcfM6BdpxvqW7/x1M9HKHO3RUnoO5nzuIGKHD5UwDe8LbK+LVjj9SuvffKTxohbjvhHaJTRp95kkabZkcO+B9gg=
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 07:36:18 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::61) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 07:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:36:17 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:36:13 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 2/5] cpufreq: amd-pstate: change amd-pstate driver to be built-in type
Date:   Thu, 17 Nov 2022 15:35:38 +0800
Message-ID: <20221117073541.3350600-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117073541.3350600-1-Perry.Yuan@amd.com>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: c829a3e7-47ee-4318-4c6f-08dac86e6a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL9ul1yZn4VMJi/kdf/VR4aawDhxtLCX75veG4Rc2qVaMS/BkvMRFdTe9lpZuFMpNvW74S6ELN2RE03MAiVxGUEWW7989yy6WWZqWBgKQtqLi5ZRUTSq3aMyJEwc1aJjY99qFXzuvJFYn/yoek6q2LVU28b0a3V7i+4coiiACY2qWa5vaQHLNx5jywwKDDLUNzjppPFZFoS/CBF3L8PRv1fn+yWJmjcI22WoXJY4kiUXVvxzMZ2d4x+YwDGiHfC9ugShbtFJV68SjMrfqwmJ4ifWlkmEnrTEwCB6b6ngCoDvSRVQnTJRreSdTtqXaccoguKplxBl10TvKFHxqwK0qoAzwLXhyWnlf2+3q6KDPuE0ZmfQWXDeQYINrcJ9JClb1YxQNz0SeFGFLp/p4cY/Xz82T2i7F2HvWkejAtXgya0bT18k/tq4aMCRb0nc9CR+8zevnQL0XjKcJvAHD76j0To/LT2aVQl8+TuuqBxXjQBINU3OWr2JfmGjHXSTOmR6Kst0hn/Us3Z1pLr9Lnd0ewjbQO14KC6HsFwl8tFdTQrZNajrdK+VZo645XRT3WSNYVctWCCAWIz4bIYbI7A3+Go3N/L0DPJNmN0FvB04VC5DjnpwhzA9Axpz1AKwC9beMfshHLznaK3JrvD9he2hKaCGfFERWBHQci2LeOlMDFJD66MMUWQwj3L76YnuzqA5f1f6wLka7eL2LIn7wBHTgq8P5Za3I2WO4b+llv9uVpuSEaXeUpDp1HYHT0SZnLW9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(26005)(86362001)(81166007)(82740400003)(82310400005)(36860700001)(356005)(83380400001)(336012)(426003)(47076005)(2906002)(40460700003)(186003)(1076003)(16526019)(2616005)(5660300002)(478600001)(7696005)(110136005)(40480700001)(8936002)(6636002)(70206006)(6666004)(54906003)(70586007)(41300700001)(8676002)(316002)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:36:17.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c829a3e7-47ee-4318-4c6f-08dac86e6a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the amd-pstate and acpi_cpufreq are both built into
kernel as module driver, amd-pstate will not be loaded by default
in this case.

Change amd-pstate driver as built-in type, it will resolve the loading
sequence problem to allow user to make amd-pstate driver as the default
cpufreq scaling driver.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
---
 drivers/cpufreq/Kconfig.x86  |  2 +-
 drivers/cpufreq/amd-pstate.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 310779b07daf..00476e94db90 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -35,7 +35,7 @@ config X86_PCC_CPUFREQ
 	  If in doubt, say N.
 
 config X86_AMD_PSTATE
-	tristate "AMD Processor P-State driver"
+	bool "AMD Processor P-State driver"
 	depends on X86 && ACPI
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d844c6f97caf..701f49d6d240 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -663,16 +663,7 @@ static int __init amd_pstate_init(void)
 
 	return ret;
 }
-
-static void __exit amd_pstate_exit(void)
-{
-	cpufreq_unregister_driver(&amd_pstate_driver);
-
-	amd_pstate_enable(false);
-}
-
-module_init(amd_pstate_init);
-module_exit(amd_pstate_exit);
+device_initcall(amd_pstate_init);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.25.1

