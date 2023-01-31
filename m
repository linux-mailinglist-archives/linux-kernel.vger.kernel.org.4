Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80E6823C3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAaFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaFWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:22:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405AD507;
        Mon, 30 Jan 2023 21:22:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbMvg3hm22Vhkii4DpnOTLQU5uSX5gvwlE0pd4ywO4NjPcjjTQ1mHOzG3v86mew7OTzIR6BcGuyc9Ej0ch5SiMHCg1NOZ9hSqcee/PQoyEwnZdkDFLQ39IyzMd/u2lIsBxmkZEYAxXpJk4zbktqJmLt2Qmiwpj6wib3YkPWJVQ6lWyquJ2yVRhzS1aFXdX7F1AxSdbDo/kBnPSn07Vby5YT9q9sqEcgnx3TObV/VDVx3mW/Hx+FGIRCyyPT8wE4bHChzGpvYydXhl6mvXD3eRMdZRpW7mHYEWH1ln9/zVKeI8TBlrGM2hFUABxzJe6xReYZtUh2XqTBtmihkovaNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N+M2nKiKBb8G3WmPxFJFqr3KYtk/VRfyIuTTEkGhm8=;
 b=U4UZOVUiuVZVMhDsOh11OHwuFyqOefzOWDmBSHRl24CztakBW1AdJbcltn235UAL6PTukxFWjZyiFmRLwxgSwEGL7+kp+/n6I+EUkyeoFfmj8gLDpUqR7W1SJptfsQhZmBAuQB8Me5bUMsnmPZFdfZ1TSvoxuc1DNIBnat//QA+K6Fy/Xzgu0Brq6Kay/xt7IVod2dnbEpjL49eLXP49Uv8o3DUVPDIpeVZqVqAuHfGFFetiUasXwePRfpgO2uWqRVSYESNP7Rtk4DVaRQtZiPl9ph8r0qcv1bCeSohlip+9Ahx2UFTMH6iShD8v9btTEtuLgVIz9GN+bnP14o4nWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N+M2nKiKBb8G3WmPxFJFqr3KYtk/VRfyIuTTEkGhm8=;
 b=Qxg2hwGq5S2jTpP+meIihuze9GGZvjVTGDZUnCsDC0QPUslXryr71oafAUa+sAc5AjYf0b2cmk4klFwVzhBTZQ1huXTOsF/RHjM+SwsOG7z1TKDdK/lKN+jPLs4C/ilHVcKiMkYrL/g43B2PhVcR1psUna9bsON7dhHPVLlICEg=
Received: from DM6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:5:80::22) by
 SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 05:22:03 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::bc) by DM6PR08CA0009.outlook.office365.com
 (2603:10b6:5:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 05:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 05:22:03 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:21:58 -0600
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
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 0/6] amd_pstate: Add guided autonomous mode support
Date:   Tue, 31 Jan 2023 05:21:35 +0000
Message-ID: <20230131052141.96475-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6e0a8e-81d3-4341-713b-08db034b166f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTUDAd1cRvvYOIRIgsgGVEQ4P2D7Dsjp7tXCPfj35XI5HZo0P66ECiP3JEp8YzzdCvvRKu5C06K6Ce4KTcKU/592C8nY5aepFbVCIJrYDO1dwnwHpd3q3jofzwF5rl5lKifn4iaHZ8jZNjlVyicwI+kn15qndYPhp9CXdGZgbDxd5xR2mwBwu50G8WzGI4gPlkWB6UD12HAqlzYCUYbhKoKK7wq2uPGPVzZNftiw9Y0BqOtbeiSregUYDX2CvAnigAy9EBwUcZm9oZ5eNFXNqwSpu+APKlF3bPtqu87CeQgXlgbGwz7MBBZhEy3QINMo9xq/kHRlJtjbPgsrQpFdCT9Z3MqAZrX5xB+9sVRh3TNafRWoGkgtqYk9iDMjYpKKSJD2rSj+FG7Iz9tK6ZS5uCvNm2ZIDShrZcBhdiG7JyBoUVCP6SKwi3BX8H3cznTgQ4wI57t4AW9QlemIJqVk4KVnYm4BMIUevn843b3YTlsh9RX7ZbFhZh8GJ2Xf+y2dzJBCZcSOxOE0N6PU1bdzJ9go/GEpS1oZf5Qhb5x+mdaSq1GkOXY9K7vuk95BSRGmjMrhs9L3/kpbgAtszlgf3ddUoG028CTXYb2bqTyxfmbMDm31KVWz+wVMWqQj4cPrJPwDgIWxwA2RJHYlD8hSLLpLt08wl32hmnk+KvyIGJ3lVwlh83SNeRiNw/bVr7g1QEUO1AMjYqgf767DGa6vQAiToVSGiiE9oJCt11pkIqD8AsDmmCpXp348Ob65P+CWS9ky7one1UTvUw5g3BdskNfRsJ7YiKDOksJlOIbnNBdz7gpgXCIHIU963tNqvJ/z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(2906002)(336012)(4326008)(8676002)(44832011)(36756003)(478600001)(7416002)(40460700003)(5660300002)(966005)(186003)(1076003)(6666004)(26005)(16526019)(7696005)(2616005)(40480700001)(86362001)(426003)(47076005)(41300700001)(82310400005)(356005)(81166007)(83380400001)(70206006)(70586007)(82740400003)(316002)(36860700001)(110136005)(6636002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:22:03.6108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6e0a8e-81d3-4341-713b-08db034b166f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
[3]: https://lore.kernel.org/linux-pm/20230118075210.447418-1-perry.yuan@amd.com/

Wyes Karny (6):
  acpi: cppc: Add min and max perf reg writing support
  acpi: cppc: Add auto select register read/write support
  cpufreq: amd_pstate: Add guided autonomous mode
  Documentation: amd_pstate: Move amd_pstate param to alphabetical order
  cpufreq: amd_pstate: Add guided mode control support via sysfs
  Documentation: amd_pstate: Update amd_pstate status sysfs for guided

 .../admin-guide/kernel-parameters.txt         |  41 ++--
 Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
 drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
 drivers/cpufreq/amd-pstate.c                  | 184 +++++++++++++-----
 include/acpi/cppc_acpi.h                      |  11 ++
 include/linux/amd-pstate.h                    |   2 +
 6 files changed, 309 insertions(+), 81 deletions(-)

-- 
2.34.1

