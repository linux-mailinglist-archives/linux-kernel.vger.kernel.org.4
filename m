Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155FB698E79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBPISe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:18:32 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E526CC3;
        Thu, 16 Feb 2023 00:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djZFQ2yfp3vUXuQlLh6pDcp6ryVrxuIIHe+pK/HMvQ8ibi4jFOFZql6B5s6Ij5cC/AUazFhKodaHa2ODGcUlJN+0EHz23coHK/Smi5CaZfX9eLgr4/y1EtF8PlNCl40hCAc42SKUrJL99a+AwrPTOsOuuvuR5fnXRgaaIwtKBZxoYJ/EklVNgUDJnV1SES+da05SXnuCQUkrTuF/kkOiXoU6A2F69GowaQ/onEYOKyxeQ8dl+8H4fwx9+b4y47w5Z577jURetWc1UGsjYtjZ3VtihgXGtZ1kqPsgX+0+gFxpJP7YqZTEloBa9YGE8tEkf65cMVzr++FtAt2C+3u82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdxzbMR1RLITAVEUbuAu2zn2b5m8v19/BpE3vhbc5So=;
 b=AVyaVOMm5uWvu+9fYTs9evUqYCApLAyBueMkl1na78LCIj+IyiasL2oUNawNrwgAb5KayS8tORTUPw/yO9wOh77uK/EXIAfyBn9RdbPVdKPMZxCQSJllqPxZ+b/mBT9nJAqOSYqSmOWgCNO1D6Suy5rRcET9se7RbTCdRiFvEYef6n8FLERfoB3uwtqngnLV5hJl2FkluxSNHFNvBRtMPlyGBMRtTq98SFVOuDXzbSDQEjkZKFeW8+SrHcwMyILep8VxB4Wow4ELKuhoOlJwR1VMT7XhHuzotmiRMiUMnl/q8fMmhgLso4qqs9PN8ZGwSuMmesZQxk9ZaofEvDEZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdxzbMR1RLITAVEUbuAu2zn2b5m8v19/BpE3vhbc5So=;
 b=y5LWUhfffe9FiSC9pFUNfHwPdJTqFIJv49qIGzuVlj84cd025LrSO5UeJg7iY9exlM1PlN6B4Epi/UIF6SVb3bJM6Y5e122V0VmYMMb5aIvvOwwwei9UW/1CrNVmJRqHuQQoJF6B5QVj0/VdFVbQ8JdVBhhkTwewCSzMNEjWRYg=
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 08:18:24 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::b7) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 08:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 08:18:23 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 02:18:18 -0600
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
Subject: [PATCH v7 0/6] cpufreq: amd-pstate: Add guided autonomous mode support
Date:   Thu, 16 Feb 2023 08:17:56 +0000
Message-ID: <20230216081802.38007-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ba426f-4cf0-4f22-94e8-08db0ff65f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYCqUQwyz9uLqabnpoHx0eMaGXEVRiaQMxTrGFTJQGsIbRWxjkmob5Tzzp6YFpd15p5CBx0Bojyfz5rjWSLGPUQpnCcQWd85nzErA0RZxUVPDogFlbqYJZ7yf4EGUQQ3or0S+2bU6lxq5x/uBuV8GdbW0BES3zXfnto7CxF3ETfPUJVdnSjhqAJDusj4+BqmfKlpW+YLttB9QHrH4Herh4SI3nEz+cGFYl6I9kt1kWNttnqqzXocBNCcg9eGZoBUdE0KPIjWs92yz8AMnGXXO36pRbZG+KednHVfFGuDtivWA6Aee/KV3dd9iu/EuaoNDJM4Qqg1wygZ83NEVpEg/bUtoTCtY82Sql0lAaHAlk4+h0P/qKjiBcXfwQbavLZF9otL1uHd5Wuot9QPLFSbhTNKQJQXx8iopknFYLgD8pvVC23+LZrR2QIbAGVnELc82XLv4X+mLqkBLQCMvuf0Fn5NobsCJAx+/i2jySq+Kafb+yomSsR48hI82ZLin8NlOK0LPyiS9OwL3yGD5X7hRTBxMg/xSn5AxO/bxjBAo7eL67qXUmfVQaQYQNcMQGYKjFBxP1Kx3rFIFR9nDbI5ZJ1JDg2OVfp1RrKHFK83mmkq73X+b4rETfkoPbzzkWu1/FFMPr7SoxyMhz00QDbH5YspJzAzsqTlkFnjExgd2FXUh0wnfi+ZfXYAozLmidlTSB6YJ+UuAMgJiKqmp5nZJR/gBDWbj9DAk49ZVSczjleyV5xFGRiqZg6Yftmf73Z8ccXU+wcfBEqKCUrS7vnIZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(7696005)(478600001)(966005)(36860700001)(40480700001)(426003)(47076005)(83380400001)(356005)(82310400005)(86362001)(82740400003)(81166007)(6666004)(1076003)(336012)(36756003)(26005)(186003)(16526019)(40460700003)(2616005)(316002)(70586007)(70206006)(8676002)(5660300002)(7416002)(4326008)(6636002)(8936002)(54906003)(110136005)(41300700001)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:18:23.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ba426f-4cf0-4f22-94e8-08db0ff65f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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
Kernel: 6.2.0-rc2 + EPP v12 + patch
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

Note: this series is based on top of EPP v12 [3] series

Change log:

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

