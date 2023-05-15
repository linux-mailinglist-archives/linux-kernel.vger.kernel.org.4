Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7D702C37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbjEOMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbjEOMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:03:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95F19BA;
        Mon, 15 May 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mEVtTPGjX5VUAK36tVkFbSuQO22AuGeDmAzn9epzuw=; b=AmiVyh00bk/IBxeKT1sJOhNhPw
        sKnnSOF2uFizS5FDPwFE+Ot6Zv0LcoZ6HJF47h5sBYfsBjpiqyZyI5uuDK5u2MZ4g4WobyDMhkodb
        fUSujxE1pqhBhDi+eUM0ht45DR2Y3i+nr1YT42g2zawDfvMwb295A0aq8ARQ+5Z4gi/pV9YXxQYVt
        3wUGZYGDjBC3RzitLceq6j/qPs1owVcSfLpElN1Y8S30KXDX5uH0Odcz4RLnxHbc6f5jNYL4oL/bz
        nTpSFPHQoB6BKp5r4Q6WAS69amz0yrUYHbuk51pYpxo8D3N1weBBW6mFoBFyYlJ+O4Y0A9ycf248d
        MFethNqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyWsq-00BTBM-2z;
        Mon, 15 May 2023 12:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D89B330003A;
        Mon, 15 May 2023 14:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A377520AA5AEB; Mon, 15 May 2023 14:00:51 +0200 (CEST)
Date:   Mon, 15 May 2023 14:00:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [patch V4 37/37] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Message-ID: <20230515120051.GH83892@hirez.programming.kicks-ass.net>
References: <20230512203426.452963764@linutronix.de>
 <20230512205257.467571745@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512205257.467571745@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:07:56PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Implement the validation function which tells the core code whether
> parallel bringup is possible.
> 
> The only condition for now is that the kernel does not run in an encrypted
> guest as these will trap the RDMSR via #VC, which cannot be handled at that
> point in early startup.
> 
> There was an earlier variant for AMD-SEV which used the GHBC protocol for
> retrieving the APIC ID via CPUID, but there is no guarantee that the
> initial APIC ID in CPUID is the same as the real APIC ID. There is no
> enforcement from the secure firmware and the hypervisor can assign APIC IDs
> as it sees fit as long as the ACPI/MADT table is consistent with that
> assignment.
> 
> Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling
> AMD-SEV guests for parallel startup needs some more thought.

One option, other than adding said protocol, would be to:

 - use the APICID from CPUID -- with the expectation that it can be
   wrong.
 - (ab)use one of the high bits in cpuid_to_apicid[] as a test-and-set
   trylock. This avoids two CPUs from using the same per-cpu base, if
   CPUID is being malicious. Panic on fail.
 - validate against MSR the moment we can and panic if not matching

The trylock ensures the stacks/percpu state is not used by multiple
CPUs, and should guarantee a coherent state to get far enough along to
be able to do the #VE inducing RDMSR.


