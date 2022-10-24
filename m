Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2536097D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJXBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJXBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:34:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEFEE60;
        Sun, 23 Oct 2022 18:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2XREAEIqaKTbCpPkb0p57yfzO2bTTFupHINjWWE/MspIiSjxSQbjAFQ1ftz/WTfpRNI3M1/vipXRvPYWUptsqf+Vai5YOB1LxOGxMhgtITwIOksDaB3k/XEdykERhCnHe2UggRspsOpDp5SiIqmN87i0TiQeKO1TiirCVqYWWsaEgVN3qAQ44k9sBsBM+V5yoiTGBmR96XdchdTXZDIdWC85iokOc9FVrRHnyxNE1xCz4mTye2s7G6xfxf85tHI3tm5m88DiQp83swisCppWboM3lYJlmwj8uT6GIVJ9s2NgUdxw/6bI86D5xnTTne750WucL+NRIw5KzjHPTqjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAPX8Al+yBfiX0TA9FcraQfzdehPHAgrOzjWPKbfqU8=;
 b=Wh+U90xQz6ykJoKiwZrfSDCe3bjYPvB61Pj5UPfDznXX6xzUinfzVsV688xAu3pwYnrx5JxrcEaHD5LUPTuBwtSY5qDK0MK/JGzE5z0Ia7nLMat4Vgg2Qcfpv2taB5LPZRzEuPMAN3sL9l9qiBckI0gXxqnxLn8J/p1Ozkhui8BzW5YyjJe9XawW7W0oYjJ1WA5d6Wv4juA8dKbHAMXVV0I8R/ea/xvnVJ/HlwkJIfxHCGrdXel0sZ2h9GyL263rUJHJmXmvwUQxk/BnHiN3PNDR1MPZWCPmi7E722a8Jwl37/AZ7d4guxlho9G+u+aSJWkGEcPVHCw4C1l3vYKi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAPX8Al+yBfiX0TA9FcraQfzdehPHAgrOzjWPKbfqU8=;
 b=C4mJ1Sg3u/gM+cHHOuSYdnU2H+9gv77p/QWZX8lMbuTweaE4Qe1XUeXsJhlbp7Nrx8YIrbMxnAMbvTlNQGcsTlCtnIJpEUr3hEAVaY7zke16imkIH2s2XvtissMtn8zZ7V5r4OIA+pBFuJfBCToamygZ0i0RnaP9tyFc/ovkZwY=
Received: from MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21) by
 IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 01:34:23 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::1a) by MW2PR16CA0008.outlook.office365.com
 (2603:10b6:907::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Mon, 24 Oct 2022 01:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 01:34:22 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 23 Oct
 2022 20:34:18 -0500
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
Subject: [PATCH V4 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
Date:   Mon, 24 Oct 2022 09:33:53 +0800
Message-ID: <20221024013356.1639489-2-li.meng@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ccfe36-07c2-4231-a8ec-08dab55fe128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGB3xy0g2oQK/a7Oz35/+NCiCl/n/sGOdCOXRMN9zfM+C6EbpuJDD07hDJsS6u85T95BTV0eDulci/qHZK8NJbfdYUou82IGGTLmWs44wgGIMW/LHa/vGrajZ/1mDHUfjjx00sz6zbg8wHuJiQse6/iffFz2K0vPW0D0usji+rsToAHNovHuerY2w+fjIfbJfc2LakNB1Gqk5ofdzmvZdddC2Lqg/IaHlN/kqPJszLQpt/vB54jVkJy2utWrBIecAmveZXR9hdATQiT12t3Ndy+JTucKNXxm8MCPs1FYebOTUY682Kc/9/z1MsjshInWU0al/EQzAIcW0avEmbOqEfM1q9vBnJxsDWjIsgdzXJSpBS0CJv1ififM19sf2VsOaTiUSyRiqudv595TP3PtnNoSFsbZJFO0/NaKVEYa70ItnwJFrzLobKQ8ulLV1J1rWbN0hzdXpeda+Ql3+eQLxMPgwLESXgXndPMhUSsqf5UWND5sf/x9ao+sP8YzCZkNMLP+CnF8YcPl26dOk/NvDGPdmGP9XwUNwX11JVdeMQlD+g22WBifLdDpatByTqu33/4tIdKE9w1FLlhX/V1Mtuaw/wL3rU5Lqgg79c8obXJuWXr11s1bPb9nk7cDB09bUk9gzmYXnZJBSVK9I8mBFdANsYGTT6CSj/XQmkknUonpQ1kkT5serZ0DxqoexLK9q5pnH0MO3eY4HoBWCIdCHqVQrxcfcXSqgPoz+fXAZWpK8AZ9YJPTYqUXbjiYV+SjN6l7XX1LFaCQMDxKSiGUEf0NoQlaGBKTezQbkp2u2xbu3Db4LGSYupRyvsrN+a6/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(316002)(426003)(54906003)(47076005)(186003)(86362001)(1076003)(83380400001)(356005)(2616005)(36860700001)(70586007)(16526019)(7696005)(82740400003)(2906002)(5660300002)(8676002)(41300700001)(81166007)(4326008)(8936002)(82310400005)(6666004)(478600001)(336012)(26005)(70206006)(40460700003)(110136005)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 01:34:22.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ccfe36-07c2-4231-a8ec-08dab55fe128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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
Acked-by: Huang Rui <ray.huang@amd.com>
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

