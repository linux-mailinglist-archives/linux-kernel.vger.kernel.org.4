Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518A6FB6F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjEHTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjEHTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:43:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04516A57;
        Mon,  8 May 2023 12:43:34 -0700 (PDT)
Message-ID: <20230508185217.458393998@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YVvAw0WAsVmopE5OIHIsJcpjHcWT9bVzoHoSegD/6OE=;
        b=G8jY8noRcocsOMuudUmnigMS5g2D2j/illqfnrAKMDSwZNAyNByW7W91CB5A0qyup8xoLU
        ju1ecTOFYCXG1ZOzwfeLNIWu4WEoDoD6p+1D+AqZKyOSugeGaOehdmkoA/nlGtcew2jUOh
        DzAZFh9YTiogntfcZ4P9+UPNch+6emIC0ae/WUtPo0aud1Iu4QPNUMUDCBmri2TlGBp9jT
        AA6L+H6VK8adYXgBNCf9r3PVCVhzwleTI15/nfJTmsMFQVq+7axqKZpItAeazqI90AqRIf
        nMTxkJ3sBvJwkZTMIR7xYS+DUgVAJRQlg/jUyMsipvPSuiu4phOaq20wyRyl4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YVvAw0WAsVmopE5OIHIsJcpjHcWT9bVzoHoSegD/6OE=;
        b=s+ViDYzSQVsqYkVETBJLWwXeFyinDS8d3eNTrYKk8dlzptBDC/K8uzHkO4TXLBIVOdRrGS
        hKy0R6/dTZ++mCAg==
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch v3 04/36] x86/smpboot: Rename start_cpu0() to soft_restart_cpu()
References: <20230508181633.089804905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  8 May 2023 21:43:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This is used in the SEV play_dead() implementation to re-online CPUs. But
that has nothing to do with CPU0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>


---
 arch/x86/include/asm/cpu.h   |    2 +-
 arch/x86/kernel/callthunks.c |    2 +-
 arch/x86/kernel/head_32.S    |   10 +++++-----
 arch/x86/kernel/head_64.S    |   10 +++++-----
 arch/x86/kernel/sev.c        |    2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)
---

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -30,7 +30,7 @@ struct x86_cpu {
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
-extern void start_cpu0(void);
+extern void soft_restart_cpu(void);
 #ifdef CONFIG_DEBUG_HOTPLUG_CPU0
 extern int _debug_hotplug_cpu(int cpu, int action);
 #endif
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -134,7 +134,7 @@ static bool skip_addr(void *dest)
 	if (dest == ret_from_fork)
 		return true;
 #ifdef CONFIG_HOTPLUG_CPU
-	if (dest == start_cpu0)
+	if (dest == soft_restart_cpu)
 		return true;
 #endif
 #ifdef CONFIG_FUNCTION_TRACER
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -140,16 +140,16 @@ SYM_CODE_END(startup_32)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
- * up already except stack. We just set up stack here. Then call
- * start_secondary().
+ * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
+ * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
+ * unplug. Everything is set up already except the stack.
  */
-SYM_FUNC_START(start_cpu0)
+SYM_FUNC_START(soft_restart_cpu)
 	movl initial_stack, %ecx
 	movl %ecx, %esp
 	call *(initial_code)
 1:	jmp 1b
-SYM_FUNC_END(start_cpu0)
+SYM_FUNC_END(soft_restart_cpu)
 #endif
 
 /*
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -377,11 +377,11 @@ SYM_CODE_END(secondary_startup_64)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
- * up already except stack. We just set up stack here. Then call
- * start_secondary() via .Ljump_to_C_code.
+ * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
+ * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
+ * unplug. Everything is set up already except the stack.
  */
-SYM_CODE_START(start_cpu0)
+SYM_CODE_START(soft_restart_cpu)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_END_OF_STACK
 
@@ -390,7 +390,7 @@ SYM_CODE_START(start_cpu0)
 	movq	TASK_threadsp(%rcx), %rsp
 
 	jmp	.Ljump_to_C_code
-SYM_CODE_END(start_cpu0)
+SYM_CODE_END(soft_restart_cpu)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1328,7 +1328,7 @@ static void sev_es_play_dead(void)
 	 * If we get here, the VCPU was woken up again. Jump to CPU
 	 * startup code to get it back online.
 	 */
-	start_cpu0();
+	soft_restart_cpu();
 }
 #else  /* CONFIG_HOTPLUG_CPU */
 #define sev_es_play_dead	native_play_dead


