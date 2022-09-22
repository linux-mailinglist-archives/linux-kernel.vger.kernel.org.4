Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78AE5E6BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiIVTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIVTii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:38:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444510B203;
        Thu, 22 Sep 2022 12:38:36 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MJGMj2026762;
        Thu, 22 Sep 2022 19:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SumduS5pnJG4Lexk2qixDBgCpRAyAPkg9dIaI+5HcOo=;
 b=KrbT0gkAlLxqoXhyIut5A53Bun3Wkme+N/Bs4wr0qukq37EFQ0LVXoCM9rtvNAsRj0/2
 Od015XaciMhaL2t5scHoM6biaURMQHULeU4q2jsi/9lWO7GoUcTuqXs4QkIAhbyKMz4m
 1PXVdK2RW2RB9Dl0aI8/fhTUXdkdtE7O6+syp5PkLXnlrKArZIOsOerAB5Xx3jdg3Cr1
 yvh+QOPqfuoatABNBdbQbndonhQD7lZkhXIYYpIYM+veg1bo49zUr4NzHHjjrKhNC9IG
 oBkx4HG0EqE3bNmJS2u9log8W7DRn3L33lg/WAJidODDuyVDkjfukVpi1RjFJV/YmBva 9Q== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrvvx2cv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:38:20 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MJa37O008113;
        Thu, 22 Sep 2022 19:38:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 3jn5v9twp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:38:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MJcJuo65470872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 19:38:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9735A5805A;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8476958051;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 19:38:17 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jmorris@namei.org, mpe@ellerman.id.au, paul@paul-moore.com,
        serge@hallyn.com, ajd@linux.ibm.com, gcwilson@linux.ibm.com,
        nayna@linux.ibm.com
Subject: [PATCH 2/2] powerpc/rtas: block error injection when locked down
Date:   Thu, 22 Sep 2022 14:38:17 -0500
Message-Id: <20220922193817.106041-3-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922193817.106041-1-nathanl@linux.ibm.com>
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wUH6TLbpjNitun1gfSh4CeOowyl852t6
X-Proofpoint-ORIG-GUID: wUH6TLbpjNitun1gfSh4CeOowyl852t6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error injection facility on pseries VMs allows corruption of
arbitrary guest memory, potentially enabling a sufficiently privileged
user to disable lockdown or perform other modifications of the running
kernel via the rtas syscall.

Block the PAPR error injection facility from being opened or called
when locked down.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
 include/linux/security.h   |  1 +
 security/security.c        |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 693133972294..c2540d393f1c 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -23,6 +23,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
+#include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -464,6 +465,9 @@ void rtas_call_unlocked(struct rtas_args *args, int token, int nargs, int nret,
 	va_end(list);
 }
 
+static int ibm_open_errinjct_token;
+static int ibm_errinjct_token;
+
 int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 {
 	va_list list;
@@ -476,6 +480,16 @@ int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
 		return -1;
 
+	if (token == ibm_open_errinjct_token || token == ibm_errinjct_token) {
+		/*
+		 * It would be nicer to not discard the error value
+		 * from security_locked_down(), but callers expect an
+		 * RTAS status, not an errno.
+		 */
+		if (security_locked_down(LOCKDOWN_RTAS_ERROR_INJECTION))
+			return -1;
+	}
+
 	if ((mfmsr() & (MSR_IR|MSR_DR)) != (MSR_IR|MSR_DR)) {
 		WARN_ON_ONCE(1);
 		return -1;
@@ -1227,6 +1241,14 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	if (block_rtas_call(token, nargs, &args))
 		return -EINVAL;
 
+	if (token == ibm_open_errinjct_token || token == ibm_errinjct_token) {
+		int err;
+
+		err = security_locked_down(LOCKDOWN_RTAS_ERROR_INJECTION);
+		if (err)
+			return err;
+	}
+
 	/* Need to handle ibm,suspend_me call specially */
 	if (token == rtas_token("ibm,suspend-me")) {
 
@@ -1325,7 +1347,8 @@ void __init rtas_initialize(void)
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
-
+	ibm_open_errinjct_token = rtas_token("ibm,open-errinjct");
+	ibm_errinjct_token = rtas_token("ibm,errinjct");
 	rtas_syscall_filter_init();
 }
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 1ca8dbacd3cc..b5d5138ae66a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -123,6 +123,7 @@ enum lockdown_reason {
 	LOCKDOWN_BPF_WRITE_USER,
 	LOCKDOWN_DBG_WRITE_KERNEL,
 	LOCKDOWN_DEVICE_TREE,
+	LOCKDOWN_RTAS_ERROR_INJECTION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/security.c b/security/security.c
index 2863fc31eec6..6518b239ada2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -61,6 +61,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
 	[LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
+	[LOCKDOWN_RTAS_ERROR_INJECTION] = "RTAS error injection",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
-- 
2.37.3

