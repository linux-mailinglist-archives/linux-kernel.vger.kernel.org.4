Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58808631987
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKUFiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKUFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:38:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814611454;
        Sun, 20 Nov 2022 21:37:59 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL5NuJX016197;
        Mon, 21 Nov 2022 05:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=72/liU1/LkGrovXaDJnDD0Z0eL3eWidWNtd7AV+E1xQ=;
 b=O7FfB+pB4Jetnq4u0HRLD+OmDhb7yG/jQZCl4TSqnRKXMRz3i+PSXvpT5PDMVQ2KWw2l
 ygVcIGnwQco1QCE2Z8FMaDsp3ImJcsedUUDDWY9dmPyRJExliGb2ZxgL8p+KIRhtk8Q3
 URQuX1lWJjADG1JvNeDCVPFYh1xWqGnzpdOj9/i5KIOkFD5NNiM398vSdzyEzk/5CEX6
 4BOS961Mevp4lvIjvbFgTAQfXSjMJXjL+TI5jlnczMS75ykGgAg6WW5i0QF9VA7P1dYt
 l1aX2SxAf89W+oY0QO9DmK8umyneK9GEdEinl1DX/NumxWrfJnRNdcF/3MPCN/GN0Q3Y Vw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8xsymum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 05:37:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AL5aQ01005834;
        Mon, 21 Nov 2022 05:37:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3kxps91js6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 05:37:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AL5bdMF51118516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 05:37:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB4BC4204B;
        Mon, 21 Nov 2022 05:37:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2403042041;
        Mon, 21 Nov 2022 05:37:38 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.38.80])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 05:37:37 +0000 (GMT)
From:   Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah@kernel.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
Subject: [PATCH] tools/cpupower: Choose first online CPU to display details
Date:   Mon, 21 Nov 2022 11:05:30 +0530
Message-Id: <20221121053530.103600-1-skb99@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7kN2OiL8TsWI6sfNYQ9uDErLoXKmEIz9
X-Proofpoint-ORIG-GUID: 7kN2OiL8TsWI6sfNYQ9uDErLoXKmEIz9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default output of cpupower info utils shows unexpected output
when CPU 0 is disabled.

Considering a case where CPU 0 is disabled, output of cpupower idle-info:

Before change:
cpupower idle-info
CPUidle driver: pseries_idle
CPUidle governor: menu
analyzing CPU 0:
 *is offline

After change:
./cpupower idle-info
CPUidle driver: pseries_idle
CPUidle governor: menu
analyzing CPU 0:
 *is offline
analyzing CPU 1:

Number of idle states: 2
Available idle states: snooze Shared Cede
snooze:
Flags/Description: snooze
Latency: 0
Usage: 919
Duration: 68227
Shared Cede:
Flags/Description: Shared Cede
Latency: 10
Usage: 99324
Duration: 67871518243

If -c option is not passed, CPU 0 was chosen as the default chosen CPU to
display details. However when CPU 0 is offline, it results in showing
unexpected output. This commit chooses the first online CPU
instead of CPU 0, hence keeping the output more relevant in all cases.

Somewhat similar logic to set all CPUs in default case is present in
cpufreq-set.c, cpuidle-set.c, cpupower-set.c. But here we have added
logic to stop at first online CPU.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpufreq-info.c  | 15 ++++++++++++---
 tools/power/cpupower/utils/cpuidle-info.c  | 15 ++++++++++++---
 tools/power/cpupower/utils/cpupower-info.c | 16 +++++++++++++---
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 0646f615fe2d..4001a5934494 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -508,6 +508,7 @@ int cmd_freq_info(int argc, char **argv)
 	unsigned int cpu = 0;
 	unsigned int human = 0;
 	int output_param = 0;
+	bool is_default = false;
 
 	do {
 		ret = getopt_long(argc, argv, "oefwldpgrasmybnc", info_opts,
@@ -572,9 +573,11 @@ int cmd_freq_info(int argc, char **argv)
 
 	ret = 0;
 
-	/* Default is: show output of CPU 0 only */
-	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+	/* Default is: set all CPUs */
+	if (bitmask_isallclear(cpus_chosen)) {
+		bitmask_setall(cpus_chosen);
+		is_default = true;
+	}
 
 	switch (output_param) {
 	case -1:
@@ -646,6 +649,12 @@ int cmd_freq_info(int argc, char **argv)
 		}
 		if (ret)
 			return ret;
+
+		if (is_default) {
+			bitmask_clearall(cpus_chosen);
+			bitmask_setbit(cpus_chosen, cpu);
+			break;
+		}
 	}
 	return ret;
 }
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index f2b202c5552a..a0e2f5b98537 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -139,6 +139,7 @@ int cmd_idle_info(int argc, char **argv)
 	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1, output_param = 0, verbose = 1;
 	unsigned int cpu = 0;
+	bool is_default = false;
 
 	do {
 		ret = getopt_long(argc, argv, "os", info_opts, NULL);
@@ -176,9 +177,11 @@ int cmd_idle_info(int argc, char **argv)
 		cpuidle_exit(EXIT_FAILURE);
 	}
 
-	/* Default is: show output of CPU 0 only */
-	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+	/* Default is: set all CPUs */
+	if (bitmask_isallclear(cpus_chosen)) {
+		bitmask_setall(cpus_chosen);
+		is_default = true;
+	}
 
 	if (output_param == 0)
 		cpuidle_general_output();
@@ -208,6 +211,12 @@ int cmd_idle_info(int argc, char **argv)
 			break;
 		}
 		printf("\n");
+
+		if (is_default) {
+			bitmask_clearall(cpus_chosen);
+			bitmask_setbit(cpus_chosen, cpu);
+			break;
+		}
 	}
 	return EXIT_SUCCESS;
 }
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 06345b543786..995bc20a8c7d 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -40,6 +40,7 @@ int cmd_info(int argc, char **argv)
 		int params;
 	} params = {};
 	int ret = 0;
+	bool is_default = false;
 
 	ret = uname(&uts);
 	if (!ret && (!strcmp(uts.machine, "ppc64le") ||
@@ -67,9 +68,12 @@ int cmd_info(int argc, char **argv)
 	if (!params.params)
 		params.params = 0x7;
 
-	/* Default is: show output of CPU 0 only */
-	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+	/* Default is: set all CPUs */
+	if (bitmask_isallclear(cpus_chosen)) {
+		bitmask_setall(cpus_chosen);
+		is_default = true;
+	}
+
 
 	/* Add more per cpu options here */
 	if (!params.perf_bias)
@@ -109,6 +113,12 @@ int cmd_info(int argc, char **argv)
 			} else
 				printf(_("perf-bias: %d\n"), ret);
 		}
+
+		if (is_default) {
+			bitmask_clearall(cpus_chosen);
+			bitmask_setbit(cpus_chosen, cpu);
+			break;
+		}
 	}
 	return 0;
 }
-- 
2.31.1

