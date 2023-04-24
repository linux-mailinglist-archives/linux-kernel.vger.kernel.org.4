Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568B86D2425
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjCaPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjCaPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:39:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCDE1F7A9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:39:41 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VEPx31005458;
        Fri, 31 Mar 2023 15:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FdoNSkdZl5W6MhRIMFXPBEnEOg1f2E5cEytcW+wyPCo=;
 b=XBBYpAUdUD4Uc9EV71ZnOZ0q7Lnbc8Zy2HBdv6sMOgiETPxaKDPOEklUTm4ugZ5KQ/7g
 4IJCMzTA6WSS7EN6z8IswtgTzmNG0K3Dmdtmj+/9QrXlvaxt5d1a5HSZ4B8xgxtD1x8d
 H2ymqRiSOlhuKL7UOatES49YN8I0V5HILvIZO5Ya3yRUf9qntWwGT+QdPtdDSwieCtAD
 MWyzl+BurVuIl5/ozUAwSTVIEMyAqIEEdeZ0UNGRV8/MMAp6rUjzRf/BqAaLJpPJmoGf
 9UWV7vKbtIWvVM0RLUzVFZAOeRuBSx3Ul8z0mci3TA/Dc6kJgh6NMVArRpkIiGiYnrg2 GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pp19c9us5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:39:30 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32VEQlRs010922;
        Fri, 31 Mar 2023 15:39:30 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pp19c9uns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:39:29 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ULo5t2005469;
        Fri, 31 Mar 2023 15:39:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6pw6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:39:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32VFdIGO31981848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 15:39:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E90C20043;
        Fri, 31 Mar 2023 15:39:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9A3B20040;
        Fri, 31 Mar 2023 15:39:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.179.0.144])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 31 Mar 2023 15:39:17 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     msuchanek@suse.de, nathanl@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/pseries/cpuhp: respect current SMT when adding new CPU
Date:   Fri, 31 Mar 2023 17:39:05 +0200
Message-Id: <20230331153905.31698-3-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331153905.31698-1-ldufour@linux.ibm.com>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H9apdsxfmK6GdWx27csX4-aUTx8w3LD6
X-Proofpoint-ORIG-GUID: qL5AAfG4VlfyGk0oo2RNr1iUO5wTj3Wq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310123
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

We rely on the newly pseries_smt value which should be updated when
changing the SMT level by ppc64_cpu --smt=x and at boot time using the
smt-enabled kernel option.

This way on a LPAR running in SMT=4, newly added CPU will be running 4
threads, which is what a end user would expect.

Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 18 +++++++++++++-----
 arch/powerpc/platforms/pseries/smp.c         |  2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 1a3cb313976a..e623ed8649b3 100644
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
 
@@ -392,6 +392,11 @@ static int dlpar_online_cpu(struct device_node *dn)
 
 	nthreads = len / sizeof(u32);
 
+	smt = READ_ONCE(pseries_smt);
+	/* We should online at least one thread */
+	if (smt < 1)
+		smt = 1;
+
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
@@ -400,10 +405,13 @@ static int dlpar_online_cpu(struct device_node *dn)
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
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 6c382922f8f3..ef8070651846 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -295,7 +295,7 @@ static ssize_t pseries_smt_store(struct class *class,
 		return -EINVAL;
 	}
 
-	pseries_smt = smt;
+	WRITE_ONCE(pseries_smt, smt);
 
 	return count;
 }
-- 
2.40.0

