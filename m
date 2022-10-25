Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113360C9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiJYKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiJYKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:16:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E3F53D0;
        Tue, 25 Oct 2022 03:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yw5E+XBluBDQSa1n2V8cOHjjvk52MdEVVtSc+YrEkFOBXnTF9rT6vlIQC5yeJJcTupz5sWLS9GI89KA2+YIoSKnr98l+5fJlA8XDJf4YG6UN9iP4ZmGR8JZbYwdklCaCswNn/4J9458q/AMz2JNphOxhylM7J7N5MOZQdlEIPdE4BWJTkW7+15wUzZm15l1PC1RQCotIBQyrGD6cet1AcTX6BUZSXeHCIDJ/x4s++YJQqgmHdTMM+M6axQOaaa++B0MadJ588ISl6vrsBm4eu/uk6Zb9hbnk9VW0mE1OQnKTRF7l1nAVd/Qa90nLJAZRSbiFVSYed0X6FSNr9/S+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB7qMc1OXxTQzcguIRDh30RFkjcS4JMSvK1b7CtYARU=;
 b=d4KVu2SFlcCHucDqrawtGOcJKuFj5oRczWJ6pXcHMhQrHerP5JXug2dsfgUEv4ZoUTY3FENCeU9nq5ODmzzj7b6EoE3ZnXW0QpDRDZbiK6TYQjjWy2upghnYoQGAWUybxZz3v/MNiWDAFjwbm2+prYmLBoeFDnusVQEtG8OqaUCnWwjO1xDHRoaaoV59Ya92QB0JJ4jkaGF6HKdKp2QoGcd7ZDIu0pY7cVOCKq+CNz750SEhDiAZoOYhbNvxw2TdOUb4G1GDw4aYs1e4SWa5IN/WV76WUJFBE8uyY2JLZLoywPfJDZp1u4vvv+RcLI6cMXlM8qJyG8018gOsu4TGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB7qMc1OXxTQzcguIRDh30RFkjcS4JMSvK1b7CtYARU=;
 b=C5NyI2tQdsqj/YeItS8sDflUeSjaHDCPo1ci7oOylnbbrz9r+Iono3vsEP3T9cabdr1g/slFgD7gJHWvuwaqdGYWrNGDwee5yH246KOvM9g3rA22vOCT0idwRlIuO+vsy70GSPp84c5Cmy0vW+da7of8VVS1/NwbsxmpUD4NxgE=
Received: from BN0PR04CA0165.namprd04.prod.outlook.com (2603:10b6:408:eb::20)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 10:10:29 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::3b) by BN0PR04CA0165.outlook.office365.com
 (2603:10b6:408:eb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 10:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 10:10:29 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 05:09:58 -0500
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
Subject: [PATCH V1 2/2] Documentation: amd-pstate: Add speedometer test introduction
Date:   Tue, 25 Oct 2022 18:09:10 +0800
Message-ID: <20221025100910.1682567-3-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025100910.1682567-1-li.meng@amd.com>
References: <20221025100910.1682567-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ad10b3-62bb-4ced-5cac-08dab6712500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtDlXMNNCAhBOs/2hQ3IPw9TvnoBdYHHbtQRpamz/zvcJsnhbQlnFrHyFmcjZtYS+exSy3n9quoB+DdMHHWmsMH/Egeta/nD6HZfuKV1QziGQehPmr8mW12nOHhPbNICyuZR/Ldchvme2V29bGTkGgiS9lgc4fGQwyqYKUdmRPaeOPhaIbl6pAiM4l7RshmHx6oGaUfCrNkfpmhUDcEBdBL4MXLEDfOQasEhm6DFO1urf9hXy/2hPKohyTEw83yq/3VTmMdJSfs5l5aXofo5m1bO6K6dyz88LASsNRBokw4wYMnFMQrtAbHhVPrGKp/Vp+LtivMpAWSGMpez78yntC14D3p9FNvk8miTjYVngi6SI1IY0P28MbKrAj331m+161H1eT4pBnvMIm/fWd5Z6k6UJne+5cw0viDv/inTtj2L1w6x5kXR8dOY/NQIDhhgMz0ACiVGUDFJFB0uXWggAoIuobtWAvRmZJlq0wIBkcsKMnPqjrJpUQxaDWSRus4QcmmHbtkhFjvQedjYF8FDIiSl20dvF+eHcEn7NhU+//p3Nzs9qVGjUxxLyxyvN2HRj7MIlWJxXq6GVnX3CQLQLIbEU0FsySWDttpruqN3Wsb+jWAUOhh1Qjk94qZvhvKszHtf/n5PiGwfPzXW/HTxrREO3RWjEg1whltuCxdzUGgfkl11mcSyIAJdeLsgBMqfeLwQ0cORilXzIp8WPrY6+nlfkgVQbp+k5HIURtUwvIs70MPb27g1Axj0TZbubsx8O5yEqqFE1/rkG7zhiGbv6aJGolJpzCg+tXSTM4SXUSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(81166007)(54906003)(110136005)(356005)(82310400005)(478600001)(40460700003)(36756003)(16526019)(186003)(316002)(36860700001)(6666004)(1076003)(82740400003)(86362001)(41300700001)(26005)(2906002)(426003)(336012)(47076005)(8936002)(83380400001)(7696005)(66574015)(70586007)(5660300002)(4326008)(40480700001)(8676002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 10:10:29.4218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ad10b3-62bb-4ced-5cac-08dab6712500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce speedometer test cases design and implementation.
Monitor cpus changes about performance and power consumption etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 75 ++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 4f0d5169ff86..769982f66eca 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -451,6 +451,23 @@ Unit Tests for amd-pstate
         The specified governor is ondemand or schedutil.
         Gitsource can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
 
+    4). Speedometer test
+
+        Test and monitor the cpu changes when running speedometer benchmark under the specified governor.
+        These changes include desire performance, frequency, load, time, energy etc.
+        The specified governor is ondemand or schedutil.
+        Speedometer can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
+
+#. Preparations before tests
+
+    1). Speedometer
+
+     + Python version 3.0.x or higher
+     + Install chromium-browser
+     + Install chromium-chromedriver
+     + Install selenium on the client
+     + Install selenium-server on the server
+
 #. How to execute the tests
 
    We use test module in the kselftest frameworks to implement it.
@@ -487,6 +504,8 @@ Unit Tests for amd-pstate
         $ sudo ./run.sh -t tbench -m acpi-cpufreq
         $ sudo ./run.sh -t gitsource
         $ sudo ./run.sh -t gitsource -m acpi-cpufreq
+        $ sudo ./run.sh -t speedometer
+        $ sudo ./run.sh -t speedometer -m acpi-cpufreq
         $ ./run.sh --help
         ./run.sh: illegal option -- -
         Usage: ./run.sh [OPTION...]
@@ -495,7 +514,8 @@ Unit Tests for amd-pstate
                 [-c <all: All testing,
                      basic: Basic testing,
                      tbench: Tbench testing,
-                     gitsource: Gitsource testing.>]
+                     gitsource: Gitsource testing,
+                     speedometer: Speedometer testing.>]
                 [-t <tbench time limit>]
                 [-p <tbench process number>]
                 [-l <loop times for tbench>]
@@ -621,6 +641,59 @@ Unit Tests for amd-pstate
          + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
          +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
 
+        + speedometer
+
+         When you finish test, you will get selftest.speedometer.csv and png images.
+         The selftest.speedometer.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the goal, time, energy and performan per watt of each test.
+         Open selftest.speedometer.csv :
+
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq     | Load     | Goal        | Time        | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz      |          | Runs/Minute | s           | J       | Runs/w               |
+         +=================================================+==============+==========+==========+==========+=============+=============+=========+======================+
+         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 209         | 51          | 731.84  | 0.2427               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 205         | 51          | 759.03  | 0.2295               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 206         | 51          | 755.15  | 0.2318               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 206.667     | 51          | 748.673 | 0.2346               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 206         | 56          | 775.08  | 0.248                |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 204         | 51          | 762.06  | 0.2275               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 207         | 56          | 776.35  | 0.2488               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 205.667     | 54.3333     | 771.163 | 0.2415               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 1            | 24.7974  | 1.73142  | 7.71728  | 195         | 64          | 756.6   | 0.2749               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            | 26.1653  | 1.91492  | 8.5525   | 195         | 51          | 705.67  | 0.2348               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            | 24.1789  | 1.69516  | 7.41152  | 196         | 65          | 758.98  | 0.2797               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      | 25.0472  | 1.7805   | 7.89377  | 195.333     | 60          | 740.417 | 0.2638               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 67.0214  | 2.76691  | 17.1314  | 197         | 51          | 737.52  | 0.227                |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 64.3032  | 2.75981  | 16.1196  | 198         | 55          | 763.57  | 0.2376               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 65.5175  | 2.59423  | 17.0067  | 201         | 51          | 735.96  | 0.2321               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 65.614   | 2.70698  | 16.7526  | 198.667     | 52.3333     | 745.683 | 0.2323               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | -0.4838     | 6.5358      | 3.0039  | 2.9411               |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 161.9614 | 52.0348  | 112.2255 | 1.7068      | -12.7778    | 0.7112  | -11.9408             |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | -5.4841     | 17.647      | -1.1027 | 12.4467              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | -3.4035     | -3.6809     | -3.3041 | -3.8095              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
+
 Reference
 ===========
 
-- 
2.34.1

