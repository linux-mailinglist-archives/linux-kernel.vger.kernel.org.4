Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8334B6097DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJXBe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJXBen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:34:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FD711A10;
        Sun, 23 Oct 2022 18:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZpdLuZczxX/fKNsHvj5Tr9f6rCdG9OxWZzqkjjs/gwg3HyAKrrDW2cRMoBlMd51GFKnxlmw2aGjkDWMRWPpWJCAvlEcJmFhC7Mng4L53DIf2QE9wr2VIkW2ogffIXqNlcogdKDkV27RO/hNV6ARqy360waLD/8NVkoqll1sH6Ro9uy8ryeQya928THNwMNo7+qYHjB5BYlH/53eWSzLDf04FMzNtlDzFmGo63zwVI07mPdazDfpEFjNqr19xeC2FcdjtrkVDJrmMFmQxYYqEvP8X0vUxzeIODGVuuqDFpI+wtbsywa9fpmGc2uI3IED+ldY0Yy2BQ/y1YgM6Eg/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zhbKf2YdCyhli7vfraDFgh/unNOGAzUxWffwuvKGg8=;
 b=BhydbU4JLg48KxiHOJ+NeK59G6Dfw1QgnOsqix9R19W5y4E9X4oKBX1uTyjP0OoT2AldM65rhDQkz6mY8tee0BXoarYzyQFoZnxWclZVI419HPZ0LJZacLk9iyKEweu2pCAlw3FKe6o7Q8/9XyF8B09Lg1X6U/4jutGhkf0YKItmRfQ81Zl+0mbzv5I0yXQX7Pn4pfWUlp30tbYoImb5yuMcDeDCN/Py1qe2GNrdFhtShI0I1N8knRVqIRGPBoPfMc2eiH3cCVouedzEHqBS04Ty4jbbebMQZg6fWwECC6D+Rg8DuD2WGesYrpJw1iVF5bRYalJBuTeiekRksbNXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zhbKf2YdCyhli7vfraDFgh/unNOGAzUxWffwuvKGg8=;
 b=yAlqxBFt61k06FoSbHXon0mujwim3Q19Jj154G5GWQmi+SHrdrV2OszPGXCfFoTcwMJWk464pMG0+1nX4lDXhXwTYHOMGaSZ1U+l7nFa4OxZ4xIuSosOFY3cdcOPYGLE8VyxTgHi5go4qaI5Qwt/2zrx80Z/dVT5GvSnW5hMZLE=
Received: from MW2PR2101CA0005.namprd21.prod.outlook.com (2603:10b6:302:1::18)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Mon, 24 Oct
 2022 01:34:35 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b8) by MW2PR2101CA0005.outlook.office365.com
 (2603:10b6:302:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0 via Frontend
 Transport; Mon, 24 Oct 2022 01:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 01:34:34 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 23 Oct
 2022 20:34:30 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V4 4/4] Documentation: amd-pstate: Add tbench and gitsource test introduction
Date:   Mon, 24 Oct 2022 09:33:56 +0800
Message-ID: <20221024013356.1639489-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024013356.1639489-1-li.meng@amd.com>
References: <20221024013356.1639489-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5a9f9f-4a41-44be-b9df-08dab55fe842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dr6HuLFz5H2cQKJPdaSgF3KK4u7t+hN/sZxArhUY/KPeOtZKAsPfW8RygLxwrRM/p7ZO85V1pWaqQleA9h2KuzxqQsUsC6xqMuwvjpnwkv22juJijH2GP50GlfVijE4wYqoFeqFg/1hHycpfQSrzE5XoolxhZsYX0AHXGG8AuZczJmui2Kj1UclLkbTcwZlL6E5SDk9PaPO3M8pNnDzCiNfQrDS6FtcXiyPI80JDQt+6cRMnFtUkqg0x25ddG0f4P6o3zGyA4Wm5J/hrdsrgtbgEkrksO65USyXYXacFcui4mcCJaDRgMVvWY+kQqDJlxnjfLocBzsuMBBjcZMaHDEZjthmrZ3svJesNUqypzVMj3fAX4b9AtdcmE1jYOXM86H9/yiLA2KupwD7VWBLMv2AXrOJaIl0z1h1doDKPZtr1fqvsGEfiNtPJbrfJJVnqeLpWFCcgJbNOnC6XvQEeuapvW+GZ0BNChNzcmpJNl8yWPwPfeFkQwK8vhpTR+eeudcQe5BGKX0C53pM2bLEX566GsxzcKoEdaYzoSPPryktNgNO/B1itSOaKzrjN8SVdVAmRFSTXNRF4IQTOHT0mSqbxolVf1tGYuSJ0XpMUo3yDjyW+mFaZlErJHjKVXCtkppFgY3ov0oOpJ4RQ0cwcqEy+oWKiAgC+BVpIi5cJyDiTtZhgxDnr20PGby5/XWfJ77SYNpIfOV985ZR0+HBCVIICNUOvMHapB2C1yAY19ESob11/Xv/C7gpvtrAZZycGb38eLQvX/JAPlVrzBM5axfbICA2s++SESIaz0YqHRqD/0dRY4/TzrnF0e5L485y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(336012)(83380400001)(41300700001)(16526019)(356005)(81166007)(426003)(8676002)(82740400003)(30864003)(478600001)(2906002)(36860700001)(82310400005)(1076003)(2616005)(86362001)(47076005)(186003)(8936002)(40480700001)(70586007)(40460700003)(7696005)(6666004)(70206006)(4326008)(5660300002)(316002)(26005)(110136005)(36756003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 01:34:34.7991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a9f9f-4a41-44be-b9df-08dab55fe842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce tbench and gitsource test cases design and implementation.
Monitor cpus changes about performance and power consumption etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 194 ++++++++++++++++++--
 1 file changed, 174 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 8f3d30c5a0d8..4f0d5169ff86 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -409,37 +409,55 @@ Unit Tests for amd-pstate
 
 1. Test case decriptions
 
+    1). Basic tests
+
+        Test prerequisite and basic functions for the ``amd-pstate`` driver.
+
         +---------+--------------------------------+------------------------------------------------------------------------------------+
         | Index   | Functions                      | Description                                                                        |
         +=========+================================+====================================================================================+
-        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
+        | 1       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
         |         |                                ||                                                                                   |
         |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
+        | 2       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
         |         |                                ||                                                                                   |
         |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
         |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
         |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
         |         |                                | request from AMD P-States.                                                         |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
+        | 3       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
         |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
+        | 4       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
         |         |                                | are reasonable.                                                                    |
         |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
         |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
         |         |                                | the one in ``cpuinfo``.                                                            |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
 
+    2). Tbench test
+
+        Test and monitor the cpu changes when running tbench benchmark under the specified governor.
+        These changes include desire performance, frequency, load, performance, energy etc.
+        The specified governor is ondemand or schedutil.
+        Tbench can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
+
+    3). Gitsource test
+
+        Test and monitor the cpu changes when running gitsource benchmark under the specified governor.
+        These changes include desire performance, frequency, load, time, energy etc.
+        The specified governor is ondemand or schedutil.
+        Gitsource can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
+
 #. How to execute the tests
 
    We use test module in the kselftest frameworks to implement it.
-   We create amd-pstate-ut module and tie it into kselftest.(for
+   We create ``amd-pstate-ut`` module and tie it into kselftest.(for
    details refer to Linux Kernel Selftests [4]_).
 
-    1. Build
+    1). Build
 
         + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
         + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
@@ -449,23 +467,159 @@ Unit Tests for amd-pstate
             $ cd linux
             $ make -C tools/testing/selftests
 
-    #. Installation & Steps ::
+        + make perf ::
+
+            $ cd tools/perf/
+            $ make
+
+
+    2). Installation & Steps ::
 
         $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        $ cp tools/perf/perf /user/bin/perf
         $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
-        TAP version 13
-        1..1
-        # selftests: amd-pstate: amd-pstate-ut.sh
-        # amd-pstate-ut: ok
-        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
-
-    #. Results ::
-
-         $ dmesg | grep "amd_pstate_ut" | tee log.txt
-         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
-         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
-         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
-         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+    3). Specified test case ::
+
+        $ cd ~/kselftest/amd-pstate
+        $ sudo ./run.sh -t basic
+        $ sudo ./run.sh -t tbench
+        $ sudo ./run.sh -t tbench -m acpi-cpufreq
+        $ sudo ./run.sh -t gitsource
+        $ sudo ./run.sh -t gitsource -m acpi-cpufreq
+        $ ./run.sh --help
+        ./run.sh: illegal option -- -
+        Usage: ./run.sh [OPTION...]
+                [-h <help>]
+                [-o <output-file-for-dump>]
+                [-c <all: All testing,
+                     basic: Basic testing,
+                     tbench: Tbench testing,
+                     gitsource: Gitsource testing.>]
+                [-t <tbench time limit>]
+                [-p <tbench process number>]
+                [-l <loop times for tbench>]
+                [-i <amd tracer interval>]
+                [-m <comparative test: acpi-cpufreq>]
+
+
+    4). Results
+
+        + basic
+
+         When you finish test, you will get the following log info ::
+
+          $ dmesg | grep "amd_pstate_ut" | tee log.txt
+          [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
+          [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
+          [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
+          [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+        + tbench
+
+         When you finish test, you will get selftest.tbench.csv and png images.
+         The selftest.tbench.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the performance, energy and performan per watt of each test.
+         Open selftest.tbench.csv :
+
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq    | Load     | Performance | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz     |          | MB/s        | J       | MB/J                 |
+         +=================================================+==============+==========+=========+==========+=============+=========+======================+
+         + amd-pstate-ondemand                             | 1            |          |         |          | 2504.05     | 1563.67 | 158.5378             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            |          |         |          | 2243.64     | 1430.32 | 155.2941             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            |          |         |          | 2183.88     | 1401.32 | 154.2860             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      |          |         |          | 2310.52     | 1465.1  | 156.1268             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 165.329  | 1.62257 | 99.798   | 2136.54     | 1395.26 | 151.5971             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 166      | 1.49761 | 99.9993  | 2100.56     | 1380.5  | 150.6377             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 166      | 1.47806 | 99.9993  | 2084.12     | 1375.76 | 149.9737             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 165.776  | 1.53275 | 99.9322  | 2107.07     | 1383.84 | 150.7399             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 1            |          |         |          | 2529.9      | 1564.4  | 160.0997             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |         |          | 2249.76     | 1432.97 | 155.4297             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |         |          | 2181.46     | 1406.88 | 153.5060             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |         |          | 2320.37     | 1468.08 | 156.4741             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |         |          | 2137.64     | 1385.24 | 152.7723             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |         |          | 2107.05     | 1372.23 | 152.0138             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |         |          | 2085.86     | 1365.35 | 151.2433             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |         |          | 2110.18     | 1374.27 | 152.0136             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |         |          | -9.0584     | -6.3899 | -2.8506              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) |          |         |          | 8.8053      | -5.5463 | -3.4503              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |         |          | -0.4245     | -0.2029 | -0.2219              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |         |          | -0.1473     | 0.6963  | -0.8378              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+
+        + gitsource
+
+         When you finish test, you will get selftest.gitsource.csv and png images.
+         The selftest.gitsource.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the performance, energy and performan per watt of each test.
+         Open selftest.gitsource.csv :
+
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq     | Load     | Time        | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz      |          | s           | J       | 1/J                  |
+         +=================================================+==============+==========+==========+==========+=============+=========+======================+
+         + amd-pstate-ondemand                             | 1            | 50.119   | 2.10509  | 23.3076  | 475.69      | 865.78  | 0.001155027          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            | 94.8006  | 1.98771  | 56.6533  | 467.1       | 839.67  | 0.001190944          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            | 76.6091  | 2.53251  | 43.7791  | 467.69      | 855.85  | 0.001168429          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      | 73.8429  | 2.20844  | 41.2467  | 470.16      | 853.767 | 0.001171279          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 165.919  | 1.62319  | 98.3868  | 464.17      | 866.8   | 0.001153668          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 165.97   | 1.31309  | 99.5712  | 480.15      | 880.4   | 0.001135847          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 165.973  | 1.28448  | 99.9252  | 481.79      | 867.02  | 0.001153375          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 165.954  | 1.40692  | 99.2944  | 475.37      | 871.407 | 0.001147569          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 2379.62     | 742.96  | 0.001345967          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 441.74      | 817.49  | 0.001223256          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 455.48      | 820.01  | 0.001219497          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 425.613     | 793.487 | 0.001260260          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 459.69      | 838.54  | 0.001192548          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 466.55      | 830.89  | 0.001203528          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 470.38      | 837.32  | 0.001194286          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 465.54      | 835.583 | 0.001196769          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | 9.3810      | 5.3051  | -5.0379              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 124.7392 | -36.2934 | 140.7329 | 1.1081      | 2.0661  | -2.0242              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | 10.4665     | 7.5968  | -7.0605              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
 
 Reference
 ===========
-- 
2.34.1

