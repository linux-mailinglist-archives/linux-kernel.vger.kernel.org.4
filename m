Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE565F89E9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJIHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJIHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45CBC18;
        Sun,  9 Oct 2022 00:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWGdRIpaUhoZlNZ3u2IIYJurYIurv3XdV9+Jf8/q3D/3TEzPYTFdj9D+G/uCdisNCbLDqQ/X1zFsyFxc+ATptxrn5viN/uhKIHQgxlAriCuGRFTpDBi2V9++7O6zwx9lRhLolrYxPxrH0gX28n+5t31iWD5Dm6Tr1TK4CJ/uQEoc4JKCYkrXVocXqwEsDamad6/9T/Dc9VpaQSFUJeX6VYsFDU13PhiO3aI2wEWX3+ECAgo277TGptUDu8zm3IkNGon7rYOH7bphJFXR1H28tX185inWAEeaanZTKc82ysVyTzBrLeNWhSzn6w2l/Fc6icR70TFCZQixyeIH4nOXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03C9op1n5fZ/qooFNpjk00Vq5l6wlYlZhZ7syfuLNsY=;
 b=VJD9lZfxfnNvjj16Fd7JirN0HurtD0Y54XrPyc32QZbJk/Is64JlC/wLoAaMmIDa3pK9RVgHkl+Zv8CBeEDl/uxm2ess4k7P6n/xUK3x5Kp4ZDewGe0PgLMcFgmYb51t2PtrGuQNiZ+BozyqL2Y2LMzu2ih/FzSo3tcDj4PLxgJRuX9IM4l9Tvy2DibMk03QyJ1gkYWNZ1lgW6YddxNpFc7oDgvfnxyfcswN6rQvXWBxmBpBSBMKdHfEgzxkIPY7jFv7drky2cnGhPlAHUJPfmtR6/iSJzziWpjsc3a7C5KOfOZU9EOn9SnJvvTD1S4XpkIapepr9OcVpNdglrc7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03C9op1n5fZ/qooFNpjk00Vq5l6wlYlZhZ7syfuLNsY=;
 b=dSjxGAdVrme5FVdpM5vVaFlm/fn8avEhBX+fVUy2XiBA1WeqO7jNp9gEMGHwCTBUEm7VHJxpGkdaFKt2ba4MNLcpIi55kWeJMZ9X1RzVyGq6xto0d3eiDnF6FncDovULw9ojVtqHi52yocFyWIwOMXuAXHD29Ts2TKc3YwQxVzs=
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:04 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 0/9] Implement AMD Pstate EPP Driver
Date:   Sun, 9 Oct 2022 15:10:24 +0800
Message-ID: <20221009071033.21170-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: b68852cd-d4b0-4d78-7bbc-08daa9c579ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/TOSNMkZnCKGchjFWimwiuFYdyFd0HxFKzqfzXTmdNRmPa2Ps1daPRFWV2AV40CZJ4ay2PQ3v2Pm5/jWsCmzcINdqlT+6k4mnDL13FT1cpsRGJI0m8WaiHi+G/XYARVjOfylcqCQODVW16jvEVcfR5EHA2KQ7DqJK6b4TzN9LDSNVkiXx9rF1ftLNf4b/lD86OETLyk7egUWwgIq8j+AkIAXxJ/Z8vfxxGwThexiOnbMIwxJGOyqI8f5unhF72r6C4uCuYnecQA30NWlxkeTsy/Ppu8C5+8AyupPa5o+txxoZROWQfayYUxX4VixHBWoUwnjQK43yBBg7A1xQoP26uDtEArgoj9ulROOhM7Shd/Z6LhGxZEWLs0K249BxjvVg8WORzQKzFeOYqlHsMt9tdhpLC9IlE7AIrKvceuryCwtnIA1ObviW92AzHdKUpTOEJYqScmYUVLUNR2eyZ5n7kmKq4p10Qfy6KVzhF4wEx+Qo/daLsSGfCKUpBHPmDzmboypoIJyQ0+CzTT03CwA/PgD3+EpZYXtSoaqW1+qTT8caRsd9PHpm7VlHvCmllXLHXyRA6vsuLP3RPd12GHWAYqdFz5wZNJzuy/ovodCl9px1D53LQy22uU10oyX2MOpg10GZa9n2pnZJ/ObD+FUzyxod7f4FnnBvH+SoVv0Mfjr4MsKlA/jKCu1s1Vx48YbPxcG7aJQEbTogECjKIu64TXy8D4KdhpnahPk5jRC0cy9j5GtQHSPOBfvif35AK504mgPkgYvq+Fe7hHA8znGlSsmZyKeYHP+sOzbGMyuQ11Wm3yCDZ0FaDFmqV0s0wfxOpjF+zDvikEBtT5WrzE4Qlj42UGx7sOdUjeqVfKqBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(6666004)(110136005)(45080400002)(966005)(86362001)(82310400005)(8936002)(36756003)(5660300002)(41300700001)(316002)(4326008)(70586007)(70206006)(8676002)(36860700001)(186003)(82740400003)(26005)(40480700001)(40460700003)(356005)(81166007)(336012)(426003)(478600001)(2616005)(7696005)(47076005)(16526019)(83380400001)(1076003)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:24.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68852cd-d4b0-4d78-7bbc-08daa9c579ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset implements one new AMD CPU frequency driver
"amd-pstate-epp” instance for better performance and power control.
CPPC has a parameter called energy preference performance (EPP).
The EPP is used in the CCLK DPM controller to drive the frequency that a core
is going to operate during short periods of activity.
EPP values will be utilized for different OS profiles (balanced, performance, power savings).

AMD Energy Performance Preference (EPP) provides a hint to the hardware
if software wants to bias toward performance (0x0) or energy efficiency (0xff)
The lowlevel power firmware will calculate the runtime frequency according to the EPP preference 
value. So the EPP hint will impact the CPU cores frequency responsiveness.

We use the RAPL interface with "perf" tool to get the energy data of the package power.
Performance Per Watt (PPW) Calculation:

The PPW calculation is referred by below paper:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0

Below formula is referred from below spec to measure the PPW:

(F / t) / P = F * t / (t * E) = F / E,

"F" is the number of frames per second.
"P" is power measured in watts.
"E" is energy measured in joules.

Gitsouce Benchmark Data on ROME Server CPU
+------------------------------+------------------------------+------------+------------------+
| Kernel Module                | PPW (1 / s * J)              | Energy(J)  | Improvement (%)  |
+==============================+==============================+============+==================+
| acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
+------------------------------+------------------------------+------------+------------------+
| acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
+------------------------------+------------------------------+------------+------------------+
| acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
+------------------------------+------------------------------+------------+------------------+
| amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
+------------------------------+------------------------------+------------+------------------+
| amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
+------------------------------+------------------------------+------------+------------------+
| amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
+------------------------------+------------------------------+------------+------------------+
| EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
+------------------------------+------------------------------+------------+------------------+
| EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
+------------------------------+------------------------------+------------+------------------+
| EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
+------------------------------+------------------------------+------------+------------------+

Tbench Benchmark Data one ROME Server CPU
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)  | Improvement (%)|
+=============================================+===================+==============+=============+==================+
| acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
+---------------------------------------------+-------------------+--------------+-------------+------------------+

changes from v1:
 * rebased to v6.0
 * drive feedbacks from Mario for the suspend/resume patch
 * drive feedbacks from Nathan for the EPP support on msr type
 * fix some typos and code style indent problems
 * update commit comments for patch 4/7
 * change the `epp_enabled` module param name to `epp`
 * set the default epp mode to be false
 * try to move energy_perf_strings[] and epp_values[] into `msr-index.h`,
   but this change will cause compiler errors "no such instruction...",
 * add testing for the x86_energy_perf_policy utility patchset(will
   send that utility patchset with another thread)

Perry Yuan (9):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  cpufreq: amd_pstate: add module parameter to load amd pstate EPP
    driver
  cpufreq: cpufreq: export cpufreq cpu release and acquire
  x86/msr: Add the MSR definition for AMD CPPC boost state
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type
    processor
  cpufreq: amd_pstate: add AMD Pstate EPP support for the MSR based
    processors
  cpufreq: amd_pstate: implement amd pstate cpu online and offline
    callback
  cpufreq: amd-pstate: implement suspend and resume callbacks

 Documentation/admin-guide/pm/amd-pstate.rst |  19 +
 arch/x86/include/asm/msr-index.h            |   7 +
 drivers/acpi/cppc_acpi.c                    | 128 ++-
 drivers/cpufreq/amd-pstate.c                | 950 +++++++++++++++++++-
 drivers/cpufreq/cpufreq.c                   |   2 +
 include/acpi/cppc_acpi.h                    |  17 +
 6 files changed, 1116 insertions(+), 7 deletions(-)

-- 
2.34.1

