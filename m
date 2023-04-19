Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58026E79D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjDSMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDSMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFD0A5C8;
        Wed, 19 Apr 2023 05:38:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681907899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzrbFJX0mLRnVyg6gK50wjW8gAdRTyt3eKsS6bO2Ho8=;
        b=UQOJzBaZIKBAqIIp2iqE9MqaQt4o5jf4X54iENF8PIgb3XVSKHeAToYhSAetn/VDc3XDSc
        vbXK6VM/E7725N29s2FSKaatj7nI1wyCTjA86cgr2JkrX8DxeEun3hjlUqogLtb5s5zfSa
        SywUUUueeIYsZNv4w36kFnEjVOxY/DSPPwkyq+kebzFI7z2gYg0r9CnlmtgFv9TqDyfAlD
        YKid0ziPPcge9cOBT8GWWTc95C+prcMhIbymQfHwn03mi0EsBFOddKVOKY2XMi3tesk7+V
        TiCAx54bzs6ELiLXkmKcxWv4fFnjWSoKaHB0PW1kBv0yCnbUWTFXcy/RdtQ2bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681907899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzrbFJX0mLRnVyg6gK50wjW8gAdRTyt3eKsS6bO2Ho8=;
        b=G/PDlG02+awXAj/Znv2ir94TrCNuE4soVJYG72z/i6F9KUyMxTR0qJUk/z9cfxNZH98BUp
        FAdnV9eglXscn1DA==
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
In-Reply-To: <87a5z443g2.ffs@tglx>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de> <87wn2a4la5.ffs@tglx>
 <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de> <87ttxd4qxz.ffs@tglx>
 <87r0sh4m7a.ffs@tglx> <8592a301-9933-1cad-bd61-8d97e7c7493b@molgen.mpg.de>
 <87a5z443g2.ffs@tglx>
Date:   Wed, 19 Apr 2023 14:38:18 +0200
Message-ID: <877cu83v45.ffs@tglx>
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

On Wed, Apr 19 2023 at 11:38, Thomas Gleixner wrote:
> On Tue, Apr 18 2023 at 22:10, Paul Menzel wrote:
>> Am 18.04.23 um 10:40 schrieb Thomas Gleixner:
>>> Can you please provide the output of cpuid?
>>
>> Of course. Here the top, and the whole output is attached.
>
> Thanks for the data. Can you please apply the debug patch below and
> provide the dmesg output? Just the line which is added by the patch is
> enough. You can boot with cpuhp.parallel=off so you don't have wait for
> 10 seconds.

Borislav found some a machine which also refuses to boot. It turns of
the debug patch was spot on:

[    0.462724] .... node  #0, CPUs:      #1
[    0.462731] smpboot: Kicking AP alive: 17
[    0.465723]  #2
[    0.465732] smpboot: Kicking AP alive: 18
[    0.467641]  #3
[    0.467641] smpboot: Kicking AP alive: 19

So the kernel gets APICID 17, 18, 19 from ACPI but CPUID leaf 0x1
ebx[31:24], which is the initial APICID has:

CPU1		0x01
CPU2		0x02
CPU3		0x03

Which means the APICID to Linux CPU number lookup based on CPUID 0x01
fails for all of them and stops them dead in the low level startup code.

IOW, the BIOS assignes random numbers to the AP APICs for whatever
raisins, which leaves the parallel startup low level code up a creek
without a paddle, except for actually reading the APICID back from the
APIC. *SHUDDER*

I'm leaning towards disabling the CPUID lead 0x01 based discovery and be
done with it.

Thanks,

        tglx
