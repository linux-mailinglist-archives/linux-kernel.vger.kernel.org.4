Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470C6BC7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCPHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCPHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:50:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103DCB04AC;
        Thu, 16 Mar 2023 00:49:58 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G6AnHU022820;
        Thu, 16 Mar 2023 07:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GIuV8Btv07Au0dPj84B54f9G6+hiN/I2bv2hb55/imE=;
 b=XTNYsEGUaSRcKijRR4T02g96NS3+BC3yAXtBjpkbituEbNayV8aLUUXF6wtfYeuUvfNJ
 LD3yxPZ3jxvy2EU7jlNKNRwHvn8cqXNhFcj2zKAA/2TVD3yQAofvZ5EAbFCXLTrfcr8l
 dX/u4YDolywDczJ0aDC3dGhkasAQU5Y5NDkuJsKQgL/oouRbhQzkTtZvUx0L0+0Dw4Nn
 o3EH+gGhsO6Zo9SYUwMgbw6K98rRDEQdymDimgKGat8DPxrhP8reTfORCs/8tmuq8/p6
 Bc5z2VzWNdk8tkyQpuxRp4t30xyYFOl6I8v4nbnMhDBKHXjVLPheqeDuCGuW0+qgN/qP Ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbqws1j7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 07:49:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32G1cAuF029743;
        Thu, 16 Mar 2023 07:49:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pbskt0bkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 07:49:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32G7nnnB63963392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 07:49:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37F5F20043;
        Thu, 16 Mar 2023 07:49:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA17220040;
        Thu, 16 Mar 2023 07:49:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Mar 2023 07:49:48 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf stat: Suppress warning when using cpum_cf events on s390
Date:   Thu, 16 Mar 2023 08:49:46 +0100
Message-Id: <20230316074946.41110-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7HP7C5K07vJ95bFYkv73NkMu0cPaI9cE
X-Proofpoint-ORIG-GUID: 7HP7C5K07vJ95bFYkv73NkMu0cPaI9cE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running command perf stat -vv -e cpu_cycles -C0 -- true
displays this warning:

 Attempting to add event pmu 'cpum_cf' with 'cpu_cycles,'
 that may result in non-fatal errors

Make the PMU cpum_cf selectable and avoid this warning.
While at it also fix this warning for PMUs pai_crypto and pai_ext.

Output before:

 #  ./perf stat -vv -e cpu_cycles -C0 -- true
 Using CPUID IBM,3931,704,A01,3.7,002f
 Attempting to add event pmu 'cpum_cf' with 'cpu_cycles,'
   that may result in non-fatal errors
 After aliases, add event pmu 'cpum_cf' with 'event,'
   that may result in non-fatal errors
   cpu_cycles -> cpum_cf/event=0/
 Control descriptor is not initialized
 ------------------------------------------------------------
 perf_event_attr:
  type                             10
  size                             128
  config                           0x1001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
 ------------------------------------------------------------
 sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
 cpu_cycles: 0: 290434 2479172 2479172:
 cpu_cycles: 290434 2479172 2479172

 Performance counter stats for 'CPU(s) 0':

           290,434      cpu_cycles

       0.002465617 seconds time elapsed
 #

Now the warning "Attempting to add event pmu 'cpum_cf' ..."
does not show up anymore.

Output after:
 # ./perf stat -vv -e cpu_cycles -C0 -- true
 Using CPUID IBM,3931,704,A01,3.7,002f
 After aliases, add event pmu 'cpum_cf' with 'event,'
   that may result in non-fatal errors
   cpu_cycles -> cpum_cf/event=0/
 Control descriptor is not initialized
 ....

 Performance counter stats for 'CPU(s) 0':

           357,023      cpu_cycles

       0.002454995 seconds time elapsed
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/util/Build |  1 +
 tools/perf/arch/s390/util/pmu.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/perf/arch/s390/util/pmu.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index db6884086997..fa66f15a14ec 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -6,5 +6,6 @@ perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-y += machine.o
+perf-y += pmu.o
 
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
new file mode 100644
index 000000000000..11f03f32e3fd
--- /dev/null
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright IBM Corp. 2023
+ * Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#include <string.h>
+
+#include "../../../util/pmu.h"
+
+#define	S390_PMUPAI_CRYPTO	"pai_crypto"
+#define	S390_PMUPAI_EXT		"pai_ext"
+#define	S390_PMUCPUM_CF		"cpum_cf"
+
+struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu)
+{
+	if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
+	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
+	    !strcmp(pmu->name, S390_PMUCPUM_CF))
+		pmu->selectable = true;
+	return NULL;
+}
-- 
2.39.1

