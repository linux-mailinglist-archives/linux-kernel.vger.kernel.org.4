Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F106EEFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbjDZH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjDZH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:59:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 284F130EB;
        Wed, 26 Apr 2023 00:59:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680B44B3;
        Wed, 26 Apr 2023 01:00:21 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.23.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A76593F587;
        Wed, 26 Apr 2023 00:59:32 -0700 (PDT)
Date:   Wed, 26 Apr 2023 08:59:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 22/37] arm64: smp: Switch to hotplug core state
 synchronization
Message-ID: <ZEjZ3pHjQWn4drs8@FVFF77S0Q05N>
References: <20230414225551.858160935@linutronix.de>
 <20230414232310.569498144@linutronix.de>
 <ZD1q3TF2ixVD1f2M@FVFF77S0Q05N>
 <87ttx3zqof.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttx3zqof.ffs@tglx>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:51:12PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 17 2023 at 16:50, Mark Rutland wrote:
> > As a tangent/aside, we might need to improve that for confidential compute
> > architectures, and we might want to generically track cpus which might still be
> > using kernel text/data. On arm64 we ensure that via our cpu_kill() callback
> > (which'll use PSCI CPU_AFFINITY_INFO), but I'm not sure if TDX and/or SEV-SNP
> > have a similar mechanism.
> >
> > Otherwise, a malicious hypervisor can pause a vCPU just before it leaves the
> > kernel (e.g. immediately after the arch_cpuhp_cleanup_dead_cpu() call), wait
> > for a kexec (or resuse of stack memroy), and unpause the vCPU to cause things
> > to blow up.
> 
> There are a gazillion ways for a malicious hypervisor to blow up a
> 'squint enough to be confident' guest.
> 
> The real question is whether it can utilize such a blow up to extract
> confidential information from the guest.
>
> If not then it's just yet another way of DoS which is an "acceptable"
> attack as it only affects availability but not confidentiality.

Sure.

My thinking is that this is an attack against the *integrity* of the guest
(since the vCPU that gets unpasued may write to memory), and so it's
potentially more than just a DoS.

I only mention this because I'd like to account for that on arm64, and if other
architectures also wanted to handle that it might make sense to have some
common infrastructure to track whether CPUs are potentially still within the
kernel.

Thanks,
Mark.
