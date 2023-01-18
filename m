Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B4671640
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjARI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF54858C;
        Tue, 17 Jan 2023 23:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8NL/eP5w2CyS04pzABsYZW4D2zV/Zc8SGZsuoGuT2fe7datSxfqZkUlo2dGE6htRF+uN4Ey6hmuVDYh5sxskeYkQzckfElS/b3cuYSWqsG6vexacwIMhlQmlObxB8QzGuSm9+FagxTBbK+QH3gIbYDteuK5HKU0W54lUgFKfUL97Fi8QRdQ32D/CFbBE0Y6Z4anrEX2YgcNoHz7VWcbiY8Q6IrJdd84J9VLOCHI3atL+ToHBBNaw89wRNl1R/7kar/tVi62V0IC+ZvSNC5XG398b7VRYvhzPpNoQVYewVJxcNeyRilbEZf6rWDvyzKB034QHbaawdJXlQJvL9DmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwAEPPpxDKljrXMaK+fXFmEHHWhIO0o27EI+PtRhRzc=;
 b=SCKcTJSwS5Ecs2fpaBKxfW3XwFqPPrpi62wsyFAHYFhNRRCc/LooFy4Z2dNtWkQK5mwE7SSR3pOxS8OI2v4jtlh6ljWuzC3LNJDrLCWBm41QSZ7/G117efb9ObVY6SK0ca0p+29zclGHphs+VTAiBBjvkNvVrcyUTp4FUqFSY/1hkWQXd2kQRVWPenj/OHbMI2xfpfbvGJcbJq+0BdM7XLWa6LZI0pt3d5LDNG3WzqgCEQ1ZEnlVuUzsX0qgKsdSCgLqxz8fet8uKh1shZ0ouNYKG6lfqiETzvJG4XCGTMUFlGReF4x16aeN5EFIYIF70FHfe7CfbMAlIZc12uh7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwAEPPpxDKljrXMaK+fXFmEHHWhIO0o27EI+PtRhRzc=;
 b=OBvbqp0PAoHQZzJSz1Rbp+iSLkyB4OotjI1coFZDmnk9mkkSE3asxQyArRNzcJ5033V461QMISDKj/n8WzkSxkBddpzqR4XOL/auhO7U0IRoN1sKDqJmyGyXVx4FSeGXbQfKYrUdvll+kxnu1er6OJMMsPbpIXd3/22KBGTt/+o=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:52:47 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::2a) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.22 via Frontend
 Transport; Wed, 18 Jan 2023 07:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:52:46 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:52:42 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 00/11] Implement AMD Pstate EPP Driver
Date:   Wed, 18 Jan 2023 15:51:59 +0800
Message-ID: <20230118075210.447418-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: a21d0dbe-9463-4e58-7041-08daf928fd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/bPBlmYXycbZ1cmHa/bHKo3acnraGLGAexpxxBvjtPWmIh00WvArjitI1gIJyXDewwjWSnTZLUB62i95farwi2tN5fdDQzpp+1O2XcVMFs3+Rqsz9gDnT5icJKFULMUaFdAngqULwzr7nDb08rG2czsqsvT32LRc5CtIifjOFE36/Qj4gMoP8XwksS14NiAlYM0TbcGVKnWqhwZHQlhkvtLLufqniGgdwKZSCZpt0hhlJXy8LXh+uEaCLQaOwX/29crm+bmCo8z+B2htlGaNqHAPF6Yhx/9HwqtTKUCc3xO8HMtODYHmf6SgQ/vEbZQGWF54rmBG49SgmFw3rd1UbT3A36agbiGd3BjYIjM9XsdG8M6xubTiiBS4CmpXux5BCtFYY/Z3TiS+U8EqDWCa4UtQ9AGZcocny/vn0lqd2hoAfpKCVL5Ki6sbXyYoyaiURY5aKTgDGDBeM8+MzNBdXoLHJ5SAmc1FUz+J+Zn9lQCplBFM9Cd9DIl1AbGTN/ceky/0c0qrSvYwwU2jyhU+D1zZbVsC42GDzuGaEsspyOeKGvO+YUyBjdMwbm8HuiLOuYIe/3m5ljp2ZpLap4m5BhAMZfwSa20IkT7jpuyihvVP0YSOluXseLqNuRYNljW4Z/riH5ACL1SsY0nGNCYvzELkUPr4MlSDLuBElEZVqLuOBkNgNUp17g2S4YcSYMIA4bATy7U7SJq8wOX7/0XreMj0jGKE2LR4XsSa4D5wehJ0aUhZCE5E6uxGpd3wGsM3RonQpAvMoDL8o/CMKvRXDnCH5jTSUlJLXz6L3POqjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(356005)(86362001)(2906002)(44832011)(30864003)(70586007)(70206006)(5660300002)(8936002)(82740400003)(81166007)(36860700001)(316002)(7696005)(54906003)(110136005)(6666004)(47076005)(426003)(45080400002)(966005)(478600001)(36756003)(82310400005)(41300700001)(8676002)(40480700001)(4326008)(16526019)(186003)(1076003)(336012)(83380400001)(26005)(40460700003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:52:46.9838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21d0dbe-9463-4e58-7041-08daf928fd5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

changes from v10:
 * pick up all new ack flas added by Ray
 * pick up Review-By flag added by Wyes
 * pick up Test-By flags added by Wyes
 * move the EPP macro definition to amd_pstate.h and drop the common
   code patch
 * add amd_perf_ctl_reset() in epp init code as well
 * As the warning which reminded by 0day, change amd_pstate_get_epp(cpudata, value)
   to amd_pstate_get_epp(cpudata, 0).

changes from v8:
 * drive all the feedbacks from Mario and change the codes in this
  version
 * drive all the feedbacks from Ray and change the codes in this
  version
 * pick up all the R-B flags from Mario
 * pick up all the R-B flags from Ray
 * drop boost/refresh_freq_limits callback
 * reuse policy->driver_data to store amd_cpudata struct
 * use switch-case in the driver mode switching function
 * add Kconfig dependency the INTEL_PSTATE for AMD_PSTATE build
 * fix some other code format and typos

changes from v7:
 * remove  iowait boost functions code
 * pick up ack by flag from Huang Ray.
 * add one new patch to support multiple working modes in the amd_pstate_param(),aligned with Wyse 
 * drop the patch "[v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost sysfs control"
 * replace the cppc_get_epp_caps() with new cppc_get_epp_perf() wihch is
   more simple to use
 * remove I/O wait boost code from amd_pstate_update_status()
 * replace cppc_active var with enum type AMD_PSTATE_ACTIVE
 * squash amd_pstate_epp_verify_policy() into sigle function
 * remove "amd pstate" string from the pr_err, pr_debug logs info
 * rework patch [v7 03/13], move the common EPP profiles declaration
   into cpufreq.h which will be used by amd-pstate and intel-pstate
 * combine amd psate init functions.
 * remove epp_powersave from amd-pstate.h and dropping the codes.
 * move amd_pstate_params{} from amd-pstate.h into amd-pstate.c
 * drive some other feedbacks from huang ray 

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

v10:https://lore.kernel.org/lkml/20230106061420.95715-1-perry.yuan@amd.com/
v9: https://lore.kernel.org/lkml/20221225163442.2205660-1-perry.yuan@amd.com/
v8: https://lore.kernel.org/lkml/20221219064042.661122-1-perry.yuan@amd.com/
v7: https://lore.kernel.org/lkml/20221208111852.386731-1-perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/

Perry Yuan (10):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: amd-pstate: implement Pstate EPP support for the AMD
    processors
  cpufreq: amd-pstate: implement amd pstate cpu online and offline
    callback
  cpufreq: amd-pstate: implement suspend and resume callbacks
  cpufreq: amd-pstate: add driver working mode switch support
  Documentation: amd-pstate: add amd pstate driver mode introduction
  Documentation: introduce amd pstate active mode kernel command line
    options
  cpufreq: amd-pstate: convert sprintf with sysfs_emit()
  Documentation: amd-pstate: introduce new global sysfs attributes

Wyes Karny (1):
  cpufreq: amd-pstate: optimize driver working mode selection in
    amd_pstate_param()

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  74 +-
 drivers/acpi/cppc_acpi.c                      |  67 ++
 drivers/cpufreq/amd-pstate.c                  | 664 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  12 +
 include/linux/amd-pstate.h                    |  73 ++
 6 files changed, 876 insertions(+), 21 deletions(-)

-- 
2.34.1

