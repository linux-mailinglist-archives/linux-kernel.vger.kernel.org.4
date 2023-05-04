Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEBB6F72B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjEDTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEDTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:03:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDB7A97;
        Thu,  4 May 2023 12:02:50 -0700 (PDT)
Message-ID: <20230504185937.858955768@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x1gYrMcqzm40p2bz6RsOmSrXlBcSvXXbnfB8HNeCbJU=;
        b=F9VwenKVSYd9QFli8bXNV/fz9qUSdzJcPELJ1ngRD9BxyzaHEgcu2cC0/b4kuprOfTMBsR
        NCkyPWtTcKTi4mTU6aAeMY6PYflFdg/QnWMligdTnr5DQ53G/59w7N1RxTuaJMuxKaB+6k
        fnxGx7t6MsQx4TP0A/Wv1B3YJqsjI01JirGXHQPo53zTdX5Z488sLyftTciloBgiN9k5k/
        bzf3t4Qwlj6lxCy0qHukKPQMZGDuh3h1yP7MJWtYXWHVZt3htrK/Qtw9ul4ERCfXuX9Nze
        it6Ui4ad23Dml/cuVbhr6i6cHXzKyVbR3juE2BxVW820qfkeEJiZvG833WVS3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=x1gYrMcqzm40p2bz6RsOmSrXlBcSvXXbnfB8HNeCbJU=;
        b=PK3VhwCrlpzYLlITMOVdXxhPHsDqoA73a6Tz+/QOqHPRfKtGaiwEqnA7EtTcL4VMvMoxp6
        ebRWKW/d8KnEHmAA==
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
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [patch V2 28/38] cpu/hotplug: Reset task stack state in _cpu_up()
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:43 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Commit dce1ca0525bf ("sched/scs: Reset task stack state in bringup_cpu()")
ensured that the shadow call stack and KASAN poisoning were removed from
a CPU's stack each time that CPU is brought up, not just once.

This is not incorrect. However, with parallel bringup the idle thread setup
will happen at a different step. As a consequence the cleanup in
bringup_cpu() would be too late.

Move the SCS/KASAN cleanup to the generic _cpu_up() function instead,
which already ensures that the new CPU's stack is available, purely to
allow for early failure. This occurs when the CPU to be brought up is
in the CPUHP_OFFLINE state, which should correctly do the cleanup any
time the CPU has been taken down to the point where such is needed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>

---
 kernel/cpu.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -771,12 +771,6 @@ static int bringup_cpu(unsigned int cpu)
 		return -EAGAIN;
 
 	/*
-	 * Reset stale stack state from the last time this CPU was online.
-	 */
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
-	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
 	 * Prevent irq alloc/free across the bringup.
@@ -1583,6 +1577,12 @@ static int _cpu_up(unsigned int cpu, int
 			ret = PTR_ERR(idle);
 			goto out;
 		}
+
+		/*
+		 * Reset stale stack state from the last time this CPU was online.
+		 */
+		scs_task_reset(idle);
+		kasan_unpoison_task_stack(idle);
 	}
 
 	cpuhp_tasks_frozen = tasks_frozen;

