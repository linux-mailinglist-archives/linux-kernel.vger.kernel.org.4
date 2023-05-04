Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB56F726A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjEDTCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEDTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:02:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D88684;
        Thu,  4 May 2023 12:02:11 -0700 (PDT)
Message-ID: <20230504185936.696863260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oNktQrwN+fatH513QPoGkxuTXmWxbBJSO1kVQSmt5aw=;
        b=gBya4Wdiox20HXnYxId2o92/cZNTV4kT8ZfWJZEW8ITXjndCeX8dDH5GHwnbCKYq4N2LZ7
        1Vliet33ezvFZfT7hZ49SRcTQY9GGkgXhlSt5j4FLFBbo8w2LMXaeiXjsd9i1J9IMUzHg1
        sJN1go/y7aKDt6GemaqC60gjrJ2Y/O06s8spq6n5PMT68ouOvPdBNo/CzyJcNIvXElJXAl
        XdjDvEAOi1DHoGQz2s+P9J0LaJZ0aZZ0+hC8ebSl7akG4yKA5FQhYbj1MWyqNbSv7kr//g
        wKJSvQLOs5Ac6Rvs5KHpecAWJnrhruw0ihD4m2E9ZObgEFCoaikI3NMnkVCBlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oNktQrwN+fatH513QPoGkxuTXmWxbBJSO1kVQSmt5aw=;
        b=ne/7c8UNDxt/B5By5H8OrJEC2F33AGALC1UJsqUQEjBRB84Yn90Pp71hqA5iKSc8E1YfLo
        xVfQnGoIgwAl59BQ==
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
Subject: [patch V2 07/38] x86/smpboot: Restrict soft_restart_cpu() to SEV
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:09 +0200 (CEST)
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

Now that the CPU0 hotplug cruft is gone, the only user is AMD SEV.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>

---
 arch/x86/kernel/callthunks.c |    2 +-
 arch/x86/kernel/head_32.S    |   14 --------------
 arch/x86/kernel/head_64.S    |    2 +-
 3 files changed, 2 insertions(+), 16 deletions(-)
---
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -133,7 +133,7 @@ static bool skip_addr(void *dest)
 	/* Accounts directly */
 	if (dest == ret_from_fork)
 		return true;
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_AMD_MEM_ENCRYPT)
 	if (dest == soft_restart_cpu)
 		return true;
 #endif
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -138,20 +138,6 @@ SYM_CODE_START(startup_32)
 	jmp .Ldefault_entry
 SYM_CODE_END(startup_32)
 
-#ifdef CONFIG_HOTPLUG_CPU
-/*
- * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
- * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot
- * unplug. Everything is set up already except the stack.
- */
-SYM_FUNC_START(soft_restart_cpu)
-	movl initial_stack, %ecx
-	movl %ecx, %esp
-	call *(initial_code)
-1:	jmp 1b
-SYM_FUNC_END(soft_restart_cpu)
-#endif
-
 /*
  * Non-boot CPU entry point; entered from trampoline.S
  * We can't lgdt here, because lgdt itself uses a data segment, but
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -375,7 +375,7 @@ SYM_CODE_END(secondary_startup_64)
 #include "verify_cpu.S"
 #include "sev_verify_cbit.S"
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_AMD_MEM_ENCRYPT)
 /*
  * Entry point for soft restart of a CPU. Invoked from xxx_play_dead() for
  * restarting the boot CPU or for restarting SEV guest CPUs after CPU hot

