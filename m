Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09DC6F7219
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjEDSqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEDSqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:46:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5F83C33;
        Thu,  4 May 2023 11:46:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683225976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIAcVs2YXBnNfaPvpuizW2PEW4lhJ1YnG6MUoZkO7aY=;
        b=3+tD+LTP2nHbLKQ6ayQSSKK8VpBIuQK3gXforAfUYbXvx4vM+fYGuufKzSpG2saVKOpTsV
        to0Q6mzIGbAQjDqsOQkje2Tja0U/TKz3F+TviP3kf+19hr3bEm6s4uGo2F+s+PdBgPIGkj
        gHjK9Yi0pM4GUZc5ZpONvd31Hppwcu+Bcbd8TlaOcVKhOuZIjToIAW5YXeXW3Go5sZpcCh
        htSi5EE8To3+PKCGlsNtyNrMRTsE8PlVdNzqWmd8pkRxZ1vMQC2VO2mXVu6cVctYauCbM0
        4H8XFlx6BIILGrhdr/EBrOtC8Cm0866nFAfWkkLlHu0QtdUMHZ2jk6jWm8xf3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683225976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIAcVs2YXBnNfaPvpuizW2PEW4lhJ1YnG6MUoZkO7aY=;
        b=pPb8Wqh2Bj6AkjBEVHoo9nA/DLOEH7EgQ6O+EgS1RtAjQlyepgF0Tr/3dF7rDdC5tR1PRC
        DisRQOSHrsQxZlDw==
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw@infradead.org>,
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
        David Woodhouse <dwmw@amazon.co.uk>,
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
Subject: RE: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
In-Reply-To: <BYAPR21MB168888DC5432883D8866BA40D76A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230414225551.858160935@linutronix.de>
 <BYAPR21MB168888DC5432883D8866BA40D76A9@BYAPR21MB1688.namprd21.prod.outlook.com>
Date:   Thu, 04 May 2023 20:46:15 +0200
Message-ID: <878re43pfs.ffs@tglx>
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

Michael!

On Thu, Apr 27 2023 at 14:48, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Friday, April 14, 2023 4:44 PM
>
> I smoke-tested several Linux guest configurations running on Hyper-V,
> using the "kernel/git/tglx/devel.git hotplug" tree as updated on April 26th.
> No functional issues, but encountered one cosmetic issue (details below).
>
> Configurations tested:
> *  16 vCPUs and 32 vCPUs
> *  1 NUMA node and 2 NUMA nodes
> *  Parallel bring-up enabled and disabled via kernel boot line
> *  "Normal" VMs and SEV-SNP VMs running with a paravisor on Hyper-V.
>     This config can use parallel bring-up because most of the SNP-ness is
>     hidden in the paravisor.  I was glad to see this work properly.
>
> There's not much difference in performance with and without parallel
> bring-up on the 32 vCPU VM.   Without parallel, the time is about 26
> milliseconds.  With parallel, it's about 24 ms.   So bring-up is already
> fast in the virtual environment.

Depends on the environment :)

> The cosmetic issue is in the dmesg log, and arises because Hyper-V
> enumerates SMT CPUs differently from many other environments.  In
> a Hyper-V guest, the SMT threads in a core are numbered as <even, odd>
> pairs.  Guest CPUs #0 & #1 are SMT threads in core, as are #2 & #3, etc.  With
> parallel bring-up, here's the dmesg output:
>
> [    0.444345] smp: Bringing up secondary CPUs ...
> [    0.445139] .... node  #0, CPUs:    #2  #4  #6  #8 #10 #12 #14 #16 #18 #20 #22 #24 #26 #28 #30
> [    0.454112] x86: Booting SMP configuration:
> [    0.456035]       #1  #3  #5  #7  #9 #11 #13 #15 #17 #19 #21 #23 #25 #27 #29 #31
> [    0.466120] smp: Brought up 1 node, 32 CPUs
> [    0.467036] smpboot: Max logical packages: 1
> [    0.468035] smpboot: Total of 32 processors activated (153240.06 BogoMIPS)
>
> The function announce_cpu() is specifically testing for CPU #1 to output the
> "Booting SMP configuration" message.  In a Hyper-V guest, CPU #1 is the second
> SMT thread in a core, so it isn't started until all the even-numbered CPUs are
> started.

Ah. Didn't notice that because SMT siblings are usually enumerated after
all primary ones in ACPI.

> I don't know if this cosmetic issue is worth fixing, but I thought I'd point it out.

That's trivial enough to fix. I'll amend the topmost patch before
posting V2.

Thanks for giving it a ride!

       tglx
