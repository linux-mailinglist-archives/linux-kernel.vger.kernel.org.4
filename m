Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6B645DDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLGPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLGPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:47:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2729CBB;
        Wed,  7 Dec 2022 07:47:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSyYePI5VH+8HvliK4rhcrBv2q0++ASBQ9DUE3Wpj54b2HpYPVjixfOqMdckK+iPcos5hQ4OL8XhYx3Irzoai88l2OY35xGaATBeA88JKN7RcbFSk+jseh1ooPfWehBNbYXxoTPtcOzOpLcbgZh80mswb++wp18gbnO58TMnr9Pkp5FJ6iW56AySFMu46rIaD58yF6cLntzj2684O/f4f7Qa1c2bNn4GYE0iJMfuhjk5z/nC4GiYLyiD+Buay6TYWqbZSVpXaVG1ID2doaLH02S74jxotGty5Xfoelf+djpL4KRsghTEzmNrnCBlppOX7AzX6kN5sZpt+KBjki0I9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0dzoDDsX1HeB+myuCuCgTRVOuxgzJ/PgZCE6Nn2jus=;
 b=NLKK6h6ylptOC+KhYuVRMgQn+Q3A5covUIH6ohEFFPCxHw+nhw97Ox9WCQgA4lUTaERZZ0EFDfalDc3JMQXDTxHJdgCAGjC8iboZCYt4Zio4e4NAP5jfCpYrAwQWKP1Dc+MUQhsuoQJrUgH++Vbz80UaNT4Cu/tenW8Hi/ZCQDaiUegmNGmDUj43WS84FrdLdpR7dJr4lmCUZeTRPgritT0YD8H6KUQYeCVDHCAL8q1u+d01PSJIcP7lT9QQW2HIG+xMiOOshKptVheggQdLq/8i9idGMv2wf44LydIja9SO53rPlnKkdW+JX3ZlpK9logfAnl8qGW2VpAYL4KK6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0dzoDDsX1HeB+myuCuCgTRVOuxgzJ/PgZCE6Nn2jus=;
 b=CzKWBRHbiouYhpDJDPTXo3rAz8OU7ZDua87AnSTMTTMeUnjwIKFOjPZZO2Z0JxUOCSG5/WTePaptFFL49W7rhda7tzyLJA2LghDGfQ+25mTAYrMv/3guim51RkMeeUeSvsFUqZT8enkF2c1QvkMBQtJfR/oZDaj6XrnIC/h/g7c=
Received: from BN1PR14CA0006.namprd14.prod.outlook.com (2603:10b6:408:e3::11)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:47:42 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::70) by BN1PR14CA0006.outlook.office365.com
 (2603:10b6:408:e3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 15:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 15:47:41 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 09:47:37 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 0/4] amd_pstate: Add guided autonomous mode support
Date:   Wed, 7 Dec 2022 15:46:44 +0000
Message-ID: <20221207154648.233759-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7190fa82-ecaf-4c8f-05b3-08dad86a6036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jK3WNfZYKrZtFJjMgMU5XWtIe/doksdB+JKfNvr/wCGeo3AQEr6kukZMSMcU4OVC8va7uVSUas6RLWENsjbJ7yFV/WmSDeh1Mt8ef5sOUWqxsvv2c4OxAjLwn9JP0G6LqJWf96oQ/LyMJnC5rGgN3HKhY/JRXnGVef67Qparz5gxpUAzlgxsaFj3KQixSlZrxqmHjc+U8y17bBy4JZlu9v3/AJR1k8j53stk1gSzj6EpAHI6duO4/mFCsFiqQZik/pVBeZHYbawyt+M33hBv4LU5TO3GmSGClGc29foRbRVIs2uOy9lmZ3oA/LxyOs212QD5U+3nNCs128vyVkywSzWKK1d0kf+OXOi5aXFcOSzWhzWDUxyQNMxducBHxP6M8kT8QrjTZ3vKwp6PGn5ok2fLAxCZJD/PjXfqFiiWjTtVPSOTnq1oIY0QYweg95cWhTziR/SSaUvI+9G4FeMnUsVRHriKPzZmXVMTSznwirLq93+j7IhEaOrjOMPyC8p6423QjMfCE3ezLv0ofivwdaF23fMv24phifhGJOy2Ozr19yRTHUC1HvF1H3EgNF0laCfTUhzc6Fk/xvGYLdsqc/OEY08Kxx6UHkJGzZcn2xWTajk4k12oHvk/KuqNjjAWYpdegfmYqz1+VDFQNZI38uCnltmCYYQFNxBYyHNK/cB4HOFZFp9I0/MXCKE+lVEjCsNPyYNVGtiQP2OPIdsAEOlt8Prxnmot8GCmnbQip7h4V+ju2o6qTdR0uqBzYgOzo/04dqA3Ikiam3nGW7eeGAJbk1o61Ym1jRcJvHo7lXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(81166007)(82740400003)(36756003)(26005)(86362001)(478600001)(966005)(7696005)(5660300002)(6666004)(8936002)(41300700001)(44832011)(70206006)(4326008)(8676002)(110136005)(70586007)(54906003)(316002)(2906002)(356005)(83380400001)(36860700001)(82310400005)(336012)(186003)(16526019)(2616005)(1076003)(426003)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:47:41.8163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7190fa82-ecaf-4c8f-05b3-08dad86a6036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ACPI spec[1] below 3 modes for CPPC can be defined:
1. Non autonomous: OS scaling governor specifies operating frequency/
   performance level through `Desired Performance` register and PMFW
follows that.
2. Guided autonomous: OS scaling governor specifies min and max
   frequencies/ performance levels through `Minimum Performance` and
`Maximum Performance` register, and PMFW can autonomously select an
operating frequency in this range.
3. Fully autonomous: OS only hints (via EPP) to PMFW for the required
   energy performance preference for the workload and PMFW autonomously
scales the frequency.

Currently (1) is supported by amd_pstate as passive mode, and (3) is
implemented by EPP support[2]. This change is to support (2).

In guided autonomous mode the min_perf is based on the input from the
scaling governor. For example, in case of schedutil this value depends
on the current utilization. And max_perf is set to max capacity.

To activate guided auto mode ``amd_pstate=guided`` command line
parameter has to be passed in the kernel.

Below are the results (normalized) of benchmarks with this patch:
System: Genoa 96C 192T
Kernel: v6.1-rc6 + patch
Scaling governor: schedutil

================ tbench  ================
tbench result comparison: (higher the better)
Here results are throughput (MB/s)
Clients 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
    1	   1.00 (0.00 pct)	   1.16 (16.00 pct)	   2.20 (120.00 pct)
    2	   1.97 (0.00 pct)	   2.29 (16.24 pct)	   4.38 (122.33 pct)
    4	   3.95 (0.00 pct)	   4.51 (14.17 pct)	   8.50 (115.18 pct)
    8	   7.83 (0.00 pct)	   8.89 (13.53 pct)	  16.62 (112.26 pct)
   16	  15.28 (0.00 pct)	  16.81 (10.01 pct)	  31.02 (103.01 pct)
   32	  41.64 (0.00 pct)	  30.67 (-26.34 pct)	  55.63 (33.59 pct)
   64	  91.29 (0.00 pct)	  79.67 (-12.72 pct)	  91.74 (0.49 pct)
  128	 118.06 (0.00 pct)	 122.34 (3.62 pct)	 122.04 (3.37 pct)
  256	 260.47 (0.00 pct)	 264.31 (1.47 pct)	 264.49 (1.54 pct)
  512	 254.16 (0.00 pct)	 245.25 (-3.50 pct)	 245.50 (-3.40 pct)
tbench power comparison: (lower the better)
Clients 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
    1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.15 (15.00 pct)
    2	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.17 (18.18 pct)
    4	   1.01 (0.00 pct)	   1.02 (0.99 pct)	   1.24 (22.77 pct)
    8	   1.05 (0.00 pct)	   1.06 (0.95 pct)	   1.36 (29.52 pct)
   16	   1.15 (0.00 pct)	   1.13 (-1.73 pct)	   1.58 (37.39 pct)
   32	   1.71 (0.00 pct)	   1.30 (-23.97 pct)	   1.96 (14.61 pct)
   64	   2.35 (0.00 pct)	   2.15 (-8.51 pct)	   2.36 (0.42 pct)
  128	   2.77 (0.00 pct)	   2.77 (0.00 pct)	   2.78 (0.36 pct)
  256	   3.39 (0.00 pct)	   3.41 (0.58 pct)	   3.43 (1.17 pct)
  512	   3.42 (0.00 pct)	   3.40 (-0.58 pct)	   3.41 (-0.29 pct)

================ dbench  ================
dbench result comparison: (higher the better)
Here results are throughput (MB/s)
Clients 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
    1	   1.00 (0.00 pct)	   0.96 (-4.00 pct)	   1.02 (2.00 pct)
    2	   1.89 (0.00 pct)	   1.90 (0.52 pct)	   1.91 (1.05 pct)
    4	   3.39 (0.00 pct)	   3.31 (-2.35 pct)	   3.38 (-0.29 pct)
    8	   5.56 (0.00 pct)	   5.46 (-1.79 pct)	   5.60 (0.71 pct)
   16	   7.25 (0.00 pct)	   7.90 (8.96 pct)	   8.29 (14.34 pct)
   32	  10.85 (0.00 pct)	  10.00 (-7.83 pct)	  10.40 (-4.14 pct)
   64	  12.30 (0.00 pct)	  11.94 (-2.92 pct)	  11.82 (-3.90 pct)
  128	  12.56 (0.00 pct)	  12.30 (-2.07 pct)	  12.98 (3.34 pct)
  256	   6.55 (0.00 pct)	   6.54 (-0.15 pct)	   7.38 (12.67 pct)
  512	   1.61 (0.00 pct)	   1.58 (-1.86 pct)	   1.95 (21.11 pct)
dbench power comparison: (lower the better)
Clients 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
    1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.05 (5.00 pct)
    2	   1.07 (0.00 pct)	   1.07 (0.00 pct)	   1.09 (1.86 pct)
    4	   1.15 (0.00 pct)	   1.15 (0.00 pct)	   1.16 (0.86 pct)
    8	   1.26 (0.00 pct)	   1.26 (0.00 pct)	   1.27 (0.79 pct)
   16	   1.39 (0.00 pct)	   1.41 (1.43 pct)	   1.43 (2.87 pct)
   32	   1.60 (0.00 pct)	   1.56 (-2.50 pct)	   1.59 (-0.62 pct)
   64	   1.75 (0.00 pct)	   1.75 (0.00 pct)	   1.74 (-0.57 pct)
  128	   1.90 (0.00 pct)	   1.91 (0.52 pct)	   1.93 (1.57 pct)
  256	   1.76 (0.00 pct)	   1.77 (0.56 pct)	   1.85 (5.11 pct)
  512	   1.55 (0.00 pct)	   1.49 (-3.87 pct)	   1.73 (11.61 pct)

================ git-source  ================
git-source result comparison: (higher the better)
Here results are throughput (compilations per 1000 sec)
Threads 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
  192	 1000.00 (0.00 pct)	 943.00 (-5.70 pct)	 1000.00 (0.00 pct)
git-source power comparison: (lower the better)
Threads 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
  192	   1.00 (0.00 pct)	   1.03 (3.00 pct)	   1.02 (2.00 pct)

================ kernbench  ================
kernbench result comparison: (higher the better)
Here results are throughput (compilations per 1000 sec)
Load 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
32	   1.00 (0.00 pct)	   0.94 (-6.00 pct)	   1.02 (2.00 pct)
48	   1.24 (0.00 pct)	   1.16 (-6.45 pct)	   1.24 (0.00 pct)
64	   1.35 (0.00 pct)	   1.30 (-3.70 pct)	   1.39 (2.96 pct)
96	   1.42 (0.00 pct)	   1.28 (-9.85 pct)	   1.48 (4.22 pct)
128	   1.39 (0.00 pct)	   1.29 (-7.19 pct)	   1.41 (1.43 pct)
192	   1.32 (0.00 pct)	   1.18 (-10.60 pct)	   1.32 (0.00 pct)
256	   1.28 (0.00 pct)	   1.14 (-10.93 pct)	   1.29 (0.78 pct)
384	   1.28 (0.00 pct)	   1.13 (-11.71 pct)	   1.27 (-0.78 pct)
git-source power comparison: (lower the better)
Clients 	acpi-cpufreq			amd_pst+passive			amd_pst+guided
   32	   1.00 (0.00 pct)	   1.04 (4.00 pct)	   0.95 (-5.00 pct)
   48	   0.83 (0.00 pct)	   0.90 (8.43 pct)	   0.82 (-1.20 pct)
   64	   0.80 (0.00 pct)	   0.82 (2.50 pct)	   0.75 (-6.25 pct)
   96	   0.77 (0.00 pct)	   0.81 (5.19 pct)	   0.75 (-2.59 pct)
  128	   0.78 (0.00 pct)	   0.82 (5.12 pct)	   0.75 (-3.84 pct)
  192	   0.84 (0.00 pct)	   0.89 (5.95 pct)	   0.83 (-1.19 pct)
  256	   0.84 (0.00 pct)	   0.89 (5.95 pct)	   0.84 (0.00 pct)
  384	   0.84 (0.00 pct)	   0.90 (7.14 pct)	   0.84 (0.00 pct)

[1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
[2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/

Wyes Karny (4):
  cpufreq: amd_pstate: Add guided autonomous mode
  Documentation: amd_pstate: Move amd_pstate param to alphabetical order
  cpufreq: amd_pstate: Expose sysfs interface to control state
  Documentation: amd_pstate: Add amd_pstate state sysfs file

 .../admin-guide/kernel-parameters.txt         |  26 ++-
 Documentation/admin-guide/pm/amd-pstate.rst   |  11 +
 drivers/cpufreq/amd-pstate.c                  | 202 +++++++++++++++++-
 3 files changed, 217 insertions(+), 22 deletions(-)

-- 
2.34.1

