Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01693730F58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbjFOGaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFOGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:30:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A91FC7;
        Wed, 14 Jun 2023 23:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTKskeyPHXCTkz1srA+Nuao1WhBzSmvGwvxC42U0Tg0dwZr0UPgy0nNpW/Fd8F1NmwwAN+CPnRmKoijo0OVCg8MqfWJ0iK6+p4XM1l28WMkfdVAcgIZBL1UPAFDupEYZGNoqm0GYaa6DbXTft9Ikwf/G/JnMts0XyxmjMSzBb5STlT3pQLNRUFQV4h2F/0UDOWvcfveChKoc0sEFYpPoqCO8O1xitEi5HNP7hV0WBsTeuzpP2HuoS4yw01W2mge94SSvIrMUWQUwH9ZpBPy3LCif61FEee3jixcjJ0yc1zDCNLlxEVlFydwu9J1qjKi2CACvlisIwQ1dAJJD5iL9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibXOkKPw/qmIxOq55urOA9fyt/96qtFjR9uHmi2XK/c=;
 b=RJakbz6xR147NV1k/YFtIB9yqB1YInKpqT4ACh1gYulXEfTYSg/V2MiyaMRILbCTm2lxIbQGF7j8mCvnhqm50sys1EQyraGxJ8Ymp6miZA8eJPEHbCKKYZmHhXJlbPiwumOs34/7rgkZXI3Oy1C9sVbG17xvIQmZbCkFnjgIXhWXV5EBvvKbPQ18L77uQz/K/2uv1BYaikBKM0QoaJPlzVmE9H/aTjKu1TOyfyuwWsO7XpG4Fj9DZrU3vT8cFFGRaQxiyFs6u555y3m2G8q0oaoV+ewg6ZSs4OP75AuA57ShF7ZRfhGRKZEe5/FR5W3D4Jzl/eiNzgq1tqA9MQ/3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibXOkKPw/qmIxOq55urOA9fyt/96qtFjR9uHmi2XK/c=;
 b=2ASu0iDOMsQKXTAd7c5ubdn6uMWwA0i6Qefr9ULq1zcp3Km8HL0P3CtK0DWlgXxjLzxQSwo0nRKwuBgmGLGyaF7xbM143feowFBWfEPElg4lzMl0Tx/gFS2FYUou6J2vxqbCnXWUU3IbNFN73ZNlQ+uKcLp2mf8L9zZq2NGaS94=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 06:30:41 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::82) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 06:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 06:30:40 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:30:32 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Enable amd-pstate active mode by default
Date:   Thu, 15 Jun 2023 02:29:53 -0400
Message-ID: <20230615062953.4028965-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: e75b0934-b51a-467a-72d6-08db6d6a09f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwszK3SHDcHYXC9MWqlWcBOA8UUsxshIPq8AtiG1oK3bgJHyQ51wk/Q2mbVUTFuCibAM63Dv/NFOALSBEzHGlHKVjnnydL9KazVtF5B6cJdZBmHHM9GYqHV5mIQNXeb6CyZtFj80lb6bLexx4MmmOC+K3Fva034TyTo+AimRNFfzWSPlISgOxVw6bes0zFigiViOMe3ibfa9rERcnSG+zsvoYntYfeW78nPeOOKl2gKWhRrqDKV+Za1+0HxlHISqXnLR1N7UQvAWgLoOt1e2aOmk3mwPwg8bhLmmKvmLUDw/M88ztIzdn5CTjADZUjTi+QSmk2qjLK7t4ngR7vvUSB6lRmwj/5Kj3TXOYdWkoY2K5xi9BfH5FExZpmDk2F6JeM4gJY/TVZcv1PTzX/JAul8J8qBxQ7gaSFbT7FqFouId/AbVT+snvswn3P7rY+zrzzlXtsmMuZJLhiadHu2FvfPBbWWjJSq9j5QC4oZ7K6Q/52XMxRznk0i0TFI67/Kz0HiCT3kKtKLU05OGOh8WuhDPaPHiylr0MzinQ/OYHt7XxMSrObO1u4/wbw/is3RUaSGryAwymb+5JN4vR8Ram8SElx8pfxclMEppq5pibVL5PHRfQDQ/QPWhi4/knJJNKIYDBfxlj4/n4XvTYCWOZMd2UXMcIc4O2CFsTWptPNQJXw2dsVsXWq+WExSMYNW1d3mjcrTZ0mHqiFDGr7ld5kfvHDcd9BcdZ538s8i/KjBpxNqn/O5Sm5iztIDmmSlZbAwRks7oCEaEhm/pnh2zAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(82740400003)(81166007)(356005)(336012)(2616005)(83380400001)(426003)(1076003)(186003)(16526019)(2906002)(26005)(36860700001)(47076005)(44832011)(478600001)(40480700001)(6666004)(70206006)(316002)(8936002)(8676002)(41300700001)(7696005)(86362001)(82310400005)(70586007)(36756003)(4326008)(6636002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:30:40.3564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75b0934-b51a-467a-72d6-08db6d6a09f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

Active mode for amd-pstate has shown enough success now that it makes sense
to enable it by default on client systems.

This series introduces a new kernel configuration option to set the default
policy for amd-pstate modes for a kernel.

Server systems will by identified by the PM preferred profile and still be
set as disabled by default for now.

changes from v1:
 * fix the 0-DAY CI Kernel build error for acpi_pm_profile_server()
   function, add CONFIG_ACPI check.

Mario Limonciello (4):
  ACPI: CPPC: Add a symbol to check if the preferred profile is a server
  cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
  cpufreq: amd-pstate: Add a kernel config option to set default mode
  cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol

 drivers/acpi/cppc_acpi.c       | 34 +++++++++++++++
 drivers/cpufreq/Kconfig.x86    | 17 ++++++++
 drivers/cpufreq/amd-pstate.c   | 80 ++++++++++++++++++++++------------
 drivers/cpufreq/intel_pstate.c | 19 ++------
 include/acpi/actbl.h           |  3 +-
 include/acpi/processor.h       | 10 +++++
 include/linux/amd-pstate.h     |  4 +-
 7 files changed, 123 insertions(+), 44 deletions(-)

-- 
2.34.1

