Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E488C646E40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLHLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLHLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:15 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284C51327;
        Thu,  8 Dec 2022 03:19:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e52UDvrcnD8917VkP8QDkpnPznSOsSSnXCHCw+72612amDklhgvHPagMh0TZMegBOj4PsP95c7StN6OeMZaR9bSU0Eh4s/nilNRqtFvhJ2+WV++00/+svdiB/D4GBr8cBobqSkRy+U214mCn9sZCu4ZEwyAdwaoDP0VKQbJnNVsH2lCSPsDLkk/I2RDvqLZBhveyBHAQZ2pKkLIOXcgK2mugGZIgG3Vch0EP/LRkWSIdQVJdyi/63JKvSNo/yw4TPZYphKe56G8PUbaEsiMpwQj4+yyd2Jb4Qe7dKCAWGaUiVNPyvST3aAICkEM45CEMJIooZfroJFACtKtKZUSMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc9P+u+NhsZ5Khir+SXeAZ3NuzRGkD3JMXF+EH2xJrI=;
 b=Vt82XlQQ6QjB1qq6ZwlC73opT3RO5n8MFo1e448gikQQPxeaJhEtUT5ep1lD6ko6UhDeBU9icIUU8aUUfda3xa0Jw/MDEd5RgFKHrUZcsbmSOeQRA/+txXzUgNvMCdyoFKAqTbDdDlqMGqGmXoYZNVJhPjans7OpVCZ1D1Up9rHDJxqWgAuiP5Xypy9/20oO13Tkm9ZFuzez7tckOhOHhTs9IpbLm007Mz1FCJMalZUSbP7CWgh7bJWzBLJWzxwOfeQRg3Ppz949pbgG/HaLu1roCTpqxyA1RqtQrHcFpj6Cw4Ls65q4xFhqBkVsfKesgVCB+Y3JhF/ZgCJv/0z/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc9P+u+NhsZ5Khir+SXeAZ3NuzRGkD3JMXF+EH2xJrI=;
 b=Y2CU23aB2e3mzUDanoMPxX974QNA6V+o+/H4oRF/O9MsQdWWxraKlxch8lUQKM/4l3mjjYHc/t4tdJBNvrMIb5CTGC3x80o9wMZ6cCXgBRq5lo4dXn6QJ3Ps3zhw0tiG+2IHp34EsaontfsidWxVOseFLlyG15UodA3qlknk0jc=
Received: from DM5PR08CA0042.namprd08.prod.outlook.com (2603:10b6:4:60::31) by
 CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 11:19:11 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::bc) by DM5PR08CA0042.outlook.office365.com
 (2603:10b6:4:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:19:11 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:07 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 00/13] Implement AMD Pstate EPP Driver
Date:   Thu, 8 Dec 2022 19:18:39 +0800
Message-ID: <20221208111852.386731-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 90012a1a-4fa1-430f-17ff-08dad90e0804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaHFbcXkHCTWeNblg1EZ+CUierFunhrZNzpMmj2JBFppj9NoivvIwSkFlYQ08o1cI2R3hCMkCqpbiT/aU8vgMUsXL1mAAsEyTMj/E5GFXatncz3ZIN/ueg2e1tyAu/6ePKOwus5OxBIHkbxOdZ2SFXf3bU2/DMJ4w8CSsp8jo0gSiyNZGS9yml0pxySLrdJDnIQ6apOacjQSIxnkLLVtrJ7UKOexqCzrYt/T+o4kP1tr3hE7hfPFjte0btffPt3bCimgtLOf9M23tFoUI/FcHwaY8yCUD1C4MWeyi1/aWGIITjGrX7Mo4Gp3/NurEv6NcKyn5lEZ2XsSmu0rPHqbwe5yMqq2H4Q+rpEG/J0mPWF8+bQNjFmHm4ddrsyjHtC31IqHagLrvI42OeRhw35Dh2iX+TVCZVnnqZ1YQZIpuB2coIWOK7krlmF61EPo+SlK8JmqHdU9O4joXf/ty+cHXyy1ZJ+st3gNq+MGiVV5BHewoEeSnyuoJUUqAnUSN/ox+vlKkZknsXZfOi/7gqp+AmDVk76o9viq9nfXx9Eg69pulo1J2rfuL0tZPvdEMD1PARHqUila5DK2bQOyzS8jrNlH3Cu6XQmMROpzEp1aP4KMr9afOUeVzYDzqer27JrtV2RM2HMa/hDmVfw35m3sGspFNQm5HHVQuxr8/AIWkzZuanoTwLimsokGUBilDvADfFM3T4R1jDor5fpitWr9YNTxAUh3BGsbFH5tbOih0K/xORoZ6TwL8mkNy1zCNriLcrqSyYdnLg/N8gyaTH5oOS5aNSOL9zyiO2rr4i/sHuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(83380400001)(40460700003)(70586007)(40480700001)(70206006)(16526019)(36756003)(186003)(41300700001)(336012)(1076003)(86362001)(45080400002)(356005)(110136005)(82740400003)(44832011)(81166007)(26005)(82310400005)(316002)(2616005)(6666004)(8936002)(8676002)(4326008)(47076005)(30864003)(5660300002)(426003)(54906003)(478600001)(966005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:11.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90012a1a-4fa1-430f-17ff-08dad90e0804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
`amd-pstate-epp` instance for better performance and power control.
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

changes from v6:
 * fix one legacy kernel hang issue when amd-pstate driver unregistering
 * add new documentation to introduce new global sysfs attributes
 * use sysfs_emit_at() to print epp profiles array
 * update commit info for patch v6 patch 1/11 as Mario sugguested.
 * trying to add the EPP profiles into cpufreq.h, but it will cause lots
   of build failues,continue to keep cpufreq_common.h used in v7
 * update commit info using amd-pstate as prefix same as before.
 * remove CONFIG_ACPI for the header as Ray suggested.
 * move amd_pstate_kobj to where it is used in patch "add frequency dynamic boost sysfs control"
 * drive feedback removing X86_FEATURE_CPPC check for the epp init from Huang Ray 
 * drive feedback from Mario
 
change from v5:
 * add one common header `cpufreq_commoncpufreq_common` to extract EPP profiles 
   definition for amd and intel pstate driver.
 * remove the epp_off value to avoid confusion.
 * convert some other sysfs sprintf() function with sysfs_emit() and add onew new patch
 * add acpi pm server priofile detection to enable dynamic boost control
 * fix some code format with checkpatch script
 * move the EPP profile declaration into common header file `cpufreq_common.h`
 * fix commit typos

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

v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/

Perry Yuan (13):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: intel_pstate: use common macro definition for Energy
    Preference Performance(EPP)
  cpufreq: amd-pstate: fix kernel hang issue while amd-pstate
    unregistering
  cpufreq: amd-pstate: implement Pstate EPP support for the AMD
    processors
  cpufreq: amd-pstate: implement amd pstate cpu online and offline
    callback
  cpufreq: amd-pstate: implement suspend and resume callbacks
  cpufreq: amd-pstate: add frequency dynamic boost sysfs control
  cpufreq: amd-pstate: add driver working mode status sysfs entry
  Documentation: amd-pstate: add amd pstate driver mode introduction
  Documentation: introduce amd pstate active mode kernel command line
    options
  cpufreq: amd-pstate: convert sprintf with sysfs_emit()
  Documentation: amd-pstate: introduce new global sysfs attributes

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  83 +-
 arch/x86/include/asm/msr-index.h              |   4 -
 drivers/acpi/cppc_acpi.c                      | 114 ++-
 drivers/cpufreq/amd-pstate.c                  | 933 +++++++++++++++++-
 drivers/cpufreq/intel_pstate.c                |  37 +-
 include/acpi/cppc_acpi.h                      |  12 +
 include/linux/amd-pstate.h                    |  36 +
 include/linux/cpufreq_common.h                |  53 +
 9 files changed, 1222 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/cpufreq_common.h

-- 
2.34.1

