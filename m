Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6916D7F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbjDEOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbjDEOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:34:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C84E61
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:34:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335EVBOD012704;
        Wed, 5 Apr 2023 14:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ivelhx9ng1tSdZPRE/IPDRDCHXDReZ4l2WYrsyrBS+0=;
 b=aHhe3Fo2JAvpifGCO+Tfw1mhyFasHC+24W/DOR+1wkEC2SKaACOkZks8vJvf+4SN62eX
 jj3kojPHxFuT2v+LcFkbu6v1VigboUWPzy5gcmVAUKmFKKUIFMr4D4A0SIz86G1VOIIZ
 /0K8FVsRpfNIgKwZYoowO7ja3N8Pwuz5iCScPwwKIUD6faE37w92+XMh2qBzvaBttM9j
 wEpb3Xs1Hf3QI1h8vMqacBDP/VlqLgnEDBzZyWFxl8pO+EnDhDcxKODaskLjVcQV9QCc
 kOVwltrqAi9CEO2Aifb8z54DexQNrcGOBG5PDQhmJQcViYoxqDAG15sQjrjRMuA6G+Rg lg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps7n3dvqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:34:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33548rpQ019661;
        Wed, 5 Apr 2023 14:34:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ppc872jh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:34:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EYqQf30802530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:34:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7F82004D;
        Wed,  5 Apr 2023 14:34:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F692004E;
        Wed,  5 Apr 2023 14:34:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 14:34:52 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc/stat: remove arch_idle_time()
Date:   Wed,  5 Apr 2023 16:34:52 +0200
Message-Id: <20230405143452.2677172-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HQml2TZzgBdUV4LrJ0jw7H3gt-8QBLUU
X-Proofpoint-ORIG-GUID: HQml2TZzgBdUV4LrJ0jw7H3gt-8QBLUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=979 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050132
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last (only) architecture specific arch_idle_time() implementation was
removed with commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time()
and corresponding code").

Therefore remove the now dead code in fs/proc/stat.c as well.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 fs/proc/stat.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4fb8729a68d4..da60956b2915 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -22,30 +22,6 @@
 #define arch_irq_stat() 0
 #endif
 
-#ifdef arch_idle_time
-
-u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 idle;
-
-	idle = kcs->cpustat[CPUTIME_IDLE];
-	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
-		idle += arch_idle_time(cpu);
-	return idle;
-}
-
-static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 iowait;
-
-	iowait = kcs->cpustat[CPUTIME_IOWAIT];
-	if (cpu_online(cpu) && nr_iowait_cpu(cpu))
-		iowait += arch_idle_time(cpu);
-	return iowait;
-}
-
-#else
-
 u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
@@ -78,8 +54,6 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 	return iowait;
 }
 
-#endif
-
 static void show_irq_gap(struct seq_file *p, unsigned int gap)
 {
 	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
-- 
2.37.2

