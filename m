Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FC722A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjFEPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjFEPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94102109;
        Mon,  5 Jun 2023 08:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DybvNlac65df0r0pwdKAU9K93YyXXpWBQ+UcdfHS6UGP1KtvTLkBKrHrwPJ0a5viTWKqMyqGYLi6iQIc4NhC3Z2WI8AiCR/JobUtX22ToHRz5iS99zM9mfAi2Y+WvEudja2XMCwDHCwldJh5+oYxGrCJauUjz6bOyzoys3llY3lvG2m+jub2UjarIk6/Vz9ucb591UfeUFtleBL/FEgF653MoVlyi/bkSS76Ofi0dKIQBZzf2lyICE8jZT6hNlPKX1SI5CGhtBsfQuEH/E9gFFYrOzOP7acstdyOue2lRw9nyMWkVhbvh+gCxyjWc5fy+t/hps+13SyH6JJANEymlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYnxTogBpZOUMyP4Kt72f776HwnVabAklKaP9FXXeAE=;
 b=cc28McKpoQTAh3cbn7XaKdl/0yn8slyVl2tCMaaF/IsPeozIGPl8R/UfJopNK7uKaxTQVM64YosznFNXWlqzSOZNEDyeJPEfoElvsp/rD2YZawdj5MpOoFyDsJ/hxO1AfTtgm/P6hwfKJiP3degaIOeSKW01DsInk7MF6f4qix5HsZaaU8LqccGlP9HgbXPYl9Hd+lmsVW0Y65eXYYSOFkkJ5M51avkjQFK3uV1aNnWdEvQfDmZKXnKFPVEgOriuAri8xGUYxGr6ZNx2uwQGyP+2jSybkGSRgsK9dIWqKYPE4CmmvoBjCgmSBSZUGMP6fSp1e+MPgZmSIbRtvVpGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYnxTogBpZOUMyP4Kt72f776HwnVabAklKaP9FXXeAE=;
 b=uiRKn138uMAFDm76jOOAeSI0cqv4IHWXgTUUFL5xfsTwym2tOlbfhTEFD4HIwhScaDaoFkHKmE1mvzvNmJqKmCGIA7wMvrv2S/aWnN9qRrX7twEp2GWz1u1gK/MMxHCZ7KR2Q3X4MG439BKwueznANoggfOAoRJXkrs3exXvcpw=
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 15:12:04 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::9) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 15:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 15:12:03 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 10:12:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devel@acpica.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        "Wyes Karny" <Wyes.Karny@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Enable amd-pstate active mode by default
Date:   Mon, 5 Jun 2023 10:11:29 -0500
Message-ID: <20230605151133.2615-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 456c0cc1-3b08-4997-3492-08db65d7383a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHVRXq5dsCanNuEU2QOW4cwHwVF2pC6geeH5NT5oJoap8XOd9bzmo5U5mqYmhoUpO+JA4/McCGI0hAdRyDcE0ssOCX5sKHESLkGiNSJcvss5CRV8G+fCFW9wc8BXvfb5YNFEpJX+gmvxOwtvyHNRQU5nA/VELHxMeK1c42npFp1n5/HsQQvn0aqQhdOD4f8+aDVVnHh9E+WcNtvKDWQFVmXc/nHOoXutjI5V8MRgeqm+wS1gWoZSpXUX+d04me3CdHPIr/L1Tl0ReQPE2WvXl0z/qDKEV5iE4gwGrxbs6rUhtzPrScm6Q+0hs6bBsVMENS2446Ai8cc/20AfTRIT/CJ1ZEAu/X7zgwfIpPezL66u1DgFKMiWNI82j/q66ZLe1ZdA8Mjq9uH/VgYy1Ow3PYMpPNv0jowgsGetoZh6MnrgWuxWKAcxq730s3FxI1AasMnCPnYcVoO50TeN+m5T02Hd7AaXuPfE+/hFKYabTyRBxWhmDT2cch4Fnq/SrUrnPq3u5swMyVZRy4AR54IqCfE3vUq7slRJjVHs2AJsFE/+5fX4ycaXGkIg/qtQuMJlPUaWdnyTwpH//liZRClud1aRv8gtIGI5gQze86dLhOW0H07M29DD5bh1VOvtGhZPkGomTHeRneAd2lcva0rBLwS7T+7cqbivSjncTDXWjVdCRSMTKPNJ+4sTptWeO9gp5Zw/ziW/j0m+nhWnFin+dF4atVG72DE8IOv6UMklFHRBI3eGJi3e7SpF/FbkcW/n4dLHf3lKmjb2bVQWeGu9MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(1076003)(26005)(40460700003)(36860700001)(36756003)(47076005)(83380400001)(426003)(336012)(86362001)(82310400005)(81166007)(356005)(82740400003)(16526019)(186003)(2616005)(40480700001)(41300700001)(44832011)(54906003)(110136005)(2906002)(478600001)(70586007)(70206006)(4326008)(8936002)(8676002)(316002)(5660300002)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:12:03.8301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456c0cc1-3b08-4997-3492-08db65d7383a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active mode for amd-pstate has shown enough success now that it makes sense
to enable it by default on client systems.

This series introduces a new kernel configuration option to set the default
policy for amd-pstate modes for a kernel.

Server systems will by identified by the PM preferred profile and still be
set as disabled by default for now.

Mario Limonciello (4):
  ACPI: CPPC: Add a symbol to check if the preferred profile is a server
  cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
  cpufreq: amd-pstate: Add a kernel config option to set default mode
  cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol

 drivers/acpi/cppc_acpi.c       | 34 +++++++++++++++
 drivers/cpufreq/Kconfig.x86    | 17 ++++++++
 drivers/cpufreq/amd-pstate.c   | 80 ++++++++++++++++++++++------------
 drivers/cpufreq/intel_pstate.c | 17 +-------
 include/acpi/actbl.h           |  3 +-
 include/acpi/processor.h       | 10 +++++
 include/linux/amd-pstate.h     |  4 +-
 7 files changed, 121 insertions(+), 44 deletions(-)

-- 
2.34.1

