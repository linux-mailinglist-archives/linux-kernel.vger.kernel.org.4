Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484466DC6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDJML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDJML0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:11:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE081B9;
        Mon, 10 Apr 2023 05:11:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AAWg4Q002478;
        Mon, 10 Apr 2023 12:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=oCX33MHJdVwOcqkM9x30iXp+//dYE8FJsaDB4GyktJM=;
 b=pB7yvr+47tys5sMNhweB7ggoJT62VjE5Xek1+x+hPfOvVcfzwehDbuF6AkiZONlq0YZR
 N22RBcMh4RpkgeEaKITffC11tzYLjwwTp/1ny28KlTYsd7RiH1QqsGRV1uDrJy0VBQjs
 jSzQpwRfowuHR1dN8ZORCZsxvHj0+HQAO4FVyvuerNqvqOqpDBvA3gAfqe+wAfkS9hok
 OqnKe3f0y8CG2DPVAgDs7FXcKlfxS/QA3dc7DRsYsJXmwJpNYdZqCDj+RISQX8kWgVsD
 aL+CiKDl2FBbdfynVHty9fC9UwFzUAgfoaJluHm0HEVYwIIL9+Ja4yZ7UGjm53g0DYhs rQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2txjm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 12:11:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33A3v8aD003252;
        Mon, 10 Apr 2023 12:11:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m191s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 12:11:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33ACBEqZ24314374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 12:11:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAE6520043;
        Mon, 10 Apr 2023 12:11:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1052F20040;
        Mon, 10 Apr 2023 12:11:13 +0000 (GMT)
Received: from li-a1f1b24c-1ef0-11b2-a85c-b2994f3f6269.in.ibm.com (unknown [9.109.248.124])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Apr 2023 12:11:12 +0000 (GMT)
From:   Korrapati Likhitha <likhitha@linux.ibm.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricklind@linux.vnet.ibm.com, latha@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com,
        Likhitha Korrapati <likhitha@linux.ibm.com>,
        Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Subject: [PATCH v2] cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation.
Date:   Mon, 10 Apr 2023 17:40:54 +0530
Message-Id: <20230410121054.61622-1-likhitha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CZ-hDHT6yL7JfOG4XsZ-Hx98efbR4ymQ
X-Proofpoint-ORIG-GUID: CZ-hDHT6yL7JfOG4XsZ-Hx98efbR4ymQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100103
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Likhitha Korrapati <likhitha@linux.ibm.com>

For both the d and e options in 'cpupower idle_set' command, an
atoi() conversion is done without checking if the input argument
is all numeric. So, an atoi conversion is done on any character
provided as input and the CPU idle_set operation continues with
that integer value, which may not be what is intended or entirely
correct.

The output of cpuidle-set before patch is as follows:

[root@xxx cpupower]# cpupower idle-set -e 1$
Idlestate 1 enabled on CPU 0
[snip]
Idlestate 1 enabled on CPU 47

[root@xxx cpupower]# cpupower idle-set -e 11
Idlestate 11 not available on CPU 0
[snip]
Idlestate 11 not available on CPU 47

[root@xxx cpupower]# cpupower idle-set -d 12
Idlestate 12 not available on CPU 0
[snip]
Idlestate 12 not available on CPU 47

[root@xxx cpupower]# cpupower idle-set -d qw
Idlestate 0 disabled on CPU 0
[snip]
Idlestate 0 disabled on CPU 47

This patch adds a check for both d and e options in cpuidle-set.c
to see that the idle_set value is all numeric before doing a
string-to-int conversion.

The output of cpuidle-set after the patch is as below:

[root@xxx cpupower]# ./cpupower idle-set -e 1$
Bad idle_set value: 1$. Integer expected

[root@xxx cpupower]# ./cpupower idle-set -e 11
Idlestate 11 not available on CPU 0
[snip]
Idlestate 11 not available on CPU 47

[root@xxx cpupower]# ./cpupower idle-set -d 12
Idlestate 12 not available on CPU 0
[snip]
Idlestate 12 not available on CPU 47

[root@xxx cpupower]# ./cpupower idle-set -d qw
Bad idle_set value: qw. Integer expected

Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
Reported-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Reviewed-by: Rick Lindsley <ricklind@linux.vnet.ibm.com>
---

** changes since v1 [1] **

- Addressed reviewed comments from v1.
- Slightly reworded the commit for clarity.

[1] https://lore.kernel.org/all/20210105122452.8687-1-latha@linux.vnet.ibm.com/

 tools/power/cpupower/utils/cpuidle-set.c     | 25 ++++++++++++++++----
 tools/power/cpupower/utils/helpers/helpers.h |  8 +++++++
 tools/power/cpupower/utils/helpers/misc.c    | 17 +++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 46158928f9ad..1bfe16d27c2d 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -47,7 +47,12 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			idlestate = atoi(optarg);
+			if (is_stringnumeric(optarg))
+				idlestate = atoi(optarg);
+			else {
+				printf(_("Bad idle_set value: %s. Integer expected\n"), optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'e':
 			if (param) {
@@ -56,7 +61,12 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			idlestate = atoi(optarg);
+			if (is_stringnumeric(optarg))
+				idlestate = atoi(optarg);
+			else {
+				printf(_("Bad idle_set value: %s. Integer expected\n"), optarg);
+				exit(EXIT_FAILURE);
+			}
 			break;
 		case 'D':
 			if (param) {
@@ -65,9 +75,14 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			latency = strtoull(optarg, &endptr, 10);
-			if (*endptr != '\0') {
-				printf(_("Bad latency value: %s\n"), optarg);
+			if (is_stringnumeric(optarg)) {
+				latency = strtoull(optarg, &endptr, 10);
+				if (*endptr != '\0') {
+					printf(_("Bad latency value: %s\n"), optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				printf(_("Bad idle_set value: %s. Integer expected\n"), optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 96e4bede078b..9977f0773986 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -208,3 +208,11 @@ void print_offline_cpus(void);
 void print_speed(unsigned long speed, int no_rounding);
 
 #endif /* __CPUPOWERUTILS_HELPERS__ */
+
+/*
+ * CPU idle-set
+ */
+int is_stringnumeric(char *arg);
+/*
+ * CPU idle-set
+ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..8ec47c3c138e 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -4,6 +4,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -204,3 +205,19 @@ void print_speed(unsigned long speed, int no_rounding)
 		}
 	}
 }
+
+/*
+ * is_stringnumeric
+ *
+ * To check if the given string has all numericals
+ */
+int is_stringnumeric(char *arg)
+{
+	size_t i = 0;
+
+	for (i = 0; arg[i] ; i++) {
+		if (!isdigit(arg[i]))
+			return 0;
+	}
+	return 1;
+}
-- 
2.31.1

