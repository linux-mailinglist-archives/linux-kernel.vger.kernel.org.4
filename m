Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC44A637617
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKXKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKXKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:18:40 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F710EA35
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:18:38 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id h132so1145397oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zGiZlBvNiwhpkqsR+b3pszQBQ7Auh+g6CaM/s8BUrYg=;
        b=YDyoj+Zi8XAnNDRzcGL99v05D7zM8bWz+3OqIzyD2w4N2pJALRtx8fJ8jFEHjuO6DL
         Mu+mYCeMpo/gbYQ5WroHlgcWIZHJ69btnS3eLz5Ww0okQo6qof1zG2bsnzX7kNEOJJ/z
         6wUTLbB8asyfYc7hleNjb2knO4EabRB9LnoeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGiZlBvNiwhpkqsR+b3pszQBQ7Auh+g6CaM/s8BUrYg=;
        b=RroaNO1zU4B4rnVdz0T7vGcebyVVQnJwjpnzXAyBrt2wOXZG1P6v+52F7mefZpiZqo
         uSnq9GG/mk8RVBDbScvEbttNArJRAnioiNJUhL85RLBbX0FRnypIYlA7T9EiGVU4lO7F
         0VJHuzppzkjA7LmtpSuAF6odQNnM/aehIrAekU4n7IkeimoR5SsljlB9D4XcLoAPlxiS
         RzPdx59K5fv9dfxV1WRb2abnKZODh7NOwPJDD1iesIx6lSTY23E8IfsBJidHoc18OUWc
         CS/DnR4Bucieb9HEYPE2p0/6qncaSwrSa8G/hyefdXHDWGHl/iTf6FHuVXTAaztBC3Tt
         QuUA==
X-Gm-Message-State: ANoB5pn1VDWBqh1iLgBgwmUVkPj1NpKKeDIKy4EZn2x7ckZI0Hm4Fev0
        38lcgnzZZh9InD8kbKMDSmFLfFmkl7Bf0nkCqey2
X-Google-Smtp-Source: AA0mqf6C5dlDvnPsT44KvSrCnZApXT9e7P7KCYteZn1aOOsjl4G37U/m6ORn0KcUFQTwHGkePw8WKf/CRMGz0a8DiPo=
X-Received: by 2002:a05:6808:51:b0:359:f091:104 with SMTP id
 v17-20020a056808005100b00359f0910104mr19097584oic.274.1669285117693; Thu, 24
 Nov 2022 02:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-7-atishp@rivosinc.com>
 <20221101142631.du54p4kyhlgf54cr@kamzik> <CAOnJCUJfakcoiWh4vFk5_BcTKfoSDbx+wtmh7MW4cPYog7q4BQ@mail.gmail.com>
 <20221123135842.uyw46kbybgb7unm2@kamzik>
In-Reply-To: <20221123135842.uyw46kbybgb7unm2@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 24 Nov 2022 02:18:26 -0800
Message-ID: <CAOnJCUKZV+0Xts6C4QY7X+Wak0ZR_f8wPtEAtH4PEmh2-_AcWw@mail.gmail.com>
Subject: Re: [RFC 6/9] RISC-V: KVM: Add SBI PMU extension support
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 5:58 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Tue, Nov 22, 2022 at 03:08:34PM -0800, Atish Patra wrote:
> > On Tue, Nov 1, 2022 at 7:26 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > >
> > > On Mon, Jul 18, 2022 at 10:02:02AM -0700, Atish Patra wrote:
> ...
> > > > +static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> > > > +                                unsigned long *out_val,
> > > > +                                struct kvm_cpu_trap *utrap,
> > > > +                                bool *exit)
> > > > +{
> > > > +     int ret = -EOPNOTSUPP;
> > > > +     struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> > > > +     unsigned long funcid = cp->a6;
> > > > +     uint64_t temp;
> > >
> > > I think we need something like
> > >
> > >    if (!vcpu_to_pmu(vcpu)->enabled)
> > >       return -EOPNOTSUPP;
> > >
> > > here. Where 'enabled' is only true when we successfully initialize
> > > the pmu. And, successful initialization depends on
> >
> > Yes. I have added the flag. But should we do the check here or
> > respective function
> > as a paranoia sanity check ?
>
> I think something like above that returns a not-supported error should be
> in all the entry points, like the top level SBI call handler. Functions
> that should never be called unless the PMU is active could have WARNs
> added for sanity checks.
>

Sure. Will add those checks.

> >
> > > IS_ENABLED(CONFIG_RISCV_PMU_SBI) and
> >
> > Why do we need to guard under CONFIG_RISCV_PMU_SBI ?
> > vcpu_sbi_pmu.c is only compiled under CONFIG_RISCV_PMU_SBI
> >
> > If CONFIG_RISCV_PMU_SBI is not enabled, probe function will return failure.
>
> You're right. We don't need explicit config checks for things that can't
> exist without the config.
>
> >
> > In fact, I think we should also add the pmu enabled check in the probe function
> > itself. Probe function(kvm_sbi_ext_pmu_probe) should only true when
> > both vcpu_to_pmu(vcpu)->enabled and
> > riscv_isa_extension_available(NULL, SSCOFPMF) are true.
> >
> > Thoughts?
>
> Agreed.
>
> >
> > > riscv_isa_extension_available(NULL, SSCOFPMF) as well as not
> > > failing other things. And, KVM userspace should be able to
> > > disable the pmu, which keep enabled from being set as well.
> > >
> > We already have provisions for disabling sscofpmf from guests via ISA
> > one reg interface.
> > Do you mean disable the entire PMU from userspace ?
>
> Yes. We may need to configure a VM without a PMU to increase its
> migratability, workaround errata, or just for testing/debugging purposes.
>
> >
> > Currently, ARM64 enables pmu from user space using device control APIs
> > on vcpu fd.
> > Are you suggesting we should do something like that ?
>
> Yes. Although choosing which KVM API should be used could probably be
> thought-out again. x86 uses VM ioctls.
>

How does it handle hetergenous systems in per VM ioctls ?

> >
> > If PMU needs to have device control APIs (either via vcpu fd or its
> > own), we can retrieve
> > the hpmcounter width and count from there as well.
>
> Right. We need to decide how the VM/VCPU + PMU user interface should look.
> A separate PMU device, like arm64 has, sounds good, but the ioctl
> sequences for initialization may get more tricky.
>

Do we really need a per VM interface ? I was thinking we can just
continue to use
one reg interface for PMU as well. We probably need two of them.

1. To enable/disable SBI extension
    -- The probe function will depend on this
2. PMU specific get/set
    -- Number of hpmcounters
    -- hpmcounter width
    -- enable PMU


> Thanks,
> drew



-- 
Regards,
Atish
