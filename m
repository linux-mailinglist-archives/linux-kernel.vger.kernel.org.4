Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E437C6F72CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjEDTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEDTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:03:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396B9EC4;
        Thu,  4 May 2023 12:03:05 -0700 (PDT)
Message-ID: <20230504185938.126719312@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C2xEv0EYOzjjBDOf0WNXDnbg3SxiEflVftHaff1ezNc=;
        b=R7TFizeMBd1vCDVjEXU0BtfNbQoQd0Q7O5Cmi/GhoH+A7DPO/eDCQYvwL8d0EzW6TZevXV
        zTSW3dCyZNMiwvAMbTbcTVfTHbY6pLve5Gv/afd1jzhLujx3f5ZspMS2zkpgXg0oDc3s5d
        kXcBYyWoHlipJH2VBBXdFP8QtRznLbAKZV10Ph92/Hk65CJwnRS+0u5oUwspH7khzqSQ/u
        SpYu0bcq4JwwE/JeCF3NwhBMiC+1RMRMfogzt5BdrL549/PBdPFpI4eEajMl9aEC63+JVF
        9zu2Vsz02+ZJpxAIfDIw2+6pnaLRSdZXjwd9Lq61E8b+1bqiBtxkam2eHoBKxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C2xEv0EYOzjjBDOf0WNXDnbg3SxiEflVftHaff1ezNc=;
        b=L3yFFvyeaWcbSL4+w4FNUsUl3Xq9FYBhGlVedajTlxgN49PBR5/K5uqBP8Q/AEH8xz/YfX
        kk6rHy0rbLZe69Cw==
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
Subject: [patch V2 33/38] x86/topology: Store extended topology leaf information
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:51 +0200 (CEST)
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

Save the extended topology leaf number if it exists and is valid in
preparation of parallel CPU bringup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/topology.h |    1 +
 arch/x86/kernel/cpu/topology.c  |    3 +++
 2 files changed, 4 insertions(+)
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -121,6 +121,7 @@ extern unsigned int __max_die_per_packag
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
+extern unsigned int topology_extended_leaf;
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,6 +29,8 @@ unsigned int __max_die_per_package __rea
 EXPORT_SYMBOL(__max_die_per_package);
 
 #ifdef CONFIG_SMP
+unsigned int topology_extended_leaf __read_mostly;
+
 /*
  * Check if given CPUID extended topology "leaf" is implemented
  */
@@ -72,6 +74,7 @@ int detect_extended_topology_early(struc
 	if (leaf < 0)
 		return -1;
 
+	topology_extended_leaf = leaf;
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);

