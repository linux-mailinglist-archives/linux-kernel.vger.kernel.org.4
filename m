Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE096E59FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjDRG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDRG6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:58:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38FCD;
        Mon, 17 Apr 2023 23:58:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681801114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JrvTFx0WVeMY9cJy762Xh8k6ZgcD547tgSMeBaRvfE=;
        b=Et6llJLqBk0yfoU12mOHK72SfYQgEWu+q48gtjbOp01/oW1pWwNWzYkMj3rsubBi7GEzq5
        mPT5IZDLQl4QKMdJBFAIqKyeL5/EHZMZmHN21initZgWfHDK9dVyf4svi0aLfhUnyeDqQK
        I3vYRVmGWdTJWrOGtNsTNLH4myxFa9B/Cic2FVRJKblYIYu57zyU8GZBAWAfanD+weXHiR
        ms33Y/xbIFrXQYi8r9H5uTRDm8lfMric1/URavwJ7tQwqLrW0R7pwMbi7rSmGj07t3TRXL
        qWncTgcrXxLCvAZcnDKbYXnQQ7HAmFlnUm/wlHJLSqR024Ajk5DxDVTQi7RWeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681801114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JrvTFx0WVeMY9cJy762Xh8k6ZgcD547tgSMeBaRvfE=;
        b=2IDo3vCdzNc6EWeefm49U4euIaA6bLjlIhlJmFMjsR5vvqBpGyDNOwFnUfvXHrOiAPFmV7
        jCwlVmV4XYpFQwCw==
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
In-Reply-To: <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de>
References: <20230414225551.858160935@linutronix.de>
 <8247ce4d-15b7-03b2-0c9b-74f8cd6cad50@molgen.mpg.de> <87wn2a4la5.ffs@tglx>
 <bd5a6a93-def1-9248-2258-c3d3b40071ef@molgen.mpg.de>
Date:   Tue, 18 Apr 2023 08:58:32 +0200
Message-ID: <87ttxd4qxz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Mon, Apr 17 2023 at 19:40, Paul Menzel wrote:
> Am 17.04.23 um 16:48 schrieb Thomas Gleixner:
>
>> On Mon, Apr 17 2023 at 13:19, Paul Menzel wrote:
>>> Am 15.04.23 um 01:44 schrieb Thomas Gleixner:
>>> [    0.258193] smpboot: CPU0: AMD A6-6400K APU with Radeon(tm) HD
>>> Graphics (family: 0x15, model: 0x13, stepping: 0x1)
>>> [=E2=80=A6]
>>> [    0.259329] smp: Bringing up secondary CPUs ...
>>> [    0.259527] x86: Booting SMP configuration:
>>> [    0.259528] .... node  #0, CPUs:      #1
>>> [    0.261007] After schedule_preempt_disabled
>>> [   10.260990] CPU1 failed to report alive state
>>=20
>> Weird. CPU1 fails to come up and report that it has reached the
>> synchronization point.
>>=20
>> Does it work when you add cpuhp.parallel=3Doff on the kernel command lin=
e?
>
> Yes, the ten seconds delay is gone with `cpuhp.parallel=3Doff`.
>
> There was a patch set in the past, that worked on that device. I think=20
> up to v4 it did *not* work at all and hung [1]. I need some days to=20
> collect the results again.

Can you please apply the patch below on top of the pile remove the
command line option again?

Thanks,


        tglx
---
 kernel/cpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1777,6 +1777,7 @@ static void __init cpuhp_bringup_mask(co
 			 */
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st, CPUHP_OFFLINE));
 		}
+		msleep(20);
 	}
 }
=20
