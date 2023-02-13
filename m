Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BA694F88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBMSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBMSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:39:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB0883ED;
        Mon, 13 Feb 2023 10:39:11 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DHC33M032726;
        Mon, 13 Feb 2023 18:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=eKRBeAe3qigupaZY72Q88hKzNT8kWDVPaSv+ayvjbhE=;
 b=BJagRqq7pFob0NQmb+DfdJo28bQR4QCRzmYMY04DYCL5iFNYktQZUbPzXF1/XuDWEtnd
 +iRTF6IeE+ruW78B2YebxAxtSNnVw/3nNc4RsDWEXS1gYkxShEVUYG81yMKeB+W8i34o
 PlD/XM5q32umn6xLLiY9q9LTTFlahEfxHQXMn83nGIyrY4mYbHtC1YrYhQOOamJm0W8B
 eYD6lpeaBcdM9GCDBRq5olNBQbL4vD/8bfgH0G48qquYPHuTyeYZUquVXQUMTzH3BPpu
 CbXwjjqiINJsBwy/OVU3mfJ7min7iG8n0gSt75m6N2JGO1mUfyfBI2cZFnUN4ELnvAlm Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqsd1a3sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:39:05 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DIGQmU028606;
        Mon, 13 Feb 2023 18:39:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqsd1a3rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:39:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDGAp4010684;
        Mon, 13 Feb 2023 18:39:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6u146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 18:39:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DIcwOW21168428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 18:38:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903B420043;
        Mon, 13 Feb 2023 18:38:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6363B20040;
        Mon, 13 Feb 2023 18:38:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 18:38:58 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, Sven Schnelle <svens@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/kfence: fix page fault reporting
Date:   Mon, 13 Feb 2023 19:38:58 +0100
Message-Id: <20230213183858.1473681-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mUe91CjTfv_NaOeeLIwY-oFIfaDsIJIc
X-Proofpoint-GUID: E59laLqf_RTz1dHpxiQNgOh28pr0r_i6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=678 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302130165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He reported lots of KFENCE reports when /proc/kcore is read,
e.g. with crash or even simpler with dd:

 BUG: KFENCE: invalid read in copy_from_kernel_nofault+0x5e/0x120
 Invalid read at 0x00000000f4f5149f:
  copy_from_kernel_nofault+0x5e/0x120
  read_kcore+0x6b2/0x870
  proc_reg_read+0x9a/0xf0
  vfs_read+0x94/0x270
  ksys_read+0x70/0x100
  __do_syscall+0x1d0/0x200
  system_call+0x82/0xb0

The reason for this is that read_kcore() simply reads memory that might
have been unmapped by KFENCE with copy_from_kernel_nofault(). Any fault due
to pages being unmapped by KFENCE would be handled gracefully by the fault
handler (exception table fixup).

However the s390 fault handler first reports the fault, and only afterwards
would perform the exception table fixup. Most architectures have this in
reversed order, which also avoids the false positive KFENCE reports when an
unmapped page is accessed.

Therefore change the s390 fault handler so it handles exception table
fixups before KFENCE page faults are reported.

Reported-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 49 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9649d9382e0a..8e84ed2bb944 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -96,6 +96,20 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
 	return KERNEL_FAULT;
 }
 
+static unsigned long get_fault_address(struct pt_regs *regs)
+{
+	unsigned long trans_exc_code = regs->int_parm_long;
+
+	return trans_exc_code & __FAIL_ADDR_MASK;
+}
+
+static bool fault_is_write(struct pt_regs *regs)
+{
+	unsigned long trans_exc_code = regs->int_parm_long;
+
+	return (trans_exc_code & store_indication) == 0x400;
+}
+
 static int bad_address(void *p)
 {
 	unsigned long dummy;
@@ -228,15 +242,26 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
 			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK));
 }
 
-static noinline void do_no_context(struct pt_regs *regs)
+static noinline void do_no_context(struct pt_regs *regs, vm_fault_t fault)
 {
+	enum fault_type fault_type;
+	unsigned long address;
+	bool is_write;
+
 	if (fixup_exception(regs))
 		return;
+	fault_type = get_fault_type(regs);
+	if ((fault_type == KERNEL_FAULT) && (fault == VM_FAULT_BADCONTEXT)) {
+		address = get_fault_address(regs);
+		is_write = fault_is_write(regs);
+		if (kfence_handle_page_fault(address, is_write, regs))
+			return;
+	}
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice.
 	 */
-	if (get_fault_type(regs) == KERNEL_FAULT)
+	if (fault_type == KERNEL_FAULT)
 		printk(KERN_ALERT "Unable to handle kernel pointer dereference"
 		       " in virtual kernel address space\n");
 	else
@@ -255,7 +280,7 @@ static noinline void do_low_address(struct pt_regs *regs)
 		die (regs, "Low-address protection");
 	}
 
-	do_no_context(regs);
+	do_no_context(regs, VM_FAULT_BADACCESS);
 }
 
 static noinline void do_sigbus(struct pt_regs *regs)
@@ -286,28 +311,28 @@ static noinline void do_fault_error(struct pt_regs *regs, vm_fault_t fault)
 		fallthrough;
 	case VM_FAULT_BADCONTEXT:
 	case VM_FAULT_PFAULT:
-		do_no_context(regs);
+		do_no_context(regs, fault);
 		break;
 	case VM_FAULT_SIGNAL:
 		if (!user_mode(regs))
-			do_no_context(regs);
+			do_no_context(regs, fault);
 		break;
 	default: /* fault & VM_FAULT_ERROR */
 		if (fault & VM_FAULT_OOM) {
 			if (!user_mode(regs))
-				do_no_context(regs);
+				do_no_context(regs, fault);
 			else
 				pagefault_out_of_memory();
 		} else if (fault & VM_FAULT_SIGSEGV) {
 			/* Kernel mode? Handle exceptions or die */
 			if (!user_mode(regs))
-				do_no_context(regs);
+				do_no_context(regs, fault);
 			else
 				do_sigsegv(regs, SEGV_MAPERR);
 		} else if (fault & VM_FAULT_SIGBUS) {
 			/* Kernel mode? Handle exceptions or die */
 			if (!user_mode(regs))
-				do_no_context(regs);
+				do_no_context(regs, fault);
 			else
 				do_sigbus(regs);
 		} else
@@ -334,7 +359,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum fault_type type;
-	unsigned long trans_exc_code;
 	unsigned long address;
 	unsigned int flags;
 	vm_fault_t fault;
@@ -351,9 +375,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 		return 0;
 
 	mm = tsk->mm;
-	trans_exc_code = regs->int_parm_long;
-	address = trans_exc_code & __FAIL_ADDR_MASK;
-	is_write = (trans_exc_code & store_indication) == 0x400;
+	address = get_fault_address(regs);
+	is_write = fault_is_write(regs);
 
 	/*
 	 * Verify that the fault happened in user space, that
@@ -364,8 +387,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	type = get_fault_type(regs);
 	switch (type) {
 	case KERNEL_FAULT:
-		if (kfence_handle_page_fault(address, is_write, regs))
-			return 0;
 		goto out;
 	case USER_FAULT:
 	case GMAP_FAULT:
-- 
2.37.2

