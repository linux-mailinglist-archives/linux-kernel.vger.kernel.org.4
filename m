Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F345B815E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiINGLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiINGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:11:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14863275E7;
        Tue, 13 Sep 2022 23:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsTFC+qjZgK76/3Zpc2zQq3ho6nViIxt2nnH0dYbuFoEgopR/RyOfVJD7YbuuRiUcdfE6uFplyd0rBajnLD3nsJ8j+YzVr+8qZzDEGfT8BlSaQEZgq3T3P8onD3VK9SEa/W3KvSd8R2ocEABWGKkFTicth9lmXLiPysZ0jmwJ+XVL3W+0DF+zcsyaWegP/P0A9/mVC5e5Dbx5fgr6+hXMtY6AQxPrI5S6t9D+5fHxLWrXrRk9dQn4wRk5ZOqteqBVlxnbYRu6pvgKa6/f3SrRpa5vuLwG4xHUwuURvRDOeDWH3FWYulDdBgK8O37GbGOhytrajwNhxGf+9Vwt9yhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0A0zMubAesMwzzoBxvk0JPUgk7WMN1kAGiQSvopYk4=;
 b=UuEID563e137XoZOHyejOn8DBFAZZk6mAEEhLLOJhMIJEocpmDeoZPWFqh27TUmczWrRvfta/M6ahWrPuJ0GcurnV9vm8HJvRSx2jIKezPj7o6hIT4MJgASSkQJ/r4O3UCOc47nNpzvixdFxraTK1ykdLlS0kNi4YtGHP9TX3G7Fo8TcNzb5ouG22WGHzq/MeLgen/AKUMyP3Ljxghz/iPmIcsGspcc7jS2UykPGQ+L7KZWesun42qvm/3L4fK/Stbzs3xde6HT8S9bPjELrQv9eQ75de2PFmmMuT2st+qTJqlRrQ2z+PXJuxA5jBQRnaD5UyNYVFfH5O0p9WlV83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0A0zMubAesMwzzoBxvk0JPUgk7WMN1kAGiQSvopYk4=;
 b=gTH+FN+gMQmcQkHIrepKhxe/rsxgqHYI4c6TlxJ3l4XsvXIhr7Uv73aMXb7W9mMlG8O8GvP2tjWjOpA6q8ldljOGPY9JKkRK7JiYDt2yKqzYzkmHXtcgKcBr+FbSZHsDXx5n3xhre2ASYaowiK0FgV/4SW/C8w3XNpMb+aJZnCw=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.18; Wed, 14 Sep 2022 06:11:36 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::b0) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.5 via Frontend
 Transport; Wed, 14 Sep 2022 06:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 06:11:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 01:11:31 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
Date:   Wed, 14 Sep 2022 14:11:02 +0800
Message-ID: <20220914061105.1982477-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220914061105.1982477-1-li.meng@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1775d398-1024-47e5-be78-08da9617fab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXqolI+COij8eQLWmgSOnMEJpW675Qp6biVOBu7bzg2CY1JsgQ4oxe9dasdUvrn8+s3FzV7GV6U/GmaWzqdV7zVDJaYunU3k7LH72wJDIqEP1BwfCbtcegPoxSzZ9J41iT4MicdUA6iL6bK2DShEXQP0oksUBGCG4gAWuk3AcAGv8dY24PphtiT4qNW//1dAbNhkBaDtSkmNSLzzVRKTkwQrhDOb83I68ZXljsrSRySKGbq0Ezv107fR7LO582szxcknI1YEkcJTP8sJ8EmMfkhecwa5UXsDQb3FU7kyi21334LFSWYHBcyv2fb0rJBMkGXtx6DKfN19FloguMNe2AaSUrHRca7NWAk4zn6NLSZVdj0q7ExvHh1y37huz0FHIQSYPE/lArFKf5lnNfXEuz5C9h4/ex7FHNrm/M4YlFj9ng1nG1MpiZA7ESS2PO2cLMZz2FYceFnrC+/i8OTLifGbBWgg5yq9aqUDTTVdh8d/iYwKMvYV4e+Ne5msv5CKJWGAu+Y7G0XIcymHgMs3EDNvbER/VD9Nr/zdxdDXtD9xXxCsPi7RvUY9kJqMQnfux/tu7A6pCBFRhj146ftIa4V6y1ecJWIIWbHTvj77uTNdLL9/xTXvHcWtnivKYM4xMXSAvHONMMgrdL//BgCWyY7C0uzndwSxcNwwcwrUlJFPJl0guABByflvEqX5SJChy3lSklErhVrCIjLmHbrWC0m/l3G5IUMrf4/nJqTlOMMonA3T6iBBYgz6G6/EByuKrOSjB7k/5UbJDX6wlFBBYVOdHV0biG2YhivkwrxuWFVWeJlHAS6oGpumJOXpuRq4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(2906002)(356005)(82310400005)(40480700001)(81166007)(16526019)(86362001)(41300700001)(316002)(1076003)(186003)(47076005)(8936002)(110136005)(2616005)(70586007)(26005)(336012)(5660300002)(426003)(82740400003)(54906003)(83380400001)(36860700001)(478600001)(36756003)(7696005)(4326008)(40460700003)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:11:35.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1775d398-1024-47e5-be78-08da9617fab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify amd-pstate-ut.sh to basic.sh.
The purpose of this modification is to facilitate the subsequent
addition of gitsource, tbench and other tests.
Then you can specify test case in kselftest/amd-pstate, for example:
sudo ./run.sh -c basic, this command only test basic kernel funcitions.
The detail please run the below script.
./run.sh --help

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |   3 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 -------
 tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
 tools/testing/selftests/amd-pstate/run.sh     | 142 ++++++++++++++++++
 4 files changed, 182 insertions(+), 57 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index 199867f44b32..6f4c7b01e3bb 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -4,6 +4,7 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := amd-pstate-ut.sh
+TEST_PROGS := run.sh
+TEST_FILES := basic.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
deleted file mode 100755
index f8e82d91ffcf..000000000000
--- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# amd-pstate-ut is a test module for testing the amd-pstate driver.
-# It can only run on x86 architectures and current cpufreq driver
-# must be amd-pstate.
-# (1) It can help all users to verify their processor support
-# (SBIOS/Firmware or Hardware).
-# (2) Kernel can have a basic function test to avoid the kernel
-# regression during the update.
-# (3) We can introduce more functional or performance tests to align
-# the result together, it will benefit power and performance scale optimization.
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# amd-pstate-ut only run on x86/x86_64 AMD systems.
-ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
-VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
-
-if ! echo "$ARCH" | grep -q x86; then
-	echo "$0 # Skipped: Test can only run on x86 architectures."
-	exit $ksft_skip
-fi
-
-if ! echo "$VENDOR" | grep -iq amd; then
-	echo "$0 # Skipped: Test can only run on AMD CPU."
-	echo "$0 # Current cpu vendor is $VENDOR."
-	exit $ksft_skip
-fi
-
-scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
-if [ "$scaling_driver" != "amd-pstate" ]; then
-	echo "$0 # Skipped: Test can only run on amd-pstate driver."
-	echo "$0 # Please set X86_AMD_PSTATE enabled."
-	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
-	exit $ksft_skip
-fi
-
-msg="Skip all tests:"
-if [ ! -w /dev ]; then
-    echo $msg please run this as root >&2
-    exit $ksft_skip
-fi
-
-if ! /sbin/modprobe -q -n amd-pstate-ut; then
-	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
-	exit $ksft_skip
-fi
-if /sbin/modprobe -q amd-pstate-ut; then
-	/sbin/modprobe -q -r amd-pstate-ut
-	echo "amd-pstate-ut: ok"
-else
-	echo "amd-pstate-ut: [FAIL]"
-	exit 1
-fi
diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
new file mode 100755
index 000000000000..e4c43193e4a3
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/basic.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# amd-pstate-ut is a test module for testing the amd-pstate driver.
+# It can only run on x86 architectures and current cpufreq driver
+# must be amd-pstate.
+# (1) It can help all users to verify their processor support
+# (SBIOS/Firmware or Hardware).
+# (2) Kernel can have a basic function test to avoid the kernel
+# regression during the update.
+# (3) We can introduce more functional or performance tests to align
+# the result together, it will benefit power and performance scale optimization.
+
+# protect against multiple inclusion
+if [ $FILE_BASIC ]; then
+	return 0
+else
+	FILE_BASIC=DONE
+fi
+
+amd_pstate_basic()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running AMD P-state ut                ***"
+	printf "\n---------------------------------------------\n"
+
+	if ! /sbin/modprobe -q -n amd-pstate-ut; then
+		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
+		exit $ksft_skip
+	fi
+	if /sbin/modprobe -q amd-pstate-ut; then
+		/sbin/modprobe -q -r amd-pstate-ut
+		echo "amd-pstate-basic: ok"
+	else
+		echo "amd-pstate-basic: [FAIL]"
+		exit 1
+	fi
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
new file mode 100755
index 000000000000..715e9d01484f
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/run.sh
@@ -0,0 +1,142 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# protect against multiple inclusion
+if [ $FILE_MAIN ]; then
+	return 0
+else
+	FILE_MAIN=DONE
+fi
+
+source basic.sh
+
+# amd-pstate-ut only run on x86/x86_64 AMD systems.
+ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
+VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
+
+FUNC=all
+OUTFILE=selftest
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# All amd-pstate tests
+amd_pstate_all()
+{
+	printf "\n=============================================\n"
+	printf "***** Running AMD P-state Sanity Tests  *****\n"
+	printf "=============================================\n\n"
+
+	# unit test for amd-pstate kernel driver
+	amd_pstate_basic
+}
+
+helpme()
+{
+	printf "Usage: $0 [OPTION...]
+	[-h <help>]
+	[-o <output-file-for-dump>]
+	[-c <all: All testing,
+	     basic: Basic testing.>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ho:c: arg
+	do
+		case $arg in
+			h) # --help
+				helpme
+				;;
+
+			c) # --func_type (Function to perform: basic (default: all))
+				FUNC=$OPTARG
+				;;
+
+			o) # --output-file (Output file to store dumps)
+				OUTFILE=$OPTARG
+				;;
+
+			*)
+				helpme
+				;;
+		esac
+	done
+}
+
+prerequisite()
+{
+	if ! echo "$ARCH" | grep -q x86; then
+		echo "$0 # Skipped: Test can only run on x86 architectures."
+		exit $ksft_skip
+	fi
+
+	if ! echo "$VENDOR" | grep -iq amd; then
+		echo "$0 # Skipped: Test can only run on AMD CPU."
+		echo "$0 # Current cpu vendor is $VENDOR."
+		exit $ksft_skip
+	fi
+
+	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+	if [ "$scaling_driver" != "amd-pstate" ]; then
+		echo "$0 # Skipped: Test can only run on amd-pstate driver."
+		echo "$0 # Please set X86_AMD_PSTATE enabled."
+		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+		exit $ksft_skip
+	fi
+
+	msg="Skip all tests:"
+	if [ ! -w /dev ]; then
+		echo $msg please run this as root >&2
+		exit $ksft_skip
+	fi
+}
+
+do_test()
+{
+	case "$FUNC" in
+		"all")
+			amd_pstate_all
+			;;
+
+		"basic")
+			amd_pstate_basic
+			;;
+
+		*)
+			echo "Invalid [-f] function type"
+			helpme
+			;;
+	esac
+}
+
+# clear dumps
+pre_clear_dumps()
+{
+	case "$FUNC" in
+		"all")
+			rm -rf $OUTFILE*
+			;;
+
+		*)
+			;;
+	esac
+}
+
+post_clear_dumps()
+{
+	rm -rf $OUTFILE.log
+}
+
+# Parse arguments
+parse_arguments $@
+
+# Make sure all requirements are met
+prerequisite
+
+# Run requested functions
+pre_clear_dumps
+do_test | tee -a $OUTFILE.log
+post_clear_dumps
-- 
2.34.1

