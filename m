Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A363AE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiK1RHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiK1RG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:06:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F2F0E;
        Mon, 28 Nov 2022 09:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf1G2tDrQXFCaKMMG0D+jEuj8A1cZ2NdBCgql19Wq57VNecwD7Ajub0ld9c5Tz3L1KkGCPwFUfNUBrgk3h7qGqswrBdtJyuXosxS1wYYmo0Cc6x4zJmLfA/iY0zqeuJxBgx7/QNg8vz7aqo12izQZMVfHzzJzOWH3w5hLPwOEKQn+ahuQmtbAnWSYbI0Lv8kMmAmATN2CButXG7Ipp9KpDkwf3CwsPIVeRKE/YH3eOxAg5Z2lba5z3SWx9DIkiC0SM3bmXjNr+Wkx94050Dqgp1q4GvDsDF0dUyIXUjDuzzKiFsT7CnfZNF26dHI4GOrN0FKB1/2/9dsnQPJ3dSqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfzNYIt80LXyCW/HjeT+ZD7eXUZiF8bJvyNhxe6Ad50=;
 b=ZWWT7NpV4EnaaeW7yg3D6pf2g2srQJ9Mwchmn0Z67OO//eqZkFPoLYTglKL/dnUpcO0IlvI63NiQ6fUnV5Rd1Kx5lVvDDZR6xfcvWBy5NGdDFR061mg4WZJ+vo9VjbXmO9BwgCWM7bc1T4Clzapst6A25JrKtDMSgbTwsX0gUbinwmXHOU6exmAQZmPE/tkFyal3ktNtjAiWGVEMfRBi69twGffRS+AYSJM1Gv51p2sAYFXmNGnLZQldnxEGqm20/S5tHmED41XBFndT184cgJ5CXNa+mWHFkV9G8Tmpkg/f4//N390vfiGpRpS3XLv/seo1Q9GkpXCiuPKmcF2kCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfzNYIt80LXyCW/HjeT+ZD7eXUZiF8bJvyNhxe6Ad50=;
 b=skdMdkVtD6ZZpV0uZt5a/gApazIHIcmCvQjE6ZgjF4t+uHi+uJltW6l87JashfOUoegi59fkqhkicosOwyueKPelCxgiWXFEbtdW4MlDitr/3Adori4gEphakVvL7xNLKw4IJ2IVAhyFJDrI7/5w6SzdWejeHKnHaGW/azzHMqM=
Received: from BN0PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:143::17)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 17:06:50 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::dd) by BN0PR10CA0013.outlook.office365.com
 (2603:10b6:408:143::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Mon, 28 Nov 2022 17:06:50 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:06:44 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/9] Implement AMD Pstate EPP Driver
Date:   Tue, 29 Nov 2022 01:03:05 +0800
Message-ID: <20221128170314.2276636-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dfefd3-fa62-475e-06ab-08dad162f0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdHA20W01waF4oWrU4L3Oj47/F9q7FT0BLSZ05jbujnMb6WlqojAM7ojnl10Vy4dg1e4QM1DfmrJTvrxEhfEGX1fJTjfm6S9w75xWuFL8/SjBe5G/Ym24CzvtZLB+ShYF6fNBjVafEr0Go1/0FIFm/gAmm6YUib/F15lt8pv5stTcKqWDZjuOTXRfQ9LTvAmCC3Oau9lEpHslKzIHFn9/G55OVoI9O5NGaw5XQdQ8L4xXTBepAdU37tlRdPltLPZgs3T9JEhSZwsb4vHE03Uvx3h6ETb4ortc1/9gUydy7jouwtngFaRZSGOCemYr0NhmUlYyPMuPcmyJzL6Sc7JNtluXLzOp4PIfjEnS7FzmS2hcAoVc+EFT5qTbTCoJd9qi+BwOb4p8MznlDW88wtQdu44MmWWmZiDP0n350F4OHcmIx5WWXa9E+W3UdnqlxQnVLL/A0NFDKAoaVW43eJDix8iiM0jd4Bfz9IY5CqhswntyS9fVhf4J3itAEYX5mCXFxR3BRPTS+Wk5sJSn7syLvY0RBM9jPCM+1ox+MfMtDUn29/88bXBxxuAuAN9LG3a73MV+1LWfLY41kWZXi5LmY4xDsbLGrADngAGLzhXleRuiDLIu0Vcn1UGEdCzOouS/bxByU818tmaK1qseIuBQIvPIlQ2fsGO4z6DY7OeXPe4Pald9P2i3bbyNFQWqcoQwRRpGr0GVVZ6t3cYZ8cnH6g3wtiEIpdm7sgnV6GoH0wzB/dobAGkcFe+8Y714XdEiHF2ALftLMYIyJ8hgE8/MmdFIWNtKAepHjVhfVfDD/cm/dAsGu5Q3icE8bl7Oh+A
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(426003)(8936002)(186003)(45080400002)(81166007)(336012)(16526019)(356005)(6666004)(2616005)(36756003)(44832011)(316002)(40460700003)(26005)(70586007)(40480700001)(70206006)(4326008)(8676002)(82740400003)(47076005)(1076003)(7696005)(54906003)(41300700001)(86362001)(5660300002)(110136005)(83380400001)(2906002)(478600001)(36860700001)(966005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:06:50.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dfefd3-fa62-475e-06ab-08dad162f0cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
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

changes from v4:
 * rebase driver based on the v6.1-rc7
 * remove the builtin changes patch because pstate driver has been
   changed to builtin type by another thread patch
 * update Documentation: amd-pstate: add amd pstate driver mode introduction 
 * replace sprintf with sysfs_emit() instead.
 * fix typo for cppc_set_epp_perf() in cppc_acpi.h header

changes from v3:
 * add one more document update patch for the active and passive mode
   introducion.
 * drive most of the feedbacks from Mario
 * drive feedback from Rafael for the cppc_acpi driver.
 * remove the epp raw data set/get function
 * set the amd-pstate drive by passing kernel parameter
 * set amd-pstate driver disabled by default if no kernel parameter
   input from booting
 * get cppc_set_auto_epp and cppc_set_epp_perf combined
 * pick up reviewed by flag from Mario

changes from v2:
 * change pstate driver as builtin type from module
 * drop patch "export cpufreq cpu release and acquire"
 * squash patch of shared mem into single patch of epp implementation
 * add one new patch to support frequency boost control
 * add patch to expose driver working status checking
 * rebase driver into v6.1-rc4 kernel release
 * move some declaration to amd-pstate.h
 * drive feedback from Mario for the online/offline patch
 * drive feedback from Mario for the suspend/resume patch
 * drive feedback from Ray for the cppc_acpi and some other patches
 * drive feedback from Nathan for the epp patch

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

v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/

Perry Yuan (9):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: amd_pstate: implement Pstate EPP support for the AMD
    processors
  cpufreq: amd_pstate: implement amd pstate cpu online and offline
    callback
  cpufreq: amd-pstate: implement suspend and resume callbacks
  cpufreq: amd-pstate: add frequency dynamic boost sysfs control
  cpufreq: amd_pstate: add driver working mode status sysfs entry
  Documentation: amd-pstate: add amd pstate driver mode introduction
  Documentation: introduce amd pstate active mode kernel command line
    options

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  45 +-
 drivers/acpi/cppc_acpi.c                      | 114 ++-
 drivers/cpufreq/amd-pstate.c                  | 872 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  12 +
 include/linux/amd-pstate.h                    |  82 ++
 6 files changed, 1118 insertions(+), 14 deletions(-)

-- 
2.34.1

