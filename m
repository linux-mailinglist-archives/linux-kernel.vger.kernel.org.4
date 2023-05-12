Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6745701066
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbjELVIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjELVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:07:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78873A25F;
        Fri, 12 May 2023 14:07:27 -0700 (PDT)
Message-ID: <20230512205256.316417181@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683925643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DlXLIimSUyDsLnpaLCie3XUbsPcjE+B3Y5/np73/syk=;
        b=0n8XyUqdMKHvhCV5NvBs8uq0bkyvVXbfLtaGYG0ApQJEOyilZiFp81ncYSBr6upR2FGS65
        C/nM69M5fEGpiISmkmAowedNeMh8stJLEoOo7kEL2Yn2+06PaBevfLVashkK38xEMls2k0
        f/2djYvKqyUSewvgr/tLWZAR3cGWoQ2BFlZWa6eUYCxL/R/BBbwHpxF3oihmcCNqrcO5vL
        DdSUgTidw3Y3j0rys0Ztwy/cnS3zHqjKWZhecFMnqr4ICUwW5Yz4Fvu/UCxs3vooavSjLb
        kpbMhzb9bUAKVmUd7V7KcFTAjo4mQTSyfyHcI0YMf+BOz6gUP+32KRGIcgecpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683925643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=DlXLIimSUyDsLnpaLCie3XUbsPcjE+B3Y5/np73/syk=;
        b=NxwadJuaL5bNYJvtkxpDH+oWBvMqBd0ae6N3DUYGY2xW3p33/XvIRC9MwzW0Aq6/9Tjy03
        UcA8T+Ga+8Z9ZeBg==
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
Subject: [patch V4 16/37] x86/smpboot: Remove wait for cpu_online()
References: <20230512203426.452963764@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 23:07:22 +0200 (CEST)
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

Now that the core code drops sparse_irq_lock after the idle thread
synchronized, it's pointless to wait for the AP to mark itself online.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/kernel/smpboot.c |   26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -275,7 +275,6 @@ static void notrace start_secondary(void
 	 * half valid vector space.
 	 */
 	lock_vector_lock();
-	/* Sync point with do_wait_cpu_online() */
 	set_cpu_online(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
@@ -1104,20 +1103,6 @@ static int wait_cpu_initialized(unsigned
 	return 0;
 }
 
-/*
- * Bringup step three: Wait for the target AP to reach set_cpu_online() in
- * start_secondary().
- */
-static void wait_cpu_online(unsigned int cpu)
-{
-	/*
-	 * Wait for the AP to mark itself online, so the core caller
-	 * can drop sparse_irq_lock.
-	 */
-	while (!cpu_online(cpu))
-		schedule();
-}
-
 static int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid = apic->cpu_present_to_apicid(cpu);
@@ -1164,16 +1149,9 @@ int native_cpu_up(unsigned int cpu, stru
 	int ret;
 
 	ret = native_kick_ap(cpu, tidle);
-	if (ret)
-		goto out;
-
-	ret = wait_cpu_initialized(cpu);
-	if (ret)
-		goto out;
-
-	wait_cpu_online(cpu);
+	if (!ret)
+		ret = wait_cpu_initialized(cpu);
 
-out:
 	/* Cleanup possible dangling ends... */
 	if (x86_platform.legacy.warm_reset)
 		smpboot_restore_warm_reset_vector();

