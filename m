Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1241639F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiK1CqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1CqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:46:01 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5111478;
        Sun, 27 Nov 2022 18:46:00 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS1vTC6025639;
        Mon, 28 Nov 2022 02:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VDZHwNjpXDUmV0cnqCVUkvrBPtd4Z+jlFXL7rQ9VsQQ=;
 b=CJri0nNDvgLy3Flpp9UcWmHC+6ZxZRz4Fq/4ruharnmUU5aYg8ECM8xtL+OzJa0/brzg
 36YPFZGWgl5O4ZY4G3lj6gD+fQbZ8ogUaj7bf1ouHZ0OPe/xNw22v6GNKvgW3eCVFBXx
 nEBcLQeJTGpuElAY9v7Rg6WXR37R1lGnXksFDhonm0YE1vU0KOv/NjNSQO9cZgkuMvM5
 tetDm9ocM4EMJqWKg1mK1pvfXONwgxlPbp8Hl9Pay0bDvSkFNEnJ2HzxNB+ArpzHahm8
 7hZaK3/AiKMhikpZurivhvuhxUkD8nQzNZMtQNGr7pJSgEOiYRb+2e4ag1knflPlhNxF Ow== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vnnumyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AS2a4Pm032545;
        Mon, 28 Nov 2022 02:45:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3m3a2hsurm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AS2jh0Q38994238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 02:45:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 725B211C04C;
        Mon, 28 Nov 2022 02:45:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7C4D11C04A;
        Mon, 28 Nov 2022 02:45:42 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 02:45:42 +0000 (GMT)
Received: from li-0d7fa1cc-2c9d-11b2-a85c-aed20764436d.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4D0736038E;
        Mon, 28 Nov 2022 13:45:39 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, ruscur@russell.cc, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [RFC PATCH 04/13] powerpc/dexcr: Support userspace ROP protection
Date:   Mon, 28 Nov 2022 13:44:49 +1100
Message-Id: <20221128024458.46121-5-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128024458.46121-1-bgray@linux.ibm.com>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AGk1WfN-RW1fIbbJ3Pfbcudv5kPb1ecU
X-Proofpoint-GUID: AGk1WfN-RW1fIbbJ3Pfbcudv5kPb1ecU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=826 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISA 3.1B hashst and hashchk instructions use a per-cpu SPR HASHKEYR
to hold a key used in the hash calculation. This key should be different
for each process to make it harder for a malicious process to recreate
valid hash values for a victim process.

Add support for storing a per-thread hash key, and setting/clearing
HASHKEYR appropriately.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/kexec.h |  3 +++
 arch/powerpc/include/asm/processor.h       |  1 +
 arch/powerpc/include/asm/reg.h             |  1 +
 arch/powerpc/kernel/process.c              | 12 ++++++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/kexec.h b/arch/powerpc/include/asm/book3s/64/kexec.h
index 563baf94a962..163de935df28 100644
--- a/arch/powerpc/include/asm/book3s/64/kexec.h
+++ b/arch/powerpc/include/asm/book3s/64/kexec.h
@@ -24,6 +24,9 @@ static inline void reset_sprs(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_31))
 		mtspr(SPRN_DEXCR, 0);
 
+	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
+		mtspr(SPRN_HASHKEYR, 0);
+
 	/*  Do we need isync()? We are going via a kexec reset */
 	isync();
 }
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c17ec1e44c86..2381217c95dc 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -264,6 +264,7 @@ struct thread_struct {
 	unsigned long   mmcr3;
 	unsigned long   sier2;
 	unsigned long   sier3;
+	unsigned long	hashkeyr;
 
 #endif
 };
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cdd1f174c399..854664cf844f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -384,6 +384,7 @@
 #define SPRN_HRMOR	0x139	/* Real mode offset register */
 #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
+#define SPRN_HASHKEYR	0x1D4	/* Non-privileged hashst/hashchk key register */
 #define SPRN_ASDR	0x330	/* Access segment descriptor register */
 #define SPRN_DEXCR	0x33C	/* Dynamic execution control register */
 #define   DEXCR_PRO_MASK(aspect)	__MASK(63 - (32 + (aspect)))	/* Aspect number to problem state aspect mask */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 17d26f652b80..4d7b0c7641d0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1229,6 +1229,9 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 	    old_thread->tidr != new_thread->tidr)
 		mtspr(SPRN_TIDR, new_thread->tidr);
 
+	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
+		mtspr(SPRN_HASHKEYR, new_thread->hashkeyr);
+
 	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
 		unsigned long new_dexcr = get_thread_dexcr(new_thread);
 
@@ -1818,6 +1821,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->ppr = DEFAULT_PPR;
 
 	p->thread.tidr = 0;
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
+		p->thread.hashkeyr = current->thread.hashkeyr;
 #endif
 	/*
 	 * Run with the current AMR value of the kernel
@@ -1947,6 +1954,11 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.load_tm = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 #ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE)) {
+		current->thread.hashkeyr = get_random_long();
+		mtspr(SPRN_HASHKEYR, current->thread.hashkeyr);
+	}
+
 	if (cpu_has_feature(CPU_FTR_ARCH_31))
 		mtspr(SPRN_DEXCR, get_thread_dexcr(&current->thread));
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.38.1

