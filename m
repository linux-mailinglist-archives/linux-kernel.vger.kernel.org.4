Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5390464E2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLOVLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLOVKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801DE0C4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:10:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 65so443173pfx.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZrvE58QOTgBWHlHruWuhMnmMmIlsVjpWBOdQKuVEhE=;
        b=B+wQLGNmo5DDX6a6+/9x1SUWJ5P/apfQN7omXyo7YwhzMsanC58dikNfLWTfyR9647
         BD4ufQdU/DVJH/GgEm6H76L+FR3siMsSWitfctH+/wfRNkzzTeltY63/7gaDmzMsxdul
         rCEkkF2RnMPE/UHccEBzeXHBbyBqbz1lG90NuofxYSdJIjGrjfK9cWWGjeS/exSRRRfM
         SDKth9DkDD3ViLRPbcjdn+ek0vJZvxJYClQNi8PbbJdKpdqyYYFTv8LWR8myqgCA2Evr
         2i8VHzF+/niPS3rFQ38A6QgwaFadfTe31Oa6NuGayRMkqmjaQYVsVCWO2xQ/I/c0MUzr
         rgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZrvE58QOTgBWHlHruWuhMnmMmIlsVjpWBOdQKuVEhE=;
        b=yY2ioHNfzy0vns0QaPW4jHN2tXQTpJojtSS3FZ/GuI8wzzkiF8b/Y2I0sIzay/k9vH
         B90LyaTbWiv3nfTWvZLuCpHx94tXSspOqX5Ht1qSBXVZc/IKLHENvKFeFy3/LSQvRIJ2
         uHj+dLqh8C6JuBBQPadPeN0s2oz4aylp6bUsqRWMbzgTGur26KdyfskHTWMFvIqv6ndg
         LgWSbUfo5w1tG00S4qFkGc55uVdkQS68PDoxnaBzN1pGyQcgko5ZajANJOU+8lONvVxS
         aSUSoG9H7OA5wl4dAfT4Tjv0IlVFnoO4yT2dhV8Z0sSJK3ziud+4oMCIK6VOhiH72NiA
         LeDg==
X-Gm-Message-State: ANoB5pkqN/NlK3lc1XYM/j9r+MG8u3kSU1/7eQkyaa6o1WOfzzJ9Y8D8
        9kz1ahYAOIx53c8PpSQjFbszJksz3Ya8HfXRDOA2aQ==
X-Google-Smtp-Source: AA0mqf45TO4Zw7SWPaGzS8xxvZqKRnNZ9IL/H+CfRI3T2MsI1uygTYHxBBGZ1vZE4NTYHG4rXfIGsF5bFaNpiJYcOOQ=
X-Received: by 2002:a63:334e:0:b0:479:2227:3aa1 with SMTP id
 z75-20020a63334e000000b0047922273aa1mr1274784pgz.595.1671138644687; Thu, 15
 Dec 2022 13:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20221215170046.2010255-1-atishp@rivosinc.com> <20221215170046.2010255-6-atishp@rivosinc.com>
 <Y5uA8CEoTKzIGoSy@dizzy>
In-Reply-To: <Y5uA8CEoTKzIGoSy@dizzy>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Thu, 15 Dec 2022 13:10:33 -0800
Message-ID: <CAHBxVyHFutEuKF=CHFA+7xrpcVEj+72L0PGvh6Hry=4SUW8tug@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] RISC-V: KVM: Improve privilege mode filtering
 for perf
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Eric Lin <eric.lin@sifive.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 12:18 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Atish,
>
> On Thu, Dec 15, 2022 at 09:00:40AM -0800, Atish Patra wrote:
> > RISC-V: KVM: Improve privilege mode filtering for perf
>
> I almost marked this as "not applicable" in patchwork as I was mislead
> by the $subject. I know our perf driver is a real mixed bag, but should
> it not be something more like:
> "perf: RISC-V: Improve privilege mode filtering for KVM"?

Sure. I will change it in the next version.

> It was only when I noticed that the rest of the series had been marked
> as "Handled Elsewhere" that I realised that this must not be a KVM patch
> ;)
>
> Thanks,
> Conor
>
> > Currently, the host driver doesn't have any method to identify if the
> > requested perf event is from kvm or bare metal. As KVM runs in HS
> > mode, there are no separate hypervisor privilege mode to distinguish
> > between the attributes for guest/host.
> >
> > Improve the privilege mode filtering by using the event specific
> > config1 field.
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c   | 27 ++++++++++++++++++++++-----
> >  include/linux/perf/riscv_pmu.h |  2 ++
> >  2 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 65d4aa4..df795b7 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -298,6 +298,27 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
> >  }
> >  EXPORT_SYMBOL(riscv_pmu_get_hpm_info);
> >
> > +static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
> > +{
> > +     unsigned long cflags = 0;
> > +     bool guest_events = false;
> > +
> > +     if (event->attr.config1 & RISCV_KVM_PMU_CONFIG1_GUEST_EVENTS)
> > +             guest_events = true;
> > +     if (event->attr.exclude_kernel)
> > +             cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VSINH : SBI_PMU_CFG_FLAG_SET_SINH;
> > +     if (event->attr.exclude_user)
> > +             cflags |= guest_events ? SBI_PMU_CFG_FLAG_SET_VUINH : SBI_PMU_CFG_FLAG_SET_UINH;
> > +     if (guest_events && event->attr.exclude_hv)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
> > +     if (event->attr.exclude_host)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_UINH | SBI_PMU_CFG_FLAG_SET_SINH;
> > +     if (event->attr.exclude_guest)
> > +             cflags |= SBI_PMU_CFG_FLAG_SET_VSINH | SBI_PMU_CFG_FLAG_SET_VUINH;
> > +
> > +     return cflags;
> > +}
> > +
> >  static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> >  {
> >       struct hw_perf_event *hwc = &event->hw;
> > @@ -308,11 +329,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
> >       uint64_t cbase = 0;
> >       unsigned long cflags = 0;
> >
> > -     if (event->attr.exclude_kernel)
> > -             cflags |= SBI_PMU_CFG_FLAG_SET_SINH;
> > -     if (event->attr.exclude_user)
> > -             cflags |= SBI_PMU_CFG_FLAG_SET_UINH;
> > -
> > +     cflags = pmu_sbi_get_filter_flags(event);
> >       /* retrieve the available counter index */
> >  #if defined(CONFIG_32BIT)
> >       ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> > diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> > index a1c3f77..1c42146 100644
> > --- a/include/linux/perf/riscv_pmu.h
> > +++ b/include/linux/perf/riscv_pmu.h
> > @@ -26,6 +26,8 @@
> >
> >  #define RISCV_PMU_STOP_FLAG_RESET 1
> >
> > +#define RISCV_KVM_PMU_CONFIG1_GUEST_EVENTS 0x1
> > +
> >  struct cpu_hw_events {
> >       /* currently enabled events */
> >       int                     n_events;
> > --
> > 2.25.1
> >
> >
