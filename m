Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDE6F9315
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEFQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:22:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00F4680;
        Sat,  6 May 2023 09:22:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683390158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXHfBgcGHt/ZfPwa+T595dnepfFJKJnpLjR3JhBl6Q0=;
        b=1czMZh1cRjeqiQ2TZA6GbMVHHXEF93eQIVvQioB8FE/pRwMNCJ9iNbT002o3Vf8Q1PmjjT
        pMzD7AC5NROe0zWPr/xkstx8tP21FQigIYhXnCedHf48++FNK52empvCyZE4IMSf7ryah7
        wwDm68n14K3LZeFvyQ99Fwubq6JJjmTxOyIllycil0ZJfXjm8tULzw2/ivE/eeRZ3vZ2Ce
        eFzoWJEYtyiUQ3YTBmQpXzsA8QFgMuJS8CeTY8f2OfEh+NvACDq69zDAubztHsM41nl1p1
        k+Q1vY7kiaQqTaWRFrb4KJC+127qTmzlxib6lozIfkeM3gQq7L3F5SIRCIw/xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683390158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXHfBgcGHt/ZfPwa+T595dnepfFJKJnpLjR3JhBl6Q0=;
        b=qtQ0xS4FhuHdv2/qWAJNtp26GqvWQxksH6Mo/Q1MgLXE9WE0n6Pih7C913p3eWGR7QXk2c
        rCYD41DUjLVIXsBw==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
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
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: RE: [patch V2 38/38] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
In-Reply-To: <BYAPR21MB168869144087644F89BAC89FD7739@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230504185733.126511787@linutronix.de>
 <20230504185938.393373946@linutronix.de>
 <BYAPR21MB168869144087644F89BAC89FD7739@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Sat, 06 May 2023 18:22:37 +0200
Message-ID: <87sfc92zw2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06 2023 at 00:53, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, May 4, 2023 12:03 PM
> [snip]
>
>> @@ -934,10 +961,10 @@ static void announce_cpu(int cpu, int ap
>>  	if (!node_width)
>>  		node_width = num_digits(num_possible_nodes()) + 1; /* + '#' */
>> 
>> -	if (cpu == 1)
>> -		printk(KERN_INFO "x86: Booting SMP configuration:\n");
>> -
>>  	if (system_state < SYSTEM_RUNNING) {
>> +		if (num_online_cpus() == 1)
>
> Unfortunately, this new check doesn't work.  Here's the output I get:
>
> [    0.721384] smp: Bringing up secondary CPUs ...
> [    0.725359] smpboot: x86: Booting SMP configuration:
> [    0.729249] .... node  #0, CPUs:        #2
> [    0.729654] smpboot: x86: Booting SMP configuration:
> [    0.737247]       #4
>
> Evidently num_online_cpus() isn't updated until after all the primary
> siblings get started.

Duh. Where is that brown paperbag?

> When booting with cpuhp.parallel=0, the output is good.

Exactly that was on the command line when I quickly booted that change :(

The below should fix it for real.

Thanks,

        tglx
---
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -951,9 +951,9 @@ static int wakeup_secondary_cpu_via_init
 /* reduce the number of lines printed when booting a large cpu count system */
 static void announce_cpu(int cpu, int apicid)
 {
+	static int width, node_width, first = 1;
 	static int current_node = NUMA_NO_NODE;
 	int node = early_cpu_to_node(cpu);
-	static int width, node_width;
 
 	if (!width)
 		width = num_digits(num_possible_cpus()) + 1; /* + '#' sign */
@@ -962,7 +962,7 @@ static void announce_cpu(int cpu, int ap
 		node_width = num_digits(num_possible_nodes()) + 1; /* + '#' */
 
 	if (system_state < SYSTEM_RUNNING) {
-		if (num_online_cpus() == 1)
+		if (first)
 			pr_info("x86: Booting SMP configuration:\n");
 
 		if (node != current_node) {
@@ -975,11 +975,11 @@ static void announce_cpu(int cpu, int ap
 		}
 
 		/* Add padding for the BSP */
-		if (num_online_cpus() == 1)
+		if (first)
 			pr_cont("%*s", width + 1, " ");
+		first = 0;
 
 		pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
-
 	} else
 		pr_info("Booting Node %d Processor %d APIC 0x%x\n",
 			node, cpu, apicid);
