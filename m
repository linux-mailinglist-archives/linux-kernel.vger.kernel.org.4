Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4886E7B26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjDSNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjDSNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:43:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F914146EA;
        Wed, 19 Apr 2023 06:43:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681911801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFu1BiBIiZJxXn+1gDPlWVAOg5qQuCy99rAdIveUYFI=;
        b=GioJJVLP3xsJ8meXcrDWG5s5gdc8c0v+E+hPsGfax24KRpT161PXreAJ6xSi1/ffGHB7Ig
        QiBx1CCi33pppdwmwttJl7f18G3nqG0JMirkvI2B/KLs1tu2KE0oys4tguZIBjdpC698x5
        qJxDi+HpdhZXd4d+95gQdCA+EcnPYPHRun+2UdCS7FOBBh/HuWgOjO1wzT9vOvsEMfGXhZ
        Bp60sCQp4nsgLMYaR72tlHdyX8qr1HW2HBQ6txx5eUn8Q1HfGVvmcQX/+2gPF1pOlVbSvA
        J67MiipF05Kzmx+7IpQU6gIRKBAfRvBEfF5UQtkBc9rk1oQMLK4aT2yGkLma2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681911801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFu1BiBIiZJxXn+1gDPlWVAOg5qQuCy99rAdIveUYFI=;
        b=PpcgZgskhULkL7/jgakP7Wurg7G56yGaYp+uPBAUp/opltoRjM69gQ7OhILB+Kv0LHnaHA
        BEEUccjsOmhHz0CA==
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
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
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
In-Reply-To: <877cu83v45.ffs@tglx>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de> <87wn2a4la5.ffs@tglx>
 <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de> <87ttxd4qxz.ffs@tglx>
 <87r0sh4m7a.ffs@tglx> <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de>
 <87a5z443g2.ffs@tglx> <877cu83v45.ffs@tglx>
Date:   Wed, 19 Apr 2023 15:43:20 +0200
Message-ID: <874jpc3s3r.ffs@tglx>
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

On Wed, Apr 19 2023 at 14:38, Thomas Gleixner wrote:
> On Wed, Apr 19 2023 at 11:38, Thomas Gleixner wrote:
> IOW, the BIOS assignes random numbers to the AP APICs for whatever
> raisins, which leaves the parallel startup low level code up a creek
> without a paddle, except for actually reading the APICID back from the
> APIC. *SHUDDER*

So Andrew just pointed out on IRC that this might be related to the
ancient issue of the 3-wire APIC bus where IO/APIC and APIC shared the
ID space, but that system is definitely post 3-wire APIC :)

Thanks,

        tglx


