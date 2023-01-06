Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1565FB3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjAFGOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjAFGOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:14:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4BE6A0D0;
        Thu,  5 Jan 2023 22:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6sbQ1dmO3uj1iXiVWHqKSEIjrKnZegSZ1gXa9OrmqPEYH7XAoCmUtcltLDFi/noARXwPFOGSmkKoenFstuK2lkGdNAIXRxOyIIUdFoPAFe4b/+iSXclRkgAZ9PiIRJxwMZui2Dh0bMGQf+WNEh+6eZr+Bdg+yq7M8oK3X5KWH3PNcMvaZw80IOIDIhFHZXF8YMnNfswEtvtoS9Ds4ZZq7JFy2/5Z8tY6XUMxihiT+ZzpiR57GYpOhIy0TPuXo3mhw8v+kHctNTjGXBUpjj1O2c8v4faWf78xeVv8+vFusm+udEOnOQRnA6JhPqszhg1pmkSZ5/Au6ALPGVFYzXq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMwilA2aL4cZmJbavKAjL8gJsq5LAUgNNNceBTcRhhY=;
 b=B0h0hut5VRvKeBOf46IoU1pmFkUOI4633fHjyQ42LO7PXllugTMl/Gem66vkY8Cf12/DxFMftH9lkhRTy2DCjHfdtD07j/oaAfCEzZYrQM+GgO+ivFffgqn0VauqSrKl+jzWbaQLOnG4P/cxFsjNyChD40KSWoY3sh56Ghe2/or6C0GOIiEAEzZp48llBx1uVhJ2PZEYgDZ2Xwlwa77Lxs5m5HTS+Er0yzeaDwbxgfn23vilQWnsvJ6kza1iORzGuf2AArVZGj8U44dpMbiDXcmNIh29hExwdHEiEZG3TI8x6cQochdV5yBtxAN4mSfXx3GK93PdJ6bQuzVxo8AdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMwilA2aL4cZmJbavKAjL8gJsq5LAUgNNNceBTcRhhY=;
 b=uhliRR23LeFe29GTsGJTF1CCMReql8py8A76XI0PkY33h0ZqiqC63RH+S36aCVPChj/MdiS31tbvfu4mPSyjUbaMlHSk2hWDTUAiPDVgD2eMu8hxuLW9HONHePXnjzsBwmBduB/X+J+shqziUImOI9Y63UK6t05UWDrP+Ee/DIc=
Received: from DM6PR05CA0055.namprd05.prod.outlook.com (2603:10b6:5:335::24)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:14:33 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::ac) by DM6PR05CA0055.outlook.office365.com
 (2603:10b6:5:335::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:32 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:28 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 00/12] Implement AMD Pstate EPP Driver
Date:   Fri, 6 Jan 2023 14:14:08 +0800
Message-ID: <20230106061420.95715-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1292609e-7e4b-40cf-8c3e-08daefad46d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGuWgN6Cmxm/Ubp12FxelQ/35+jpTDW26r8Jf8sGPOGBE4qoMXOkWVyL4NKFPZnNqXaZoKU00l8MipNe5t7PQ2W6SFVLqEqHMpL8DMjcYosU+NbFn6retF0T6URWi60obVrGm0smJCM2DqE8NZZB0lND+xmvCjQkVBA6V0a5UVOqAtuux45d3c4/ILRdCxgowxaL6sGj+zfyHUO5r6RQsb0vJii8kYULfqtOAzyIgZaCzjis5L6NeRDlMZUq7vgnVZANBxEryEUkauCK4H1QKY3RlTeTsMTXGJ7zAbjY9nmZQNwbwZ09KjwUOfhoESsJysMO8RV+clXZiTncN+RWHFBhQTigRJ5uDjIAK3gaMu78Yg5qSzIwxi/ySlD0actMbu81y11YYU6TStq9OBKQsb+yLSm45NyTn6o0ZBRH9D/+lCrXuyZip63ryvszYy49wYR63mcyH8L56hH09bsCRBk8QPcQ/BLFvvFUpEpLvWaw1B2a7tMazzHQBbxfPvjg35u1urNXeRQuwGH5LnfFKW5F9J6dbXCeP2frkxiRgtFVswj/ABX8sqGTnuDhsK0wGVZ7cHIa3J3bP01nX0Dcbrd+E1y24WUUpcnLxix7tZ38NtuIJ0PTRXEihqnQC1ePUsJREaEN1t1v76m/G8wnAe3arZq6SRPZDNSmugl1DteK2NDd6oj5lpzrdFZjRPoUSQz3R/Q/g7t5cxBzdaPbznlACnCch/ua8M2P98zU3dWF5nK5exQdg5Pt4hiqYPpPeTMul7emJmczoO5m6NC0PD6Qj7bUupuEGGIEp+pLx6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(426003)(1076003)(47076005)(336012)(26005)(2616005)(16526019)(356005)(186003)(81166007)(82740400003)(63350400001)(83380400001)(63370400001)(82310400005)(36756003)(36860700001)(86362001)(44832011)(30864003)(40480700001)(316002)(8936002)(4326008)(5660300002)(8676002)(70206006)(40460700003)(70586007)(6666004)(41300700001)(7696005)(966005)(478600001)(110136005)(54906003)(45080400002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:32.2215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1292609e-7e4b-40cf-8c3e-08daefad46d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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

changes from v9:
 * pick up R-B flas added by Mario
 * pick up R-B flag added by Wyes
 * rename "default_pstate_driver" to "current_pstate_driver"
 * update status string to "disable" when driver disabled and update size check
 * move the common macro definition of EPP to cppc library files for intel_pstate and amd_pstate common using
 * fix some doc words for new global sysfs patch

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

v9: https://lore.kernel.org/lkml/20221225163442.2205660-1-perry.yuan@amd.com/
v8: https://lore.kernel.org/lkml/20221219064042.661122-1-perry.yuan@amd.com/
v7: https://lore.kernel.org/lkml/20221208111852.386731-1-perry.yuan@amd.com/
v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/

Perry Yuan (11):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: intel_pstate: use common macro definition for Energy
    Preference Performance(EPP)
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
 drivers/acpi/cppc_acpi.c                      |  96 +++
 drivers/cpufreq/amd-pstate.c                  | 659 +++++++++++++++++-
 drivers/cpufreq/intel_pstate.c                |  36 -
 include/acpi/cppc_acpi.h                      |  22 +
 include/linux/amd-pstate.h                    |  28 +
 7 files changed, 865 insertions(+), 57 deletions(-)

-- 
2.34.1

