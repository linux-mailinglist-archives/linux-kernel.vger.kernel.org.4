Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79346D0FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjC3UVN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 16:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC3UVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:21:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC00440D3;
        Thu, 30 Mar 2023 13:21:06 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phylD-0006W9-Vs; Thu, 30 Mar 2023 22:20:40 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>, Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, slewis@rivosinc.com,
        Vineet Gupta <vineetg@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
Date:   Thu, 30 Mar 2023 22:20:38 +0200
Message-ID: <6540574.4vTCxPXJkl@diego>
In-Reply-To: <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
 <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. März 2023, 20:30:29 CEST schrieb Evan Green:
> On Thu, Feb 23, 2023 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Feb 21, 2023, at 20:08, Evan Green wrote:
> > > We don't have enough space for these all in ELF_HWCAP{,2} and there's no
> > > system call that quite does this, so let's just provide an arch-specific
> > > one to probe for hardware capabilities.  This currently just provides
> > > m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
> > > the future.
> > >
> > > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > I'm still skeptical about the need for a custom syscall interface here.
> > I had not looked at the interface so far, but there are a few things
> > that stick out:
> >
> > > +RISC-V Hardware Probing Interface
> > > +---------------------------------
> > > +
> > > +The RISC-V hardware probing interface is based around a single
> > > syscall, which
> > > +is defined in <asm/hwprobe.h>::
> > > +
> > > +    struct riscv_hwprobe {
> > > +        __s64 key;
> > > +        __u64 value;
> > > +    };
> >
> > The way this is defined, the kernel will always have to know
> > about the specific set of features, it can't just forward
> > unknown features to user space after probing them from an
> > architectured hardware interface or from DT.
> 
> You're correct that this interface wasn't intended to have usermode
> come in with augmented data or additional key/value pairs. This was
> purely meant to provide access to the kernel's repository of
> architectural and microarchitectural details. If usermode wants to
> provide extra info in this same form, maybe they could wrap this
> interface.
>
> > If 'key' is just an enumerated value with a small number of
> > possible values, I don't see anything wrong with using elf
> > aux data. I understand it's hard to know how many keys
> > might be needed in the long run, from the way you define
> > the key/value pairs here, I would expect it to have a lot
> > of the same limitations that the aux data has, except for
> > a few bytes to be copied.
> 
> Correct, this makes allocating bits out of here cheaper by not
> requiring that we actively copy them into every new process forever.
> You're right that the aux vector would work as well, but the thinking
> behind this series was that an interface like this might be better for
> an architecture as extensible as risc-v.

What would be the ramifications of defining some sort of vdso-like
data-structure and just putting the address into AT_HWCAP2 ?
(similar to what vdso does) - that could then even be re-usable
with other OS kernels.

And would also save declaring numerous new AT_* keys.


Because there are already nearly 130 standard extensions and vendors
are allowed to defines their own as well, and we will probably also want
to tell userspace about them.


Heiko


> > > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t
> > > pair_count,
> > > +                           size_t cpu_count, cpu_set_t *cpus,
> > > +                           unsigned long flags);
> >
> > The cpu set argument worries me more: there should never be a
> > need to optimize for broken hardware that has an asymmetric set
> > of features. Just let the kernel figure out the minimum set
> > of features that works across all CPUs and report that like we
> > do with HWCAP. If there is a SoC that is so broken that it has
> > important features on a subset of cores that some user might
> > actually want to rely on, then have them go through the slow
> > sysfs interface for probing the CPUs indidually, but don't make
> > the broken case easier at the expense of normal users that
> > run on working hardware.
> 
> I'm not so sure. While I agree with you for major classes of features
> (eg one CPU has floating point support but another does not), I expect
> these bits to contain more subtle details as well, which might vary
> across asymmetric implementations without breaking ABI compatibility
> per-se. Maybe some vendor has implemented exotic video decoding
> acceleration instructions that only work on the big core. Or maybe the
> big cores support v3.1 of some extension (where certain things run
> faster), but the little cores only have v3.0, where it's a little
> slower. Certain apps would likely want to know these things so they
> can allocate their work optimally across cores.
> 
> >
> > > +asmlinkage long sys_riscv_hwprobe(uintptr_t, uintptr_t, uintptr_t,
> > > uintptr_t,
> > > +                               uintptr_t, uintptr_t);
> >
> > Why 'uintptr_t' rather than the correct type?
> 
> Fixed.
> -Evan
> 




