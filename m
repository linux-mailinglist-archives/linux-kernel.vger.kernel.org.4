Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C455FA1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJJQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJJQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:23:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BD74DCC;
        Mon, 10 Oct 2022 09:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsFDRfI2vwiAxjMZVje1yxnIHwmQepKEX6/Jrk123MMvfUYk0v3dPjiGobT+j+LlGRTfmawvRRs3iv+GsZMMEege8pcgQY6hNaHzSyRAsY1joIvkKIZr20VebaEPnJvNcnbZv+1QmDFyBjTGMrndmFgyl5a2/Raxo1gUtZwtOZHzynaCgCLRlOfnfEGKXBxB/oEfJc5SUV4cyx2pcJUVRDbTyKl6puYLb1YBUFQw67lbKgGH87ArbBWH0HNH6o1cQ+1NTVBITgYDKcLc46tjxrpwLBFpc3JRuyVn25GFA3QnDbWQvyHQNTgmzypiXE95/P4CDsm2tic4pLvJzgLOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGE3Q2g7q0AE02svgvlnNtxZa/WHehXpI3skk6UMRRY=;
 b=kHbFpVJOJPpMf67pVOgsrCV1v5yX2BK32lfCgkaWFJXpMuuCtnktY0A4+PkjlBmgK6Bu1Khn2qCNEfP3ieNziE1f7ywDthJPt6P8fSp03QvaaTcw1H5Nx2xsMVreY0BznLAmrvQwt2afOxwR38uM3F3g8putJzaZw+g9QhjlILbpM70vtHPPpPhCZVWCtmJ2V9vlhMAGwccAphgYK5R7Ap/mPA3bg5+nvihli69rnitkZgfL3/vHI4DQSLKTd3SDCjLZpc5jQLnrsis0QKaVe3SEFy5CHAC41hdBPUguxjVQ0JakcET/M7MGM4ztTjGur3/djOwAmMfIXEQakJLM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGE3Q2g7q0AE02svgvlnNtxZa/WHehXpI3skk6UMRRY=;
 b=KO3Whu0c0LhLdRBKh+RiXWlcfvp67xZIvQM7fN/3ON9Pz74JzAaHJ0n9Kcj9hUwM7khzyZaKOqx4P9Go52owjOuqFxNPwun480yCfv+PMrHXJpRkJPRNUzNq4N7Phq7y2Qwy717hxCKDuIZYmz6qBm399SPYn06vB2rAwAzadeg=
Received: from DM6PR06CA0055.namprd06.prod.outlook.com (2603:10b6:5:54::32) by
 BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 10 Oct
 2022 16:23:13 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::b1) by DM6PR06CA0055.outlook.office365.com
 (2603:10b6:5:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:12 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:05 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 0/9] Implement AMD Pstate EPP Driver
Date:   Tue, 11 Oct 2022 00:22:39 +0800
Message-ID: <20221010162248.348141-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aaf37ee-19cc-40b9-77df-08daaadbba57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktoHTkW3MJWXzenzxVBjyCEXos2jb3QRS7auZeuKm1ewlQ2DKKCnQZILHX0rty9JaiJAyWKhmzPDnikoxyhku9+S1KXuI+4tZllJ9PB9+ByUSC+8Tti01OEqfXLtqaL/b0UjYNR7614BMG62R1u5D6q0Blod1KBmi4u6b+OqQCKnpAM+SFOc3EqWkiAEaWZmUOgq4psYeJPYCPMho1dixJrjp2E5ttofuFFgGbTXzeQv635poI6yzvnMEmOvDMVf/a98iDi6asG9N1sN3ldFkEtRqTaRrhOrboNosK1bN7PJVQNRCaeiJ3jSWvjl6dK7NOWqE5V7quAo7kSQ0zvQSRRREAITY3AoZeN1EaSX8Fxh6vZ0aVaff/sWmGrlaknQ/TTyAwqd1dKq8Vbtz/EWB1+FECug+ruSBky2yKc5YPrspTrq9JeciY8CNx04W2pk36XAYjsusR5bC8NF+ebKY6yN32O8zVt4b/u6r6T1GaMQp5UhPXuGrI8eQ//uZQKZZbyZ2UAVRo3dO2iZ8rNB7DjP9BtKDbluynPCAp+lAzQx1usgi4TG9aac+F1rxI69yzdUbjVAYwxpZVkz4uBM/7zBGX5rFVd/lfj2IX1+Z6NOHFI58ljkbKvoiunZoVTGip3mVqsIa10z3km7K3h1n0qc/Lu+qvgScv0UcRcUOuXrWPqNNxo6aFFNVtEljCUB9laBk90RRrOpzJprNcP77eVMt3mctJUtFTrTIYyOsuWl4g5iFOwkim04I65cEMjDkQ2diFTZYAryuO29a9EXbFuGkbHH+cHt9GiIXdjKs0TMxGRD6z/KOxuKSqW0ByjtOE0eB04CuI1nHu4t7Qm4lzhyxtFdMmLfM1NNC7Hl3eM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(83380400001)(336012)(16526019)(186003)(1076003)(26005)(70206006)(70586007)(82310400005)(2906002)(86362001)(8676002)(4326008)(5660300002)(6666004)(316002)(7696005)(40480700001)(966005)(36860700001)(478600001)(356005)(110136005)(54906003)(47076005)(426003)(82740400003)(45080400002)(8936002)(41300700001)(40460700003)(36756003)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:12.6419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaf37ee-19cc-40b9-77df-08daaadbba57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
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
| Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
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

Tbench Benchmark Data on ROME Server CPU
+---------------------------------------------+-------------------+--------------+-------------+------------------+
| Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
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
 drivers/cpufreq/amd-pstate.c                | 949 +++++++++++++++++++-
 drivers/cpufreq/cpufreq.c                   |   2 +
 include/acpi/cppc_acpi.h                    |  17 +
 6 files changed, 1115 insertions(+), 7 deletions(-)

-- 
2.34.1

