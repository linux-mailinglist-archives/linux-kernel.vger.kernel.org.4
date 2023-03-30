Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF36D10D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjC3VZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC3VZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:25:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6D1A5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:25:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so26259645lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680211515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYqYBLcFFkNS/UgYTJsvNxji20IdJ1DULm+w6DtBki4=;
        b=gy/54b0UsOHthQjf3JEADvmY5I+IUJvFjCAXPsGfjxeR2WRZkkgf5VbtrOND5mQnty
         mTyCaFMS7EjfoB3lyjPHLCbZfY2SOgJp7pWI0Sq+2/vzi7aPZOja4vE/a/yCFkc1Gk/y
         EkeE00rqXSWfBBDmkrLc5eU4KXQpDC1YT1fxScZSg+icIsHGmPQhILPbh1IpiMSO0ayC
         O/wJI0u5FjDi2uPSjMcic1FdsiLqd2bFUkaZuLw+6JfCVLXF7CZCL8K220VlVPojiXqb
         3iZg/mW0N4sLH3p7YuUh5ftHLnFSYemU6qnxy1r7xZR0jbEesxy1uYDzlzLHaJczrp6Q
         wPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYqYBLcFFkNS/UgYTJsvNxji20IdJ1DULm+w6DtBki4=;
        b=yNsVtuXJHUaujBXuDdp+IBQgIAGi0h8SCinym5p3uLYwKqoqKOB2EtCQVja3Q8SHTA
         eyu0c6FgSYE02Ena2KUBv2myg3ukQlAQPR/bZQDTojRYTmfpgOsC/P+5fZXYKQPRlAUW
         /WfcnqM+BjHvoaGUAtbeH2L5Fc9IiLsKlS3RNtobPbGdQX7JiGGxA9a5PhegJQ8uE5oR
         hewDk41FxX15z56Mwh6LRCcHdjmwiZBuqWoyVaOCSharu1RqwxScmLf1EHNOAxtRAPjW
         Mx8HGnzdz+dxmse+64/Bg1Jd7WSBgtJlfhu2HPcgLwS2N0CkMqwfFGyksvAzfMpENSH1
         CGIg==
X-Gm-Message-State: AAQBX9fhpO1F6Qh+y2ef3Jh/GARRIJmxy9ysCcPn9kYNTuSAe34Wj8d1
        84smX/zRis3VOOJLNsVH+KAFJRixdmwDcArPuVXnGg==
X-Google-Smtp-Source: AKy350YG+E22ikOANN7EgpjoEaKBmyUQkCMHo5NqvO+gl/QgqV5f2+53M+I2j1QxqSNsLgDewuS3L1HuSAYGOZAwpT4=
X-Received: by 2002:ac2:4884:0:b0:4db:1999:67a3 with SMTP id
 x4-20020ac24884000000b004db199967a3mr7458577lfc.13.1680211514656; Thu, 30 Mar
 2023 14:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230221190858.3159617-1-evan@rivosinc.com> <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
 <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com> <6540574.4vTCxPXJkl@diego>
In-Reply-To: <6540574.4vTCxPXJkl@diego>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 30 Mar 2023 14:24:38 -0700
Message-ID: <CALs-Hsvgg6aZctwxjMqi2k6D5QFWy6oOEG682gb7xb3T2iNE4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 1:20=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Am Donnerstag, 30. M=C3=A4rz 2023, 20:30:29 CEST schrieb Evan Green:
> > On Thu, Feb 23, 2023 at 2:06=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> > >
> > > On Tue, Feb 21, 2023, at 20:08, Evan Green wrote:
> > > > We don't have enough space for these all in ELF_HWCAP{,2} and there=
's no
> > > > system call that quite does this, so let's just provide an arch-spe=
cific
> > > > one to probe for hardware capabilities.  This currently just provid=
es
> > > > m{arch,imp,vendor}id, but with the key-value pairs we can pass more=
 in
> > > > the future.
> > > >
> > > > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > >
> > > I'm still skeptical about the need for a custom syscall interface her=
e.
> > > I had not looked at the interface so far, but there are a few things
> > > that stick out:
> > >
> > > > +RISC-V Hardware Probing Interface
> > > > +---------------------------------
> > > > +
> > > > +The RISC-V hardware probing interface is based around a single
> > > > syscall, which
> > > > +is defined in <asm/hwprobe.h>::
> > > > +
> > > > +    struct riscv_hwprobe {
> > > > +        __s64 key;
> > > > +        __u64 value;
> > > > +    };
> > >
> > > The way this is defined, the kernel will always have to know
> > > about the specific set of features, it can't just forward
> > > unknown features to user space after probing them from an
> > > architectured hardware interface or from DT.
> >
> > You're correct that this interface wasn't intended to have usermode
> > come in with augmented data or additional key/value pairs. This was
> > purely meant to provide access to the kernel's repository of
> > architectural and microarchitectural details. If usermode wants to
> > provide extra info in this same form, maybe they could wrap this
> > interface.
> >
> > > If 'key' is just an enumerated value with a small number of
> > > possible values, I don't see anything wrong with using elf
> > > aux data. I understand it's hard to know how many keys
> > > might be needed in the long run, from the way you define
> > > the key/value pairs here, I would expect it to have a lot
> > > of the same limitations that the aux data has, except for
> > > a few bytes to be copied.
> >
> > Correct, this makes allocating bits out of here cheaper by not
> > requiring that we actively copy them into every new process forever.
> > You're right that the aux vector would work as well, but the thinking
> > behind this series was that an interface like this might be better for
> > an architecture as extensible as risc-v.
>
> What would be the ramifications of defining some sort of vdso-like
> data-structure and just putting the address into AT_HWCAP2 ?
> (similar to what vdso does) - that could then even be re-usable
> with other OS kernels.
>
> And would also save declaring numerous new AT_* keys.
>
>
> Because there are already nearly 130 standard extensions and vendors
> are allowed to defines their own as well, and we will probably also want
> to tell userspace about them.

Yeah I mulled that approach over a bit originally as well. The
downside is the vdso data then becomes part of the ABI. So you can
never change the layout of that vdso data, and you lose the ability to
change what gets cached in the vdso versus what bounces up to the
syscall. To poach a scenario from a glibc discussion underway, if for
instance cpu hotplug comes along and you need to invalidate some
portion of your cached data, that's easy when there's a function in
front of it, but difficult if apps are crawling the data themselves.

130 extensions is certainly a lot, and illustrates how auxvec may get
out of hand quickly. One nice thing about this mechanism (though other
approaches share this trait) is that it's agnostic of where the data
comes from. In other words, it doesn't require that data come from the
DT, or alternative.c, etc, as long as the kernel can access it and
plunk it in a key/value store.
-Evan

>
>
> Heiko
>
>
> > > > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t
> > > > pair_count,
> > > > +                           size_t cpu_count, cpu_set_t *cpus,
> > > > +                           unsigned long flags);
> > >
> > > The cpu set argument worries me more: there should never be a
> > > need to optimize for broken hardware that has an asymmetric set
> > > of features. Just let the kernel figure out the minimum set
> > > of features that works across all CPUs and report that like we
> > > do with HWCAP. If there is a SoC that is so broken that it has
> > > important features on a subset of cores that some user might
> > > actually want to rely on, then have them go through the slow
> > > sysfs interface for probing the CPUs indidually, but don't make
> > > the broken case easier at the expense of normal users that
> > > run on working hardware.
> >
> > I'm not so sure. While I agree with you for major classes of features
> > (eg one CPU has floating point support but another does not), I expect
> > these bits to contain more subtle details as well, which might vary
> > across asymmetric implementations without breaking ABI compatibility
> > per-se. Maybe some vendor has implemented exotic video decoding
> > acceleration instructions that only work on the big core. Or maybe the
> > big cores support v3.1 of some extension (where certain things run
> > faster), but the little cores only have v3.0, where it's a little
> > slower. Certain apps would likely want to know these things so they
> > can allocate their work optimally across cores.
> >
> > >
> > > > +asmlinkage long sys_riscv_hwprobe(uintptr_t, uintptr_t, uintptr_t,
> > > > uintptr_t,
> > > > +                               uintptr_t, uintptr_t);
> > >
> > > Why 'uintptr_t' rather than the correct type?
> >
> > Fixed.
> > -Evan
> >
>
>
>
>
