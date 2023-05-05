Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0006F8337
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEEMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjEEMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:45:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8817FC3;
        Fri,  5 May 2023 05:45:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683290728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ro/VOFl72UDWFwy8gwNK93pOtDrJEFznvt3NXDl6cF8=;
        b=NEssImE7oVj95z4/FBIZJnxzphr31CeA4k7oJeJinz1r5r1l9dXN1gppKxrfH844UqDO9z
        4QSvSZ+MCzWy04loOUdVFWsJabtUy+6xAHaZOnUP3kDamwQqqChUVjh6yxS90kqh/3foQl
        BxPnqXdK0mEFhXKLhgXSM8yu090mNdF9FRSITtHjxNfxijznNsQsOy0jITHZ9ajNCFSUr7
        ixcpybMXO0+Tte9hyNa1D9uPISenZGZ0GM57Wg5ua9BDE6mitsB+qwg3eCN369M6O0Jwe5
        /MuZBe8FpjmVO3WPvPxa64u3KW+r1rcVtivlIiAVpuzcTFgSsngi+McsE/7vlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683290728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ro/VOFl72UDWFwy8gwNK93pOtDrJEFznvt3NXDl6cF8=;
        b=65zpCtdzuEaRqOzhfQTeNfeiCJfu8TviFjuPm0aorQPKM8pLdEAQ4DrGamxrKih4/79CxI
        kPU4Ye7GnkFx6vAA==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [patch V2 34/38] x86/cpu/amd; Invoke
 detect_extended_topology_early() on boot CPU
In-Reply-To: <38b259bb-050b-023e-4f43-212f95f022ac@citrix.com>
References: <20230504185733.126511787@linutronix.de>
 <20230504185938.179661118@linutronix.de>
 <38b259bb-050b-023e-4f43-212f95f022ac@citrix.com>
Date:   Fri, 05 May 2023 14:45:28 +0200
Message-ID: <87354b3q1j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05 2023 at 00:04, Andrew Cooper wrote:
> On 04/05/2023 8:02 pm, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> The early detection stores the extended topology leaf number which is
>> required for parallel hotplug.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> It occurs to me that this and the previous patch are stale given that we
> no longer look at CPUID in the trampoline.
>
> They're probably useful changes in isolation, but the commit messages
> want adjusting to remove the association with parallel boot.

Duh. Indeed. Completely forgot about that.
