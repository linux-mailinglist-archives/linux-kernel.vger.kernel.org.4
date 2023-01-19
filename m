Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF7673767
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjASLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjASLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:50:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7030F8;
        Thu, 19 Jan 2023 03:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTKwAGPqTpqF3aTIlFFsleh3bjMtrK2FpsfQQOuW2LoJugkXYJbDap++K5hk/cwW9ZAVGAUb5NzzlL2DgNjYZdkpoTnymEKBZwPvPSEtRRGXjGgCA2sRKGckek7be6VMZlVhUPXSPCGNLqH9mUdIO5dqyP+Eh6tEEJ8wlxBVjBc0aIlJ4TOEN5S5VxkwSTlGv9haPvNG5M3m3DBOGyTUWEf2yj6YIXZhaD2K9aADfcezRMatnFkx4jZw6HERLwbqmNWJPB8M5DnFMzxlVzXNtLMbnrGjyN0yEqWHViPpqEyG1JViPDp1RUBel61xugR61OIwxGkpckmAjRvvtwuFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddDot8RwVCcog2R8vhoezMLY7YHPipdMy+E5uSHONBA=;
 b=QpRAqoZyqZM0y8xFf6b5Y/fSpI0ge3pAMAe6Tut1QFiPttm6pJPVDrUNpNrw42gaifZqKgErFRyBs+pnhqkaGqaS3EVF43SwG3OCHm30u6FI/oMh0q0LoBMHcCT8oErC+GAeSv8yCkD9EoFfOTIy3bDyK2b9ZxzoWrCx3lgff/Yt8ROnr1a061HjF0Xo2xUpHJmw5rXF3CjaYQ5Fl+HaNJ1ouRV1eILGP62w8Bgms9wNAg+2y+JL8FOc73E0rTzmQl4uC8Z6natpR6y0ZffF6tOWE0Y3nZl5piSLdGj9wizxjaM6FKeUpYuBkVcBD8HUOY3iLy4xUsKhg6GHQ6CiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddDot8RwVCcog2R8vhoezMLY7YHPipdMy+E5uSHONBA=;
 b=RBU4LOQDjHM8L7AYvjsPmkQH1TwySn9kZdm2rioob6giyyQCCGH8RdWskLAjF4dwZiwc/GONBpUxvX6YO9TlGogcJTLdmblxhjQSSfi+j4YM9oubhGKfC+jwcR6nQw5ezRiJJI13Yf+oRQ2SzkCP1oWcs29OiyX1GAsGT7uJsb4=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 11:50:41 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::32) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.17 via Frontend
 Transport; Thu, 19 Jan 2023 11:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Thu, 19 Jan 2023 11:50:41 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:50:35 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Date:   Thu, 19 Jan 2023 11:50:11 +0000
Message-ID: <20230119115017.10188-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbda4df-b8db-468c-73df-08dafa1363d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxbXDWX38i5P2HWZcPEl5MJn5eM2H2vt6j8leUTJHA1642O4utwtfGlqtE4pRk6tfPPUUEhPK+m6F0htCUViXHB5R/mM9Mn9PeJ6rbkfyP63YnL25Abp/X6LdepS7mFJ446c9vadu3m6KTCWT1F92bA1L5Ws8x8ETLFTVpbNoUy7LoKpgqsxzbW8czJ7TQi/SC7muvqqrcR/oVKbXipFnJgMJzOsFLxD5VSeUU+3Zj2O5aQdXve3Uz3tw4PQKkw1AqIUpZjg7RF3TcwkultA8YLbs8z6fisLqnIUlFHDdREffoPBunQwnJUcYxlTLryLi4WPuk/jL7W1qsjZC0OsQWX+5QnsrdiT3XLNPR3kacP6KtMRA84yCmB4XSGtzx4JjpTHsT4ieBkiPmpiVmXZFD7c/TPNF+Fc9HJwG0xa9J7kne03INeOqDUKnNOgKHpSZ1BbyFxMnFfeOV8/NYgQNDuofqz90UYkURfxztk6s4u3xVpQZCWDewmv99+Hw7grlvdojsMKESQBRDsXAIID8cwySddhUCpv7IvcrAcMUNmdA9UTaNtY7ULutV2QXSmuJsWkeZNNKltLefT8AG9RveZcXFQFunvkAcXTahFE9b296kgBHxMIW7xKb5fXfXMw0mRb9eF+eaipy6aUoFcEEch4M0SPwRCf+SixUlUvCYQqMz3MxK4NXThVV8uy/v4+TE3fPZgms+Uq8hwcFKUXBTco8+AuMeA+IJT+nDdj02FjrhMtJfEY34UDUPKog9iaCEHQ6o2zQspiPkjU+p/i2QFYLkkGEd6GRuwGbZkcpmv8YIv6EA6RU5QRYoQRBOk8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(82310400005)(426003)(86362001)(47076005)(356005)(82740400003)(5660300002)(2906002)(8936002)(41300700001)(44832011)(7416002)(40480700001)(40460700003)(4326008)(1076003)(6666004)(2616005)(966005)(186003)(478600001)(336012)(26005)(316002)(16526019)(8676002)(54906003)(70206006)(7696005)(6636002)(110136005)(70586007)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:50:41.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbda4df-b8db-468c-73df-08dafa1363d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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
   performance level through `Desired Performance` register and platform
follows that.
2. Guided autonomous: OS scaling governor specifies min and max
   frequencies/ performance levels through `Minimum Performance` and
`Maximum Performance` register, and platform can autonomously select an
operating frequency in this range.
3. Fully autonomous: OS only hints (via EPP) to platform for the required
   energy performance preference for the workload and platform autonomously
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
Kernel: 6.2.0-rc2 + EPP v11 + patch
Scaling governor: schedutil

================ dbench comparisons ================
dbench result comparison:
Here results are throughput (MB/s)
Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
    1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
    2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
    4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
    8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
   16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
   32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
   64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
  128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
  256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
  512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
dbench power comparison:
Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
    1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
    2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
    4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
    8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
   16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
   32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
   64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
  128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
  256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
  512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)

================ git-source comparisons ================
git-source result comparison:
Here results are throughput (compilations per 1000 sec)
Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
  192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
git-source power comparison:
Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
  192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)

================ kernbench comparisons ================
kernbench result comparison:
Here results are throughput (compilations per 1000 sec)
Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
kernbench power comparison:
Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
   32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
   48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
   64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
   96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
  128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
  192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
  256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
  384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)

================ tbench comparisons ================
tbench result comparison:
Here results are throughput (MB/s)
Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
    1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
    2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
    4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
    8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
   16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
   32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
   64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
  128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
  256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
  512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
tbench power comparison:
Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
    1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
    2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
    4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
    8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
   16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
   32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
   64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
  128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
  256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
  512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)

Note: this series is based on top of EPP v11 [3] series

Change log:

v2 -> v3:
- Addressed review comments form Mario.
- Picked up RB tag from Mario.
- Rebase on top of EPP v11 [3].

v1 -> v2:
- Fix issue with shared mem systems.
- Rebase on top of EPP series.

[1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
[2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
[3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/


Wyes Karny (6):
  acpi: cppc: Add min and max perf reg writing support
  acpi: cppc: Add auto select register read/write support
  cpufreq: amd_pstate: Add guided autonomous mode
  Documentation: amd_pstate: Move amd_pstate param to alphabetical order
  cpufreq: amd_pstate: Add guided mode control support via sysfs
  Documentation: amd_pstate: Update amd_pstate status sysfs for guided

 .../admin-guide/kernel-parameters.txt         |  41 ++--
 Documentation/admin-guide/pm/amd-pstate.rst   |  32 ++-
 drivers/acpi/cppc_acpi.c                      | 113 ++++++++++-
 drivers/cpufreq/amd-pstate.c                  | 184 +++++++++++++-----
 include/acpi/cppc_acpi.h                      |  11 ++
 include/linux/amd-pstate.h                    |   2 +
 6 files changed, 302 insertions(+), 81 deletions(-)

-- 
2.34.1

