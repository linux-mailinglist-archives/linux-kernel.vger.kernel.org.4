Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD186EE8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjDYTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjDYTvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:51:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BC122;
        Tue, 25 Apr 2023 12:51:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682452273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epqrrIP9XVMR1rQYOgUv6OMHFSXsoKyAhdvov9JTG3c=;
        b=hcfCyrdfQ/+yHnKF3T+I49mLvnN7Y7S69gBRQL7PhhKJcZIQM6dUY5pvAbw4x5UtKBksj5
        +gNdAWyqbtppxTS6xk/OOGkQEgCKZ50daZMUpYiSsjHUolnRQ63od8fRIwCIy22iqsL7Jz
        ptuYgLF2Vyi6TxSoYJlRddHoLRBh0aBb/2ut263viqoCn4L8IM34OuGeUFz0vHjf3uDsn9
        kzIwMYp79iEd+cDm0M3l/TvJoQ8Ebljb98ttQPEip+uioS6jdgokPZm34PxDLgh8kTLkX7
        Tk0Brm7tWOMbl31MYKpF+X1fNVmxtHUKna8IUJdeJdt+TiqryaL2tjxt/WxUaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682452273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epqrrIP9XVMR1rQYOgUv6OMHFSXsoKyAhdvov9JTG3c=;
        b=mlbSRhNUu/9kpluKPqwDbDiOM+hdImwLPmR+/CiZOtx2CU7HgipiQ7bg9V2pgBimVEqMmi
        qqHiWR0zzWYsg/Bg==
To:     Mark Rutland <mark.rutland@arm.com>
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
In-Reply-To: <ZD1q3TF2ixVD1f2M@FVFF77S0Q05N>
References: <20230414225551.858160935@linutronix.de>
 <20230414232310.569498144@linutronix.de> <ZD1q3TF2ixVD1f2M@FVFF77S0Q05N>
Date:   Tue, 25 Apr 2023 21:51:12 +0200
Message-ID: <87ttx3zqof.ffs@tglx>
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

On Mon, Apr 17 2023 at 16:50, Mark Rutland wrote:
> On Sat, Apr 15, 2023 at 01:44:49AM +0200, Thomas Gleixner wrote:
> I gave this a spin on arm64 (in a 64-vCPU VM on an M1 host), and it seems to
> work fine with a bunch of vCPUs being hotplugged off and on again randomly.
>
> FWIW:
>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
>
> I also hacked the code to have the dying CPU spin forever before the call to
> cpuhp_ap_report_dead(). In that case I see a warning, and that we don't call
> arch_cpuhp_cleanup_dead_cpu(), and that the CPU is marked as offline (per
> /sys/devices/system/cpu/$N/online).

Nice!

> As a tangent/aside, we might need to improve that for confidential compute
> architectures, and we might want to generically track cpus which might still be
> using kernel text/data. On arm64 we ensure that via our cpu_kill() callback
> (which'll use PSCI CPU_AFFINITY_INFO), but I'm not sure if TDX and/or SEV-SNP
> have a similar mechanism.
>
> Otherwise, a malicious hypervisor can pause a vCPU just before it leaves the
> kernel (e.g. immediately after the arch_cpuhp_cleanup_dead_cpu() call), wait
> for a kexec (or resuse of stack memroy), and unpause the vCPU to cause things
> to blow up.

There are a gazillion ways for a malicious hypervisor to blow up a
'squint enough to be confident' guest.

The real question is whether it can utilize such a blow up to extract
confidential information from the guest.

If not then it's just yet another way of DoS which is an "acceptable"
attack as it only affects availability but not confidentiality.

Thanks,

        tglx
