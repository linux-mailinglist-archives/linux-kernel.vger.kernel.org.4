Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C86E2D42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDNXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:45:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430BB7EF8;
        Fri, 14 Apr 2023 16:44:38 -0700 (PDT)
Message-ID: <20230414232310.073038650@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GyywxqWp8oXO9/e7syapChEN4EQiJFDwV+0SUoqcKJk=;
        b=JUqSST6sUfcIWAgxhbacXjpEmmObS6IQmZ8ClrGYKz6doTL5ISmvBQwKyUHTzWuCMn0jQ2
        kxURDWFhZo9th4otAi+IQxUNu4L5D+QqiOZWbyNzW73qnBtuAg4kKtwBnKA13ZEyQuUA3X
        24NTR55n5XqMxhu41NV27bpjHdQ+JlbVY0oF+P/tIz60xJTXSar+rkM76hsA2KCV9DFE63
        6moUS8v6t62b1FyFg672g0WX5bUvfVeqnGzGFuSCL/S0/rzXi15l7IZ4fLWeFV2skFwkBv
        DN49AN17nBshRWNeN2Y+3WWvPRAiTBVV4LsFXW/N5eBDDmUXpiGL65/32uCbZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GyywxqWp8oXO9/e7syapChEN4EQiJFDwV+0SUoqcKJk=;
        b=snqZUI4TE1G36IaRc7SXm3rJmNJDzjCApFmrXGG7j+LkkvHa7rApiOe1UgrCEuxcVgy8d4
        n0QkZCVyncqid6Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
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
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 14/37] cpu/hotplug: Rework sparse_irq locking in bringup_cpu()
References: <20230414225551.858160935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 15 Apr 2023 01:44:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no harm to hold sparse_irq lock until the upcoming CPU completes
in cpuhp_online_idle(). This allows to remove cpu_online() synchronization
from architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

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
 
@@ -606,10 +603,23 @@ static int bringup_cpu(unsigned int cpu)
 
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

