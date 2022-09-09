Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFA5B3D41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIIQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIIQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F7145FCF;
        Fri,  9 Sep 2022 09:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+p27WuBa5u4bOs0P3MkgzOZturoFi0KVotvP76wFaJ7zyg9NEeN5YmCzgyzI7U8byaFGVaNCAvXlSZa3uFrxIg+705DLC9EFuqRf/ALlpWHTgg1EqNzbAxr4BSNGvc7+0txTkCQfSLyxBEkSMMLArTkukS44hJ/lbebXAfUWSgwYjUeurYwOVnSijJR3yNYBfQFnskU5eqtuwiEnVz6b4L5/QKq5xEWcv0DuMyeKWD6opZp8TYImdWHVH3EzHDST05oZyXwIFy6HgvYb0N7guIkms5pDd0Kh3yYBje17RsgHgNYdFsSKPfLDi3E+VEXSsQ/SPD6crSJi3GyQV+fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srl4LQrHGuLTl8zf082AFkUucc9zyGBGcQsE1CrdAmQ=;
 b=D1HrPIWJKkFzcSNH9U0FdEvD1e96arWhFlrJKMvRFj0x9Xcfmk5FcPpZNfaMSu/ezrjT1J0Yd3xxh0pilBFTNK6mY2f/+zdmViJyPlh+L7AeIi9a5r5cuzLsX9MVTpHe6c/JR/3RSXtdVcSFtdGTN3FHyk0OLNDcQwlDMSvu4J5uvz59cQqXlFawmxcZEMoiy+E3xzUokWwtPPZLJiLnBCzqNpZTkgpCAU5I+5h/BzvLUhrdhwAz8OORgZ5dGcHLKOKQXrlX9XWZdjkQkM3ZZnRYqFvMOVmytL3N4FOKpj0RXsaMCpwNeUyqN4+y9O9u4AW5mcc0qzmj028VIIQD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srl4LQrHGuLTl8zf082AFkUucc9zyGBGcQsE1CrdAmQ=;
 b=Ly0W5QnNSSG2ey/DrFQw2+hbtUtov/i0rIcp4P9+9duHcPsk7KZLSWOAZphcO4FE8pnv+DyhJm2nsW1Pqad4IDRwOQsyaAAwhyXO1cdYNVdO9LYSggSgtguZ1ljMv8zEFmK3jlzy4biCSdNzOtNWvfIiB3ZYwoevWh2VrVKDkAE=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 9 Sep
 2022 16:46:57 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::72) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:46:56 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:46:52 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 0/7] Implement AMD Pstate EPP Driver
Date:   Sat, 10 Sep 2022 00:45:27 +0800
Message-ID: <20220909164534.71864-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: d092ec3d-64f0-45f5-4576-08da9282e85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lfm3dpRweE5OFnoa3z6OnguV5vfFHlpbd0kwdh00lp+EiUpX0rWoSNpWZA9e7IFyOn/HkqjsI7THXyoLEk9v0uBhXMGBevhzJilhPiOzAGCwy8fLCZYmZAW/81H2ZHlpuuSYI7xNgJCvEmSzNS0VoqFgo72+Hb5a72DcPB8dVGj/peUo4AaP4QxaQBdQEewdvtp5O7zY0+tTAO+Prsdr9sxGqnymHMiwu8nU8t+L22JUDY2M6bp4sWrAa5f/J2uKARVD6uhRJ4K6sI61XUBqTf4Y6RDoRss+g4g71VQyOtucayGGfw27KIUeok8CnpCapo5jcudivJVGG53SoKBm8gLpQaGi17MWnjZ/qMfNiv+JpQcziyeqwHhiatyKwHOPl5ruEivTTG0Q7piuboeuALW7ArvECqQpcqUd3yCVot9ksDYxUHwQ5TQul6gQno1y4ZsaJCUwldy+sLHAPz21/Qbh/TZfhrAPjTxTuWW1ezLfYosWJvmjazfqoFJfahnUxxo9LxN7f0IS3ai0NTI8Zk5pnu0SHsSl1L4dc1zHsh4oev9eSoypuXm2pUV1NeYxpbvgcvAdDNJsqfO39HJxoliGdFtgySSR70XCuNa6dYLVp7ybFRGqNqrFmCA1oiDihhWM3VfXvn4aFLW8MWFa5Wxkp5iutj+TQfDgR/+DTLhneBs+8jXHIKukMZET/BFMVfOpC7yisFA5W0Fuo4ocKOB2/kT9Wu14rla5FBlGupe0SyVt6IXvq4cqg6e8EjlZVxtYBOOmrz1SehHAFeccFTEu5BGwfEP0+BTQ3emnekvvBw9WJlUemADsJbSfZsDznZxazi+W4fTiteFKSzc4Ip/7VuK+U+pHBrcXSOT/oE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(40470700004)(46966006)(36840700001)(40480700001)(6666004)(86362001)(81166007)(45080400002)(4326008)(186003)(82740400003)(5660300002)(47076005)(478600001)(1076003)(336012)(26005)(83380400001)(426003)(2616005)(41300700001)(16526019)(8936002)(40460700003)(2906002)(356005)(54906003)(7696005)(8676002)(36756003)(70586007)(70206006)(36860700001)(82310400005)(110136005)(966005)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:46:56.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d092ec3d-64f0-45f5-4576-08da9282e85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Energy Performance Preference (EPP) provides a hint to the hardware
if software wants to bias toward performance (0x0) or energy efficiency (0xff)
The lowlevel power firmware will calculate the runtime frequency according to the EPP preference value
So the EPP hint will impact the CPU cores frequency responsiveness.

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
| Kernel Module                | PPW (1 / s * J)      	      | Energy(J)  | Improvement (%)  |
+==============================+==============================+============+==================+
| acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
+------------------------------+------------------------------+------------+------------------+
| acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%	      |
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
| Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)  | Improvement (%)  |
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


Perry Yuan (7):
  ACPI: CPPC: Add AMD pstate energy performance preference cppc control
  cpufreq: amd_pstate: add module parameter to load amd pstate EPP
    driver
  Documentation: amd-pstate: add EPP profiles introduction
  cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type
    processor
  cpufreq: amd_pstate: add AMD Pstate EPP support for the MSR based
    processors
  cpufreq: amd_pstate: implement amd pstate cpu online and offline
    callback
  cpufreq: amd-pstate: implement suspend and resume callbacks

 Documentation/admin-guide/pm/amd-pstate.rst |  19 +
 arch/x86/include/asm/msr-index.h            |   4 +
 drivers/acpi/cppc_acpi.c                    | 128 ++-
 drivers/cpufreq/amd-pstate.c                | 942 +++++++++++++++++++-
 include/acpi/cppc_acpi.h                    |  17 +
 5 files changed, 1103 insertions(+), 7 deletions(-)

-- 
2.34.1

