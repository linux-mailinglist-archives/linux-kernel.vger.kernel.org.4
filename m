Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40D694625
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBMMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBMMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:45:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DBE9022
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:45:29 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DCLVlW014173;
        Mon, 13 Feb 2023 12:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jYKhdPovinsuTwI36nj2p9xMn1IGveI7hgrIr74uhQ8=;
 b=ncKdmJ2gnt8NcEFnZp6vI/LGpe13dOLfSdHrZ2d2zLlp/cJpdZW3e9OHRV4lIrdQJF4T
 zgNXt3sc/ADRHfzhi6belRoVt0vysx8EgYUIn/CcMyFq7BuMg77yY58RQrKk78Uhi1yQ
 fGsYplW75y7XlZcx6JKXYJ50dFgp62pZwyu3HnyZzgA3JDTHTzfqJBeXj1R6RK4CKggI
 9F+cnJq/jkOtLtZzWRkPAjFTbS/icBRGvI0QMawVsIMv0r+k59VjmKIX5SL5nhZOBAyR
 Pntqndx1fg8HZBIpZYV/1EOa/tHVpFwY6sgbJBgqxxo88YAcXGxJFprnSG3zQJ2ekIal fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqn518h4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 12:45:19 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DCUcWQ018361;
        Mon, 13 Feb 2023 12:45:18 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqn518h3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 12:45:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CJ2NZ1017578;
        Mon, 13 Feb 2023 12:45:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6jmqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 12:45:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DCjCFS43450728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 12:45:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 498FF2004B;
        Mon, 13 Feb 2023 12:45:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8420220043;
        Mon, 13 Feb 2023 12:45:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.0.211])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 12:45:11 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        nathanl@linux.ibm.com, Srikar Dronamraju <srikar@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries/cpuhp: respect current SMT when adding new CPU
Date:   Mon, 13 Feb 2023 13:45:10 +0100
Message-Id: <20230213124510.12651-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J809Gs1wwfpZix-VP9M3hadgox0xNrrm
X-Proofpoint-GUID: RUDqssxyKWsbp1Q8x-huaY_8aP6XeCX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_08,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new CPU is added, the kernel is activating all its threads. This
leads to weird, but functional, result when adding CPU on a SMT 4 system
for instance.

Here the newly added CPU 1 has 8 threads while the other one has 4 threads
active (system has been booted with the 'smt-enabled=4' kernel option):

ltcden3-lp12:~ # ppc64_cpu --info
Core   0:    0*    1*    2*    3*    4     5     6     7
Core   1:    8*    9*   10*   11*   12*   13*   14*   15*

There is no SMT value in the kernel. It is possible to run unbalanced LPAR
with 2 threads for a CPU, 4 for another one, and 5 on the latest.

To work around this possibility, and assuming that the LPAR run with the
same number of threads for each CPU, which is the common case, the number
of active threads of the CPU doing the hot-plug operation is computed. Only
that number of threads will be activated for the newly added CPU.

This way on a LPAR running in SMT=4, newly added CPU will be running 4
threads, which is what a end user would expect.

Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 24 ++++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 090ae5a1e0f5..58a7c97fc475 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -382,7 +382,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
 	unsigned int cpu;
-	int len, nthreads, i;
+	int len, nthreads, i, smt;
 	const __be32 *intserv;
 	u32 thread;
 
@@ -392,6 +392,17 @@ static int dlpar_online_cpu(struct device_node *dn)
 
 	nthreads = len / sizeof(u32);
 
+	/*
+	 * Compute the number of active threads for the current CPU, assuming
+	 * the system is homogeus, we don't want to active more threads than the
+	 * current SMT setting.
+	 */
+	for (cpu = cpu_first_thread_sibling(raw_smp_processor_id()), smt = 0;
+	     cpu <= cpu_last_thread_sibling(raw_smp_processor_id()); cpu++) {
+		if (cpu_online(cpu))
+			smt++;
+	}
+
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
@@ -400,10 +411,13 @@ static int dlpar_online_cpu(struct device_node *dn)
 				continue;
 			cpu_maps_update_done();
 			find_and_update_cpu_nid(cpu);
-			rc = device_online(get_cpu_device(cpu));
-			if (rc) {
-				dlpar_offline_cpu(dn);
-				goto out;
+			/* Don't active CPU over the current SMT setting */
+			if (smt-- > 0) {
+				rc = device_online(get_cpu_device(cpu));
+				if (rc) {
+					dlpar_offline_cpu(dn);
+					goto out;
+				}
 			}
 			cpu_maps_update_begin();
 
-- 
2.39.1

