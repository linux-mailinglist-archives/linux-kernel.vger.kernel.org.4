Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD43A701070
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjELVIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239979AbjELVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F903CE;
        Fri, 12 May 2023 14:07:32 -0700 (PDT)
Message-ID: <20230512205256.263722880@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6HcPZ1S0gKGilIW8DEzs+8FA47mShbE6fcxT9xps3qM=;
        b=wq6r7KiTpvagWfasCy7BpMaZc62MAFu3oUyN8IkTQnL9aLQt2J8dO9GuPVqDCozi0utj8B
        4IkD4xWAu5eTIAkrXomOEfRirhMpcSmjIuqx0o7p3I34k341WcbR0oawavbm30EBV5G/SQ
        pqVHGdr8O5AONZrQcM1b3A+l1qf3n3+2rHPsKgwNOlF2vQ3k5Npt0LMG9aJW+erlOl1Ibn
        pyPvj+RRfga1j85S0Dc2olvz/HEP4GwJI0tr9/CeQrVpZHiYB9toQXczVgnAW4f1NLnOxh
        6UTdAjUh2XFk2HO9QVoMZ6pTiLkYX7+zo/CatpFvhsqM4XVqS07nh/cjtfBz3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6HcPZ1S0gKGilIW8DEzs+8FA47mShbE6fcxT9xps3qM=;
        b=kLfIJYpL8LcaVnGjQ4Dcmt10BIgjcw/Luxkj9XlqF3gpecWWEb7C3Qu2IrxE2br/1iTpq7
        mpK48/gsNDr9qICw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: [patch V4 15/37] cpu/hotplug: Rework sparse_irq locking in bringup_cpu()
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no harm to hold sparse_irq lock until the upcoming CPU completes
in cpuhp_online_idle(). This allows to remove cpu_online() synchronization
from architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V4: Amend comment about sparse irq lock - Peter Z.
---
 kernel/cpu.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -558,7 +558,7 @@ static int cpuhp_kick_ap(int cpu, struct
 	return ret;
 }
 
-static int bringup_wait_for_ap(unsigned int cpu)
+static int bringup_wait_for_ap_online(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 
@@ -579,15 +579,12 @@ static int bringup_wait_for_ap(unsigned
 	 */
 	if (!cpu_smt_allowed(cpu))
 		return -ECANCELED;
-
-	if (st->target <= CPUHP_AP_ONLINE_IDLE)
-		return 0;
-
-	return cpuhp_kick_ap(cpu, st, st->target);
+	return 0;
 }
 
 static int bringup_cpu(unsigned int cpu)
 {
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
@@ -600,16 +597,33 @@ static int bringup_cpu(unsigned int cpu)
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
-	 * Prevent irq alloc/free across the bringup.
+	 *
+	 * Prevent irq alloc/free across the bringup by acquiring the
+	 * sparse irq lock. Hold it until the upcoming CPU completes the
+	 * startup in cpuhp_online_idle() which allows to avoid
+	 * intermediate synchronization points in the architecture code.
 	 */
 	irq_lock_sparse();
 
 	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu, idle);
-	irq_unlock_sparse();
 	if (ret)
-		return ret;
-	return bringup_wait_for_ap(cpu);
+		goto out_unlock;
+
+	ret = bringup_wait_for_ap_online(cpu);
+	if (ret)
+		goto out_unlock;
+
+	irq_unlock_sparse();
+
+	if (st->target <= CPUHP_AP_ONLINE_IDLE)
+		return 0;
+
+	return cpuhp_kick_ap(cpu, st, st->target);
+
+out_unlock:
+	irq_unlock_sparse();
+	return ret;
 }
 
 static int finish_cpu(unsigned int cpu)

