Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C932639FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiK1CqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiK1CqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:46:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0377511822;
        Sun, 27 Nov 2022 18:46:00 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS2AZMM025464;
        Mon, 28 Nov 2022 02:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XGjCS+BfvPB6NpKA0EgBhapLys4pzuIPtMyqk3R+pWI=;
 b=EUn98Orne5yHmf1CzKHpf2lP+mM14pa0Jxko3t0TXXPKNR7I6GvWajmIxSHzfVWzK3oU
 jPs3p8gZh5VtzkPK7RqGDJX/TJJKo1NzBLyFWNNOlXvsPi+e94hNshLZf7PHWv/VcjpB
 q1S7ZkcOQ7wNLTwRa3KMe7xXTmqLliC0xVsusoqIPqilXbOPOdenoeKiRjos54eXnccT
 iZAfKAT9QmBV+IWBJnjAHF6IFITnod9q+UzOEgUA4etlx+jlyFqJQkqw3i6NzJaTy5dx
 QcqVBzDk8TnoVrFOnHj9BOoTfRieY/ZsfBOeR/88VPfFW6glLrfOXlQXKNZKlM+WlnmY ig== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vcrkynj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AS2ZEO3023005;
        Mon, 28 Nov 2022 02:45:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3m3ae99uf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AS2jjqj918190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 02:45:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1199DA405F;
        Mon, 28 Nov 2022 02:45:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D246A4054;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from li-0d7fa1cc-2c9d-11b2-a85c-aed20764436d.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 513F660839;
        Mon, 28 Nov 2022 13:45:39 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, ruscur@russell.cc, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [RFC PATCH 06/13] powerpc/dexcr: Add prctl implementation
Date:   Mon, 28 Nov 2022 13:44:51 +1100
Message-Id: <20221128024458.46121-7-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128024458.46121-1-bgray@linux.ibm.com>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bBzVWL3hDVvOVm6530O_6BcbBNl5q58x
X-Proofpoint-ORIG-GUID: bBzVWL3hDVvOVm6530O_6BcbBNl5q58x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=988 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an initial prctl interface implementation. Unprivileged processes
can query the current prctl setting, including whether an aspect is
implemented by the hardware or is permitted to be modified by a setter
prctl. Editable aspects can be changed by a CAP_SYS_ADMIN privileged
process.

The prctl setting represents what the process itself has requested, and
does not account for any overrides. Either the kernel or a hypervisor
may enforce a different setting for an aspect.

Userspace can access a readonly view of the current DEXCR via SPR 812,
and a readonly view of the aspects enforced by the hypervisor via
SPR 455. A bitwise OR of these two SPRs will give the effective
DEXCR aspect state of the process.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 arch/powerpc/include/asm/processor.h |  13 +++
 arch/powerpc/kernel/dexcr.c          | 133 ++++++++++++++++++++++++++-
 arch/powerpc/kernel/process.c        |   6 ++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2381217c95dc..4c995258f668 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -265,6 +265,9 @@ struct thread_struct {
 	unsigned long   sier2;
 	unsigned long   sier3;
 	unsigned long	hashkeyr;
+	unsigned int	dexcr_override;
+	unsigned int	dexcr_mask;
+	unsigned int	dexcr_forced;
 
 #endif
 };
@@ -338,6 +341,16 @@ extern int set_endian(struct task_struct *tsk, unsigned int val);
 extern int get_unalign_ctl(struct task_struct *tsk, unsigned long adr);
 extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define PPC_GET_DEXCR_ASPECT(tsk, asp) dexcr_prctl_get((tsk), (asp))
+#define PPC_SET_DEXCR_ASPECT(tsk, asp, val) dexcr_prctl_set((tsk), (asp), (val))
+
+int dexcr_prctl_get(struct task_struct *tsk, unsigned long asp);
+int dexcr_prctl_set(struct task_struct *tsk, unsigned long asp, unsigned long val);
+
+#endif
+
 extern void load_fp_state(struct thread_fp_state *fp);
 extern void store_fp_state(struct thread_fp_state *fp);
 extern void load_vr_state(struct thread_vr_state *vr);
diff --git a/arch/powerpc/kernel/dexcr.c b/arch/powerpc/kernel/dexcr.c
index 11515e67afac..9290beed722a 100644
--- a/arch/powerpc/kernel/dexcr.c
+++ b/arch/powerpc/kernel/dexcr.c
@@ -1,5 +1,8 @@
 #include <linux/cache.h>
+#include <linux/capability.h>
 #include <linux/init.h>
+#include <linux/prctl.h>
+#include <linux/sched.h>
 
 #include <asm/cpu_has_feature.h>
 #include <asm/cputable.h>
@@ -11,6 +14,10 @@
 
 #define DEFAULT_DEXCR	0
 
+/* Allow process configuration of these by default */
+#define DEXCR_PRCTL_EDITABLE (DEXCR_PRO_SBHE | DEXCR_PRO_IBRTPD | \
+			      DEXCR_PRO_SRAPD | DEXCR_PRO_NPHIE)
+
 static int __init dexcr_init(void)
 {
 	if (!early_cpu_has_feature(CPU_FTR_ARCH_31))
@@ -43,5 +50,129 @@ bool is_hashchk_trap(struct pt_regs const *regs)
 
 unsigned long get_thread_dexcr(struct thread_struct const *t)
 {
-	return DEFAULT_DEXCR;
+	unsigned long dexcr = DEFAULT_DEXCR;
+
+	/* Apply prctl overrides */
+	dexcr = (dexcr & ~t->dexcr_mask) | t->dexcr_override;
+
+	return dexcr;
+}
+
+static void update_dexcr_on_cpu(void *info)
+{
+	mtspr(SPRN_DEXCR, get_thread_dexcr(&current->thread));
+}
+
+static int dexcr_aspect_get(struct task_struct *task, unsigned int aspect)
+{
+	int ret = 0;
+
+	if (aspect & DEXCR_PRCTL_EDITABLE)
+		ret |= PR_PPC_DEXCR_PRCTL;
+
+	if (aspect & task->thread.dexcr_mask) {
+		if (aspect & task->thread.dexcr_override) {
+			if (aspect & task->thread.dexcr_forced)
+				ret |= PR_PPC_DEXCR_FORCE_SET_ASPECT;
+			else
+				ret |= PR_PPC_DEXCR_SET_ASPECT;
+		} else {
+			ret |= PR_PPC_DEXCR_CLEAR_ASPECT;
+		}
+	}
+
+	return ret;
+}
+
+int dexcr_prctl_get(struct task_struct *task, unsigned long which)
+{
+	switch (which) {
+	case PR_PPC_DEXCR_SBHE:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_SBHE))
+			return -ENODEV;
+		return dexcr_aspect_get(task, DEXCR_PRO_SBHE);
+	case PR_PPC_DEXCR_IBRTPD:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_IBRTPD))
+			return -ENODEV;
+		return dexcr_aspect_get(task, DEXCR_PRO_IBRTPD);
+	case PR_PPC_DEXCR_SRAPD:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_SRAPD))
+			return -ENODEV;
+		return dexcr_aspect_get(task, DEXCR_PRO_SRAPD);
+	case PR_PPC_DEXCR_NPHIE:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
+			return -ENODEV;
+		return dexcr_aspect_get(task, DEXCR_PRO_NPHIE);
+	default:
+		return -ENODEV;
+	}
+}
+
+static int dexcr_aspect_set(struct task_struct *task, unsigned int aspect, unsigned long ctrl)
+{
+	if (!(aspect & DEXCR_PRCTL_EDITABLE))
+		return -ENXIO;  /* Aspect is not allowed to be changed by prctl */
+
+	if (aspect & task->thread.dexcr_forced)
+		return -EPERM;  /* Aspect has been forced to current state */
+
+	switch (ctrl) {
+	case PR_PPC_DEXCR_SET_ASPECT:
+		task->thread.dexcr_mask |= aspect;
+		task->thread.dexcr_override |= aspect;
+		break;
+	case PR_PPC_DEXCR_FORCE_SET_ASPECT:
+		task->thread.dexcr_mask |= aspect;
+		task->thread.dexcr_override |= aspect;
+		task->thread.dexcr_forced |= aspect;
+		break;
+	case PR_PPC_DEXCR_CLEAR_ASPECT:
+		task->thread.dexcr_mask |= aspect;
+		task->thread.dexcr_override &= ~aspect;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+int dexcr_prctl_set(struct task_struct *task, unsigned long which, unsigned long ctrl)
+{
+	int err = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	switch (which) {
+	case PR_PPC_DEXCR_SBHE:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_SBHE))
+			return -ENODEV;
+		err = dexcr_aspect_set(task, DEXCR_PRO_SBHE, ctrl);
+		break;
+	case PR_PPC_DEXCR_IBRTPD:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_IBRTPD))
+			return -ENODEV;
+		err = dexcr_aspect_set(task, DEXCR_PRO_IBRTPD, ctrl);
+		break;
+	case PR_PPC_DEXCR_SRAPD:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_SRAPD))
+			return -ENODEV;
+		err = dexcr_aspect_set(task, DEXCR_PRO_SRAPD, ctrl);
+		break;
+	case PR_PPC_DEXCR_NPHIE:
+		if (!cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
+			return -ENODEV;
+		err = dexcr_aspect_set(task, DEXCR_PRO_NPHIE, ctrl);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	if (err)
+		return err;
+
+	update_dexcr_on_cpu(NULL);
+
+	return 0;
 }
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 4d7b0c7641d0..a280842750f9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1825,6 +1825,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_DEXCR_NPHIE))
 		p->thread.hashkeyr = current->thread.hashkeyr;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+		p->thread.dexcr_override = current->thread.dexcr_override;
+		p->thread.dexcr_mask = current->thread.dexcr_mask;
+		p->thread.dexcr_forced = current->thread.dexcr_forced;
+	}
 #endif
 	/*
 	 * Run with the current AMR value of the kernel
-- 
2.38.1

