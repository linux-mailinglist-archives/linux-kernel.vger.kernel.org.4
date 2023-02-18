Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA869B6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBRAQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:16:14 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FE67445
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:16:12 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e30so2674839ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UgiLBWRR4q3c/Vqxkdr34/6qKJIWPn3ovu3vsEAFwgI=;
        b=spsnR+F8ht7zIYsSLPJopwZqzc4RBkhzXq/YvtGakMzkvwBI6CVCG6HZp8fpUa0fIV
         KSvCDoCunWQoXv4huLPwjHmjv+8j+4Za5SUpFKhlT2yOsnNYBbM7nVJKYWnW8MgWgKZV
         hjBtACgoUEkW1M8otLuijxlLKd/te8MTXFsKuWSWAb+WiXj/3AHuPD/d5kWgsZJvvkC8
         79llnEKU/4WfPoWSPMLopJDOnJXtr9Swax6OJEsQf3ftMyzYF6jhlnlAbIny358tig1d
         7XhVtw5bpsFb8Zz4Iz4yyDFz1hZCJISQjoY4jCGRaUcCIbQVDMHscKZIYIinXU78mEbK
         GmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgiLBWRR4q3c/Vqxkdr34/6qKJIWPn3ovu3vsEAFwgI=;
        b=21WCzVwMTVBA0NhHneZg/igTdkUO5C6Eg0ByhekAHhdtUJUf/zy657yvDrGQv26g3b
         IZkHRJDL1dF/zD4WXEaXahc3IYBL6/XLEi0NRzAcIHKHdC9envutVmHF70oZC0joS5SG
         TkQvJ7b69rqZGx2y+xisev5EkhDyjTwKlDXRb0iwe3ZgWIm2sN4Zi/R4UXFX5BeAGoL9
         ySFFL3dp0T2aRwZOG4J4/tAcNkjtzYx4o+aN103f5PWzM9VRvTUEcgGgywOzuyRIOCPr
         KY8ejES+HEsJpSIHCTw1K3cya0Zb57vgBKXaDZYalTd7KOUyL4b8bbBkYTn3pT21Qub7
         GkGw==
X-Gm-Message-State: AO0yUKVUQVw+htikokD9HMQm5yBTYdfh/NCaVmdnCNQ10hwM/jXBYaXI
        mCP2En+i1shbuk887Yg1XwL55GzSLOIlumifdn9TLQ==
X-Google-Smtp-Source: AK7set9u+Dnr3cyx6/5FKy/AyoYlJWNwaQt2hc013b1XXlBuGKz5LO1/SdxAtDvcKpDMxiNBRWeEV/6pwGMvkM5iijc=
X-Received: by 2002:a2e:b5dc:0:b0:293:531b:90ce with SMTP id
 g28-20020a2eb5dc000000b00293531b90cemr901827ljn.4.1676679370770; Fri, 17 Feb
 2023 16:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-6-evan@rivosinc.com>
 <Y+1VOXyKDDHEuejJ@spud>
In-Reply-To: <Y+1VOXyKDDHEuejJ@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Fri, 17 Feb 2023 16:15:34 -0800
Message-ID: <CALs-HsvZaKC5R-rAvkjBDNQGTUJ_LWn-O=KzpFwGtpac32_Xxw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 1:57 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 12:14:54PM -0800, Evan Green wrote:
> > This allows userspace to select various routines to use based on the
> > performance of misaligned access on the target hardware.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> >
> > ---
> >
> > Changes in v2:
> >  - Fixed logic error in if(of_property_read_string...) that caused crash
> >  - Include cpufeature.h in cpufeature.h to avoid undeclared variable
> >    warning.
> >  - Added a _MASK define
> >  - Fix random checkpatch complaints
> >
> >  Documentation/riscv/hwprobe.rst       | 13 +++++++++++
> >  arch/riscv/include/asm/cpufeature.h   |  2 ++
> >  arch/riscv/include/asm/hwprobe.h      |  2 +-
> >  arch/riscv/include/asm/smp.h          |  9 ++++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h |  6 ++++++
> >  arch/riscv/kernel/cpufeature.c        | 31 +++++++++++++++++++++++++--
> >  arch/riscv/kernel/sys_riscv.c         | 23 ++++++++++++++++++++
> >  7 files changed, 83 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
> > index ce186967861f..0dc75e83e127 100644
> > --- a/Documentation/riscv/hwprobe.rst
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -51,3 +51,16 @@ The following keys are defined:
> >        not minNum/maxNum") of the RISC-V ISA manual.
> >      * :RISCV_HWPROBE_IMA_C:: The C extension is supported, as defined by
> >        version 2.2 of the RISC-V ISA manual.
> > +* :RISCV_HWPROBE_KEY_PERF_0:: A bitmask that contains performance information
>
> This doesn't match what's defined?
>
> > +  about the selected set of processors.
> > +    * :RISCV_HWPROBE_MISALIGNED_UNKNOWN:: The performance of misaligned
> > +      accesses is unknown.
> > +    * :RISCV_HWPROBE_MISALIGNED_EMULATED:: Misaligned accesses are emulated via
> > +      software, either in or below the kernel.  These accesses are always
> > +      extremely slow.
> > +    * :RISCV_HWPROBE_MISALIGNED_SLOW:: Misaligned accesses are supported in
> > +      hardware, but are slower than the cooresponding aligned accesses
> > +      sequences.
> > +    * :RISCV_HWPROBE_MISALIGNED_FAST:: Misaligned accesses are supported in
> > +      hardware and are faster than the cooresponding aligned accesses
> > +      sequences.
>
> > diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> > index 3831b638ecab..6c1759091e44 100644
> > --- a/arch/riscv/include/asm/smp.h
> > +++ b/arch/riscv/include/asm/smp.h
> > @@ -26,6 +26,15 @@ struct riscv_ipi_ops {
> >   */
> >  extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
> >  #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
> > +static inline long hartid_to_cpuid_map(unsigned long hartid)
> > +{
> > +     long i;
> > +
> > +     for (i = 0; i < NR_CPUS; ++i)
>
> I'm never (or not yet?) sure about these things.
> Should this be for_each_possible_cpu()?

Me neither. I believe it's the same, as for_each_possible_cpu()
iterates over a CPU mask of all 1s, and the size of struct cpumask is
set by NR_CPUS. Some architectures appear to have an
init_cpu_possible() function to further restrict the set, though riscv
does not. It's probably better to use for_each_possible_cpu() though
in case a call to init_cpu_possible() ever does get added.

>
> > +             if (cpuid_to_hartid_map(i) == hartid)
> > +                     return i;
> > +     return -1;
> > +}
> >
> >  /* print IPI stats */
> >  void show_ipi_stats(struct seq_file *p, int prec);
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index ce39d6e74103..5d55e2da2b1f 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -25,5 +25,11 @@ struct riscv_hwprobe {
> >  #define RISCV_HWPROBE_KEY_IMA_EXT_0  4
> >  #define              RISCV_HWPROBE_IMA_FD            (1 << 0)
> >  #define              RISCV_HWPROBE_IMA_C             (1 << 1)
> > +#define RISCV_HWPROBE_KEY_CPUPERF_0  5
> > +#define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
> > +#define              RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> > +#define              RISCV_HWPROBE_MISALIGNED_SLOW           (2 << 0)
> > +#define              RISCV_HWPROBE_MISALIGNED_FAST           (3 << 0)
> > +#define              RISCV_HWPROBE_MISALIGNED_MASK           (3 << 0)
>
> Why is it UNKNOWN rather than UNSUPPORTED?
> I thought I saw Palmer saying that there is no requirement to support
> misaligned accesses any more.
> Plenty of old DTs are going to lack this property so would be UNKNOWN,
> and I *assume* that the user of the syscall is gonna conflate the two,
> but the rationale interests me.

Palmer had mentioned on the DT bindings patch that historically it was
required but emulated. So because old binaries assumed it was there,
the default values for DTs without this needs to imply "supported, but
no idea how fast it is".

But you bring up an interesting point: should the bindings and these
defines have a value that indicates no support at all for unaligned
accesses? We could always add the value to the bindings later, but
maybe we should leave space in this field now.

-Evan
