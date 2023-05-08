Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C16FB71C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjEHTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjEHToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:44:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC26E9E;
        Mon,  8 May 2023 12:43:44 -0700 (PDT)
Message-ID: <20230508185217.779457690@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683575023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hGYrzvnylJOzDXAat75Sb7qGF0AwMNGvLNaazC51fRk=;
        b=CF0aLnbIsxwy11PPaGSo9/qeT6BDOr9z6WOZ1n5alNxMpu2v9rWR0KwWbfAKKSqQHnu2Hn
        NnnSo+WQJLNlwX0V8RASx7bUePgeQQucrN8jozqHWn53CWFEZvXdW6Y2qKuXf2sMuO8LFd
        vPFSd9/cKf6jPiVXrKOCNBpqoC5p2O4AreHmLXAsBLw7vhozQ4sYeaLwrKGhc6krbZC3oC
        pq7zyVxdn/hqe1GUvju73Vol+z3Myrurw5iGjanI0WSm1tR559wW7/7IR9FR2DUET3Pet6
        d9J7XLK6/DSrSBUNRugaS2ELxaaKrUV3h9/hQgurMpa7sjjcuL3FKGuJi92j9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683575023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hGYrzvnylJOzDXAat75Sb7qGF0AwMNGvLNaazC51fRk=;
        b=zBhk/M4G/ZDNvqYEqQApQE+J8NOSpsSrbhi32/stcCYNqlxvc9b49l1CCvmbf0GB531PSJ
        vM0+Vo+LFsbAPKDw==
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
Subject: [patch v3 10/36] [patch V2 10/38] x86/cpu/cacheinfo: Remove
 cpu_callout_mask dependency
References: <20230508181633.089804905@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  8 May 2023 21:43:42 +0200 (CEST)
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

cpu_callout_mask is used for the stop machine based MTRR/PAT init.

In preparation of moving the BP/AP synchronization to the core hotplug
code, use a private CPU mask for cacheinfo and manage it in the
starting/dying hotplug state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>


---
 arch/x86/kernel/cpu/cacheinfo.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)
---

--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -39,6 +39,8 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
+static cpumask_var_t cpu_cacheinfo_mask;
+
 /* Kernel controls MTRR and/or PAT MSRs. */
 unsigned int memory_caching_control __ro_after_init;
 
@@ -1172,8 +1174,10 @@ void cache_bp_restore(void)
 		cache_cpu_init();
 }
 
-static int cache_ap_init(unsigned int cpu)
+static int cache_ap_online(unsigned int cpu)
 {
+	cpumask_set_cpu(cpu, cpu_cacheinfo_mask);
+
 	if (!memory_caching_control || get_cache_aps_delayed_init())
 		return 0;
 
@@ -1191,11 +1195,17 @@ static int cache_ap_init(unsigned int cp
 	 *      lock to prevent MTRR entry changes
 	 */
 	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
-				       cpu_callout_mask);
+				       cpu_cacheinfo_mask);
 
 	return 0;
 }
 
+static int cache_ap_offline(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, cpu_cacheinfo_mask);
+	return 0;
+}
+
 /*
  * Delayed cache initialization for all AP's
  */
@@ -1210,9 +1220,12 @@ void cache_aps_init(void)
 
 static int __init cache_ap_register(void)
 {
+	zalloc_cpumask_var(&cpu_cacheinfo_mask, GFP_KERNEL);
+	cpumask_set_cpu(smp_processor_id(), cpu_cacheinfo_mask);
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_CACHECTRL_STARTING,
 				  "x86/cachectrl:starting",
-				  cache_ap_init, NULL);
+				  cache_ap_online, cache_ap_offline);
 	return 0;
 }
-core_initcall(cache_ap_register);
+early_initcall(cache_ap_register);


