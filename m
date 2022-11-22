Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD14634ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiKVXLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbiKVXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:11:48 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214ABF825
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:11:47 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so2486030oor.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0F5kMiUlq64q8nCDKVZtkRiIUZb8kvHBOw3uONUExAc=;
        b=fPTnVe3oiuwz/G5MN1kBQcgY7ChJLEbwMY+Hfh9hd1AQPTKW1l2XWXSPRp8J/z0ZZq
         WlZrLBdvtg5j4rFva57cIh3QxE4uw2zvYXnT0zaBeX0hXFhtlQK8OoZRXXvYSr9qrRl0
         cuywZC0taIV++s/fssiNKbQok+rKoJGvN85v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F5kMiUlq64q8nCDKVZtkRiIUZb8kvHBOw3uONUExAc=;
        b=1bzD9NN5JxPn03gmd4+RhmSw2j2G9S6ZWOpgnl4AkLRSbDpb/urRHndaDvvB3wTZkj
         JkLO2lJYFx89hPJZ3r3JBovRxXCANRkYEQTlRvuMm9odFPKpT48vJPT2XBVGjoOBO45o
         S4aEXKEoJZqXnCIByjtE7kvcZSy39bghghxS8vp5iva2Zhl/MyRQowk3dtxXV5U5GHLM
         y4UY7QpoEeXp0TVRyb4yJxXrkv5efqg9Ak+eHh1vhkjpjbMF+PHygX6fVtswcFls83Px
         wWmgQvhJM5DnvLsJS32sI3zCob7QJJ3/qmpe3G48Yz3zNvCBRg4xdzLORafuhoIlEjIh
         DY3A==
X-Gm-Message-State: ANoB5pnybcZMd2zhpcWqlcalQUUG7K1IIzohtGLbDcwhQftnUH+f2F6J
        ql8coQrWB1EV3szTd5CqDkgBbpmjwKIrgayYFHF5
X-Google-Smtp-Source: AA0mqf57bcoG90p5DmgjAxb7W0jzbcNfQw08fpiG6rN94B6mly1lkSsznesqy37/frKm6RIeW2AWt6sIRigspQOcLLY=
X-Received: by 2002:a4a:dcd2:0:b0:49f:b5fe:2b43 with SMTP id
 h18-20020a4adcd2000000b0049fb5fe2b43mr11172083oou.49.1669158705939; Tue, 22
 Nov 2022 15:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-8-atishp@rivosinc.com>
 <20221101143548.plvlhedzt3oifa3u@kamzik>
In-Reply-To: <20221101143548.plvlhedzt3oifa3u@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Nov 2022 15:11:35 -0800
Message-ID: <CAOnJCU+ddtoJtdHYQXTH2_m57SEuFPj7ndpQJKM9v4JeYW=QnQ@mail.gmail.com>
Subject: Re: [RFC 7/9] RISC-V: KVM: Implement trap & emulate for hpmcounters
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:35 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Mon, Jul 18, 2022 at 10:02:03AM -0700, Atish Patra wrote:
> > As the KVM guests only see the virtual PMU counters, all hpmcounter
> > access should trap and KVM emulates the read access on behalf of guests.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_pmu.h | 16 +++++++++
> >  arch/riscv/kvm/vcpu_insn.c            |  1 +
> >  arch/riscv/kvm/vcpu_pmu.c             | 47 +++++++++++++++++++++++----
> >  3 files changed, 57 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > index bffee052f2ae..5410236b62a8 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > @@ -39,6 +39,19 @@ struct kvm_pmu {
> >  #define pmu_to_vcpu(pmu)  (container_of((pmu), struct kvm_vcpu, arch.pmu))
> >  #define pmc_to_pmu(pmc)   (&(pmc)->vcpu->arch.pmu)
> >
> > +#if defined(CONFIG_32BIT)
> > +#define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
> > +{ .base = CSR_CYCLEH,      .count = 31, .func = kvm_riscv_vcpu_pmu_read_hpm }, \
> > +{ .base = CSR_CYCLE,      .count = 31, .func = kvm_riscv_vcpu_pmu_read_hpm },
> > +#else
> > +#define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
> > +{ .base = CSR_CYCLE,      .count = 31, .func = kvm_riscv_vcpu_pmu_read_hpm },
> > +#endif
> > +
> > +int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
> > +                             unsigned long *val, unsigned long new_val,
> > +                             unsigned long wr_mask);
> > +
> >  int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu, unsigned long *out_val);
> >  int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
> >                               unsigned long *ctr_info);
> > @@ -59,6 +72,9 @@ void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
> >  #else
> >  struct kvm_pmu {
> >  };
> > +#define KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS \
> > +{ .base = 0,      .count = 0, .func = NULL },
> > +
> >
> >  static inline int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> >  {
> > diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> > index 0aa334f853c8..7c2a4b1a69f7 100644
> > --- a/arch/riscv/kvm/vcpu_insn.c
> > +++ b/arch/riscv/kvm/vcpu_insn.c
> > @@ -215,6 +215,7 @@ struct csr_func {
> >  };
> >
> >  static const struct csr_func csr_funcs[] = {
> > +     KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
> >  };
> >
> >  /**
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index 3168ed740bdd..5434051f495d 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -14,6 +14,46 @@
> >  #include <asm/kvm_vcpu_pmu.h>
> >  #include <linux/kvm_host.h>
> >
> > +int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> > +                             unsigned long *out_val)
> > +{
> > +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > +     struct kvm_pmc *pmc;
> > +     u64 enabled, running;
> > +
> > +     if (!kvpmu)
> > +             return -EINVAL;
> > +
> > +     pmc = &kvpmu->pmc[cidx];
> > +     if (!pmc->perf_event)
> > +             return -EINVAL;
> > +
> > +     pmc->counter_val += perf_event_read_value(pmc->perf_event, &enabled, &running);
> > +     *out_val = pmc->counter_val;
> > +
> > +     return 0;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
> > +                             unsigned long *val, unsigned long new_val,
> > +                             unsigned long wr_mask)
> > +{
> > +     struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > +     int cidx, ret = KVM_INSN_CONTINUE_NEXT_SEPC;
> > +
> > +     if (!kvpmu)
> > +             return KVM_INSN_EXIT_TO_USER_SPACE;
> > +     //TODO: Should we check if vcpu pmu is initialized or not!
>
> I guess it depends on the path to this call. It'd be best to keep the
> checks to the minimum, so if this isn't a top level call then I'd say
> no, but we need to check in the top level.
>

Based on the discussion on PATCH 6 we won't require the initialization check
at these functions.

We can leave the paranoia sanity check at kvm_riscv_vcpu_pmu_num_ctrs and
kvm_riscv_vcpu_pmu_ctr_info though.

> > +     if (wr_mask)
> > +             return KVM_INSN_ILLEGAL_TRAP;
> > +     cidx = csr_num - CSR_CYCLE;
> > +
> > +     if (kvm_riscv_vcpu_pmu_ctr_read(vcpu, cidx, val) < 0)
> > +             return KVM_INSN_EXIT_TO_USER_SPACE;
> > +
> > +     return ret;
> > +}
> > +
> >  int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu, unsigned long *out_val)
> >  {
> >       struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
> > @@ -60,13 +100,6 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
> >       return 0;
> >  }
> >
> > -int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> > -                             unsigned long *out_val)
> > -{
> > -     /* TODO */
> > -     return 0;
> > -}
> > -
> >  int kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> >  {
> >       int i = 0, num_hw_ctrs, num_fw_ctrs, hpm_width;
> > --
> > 2.25.1
> >
>
> Thanks,
> drew



-- 
Regards,
Atish
