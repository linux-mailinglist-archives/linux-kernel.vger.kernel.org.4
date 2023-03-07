Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD96ADD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCGL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCGL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:28:09 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67D231EA;
        Tue,  7 Mar 2023 03:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjIur8O2vuq4NRE8H1z/afc3A1d1SggMcSaMLcj9rOcLk7EDoGdLd85xHmWrPClHnn/0zYo+LzjTmOylBZk8TFtDLWwYEWCP3AtpmeG7O6Y70Vd8YlFyiB66ozNySMetuDQ02tgkNq2i1St4kjpDXoC9MEFP2TxR7oaP6ROWLQh92AnvMBC6pe3mSmn2DLJhibC+5pqfymiNsRv/2b648qG1l7E8kNeZezCF16u/nbgvJZ0pKdYYYUVGv3tY7FbD+blTRAZE8QoYTT+oH98JC3rD9DJMN1sWcyVxWU7hQGIlLY65jNgahFlYGYrC8/Vh4AzlWR8R6F5JAictn01XZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myKob7yqE/uie5lRgAB4273TTnkS3fqyRRfnH3WlKc4=;
 b=IpOe+msfRqFWKfxFCgVxm7fpAGtFOChtXPS22qT3jr3Ki8/aymeJPkhdkivv3hZ6AxexPRBpe0t1gi4LX2MjOCbBTQ5dMBzf9gkJzogrd81gI/kXj8frFMKqaKg8/zecjJlsjEunz0TTzUXUAcQh2GRg7Bgz/Zs3R5VeC5MhW9jV+7CSGs9bPIbAzlTQjqvTdO0x4OwWj+bKSAp1umEvZ+H2dUhrr9Bn5llLKdp4Dlb1uTMJ3+LP/uocXUIdk0IyJ8RTAagFxbMlC82nierHc2RJc7/bv6C2c6yEHhXVTOAbhrnVJvQCKKOp7yPuDQfu5fxzHKZuUEpApS4SbPFgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myKob7yqE/uie5lRgAB4273TTnkS3fqyRRfnH3WlKc4=;
 b=FRCKD3FUNVbXNjYNACMeaU1kywzGhWjRbrW12xiAMuilvm8L1uIEwwYsEItPYOC+nwyy3jHt7ou3TaMUguE2tZV+12UNaAuAwgtAHg0pllLt4iBd4IDKBy4KqRIPP56C+K1OtlpBB0LVqHM0NI6x+LY9nsj+IOihurT1Hfzejzs=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 11:28:02 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::43) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 11:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:28:02 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:27:56 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v8 0/6] cpufreq: amd-pstate: Add guided autonomous mode support
Date:   Tue, 7 Mar 2023 11:27:34 +0000
Message-ID: <20230307112740.132338-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8a1611-64a6-4032-f61d-08db1eff0362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8KK1Gyw595+SlIVnh1Llb6fvC3RZy5rnIB7bVX+yDS34sLtqf297XGm9vEqX45LGWc5htu6YvlTlpjrEH9CX6d1RHhBYu7lzpDa1PQDng9tVIGGgCSH6tfpjbglNhS9Qd2sySSoHVvb+0um7zOXhNut8lRZiTrMTKBvTSEz4FuWC41WMOv2qFjH27SPnyPxNbhqNQrEeqZ/QfgnGVD3+4N13/w5f6zNevEv/wvyUEcOfSrP8Iz4spcM1LPNZHC+HpueTnrIOC5YlAtQyjy+Yt8H0gvKuzmfkjUs9eTxNJgKmJfv2EZbudhWnZUYg//fvfbYEHCyl1YqasbBnff3z2NMY7NY7ilWzkrAC3QU0f4mGI0cLLJUvMKjAm/HyExVXwKb7MKnNuADW3FpIFiDUiYzpVYPfRGe9rmj6bSfqHoGmG41UNLsj8IldxhxQHfihsi48eMUQf1amx2CWzyCFktE8UN8L8O6l1EHBGy+fc5FezauoeeuWcCtP4mXy/ay1Sf3pSURqK1vbvKvAGiv/CQb8l9hkobqwn5zP+o31NchRj7iO1Z4QNA8EgoSmYrh0JRSr3PFgLLTxhjrohFS/zjHUU6TPBUxT4fkv1THvo3KJyh4DMdwdU67ChKHCTEZTHkWKIXL+bERqrVDB172URCat4wBEXJ4/XoMujWPBI/Q1nxgYnU2v6sqjCnXgO+gJtPQGgsPHEdedxzLMh0y6ogDzNsw2+yYgsB+vOB7FliC8W9ZxqatBw8sob0dC5BWlrGcBfcMfn726f3VFem5SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(54906003)(6636002)(110136005)(36756003)(316002)(336012)(966005)(83380400001)(40480700001)(82310400005)(86362001)(70206006)(186003)(16526019)(82740400003)(44832011)(70586007)(5660300002)(26005)(8936002)(8676002)(2906002)(41300700001)(36860700001)(4326008)(478600001)(1076003)(426003)(6666004)(2616005)(7416002)(47076005)(7696005)(81166007)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:28:02.3649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8a1611-64a6-4032-f61d-08db1eff0362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Kernel: 6.3-rc1 + patch
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

Change log:

v7 -> v8:
- Rebased on top of 6.3-rc1 tip
- Pickup tested-by flag by Oleksandr

v6 -> v7:
- Addressed comments by Ray
- Reorder and rebase patches
- Pick up Ack by Ray

v5 -> v6:
- Don't return -EBUSY when changing to same mode

v4 -> v5:
- Rebased on top of EPP v12 series
- Addressed comments form Mario regarding documentation
- Picked up RB flags from Mario and Bagas Sanjaya

v3 -> v4:
- Fixed active mode low frequency issue reported by Peter Jung and Tor Vic
- Documentation modification suggested by Bagas Sanjaya

v2 -> v3:
- Addressed review comments form Mario.
- Picked up RB tag from Mario.
- Rebase on top of EPP v11 [3].

v1 -> v2:
- Fix issue with shared mem systems.
- Rebase on top of EPP series.

[1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
[2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
[3]: https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan@amd.com/

Wyes Karny (6):
  acpi: cppc: Add min and max perf reg writing support
  acpi: cppc: Add auto select register read/write support
  Documentation: cpufreq: amd-pstate: Move amd_pstate param to
    alphabetical order
  cpufreq: amd-pstate: Add guided autonomous mode
  cpufreq: amd-pstate: Add guided mode control support via sysfs
  Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for
    guided

 .../admin-guide/kernel-parameters.txt         |  40 ++--
 Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
 drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
 drivers/cpufreq/amd-pstate.c                  | 177 +++++++++++++-----
 include/acpi/cppc_acpi.h                      |  11 ++
 include/linux/amd-pstate.h                    |   2 +
 6 files changed, 302 insertions(+), 80 deletions(-)

-- 
2.34.1

