Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF963525F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiKWIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiKWIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:23:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B2B112C;
        Wed, 23 Nov 2022 00:23:11 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AN63fUr039672;
        Wed, 23 Nov 2022 08:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=L7+0tXgmMj2DY933i5aUoUBMd+L6UfKtSJTLqByEi7k=;
 b=qNxunI1i6phpqMUZ4feK8m1u6rfUoVtR09RWiYKxc2bn9sBqh73KxuQiSpxmgRgv/tWz
 IQXXwcvMleYr9wqpryOzb6A1XTQ7DxE88FuOpNc1UChy3nWYOpNw4lM2smJ05eegqJP/
 Xo+wHWcyMLCegRkHqS+bmkWNQrENIZSyLaK8E8SjVWRX/WeyiCJRBCfcBio/4nIAEkBA
 O341KRaIaRtMdvHHIHURwiaWgmIsIWS4k7SdV8xdMeXmiUfJI2TCmyQVvP1YTFvhc2oA
 FPlP5LYvOKl5n9Z0PNInBUo4wVjRQlKRJMhsegvrEgxC/qYVKbZb7784GAYgM7Qh+N+F Cg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10ffee7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 08:23:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AN8L70l022914;
        Wed, 23 Nov 2022 08:23:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kxps8wb3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 08:23:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AN8N0cn65143184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 08:23:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30A9E11C050;
        Wed, 23 Nov 2022 08:23:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B019B11C04A;
        Wed, 23 Nov 2022 08:22:58 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 08:22:58 +0000 (GMT)
From:   Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, shuah@kernel.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
Subject: [PATCH v2] tools/cpupower: Choose base_cpu to display default cpupower details
Date:   Wed, 23 Nov 2022 13:52:08 +0530
Message-Id: <20221123082208.226224-1-skb99@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gn8x5E--h1bZ0QQWvqkp8INckXh5oySE
X-Proofpoint-GUID: Gn8x5E--h1bZ0QQWvqkp8INckXh5oySE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_03,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230060
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
analyzing CPU 50:

Number of idle states: 2
Available idle states: snooze CEDE
snooze:
Flags/Description: snooze
Latency: 0
Usage: 101748
Duration: 2724058
CEDE:
Flags/Description: CEDE
Latency: 12
Usage: 270004
Duration: 283019526849

If -c option is not passed, CPU 0 was chosen as the default chosen CPU to
display details. However when CPU 0 is offline, it results in showing
unexpected output. This commit chooses the base_cpu
instead of CPU 0, hence keeping the output more relevant in all cases.
The base_cpu is the number of CPU on which the calling thread is
currently executing.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpufreq-info.c  | 4 ++--
 tools/power/cpupower/utils/cpuidle-info.c  | 4 ++--
 tools/power/cpupower/utils/cpupower-info.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 0646f615fe2d..c96b77365c63 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -572,9 +572,9 @@ int cmd_freq_info(int argc, char **argv)
 
 	ret = 0;
 
-	/* Default is: show output of CPU 0 only */
+	/* Default is: show output of base_cpu only */
 	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+		bitmask_setbit(cpus_chosen, base_cpu);
 
 	switch (output_param) {
 	case -1:
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index f2b202c5552a..44126a87fa7a 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -176,9 +176,9 @@ int cmd_idle_info(int argc, char **argv)
 		cpuidle_exit(EXIT_FAILURE);
 	}
 
-	/* Default is: show output of CPU 0 only */
+	/* Default is: show output of base_cpu only */
 	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+		bitmask_setbit(cpus_chosen, base_cpu);
 
 	if (output_param == 0)
 		cpuidle_general_output();
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 06345b543786..18fd7751f509 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -67,9 +67,9 @@ int cmd_info(int argc, char **argv)
 	if (!params.params)
 		params.params = 0x7;
 
-	/* Default is: show output of CPU 0 only */
+	/* Default is: show output of base_cpu only */
 	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+		bitmask_setbit(cpus_chosen, base_cpu);
 
 	/* Add more per cpu options here */
 	if (!params.perf_bias)
-- 
2.31.1

