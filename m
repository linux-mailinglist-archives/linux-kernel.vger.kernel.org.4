Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC3701028
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbjELVHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjELVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E2CE;
        Fri, 12 May 2023 14:07:02 -0700 (PDT)
Message-ID: <20230512205255.551974164@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AjuZnUvqwfsid4jtivwVWrZiWUy0MGdS0WowlWq+wK8=;
        b=BSrk1PoZLCui388wbL4NkY9LaBfz+vMljVOsc8GC5TTSN9IaN934ZXN1fRPgPIUcdUGSe3
        rs+LcXmfTyJYvxvJjsFf8f0ApOwip1PicNa981xcjH4MKVqkoKpyzlxwwHOYcfLC+B5mEd
        7Y+gbMD+piaijvIlyMzYPyuPxHohAIb3XSFige4l+xuoi82leA8PAeQ31hGSlVRwPD+wQ3
        n6n4pYD7mFa1Y0Rsvl1DCfEMOgpANdQ/E16QD6t2Dh7pRICCqjhN/gPgPrM+fPp2Si/ih2
        sU+p5Egl9N/3D2qoNiCRvjAFt/X3L02D3fNEkcYdWn40i1TAkciD/voa8T04sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AjuZnUvqwfsid4jtivwVWrZiWUy0MGdS0WowlWq+wK8=;
        b=n1wnoGuKdWFqJ6PX+VgQN0Ufd6Syw8of6US1WCmh8XhXmEUBV6cIJXGutet95c8P750ccR
        /kEaioxsm/Oq80Bw==
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
Subject: [patch V4 02/37] cpu/hotplug: Mark arch_disable_smp_support() and
 bringup_nonboot_cpus() __init
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:00 +0200 (CEST)
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

No point in keeping them around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/smpboot.c |    4 ++--
 kernel/cpu.c              |    2 +-
 kernel/smp.c              |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)


--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1269,9 +1269,9 @@ int native_cpu_up(unsigned int cpu, stru
 }
 
 /**
- * arch_disable_smp_support() - disables SMP support for x86 at runtime
+ * arch_disable_smp_support() - Disables SMP support for x86 at boottime
  */
-void arch_disable_smp_support(void)
+void __init arch_disable_smp_support(void)
 {
 	disable_ioapic_support();
 }
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1502,7 +1502,7 @@ int bringup_hibernate_cpu(unsigned int s
 	return 0;
 }
 
-void bringup_nonboot_cpus(unsigned int setup_max_cpus)
+void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
 	unsigned int cpu;
 
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -892,7 +892,7 @@ EXPORT_SYMBOL(setup_max_cpus);
  * SMP mode to <NUM>.
  */
 
-void __weak arch_disable_smp_support(void) { }
+void __weak __init arch_disable_smp_support(void) { }
 
 static int __init nosmp(char *str)
 {



