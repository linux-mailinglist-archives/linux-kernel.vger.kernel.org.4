Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF276EF558
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbjDZNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbjDZNR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:17:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44CE6A49
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:17:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so48793135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682515033; x=1685107033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/1GdRlc+VgASDs75zDkOFrbaWfnXLmJkltE68dH6tM=;
        b=S3Geg6g0Psq1HOXpCWkyxPgOscVJCjBnA9o1UoXXaEZDD1+2hxw+hDBZFQj0ujIw0B
         gBwFyyo/lJpOiUy7mpJ6cRaXm0v53ihSvJtZzvpPMYsbpXo/y+rV24Dr8Yvtiyk8Ogd5
         ND7sAF//WOCKwqjkkOm1L9yCqg69SCi1eqHvuJTFLDWqJqqYN4FAJyZXRXZuta8dOPz3
         vt81+meeQ0ppnNTnRJpRowonLRlSXFfY6zSMTB1PGBUVjcDfMdtf+q2rrz5/SntCEpcH
         7QnCW3odFJpjwUQHXxyFEP9SkCgpx8+VQN0NSpkw5+TQlVsGw4AGnxSw03GzbvK41OZg
         CE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515033; x=1685107033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/1GdRlc+VgASDs75zDkOFrbaWfnXLmJkltE68dH6tM=;
        b=S4j6OhJ6lrdYH/CsQEiuNlHCKQiRfE4l8PdGmO5p976HhRslGDHSwEjJGGPDwJO7Yb
         Jr7z47AOOQypgZe282xFX+3ghOfBbXbXCu2P1GF1SoNoFpBX2OZC5JWcnzm1FlIM2uSj
         2KOEwpdk3G3YMn3fBwzxse1T4cZxtU9X3+h0B7W8D08fCBd86wpgK4WMXi6gY+rsPf8l
         e1q8XTOE1t6RG5ZgBU9Xrsnx2SRqjfIunzoR9Bg0yiZ+EhdEVt2uWTi7QFEjgyN7NYvz
         AHUSjG9qcwfq0NTpfzW41lSvT9B0bkYlH1Fl1NVCSuyePd2QDj2YiEYbVtJ5NCdqINhi
         Ui4Q==
X-Gm-Message-State: AAQBX9ejE+AERXcjbTPEwrmqyd2cvBx6hwaRn8bJYAASJBxiuQ58MKTt
        PKrCjhcD/jRmCor1kgzj0MVHfXcCWkIyQuE2jlxfBg==
X-Google-Smtp-Source: AKy350aVbG13+Z5fi9TN3NRPlUt9B32xLw4VA3X79f3mH4zfe607Iz/PK72dArWbzsl1xRooo/BboSMMGeoRNk9BKX8=
X-Received: by 2002:a1c:c905:0:b0:3f1:93c2:4df6 with SMTP id
 f5-20020a1cc905000000b003f193c24df6mr12880611wmb.12.1682515032924; Wed, 26
 Apr 2023 06:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com> <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
In-Reply-To: <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 26 Apr 2023 15:17:01 +0200
Message-ID: <CAHVXubh_y9Uw2xsgsQrVZEcb9bCLBLUCo74GOm-czsSawHxk4g@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through perf
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 2:57=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Apr 13, 2023 at 06:17:25PM +0200, Alexandre Ghiti wrote:
> > We used to unconditionnally expose the cycle and instret csrs to
> > userspace, which gives rise to security concerns.
> >
> > So only allow access to hw counters from userspace through the perf
> > framework which will handle context switchs, per-task events...etc. But
> > as we cannot break userspace, we give the user the choice to go back to
> > the previous behaviour by setting the sysctl perf_user_access.
> >
> > We also introduce a means to directly map the hardware counters to
> > userspace, thus avoiding the need for syscalls whenever an application
> > wants to access counters values.
> >
> > Note that arch_perf_update_userpage is a copy of arm64 code.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
> >  arch/riscv/include/asm/perf_event.h         |   3 +
> >  arch/riscv/kernel/Makefile                  |   2 +-
> >  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
> >  drivers/perf/riscv_pmu.c                    |  42 ++++++++
> >  drivers/perf/riscv_pmu_legacy.c             |  17 +++
> >  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++++--
> >  include/linux/perf/riscv_pmu.h              |   3 +
> >  tools/lib/perf/mmap.c                       |  65 +++++++++++
> >  9 files changed, 322 insertions(+), 11 deletions(-)
> >  create mode 100644 arch/riscv/kernel/perf_event.c
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentatio=
n/admin-guide/sysctl/kernel.rst
> > index 4b7bfea28cd7..02b2a40a3647 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -941,16 +941,31 @@ enabled, otherwise writing to this file will retu=
rn ``-EBUSY``.
> >  The default value is 8.
> >
> >
> > -perf_user_access (arm64 only)
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +perf_user_access (arm64 and riscv only)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Controls user space access for reading perf event counters.
> >
> > -Controls user space access for reading perf event counters. When set t=
o 1,
> > -user space can read performance monitor counter registers directly.
> > +arm64
> > +=3D=3D=3D=3D=3D
> >
> >  The default value is 0 (access disabled).
> > +When set to 1, user space can read performance monitor counter registe=
rs
> > +directly.
> >
> >  See Documentation/arm64/perf.rst for more information.
> >
> > +riscv
> > +=3D=3D=3D=3D=3D
> > +
> > +When set to 0, user access is disabled.
> > +
> > +When set to 1, user space can read performance monitor counter registe=
rs
> > +directly only through perf, any direct access without perf interventio=
n will
> > +trigger an illegal instruction.
> > +
> > +The default value is 2, it enables the legacy mode, that is user space=
 has
> > +direct access to cycle, time and insret CSRs only.
>
> I think this default value should be a Kconfig symbol, allowing kernels t=
o
> be built with a secure default.

Actually I was more in favor of having the default to 1 (ie the secure
option) and let the distros deal with the legacy mode (via a sysctl
parameter on the command line) as long as user-space has not been
fixed: does that make sense?

>
> >
> >  pid_max
> >  =3D=3D=3D=3D=3D=3D=3D
> > diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/a=
sm/perf_event.h
> > index d42c901f9a97..9fdfdd9dc92d 100644
> > --- a/arch/riscv/include/asm/perf_event.h
> > +++ b/arch/riscv/include/asm/perf_event.h
> > @@ -9,5 +9,8 @@
> >  #define _ASM_RISCV_PERF_EVENT_H
> >
> >  #include <linux/perf_event.h>
> > +
> > +#define PERF_EVENT_FLAG_LEGACY       1
> > +
> >  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)re=
gs
> >  #endif /* _ASM_RISCV_PERF_EVENT_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index aa22f87faeae..9ae951b07847 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -70,7 +70,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)        +=3D mcount-dyn.o
> >
> >  obj-$(CONFIG_TRACE_IRQFLAGS) +=3D trace_irq.o
> >
> > -obj-$(CONFIG_PERF_EVENTS)    +=3D perf_callchain.o
> > +obj-$(CONFIG_PERF_EVENTS)    +=3D perf_callchain.o perf_event.o
> >  obj-$(CONFIG_HAVE_PERF_REGS) +=3D perf_regs.o
> >  obj-$(CONFIG_RISCV_SBI)              +=3D sbi.o
> >  ifeq ($(CONFIG_RISCV_SBI), y)
> > diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_ev=
ent.c
> > new file mode 100644
> > index 000000000000..4a75ab628bfb
> > --- /dev/null
> > +++ b/arch/riscv/kernel/perf_event.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/perf/riscv_pmu.h>
> > +#include <linux/sched_clock.h>
> > +
> > +void arch_perf_update_userpage(struct perf_event *event,
> > +                            struct perf_event_mmap_page *userpg, u64 n=
ow)
> > +{
> > +     struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > +     struct clock_read_data *rd;
> > +     unsigned int seq;
> > +     u64 ns;
> > +
> > +     userpg->cap_user_time =3D 0;
> > +     userpg->cap_user_time_zero =3D 0;
> > +     userpg->cap_user_time_short =3D 0;
> > +     userpg->cap_user_rdpmc =3D
> > +             !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> > +
> > +     /*
> > +      * The counters are 64-bit but the priv spec doesn't mandate all =
the
> > +      * bits to be implemented: that's why, counter width can vary bas=
ed on
> > +      * the cpu vendor.
> > +      */
> > +     userpg->pmc_width =3D rvpmu->ctr_get_width(event->hw.idx) + 1;
> > +
> > +     do {
> > +             rd =3D sched_clock_read_begin(&seq);
> > +
> > +             userpg->time_mult =3D rd->mult;
> > +             userpg->time_shift =3D rd->shift;
> > +             userpg->time_zero =3D rd->epoch_ns;
> > +             userpg->time_cycles =3D rd->epoch_cyc;
> > +             userpg->time_mask =3D rd->sched_clock_mask;
> > +
> > +             /*
> > +              * Subtract the cycle base, such that software that
> > +              * doesn't know about cap_user_time_short still 'works'
> > +              * assuming no wraps.
> > +              */
> > +             ns =3D mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift=
);
> > +             userpg->time_zero -=3D ns;
> > +
> > +     } while (sched_clock_read_retry(seq));
> > +
> > +     userpg->time_offset =3D userpg->time_zero - now;
> > +
> > +     /*
> > +      * time_shift is not expected to be greater than 31 due to
> > +      * the original published conversion algorithm shifting a
> > +      * 32-bit value (now specifies a 64-bit value) - refer
> > +      * perf_event_mmap_page documentation in perf_event.h.
> > +      */
> > +     if (userpg->time_shift =3D=3D 32) {
> > +             userpg->time_shift =3D 31;
> > +             userpg->time_mult >>=3D 1;
> > +     }
> > +
> > +     /*
> > +      * Internal timekeeping for enabled/running/stopped times
> > +      * is always computed with the sched_clock.
> > +      */
> > +     userpg->cap_user_time =3D 1;
> > +     userpg->cap_user_time_zero =3D 1;
> > +     userpg->cap_user_time_short =3D 1;
> > +}
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index ebca5eab9c9b..12675ee1123c 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -171,6 +171,8 @@ int riscv_pmu_event_set_period(struct perf_event *e=
vent)
> >
> >       local64_set(&hwc->prev_count, (u64)-left);
> >
> > +     perf_event_update_userpage(event);
> > +
> >       return overflow;
> >  }
> >
> > @@ -283,6 +285,43 @@ static int riscv_pmu_event_init(struct perf_event =
*event)
> >       return 0;
> >  }
> >
> > +static int riscv_pmu_event_idx(struct perf_event *event)
> > +{
> > +     struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > +
> > +     if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
> > +             return 0;
> > +
> > +     /*
> > +      * cycle and instret can either be retrieved from their fixed cou=
nters
> > +      * or from programmable counters, the latter being the preferred =
way
> > +      * since cycle and instret counters do not support sampling.
> > +      */
> > +
> > +     return rvpmu->csr_index(event) + 1;
> > +}
> > +
> > +static void riscv_pmu_event_mapped(struct perf_event *event, struct mm=
_struct *mm)
> > +{
> > +     /*
> > +      * The user mmapped the event to directly access it: this is wher=
e
> > +      * we determine based on sysctl_perf_user_access if we grant user=
space
> > +      * the direct access to this event. That means that within the sa=
me
> > +      * task, some events may be directly accessible and some other ma=
y not,
> > +      * if the user changes the value of sysctl_perf_user_accesss in t=
he
> > +      * meantime.
> > +      */
> > +     struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > +
> > +     event->hw.flags |=3D rvpmu->event_flags(event);
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +static void riscv_pmu_event_unmapped(struct perf_event *event, struct =
mm_struct *mm)
> > +{
> > +     event->hw.flags &=3D ~PERF_EVENT_FLAG_USER_READ_CNT;
> > +}
> > +
> >  struct riscv_pmu *riscv_pmu_alloc(void)
> >  {
> >       struct riscv_pmu *pmu;
> > @@ -307,6 +346,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
> >       }
> >       pmu->pmu =3D (struct pmu) {
> >               .event_init     =3D riscv_pmu_event_init,
> > +             .event_mapped   =3D riscv_pmu_event_mapped,
> > +             .event_unmapped =3D riscv_pmu_event_unmapped,
> > +             .event_idx      =3D riscv_pmu_event_idx,
> >               .add            =3D riscv_pmu_add,
> >               .del            =3D riscv_pmu_del,
> >               .start          =3D riscv_pmu_start,
> > diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_l=
egacy.c
> > index 0d8c9d8849ee..35c4c9097a0f 100644
> > --- a/drivers/perf/riscv_pmu_legacy.c
> > +++ b/drivers/perf/riscv_pmu_legacy.c
> > @@ -74,6 +74,21 @@ static void pmu_legacy_ctr_start(struct perf_event *=
event, u64 ival)
> >       local64_set(&hwc->prev_count, initial_val);
> >  }
> >
> > +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
> > +{
> > +     return event->hw.idx;
> > +}
> > +
> > +static int pmu_legacy_event_flags(struct perf_event *event)
> > +{
> > +     /* In legacy mode, the first 3 CSRs are available. */
> > +     if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> > +         event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS)
> > +             return 0;
> > +
> > +     return PERF_EVENT_FLAG_USER_READ_CNT;
> > +}
> > +
> >  /*
> >   * This is just a simple implementation to allow legacy implementation=
s
> >   * compatible with new RISC-V PMU driver framework.
> > @@ -94,6 +109,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
> >       pmu->ctr_get_width =3D NULL;
> >       pmu->ctr_clear_idx =3D NULL;
> >       pmu->ctr_read =3D pmu_legacy_read_ctr;
> > +     pmu->event_flags =3D pmu_legacy_event_flags;
> > +     pmu->csr_index =3D pmu_legacy_csr_index;
> >
> >       perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> >  }
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 70cb50fd41c2..af7f3128b6b8 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -24,6 +24,10 @@
> >  #include <asm/sbi.h>
> >  #include <asm/hwcap.h>
> >
> > +#define SYSCTL_NO_USER_ACCESS        0
> > +#define SYSCTL_USER_ACCESS   1
> > +#define SYSCTL_LEGACY                2
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> > @@ -43,6 +47,9 @@ static const struct attribute_group *riscv_pmu_attr_g=
roups[] =3D {
> >       NULL,
> >  };
> >
> > +/* Allow legacy access by default */
> > +static int sysctl_perf_user_access __read_mostly =3D SYSCTL_LEGACY;
> > +
> >  /*
> >   * RISC-V doesn't have heterogeneous harts yet. This need to be part o=
f
> >   * per_cpu in case of harts with different pmu counters
> > @@ -301,6 +308,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 =
*num_hw_ctr)
> >  }
> >  EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
> >
> > +static uint8_t pmu_sbi_csr_index(struct perf_event *event)
> > +{
> > +     return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
> > +}
> > +
> >  static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event=
)
> >  {
> >       unsigned long cflags =3D 0;
> > @@ -329,18 +341,30 @@ static int pmu_sbi_ctr_get_idx(struct perf_event =
*event)
> >       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> >       struct sbiret ret;
> >       int idx;
> > -     uint64_t cbase =3D 0;
> > +     uint64_t cbase =3D 0, cmask =3D rvpmu->cmask;
> >       unsigned long cflags =3D 0;
> >
> >       cflags =3D pmu_sbi_get_filter_flags(event);
> > +
> > +     /* In legacy mode, we have to force the fixed counters for those =
events */
> > +     if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
> > +                     cflags |=3D SBI_PMU_CFG_FLAG_SKIP_MATCH;
> > +                     cmask =3D 1;
> > +             } else if (event->attr.config =3D=3D PERF_COUNT_HW_INSTRU=
CTIONS) {
> > +                     cflags |=3D SBI_PMU_CFG_FLAG_SKIP_MATCH;
> > +                     cmask =3D 1UL << (CSR_INSTRET - CSR_CYCLE);
> > +             }
> > +     }
> > +
> >       /* retrieve the available counter index */
> >  #if defined(CONFIG_32BIT)
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cba=
se,
> > -                     rvpmu->cmask, cflags, hwc->event_base, hwc->confi=
g,
> > +                     cmask, cflags, hwc->event_base, hwc->config,
> >                       hwc->config >> 32);
> >  #else
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cba=
se,
> > -                     rvpmu->cmask, cflags, hwc->event_base, hwc->confi=
g, 0);
> > +                     cmask, cflags, hwc->event_base, hwc->config, 0);
> >  #endif
> >       if (ret.error) {
> >               pr_debug("Not able to find a counter for event %lx config=
 %llx\n",
> > @@ -490,6 +514,11 @@ static void pmu_sbi_ctr_start(struct perf_event *e=
vent, u64 ival)
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED))
> >               pr_err("Starting counter idx %d failed with error %d\n",
> >                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +
> > +     if (!(event->hw.flags & PERF_EVENT_FLAG_LEGACY) &&
> > +         event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> > +             csr_write(CSR_SCOUNTEREN,
> > +                       csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_in=
dex(event)));
> >  }
> >
> >  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long f=
lag)
> > @@ -497,6 +526,11 @@ static void pmu_sbi_ctr_stop(struct perf_event *ev=
ent, unsigned long flag)
> >       struct sbiret ret;
> >       struct hw_perf_event *hwc =3D &event->hw;
> >
> > +     if (!(event->hw.flags & PERF_EVENT_FLAG_LEGACY) &&
> > +         event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> > +             csr_write(CSR_SCOUNTEREN,
> > +                       csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_i=
ndex(event)));
> > +
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> >               flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > @@ -704,10 +738,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,=
 struct hlist_node *node)
> >       struct cpu_hw_events *cpu_hw_evt =3D this_cpu_ptr(pmu->hw_events)=
;
> >
> >       /*
> > -      * Enable the access for CYCLE, TIME, and INSTRET CSRs from users=
pace,
> > -      * as is necessary to maintain uABI compatibility.
> > +      * We keep enabling userspace access to CYCLE, TIME and INSRET vi=
a the
> > +      * legacy option but that will be removed in the future.
>
> Will it? The documentation hunk didn't mention that value 2 was depreciat=
ed.

You're right, I'll add that to the documentation too, thanks.

>
> >        */
> > -     csr_write(CSR_SCOUNTEREN, 0x7);
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> > +             csr_write(CSR_SCOUNTEREN, 0x7);
> > +     else
> > +             csr_write(CSR_SCOUNTEREN, 0x2);
> >
> >       /* Stop all the counters so that they can be enabled from perf */
> >       pmu_sbi_stop_all(pmu);
> > @@ -851,6 +888,66 @@ static void riscv_pmu_destroy(struct riscv_pmu *pm=
u)
> >       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->n=
ode);
> >  }
> >
> > +static int pmu_sbi_event_flags(struct perf_event *event)
> > +{
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_NO_USER_ACCESS)
> > +             return 0;
> > +
> > +     /* In legacy mode, the first 3 CSRs are available. */
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY) {
> > +             int flags =3D PERF_EVENT_FLAG_LEGACY;
> > +
> > +             if (event->attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES ||
> > +                 event->attr.config =3D=3D PERF_COUNT_HW_INSTRUCTIONS)
> > +                     flags |=3D PERF_EVENT_FLAG_USER_READ_CNT;
> > +
> > +             return flags;
> > +     }
> > +
> > +     return PERF_EVENT_FLAG_USER_READ_CNT;
> > +}
> > +
> > +static void riscv_pmu_update_counter_access(void *info)
> > +{
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> > +             csr_write(CSR_SCOUNTEREN, 0x7);
> > +     else
> > +             csr_write(CSR_SCOUNTEREN, 0x2);
> > +}
> > +
> > +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
> > +                                           int write, void *buffer,
> > +                                           size_t *lenp, loff_t *ppos)
> > +{
> > +     int prev =3D sysctl_perf_user_access;
> > +     int ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos=
);
> > +
> > +     /*
> > +      * Test against the previous value since we clear SCOUNTEREN when
> > +      * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we s=
hould
> > +      * not do that if that was already the case.
> > +      */
> > +     if (ret || !write || prev =3D=3D sysctl_perf_user_access)
> > +             return ret;
> > +
> > +     on_each_cpu(riscv_pmu_update_counter_access, (void *)&prev, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct ctl_table sbi_pmu_sysctl_table[] =3D {
> > +     {
> > +             .procname       =3D "perf_user_access",
> > +             .data           =3D &sysctl_perf_user_access,
> > +             .maxlen         =3D sizeof(unsigned int),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D riscv_pmu_proc_user_access_handler,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_TWO,
> > +     },
> > +     { }
> > +};
> > +
> >  static int pmu_sbi_device_probe(struct platform_device *pdev)
> >  {
> >       struct riscv_pmu *pmu =3D NULL;
> > @@ -888,6 +985,8 @@ static int pmu_sbi_device_probe(struct platform_dev=
ice *pdev)
> >       pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> >       pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> >       pmu->ctr_read =3D pmu_sbi_ctr_read;
> > +     pmu->event_flags =3D pmu_sbi_event_flags;
> > +     pmu->csr_index =3D pmu_sbi_csr_index;
> >
> >       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> >       if (ret)
> > @@ -901,6 +1000,8 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
> >       if (ret)
> >               goto out_unregister;
> >
> > +     register_sysctl("kernel", sbi_pmu_sysctl_table);
> > +
> >       return 0;
> >
> >  out_unregister:
> > diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_=
pmu.h
> > index 9f70d94942e0..ba19634d815c 100644
> > --- a/include/linux/perf/riscv_pmu.h
> > +++ b/include/linux/perf/riscv_pmu.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/interrupt.h>
> > +#include <asm/perf_event.h>
> >
> >  #ifdef CONFIG_RISCV_PMU
> >
> > @@ -55,6 +56,8 @@ struct riscv_pmu {
> >       void            (*ctr_start)(struct perf_event *event, u64 init_v=
al);
> >       void            (*ctr_stop)(struct perf_event *event, unsigned lo=
ng flag);
> >       int             (*event_map)(struct perf_event *event, u64 *confi=
g);
> > +     int             (*event_flags)(struct perf_event *event);
> > +     uint8_t         (*csr_index)(struct perf_event *event);
> >
> >       struct cpu_hw_events    __percpu *hw_events;
> >       struct hlist_node       node;
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 0d1634cedf44..18f2abb1584a 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
> >
> >  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> >
> > +#elif defined(__riscv) && __riscv_xlen =3D=3D 64
>
> It's enough to just check __riscv_xlen.

Right, thanks

>
> > +
> > +#define CSR_CYCLE    0xc00
> > +#define CSR_TIME     0xc01
> > +#define CSR_CYCLEH   0xc80
> > +
> > +#define csr_read(csr)                                                \
> > +({                                                           \
> > +     register unsigned long __v;                             \
> > +             __asm__ __volatile__ ("csrr %0, " #csr          \
> > +              : "=3Dr" (__v) :                                 \
> > +              : "memory");                                   \
> > +              __v;                                           \
> > +})
> > +
> > +static unsigned long csr_read_num(int csr_num)
> > +{
> > +#define switchcase_csr_read(__csr_num, __val)           {\
> > +     case __csr_num:                                 \
> > +             __val =3D csr_read(__csr_num);            \
> > +             break; }
> > +#define switchcase_csr_read_2(__csr_num, __val)         {\
> > +     switchcase_csr_read(__csr_num + 0, __val)        \
> > +     switchcase_csr_read(__csr_num + 1, __val)}
> > +#define switchcase_csr_read_4(__csr_num, __val)         {\
> > +     switchcase_csr_read_2(__csr_num + 0, __val)      \
> > +     switchcase_csr_read_2(__csr_num + 2, __val)}
> > +#define switchcase_csr_read_8(__csr_num, __val)         {\
> > +     switchcase_csr_read_4(__csr_num + 0, __val)      \
> > +     switchcase_csr_read_4(__csr_num + 4, __val)}
> > +#define switchcase_csr_read_16(__csr_num, __val)        {\
> > +     switchcase_csr_read_8(__csr_num + 0, __val)      \
> > +     switchcase_csr_read_8(__csr_num + 8, __val)}
> > +#define switchcase_csr_read_32(__csr_num, __val)        {\
> > +     switchcase_csr_read_16(__csr_num + 0, __val)     \
> > +     switchcase_csr_read_16(__csr_num + 16, __val)}
> > +
> > +     unsigned long ret =3D 0;
> > +
> > +     switch (csr_num) {
> > +     switchcase_csr_read_32(CSR_CYCLE, ret)
> > +     switchcase_csr_read_32(CSR_CYCLEH, ret)
> > +     default :
>                ^ extra space
>

Thanks

> > +             break;
> > +     }
> > +
> > +     return ret;
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +
> > +static u64 read_perf_counter(unsigned int counter)
> > +{
> > +     return csr_read_num(CSR_CYCLE + counter);
> > +}
> > +
> > +static u64 read_timestamp(void)
> > +{
> > +     return csr_read_num(CSR_TIME);
> > +}
> > +
> >  #else
> >  static u64 read_perf_counter(unsigned int counter __maybe_unused) { re=
turn 0; }
> >  static u64 read_timestamp(void) { return 0; }
> > --
> > 2.37.2
> >
>
> A lot going on this patch. It'd be easier to review if it was broken up a
> bit. E.g. import of arm code, the tools/lib/perf/mmap.c hunk, and whateve=
r
> else makes sense.

Ok, will do that in v2!

>
> Thanks,
> drew

Thanks,

Alex
