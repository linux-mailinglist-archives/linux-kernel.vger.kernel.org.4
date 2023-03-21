Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B66C35CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCUPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCUPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:35:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA6193DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:35:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so19629501lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679412937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk8jr7BD8uYaCexras91/B4ZP6pQnOkni7RNbE9PM20=;
        b=U7i12C6xejQPRN5PVWzMmpv3+Mu+dcLGFipj5Ks0ekIWt1USoeQqFmJ8AbEe9aYkBS
         HF5nhnN+yIDzTMKCVy73NPstI2OBmbthm8u1xRC0oYyC03+j/zWFscfjDDZp6+KO0eHP
         YZUw5vMw1G5pYyVmmi4hm8J+6g8j0QmcCeWcuAU/qn7yY7kCiai5YeAIMyG4Z1w3S7d9
         W7gpGpO0dl/I+GwWptNv1JhcCmrqS9cCTqH1jkDbSFgLJL2G/W6dfqS4NUgwfgFTnvzh
         k/iTAk9hcAZIapyazy1YJ7bBU5LcoLjDt3uEe15ehpgK0OydV5B/sS96ot6ScSCEIqwQ
         hY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk8jr7BD8uYaCexras91/B4ZP6pQnOkni7RNbE9PM20=;
        b=2JmCGUIHO49c8l4QY4Sq3duntKRxIkIAJS4N/ecfSEjafDbwL3Cp660YUscf0OkWKb
         ghJiob+1U28tCWbzDOh0dOrGiT4ylsWVZ5tGiJAt0jw//DB0pd9e8BhcKwA02GBCP7ka
         YaXZAY+kZJ1dyT+euQ7PMBZUMW4ihja3zQkZbQ+gGaHRoRYX3b1p3C/SI3ezU3db9xGt
         2ojsK5yBRmGoKCrgR0guHhrgEFnJNij1EOKj9P7UMfybM/QxkZwFs0oqxuinuxy/jhN5
         IKkiVLMMvZooMoB4M2k7Qz9PmM4k/+ntmAZJ5XaQK6eCioM4q0S1saPXtHvAQlLuim/4
         Xo0w==
X-Gm-Message-State: AO0yUKU2J8n67EFuBOuhUv0iTl43El+1lHOpqFsZ2bQZKSe0G8MrqGt0
        UU6W5yLbzgsno+rHMn4zSakXfvekDG3Z2fOVtZYbVQ==
X-Google-Smtp-Source: AK7set/bcktsXNha36q7gWnQ7ixDJ+mIYGQCBZHspa50UfOaCUrg3gMf6TJwt+lK5HY5F32KPGoi93+d3VvsyHcJ8IE=
X-Received: by 2002:a05:6512:48e:b0:4e1:d025:789e with SMTP id
 v14-20020a056512048e00b004e1d025789emr958503lfq.13.1679412937672; Tue, 21 Mar
 2023 08:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230314183220.513101-1-evan@rivosinc.com> <20230314183220.513101-5-evan@rivosinc.com>
 <1846748.tdWV9SEqCh@diego>
In-Reply-To: <1846748.tdWV9SEqCh@diego>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 21 Mar 2023 08:35:01 -0700
Message-ID: <CALs-Hssz-GJ7zY5pnSjbXHzyu-uy3+UYo54rWA8nAjYBaeNk1g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 3:08=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Evan,
>
> Am Dienstag, 14. M=C3=A4rz 2023, 19:32:18 CET schrieb Evan Green:
> > This allows userspace to select various routines to use based on the
> > performance of misaligned access on the target hardware.
>
> I really like this implementation.
>
> Also interesting that T-Head actually has a fast unaligned access.
> Maybe that should be part of the commit message (including were
> this information comes from)

Thanks Heiko (and Conor)! Yep, you both noticed that, I'll add a descriptio=
n.

>
>
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > ---
> >
> > Changes in v4:
> >  - Add newlines to CPUPERF_0 documentation (Conor)
> >  - Add UNSUPPORTED value (Conor)
> >  - Switched from DT to alternatives-based probing (Rob)
> >  - Crispen up cpu index type to always be int (Conor)
> >
> > Changes in v3:
> >  - Have hwprobe_misaligned return int instead of long.
> >  - Constify cpumask pointer in hwprobe_misaligned()
> >  - Fix warnings in _PERF_O list documentation, use :c:macro:.
> >  - Move include cpufeature.h to misaligned patch.
> >  - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
> >  - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
> >  - Break early in misaligned access iteration (Conor)
> >  - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED f=
uture
> >    value (Conor)
> >
> > Changes in v2:
> >  - Fixed logic error in if(of_property_read_string...) that caused cras=
h
> >  - Include cpufeature.h in cpufeature.h to avoid undeclared variable
> >    warning.
> >  - Added a _MASK define
> >  - Fix random checkpatch complaints
> >
> >  Documentation/riscv/hwprobe.rst       | 21 ++++++++++++++++++++
> >  arch/riscv/errata/thead/errata.c      |  9 +++++++++
> >  arch/riscv/include/asm/alternative.h  |  5 +++++
> >  arch/riscv/include/asm/cpufeature.h   |  2 ++
> >  arch/riscv/include/asm/hwprobe.h      |  2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h |  7 +++++++
> >  arch/riscv/kernel/alternative.c       | 19 ++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c        |  3 +++
> >  arch/riscv/kernel/smpboot.c           |  1 +
> >  arch/riscv/kernel/sys_riscv.c         | 28 +++++++++++++++++++++++++++
> >  10 files changed, 96 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwpr=
obe.rst
> > index 945d44683c40..9f0dd62dcb5d 100644
> > --- a/Documentation/riscv/hwprobe.rst
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -63,3 +63,24 @@ The following keys are defined:
> >
> >    * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as d=
efined
> >      by version 2.2 of the RISC-V ISA manual.
> > +
> > +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains perf=
ormance
> > +  information about the selected set of processors.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of mi=
saligned
> > +    accesses is unknown.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses =
are
> > +    emulated via software, either in or below the kernel.  These acces=
ses are
> > +    always extremely slow.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are =
supported
> > +    in hardware, but are slower than the cooresponding aligned accesse=
s
> > +    sequences.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are =
supported
> > +    in hardware and are faster than the cooresponding aligned accesses
> > +    sequences.
> > +
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned access=
es are
> > +    not supported at all and will generate a misaligned address fault.
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index fac5742d1c1e..f41a45af5607 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -10,7 +10,9 @@
> >  #include <linux/uaccess.h>
> >  #include <asm/alternative.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/cpufeature.h>
> >  #include <asm/errata_list.h>
> > +#include <asm/hwprobe.h>
> >  #include <asm/patch.h>
> >  #include <asm/vendorid_list.h>
> >
> > @@ -108,3 +110,10 @@ void __init_or_module thead_errata_patch_func(stru=
ct alt_entry *begin, struct al
> >       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> >               local_flush_icache_all();
> >  }
> > +
> > +void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
> > +                           unsigned long impid)
> > +{
> > +     if ((archid =3D=3D 0) && (impid =3D=3D 0))
> > +             per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_M=
ISALIGNED_FAST;
>
> When looking at this function I 'm wondering if we also want to expose
> the active erratas somehow (not in this patch of course, just in general)

I suppose as Arnd pointed out in a different thread there's sort of a
tension between this mechanism and /proc/cpuinfo, the traditional spot
for exposing more standard cpu features/errata. Though if we think of
this mechanism as a sort of surrogate for cpuid, then it potentially
does make sense. My gut says it's a judgment call.

-Evan
