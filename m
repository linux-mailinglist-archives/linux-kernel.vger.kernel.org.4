Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145D731279
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjFOImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbjFOIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:41:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D38730C2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:41:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so22547961fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686818480; x=1689410480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kScK+DmaaVwsZ1S/KTJgh7lWuqmHbY5J+2OOHYrLyjE=;
        b=fJqOUw1MwSlFoDp4ViwFTlPLeouR31qFkw7FtQOTlP90PQDJrF+n5M8aMP5sDl8O7a
         TRhpT0TcGSsnyLzxpbkyFLFPezbsJpyL4wAp0nlvPYHJ8ONGUjURh8H4Z4Cb7rUjKoEZ
         /RgcrRqYbuRqVfBOPTkcMzaogxLBbfnaR0zMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818480; x=1689410480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kScK+DmaaVwsZ1S/KTJgh7lWuqmHbY5J+2OOHYrLyjE=;
        b=Kl/rLCbAPA525/b0Z1yf02PuXj1fOoLpp/4p8ZPY97FoQlu+4saYnjy6FkeO7f9B2M
         92/7GYZEhl5/5MyfC6IgEjY59hJv8dJT80RzbV6ltlozdmIT29RGgK1GiKBHdYAbkx6n
         35gWwTfHDEPKXqU0M5m0z+IZI6pJCZHTKMs6X3V3875PMzCDpT0elwfIvhjoMpOpE74S
         2N6RLpaFFQk7kK95GW3wIgBT/REajPiCZHBbsIvaeSYCN1/UvmQvOylwgJPuzNjSqQ8N
         ZI5WIVs0RHRGMOHYcK/FDMCGx/dWLsG+2/sXbZGpOQD9yjvWKtVY6gWjt5WVV6hyDGas
         xTEg==
X-Gm-Message-State: AC+VfDz408QTOdxDFEjkRy8+o+Hjd4kJjgcXfSVWI/9sE8UH0wFRt6xO
        omi/jSlJxES3izlkcy+NTpXygEKY8/7oi5ydXDeq
X-Google-Smtp-Source: ACHHUZ6QRDRLzy1M148PSoVPRfqjc/sl4a101nUANQCg57kdVgQKstw9ui7vYPNwM3pOgkC8bVi7NlqmM+WtCsG6hPw=
X-Received: by 2002:a2e:7c15:0:b0:2b1:d6bf:d8b2 with SMTP id
 x21-20020a2e7c15000000b002b1d6bfd8b2mr9615463ljc.22.1686818480421; Thu, 15
 Jun 2023 01:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-8-alexghiti@rivosinc.com> <20230531-7e3740ca04a3fe6e2fd25a01@orel>
In-Reply-To: <20230531-7e3740ca04a3fe6e2fd25a01@orel>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 15 Jun 2023 01:41:08 -0700
Message-ID: <CAOnJCULmOuP=EGuR7RXgkBU0LrQ9c++M43UXc1dy86kaLxOeVQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] drivers: perf: Implement perf event mmap support
 in the SBI backend
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 8:02=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, May 12, 2023 at 10:53:18AM +0200, Alexandre Ghiti wrote:
> > We used to unconditionnally expose the cycle and instret csrs to
> > userspace, which gives rise to security concerns.
> >
> > So now we only allow access to hw counters from userspace through the p=
erf
> > framework which will handle context switches, per-task events...etc. Bu=
t
> > as we cannot break userspace, we give the user the choice to go back to
> > the previous behaviour by setting the sysctl perf_user_access.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/kernel/perf_event.c |  18 ++-
> >  drivers/perf/riscv_pmu_sbi.c   | 194 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 205 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_ev=
ent.c
> > index 94174a0fc251..3af9ca45b43f 100644
> > --- a/arch/riscv/kernel/perf_event.c
> > +++ b/arch/riscv/kernel/perf_event.c
> > @@ -1,9 +1,13 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/perf/riscv_pmu.h>
> >  #include <linux/sched_clock.h>
> >
> >  void arch_perf_update_userpage(struct perf_event *event,
> >                              struct perf_event_mmap_page *userpg, u64 n=
ow)
> >  {
> > +#ifdef CONFIG_RISCV_PMU_SBI
> > +     struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> > +#endif
>
> Can avoid this pair of #ifdef/#endif's by just declaring rvpmu inside the
> if block below where it's needed. Or even just using to_riscv_pmu()
> directly in place of rvpmu.
>
> >       struct clock_read_data *rd;
> >       unsigned int seq;
> >       u64 ns;
> > @@ -14,7 +18,19 @@ void arch_perf_update_userpage(struct perf_event *ev=
ent,
> >       userpg->cap_user_rdpmc =3D
> >               !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> >
> > -     userpg->pmc_width =3D 64;
> > +#ifdef CONFIG_RISCV_PMU_SBI
> > +     /*
> > +      * The counters are 64-bit but the priv spec doesn't mandate all =
the
> > +      * bits to be implemented: that's why, counter width can vary bas=
ed on
> > +      * the cpu vendor.
> > +      */
> > +     if (event->pmu->name &&
> > +         !strncmp(event->pmu->name,
> > +                  RISCV_PMU_PDEV_NAME, sizeof(RISCV_PMU_PDEV_NAME)))
> > +             userpg->pmc_width =3D rvpmu->ctr_get_width(event->hw.idx)=
 + 1;
> > +     else
> > +#endif
> > +             userpg->pmc_width =3D 64;
>
> Can leave the initialization to 64 above the #ifdef CONFIG_RISCV_PMU_SBI
> as is and drop the else.
>
> >
> >       do {
> >               rd =3D sched_clock_read_begin(&seq);
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 3b0ee2148054..d9bcc5cc6df5 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -24,6 +24,14 @@
> >  #include <asm/sbi.h>
> >  #include <asm/hwcap.h>
> >
> > +#define SYSCTL_NO_USER_ACCESS        0
> > +#define SYSCTL_USER_ACCESS   1
> > +#define SYSCTL_LEGACY                2
> > +
> > +#define PERF_EVENT_FLAG_NO_USER_ACCESS       BIT(SYSCTL_NO_USER_ACCESS=
)
> > +#define PERF_EVENT_FLAG_USER_ACCESS  BIT(SYSCTL_USER_ACCESS)
> > +#define PERF_EVENT_FLAG_LEGACY               BIT(SYSCTL_LEGACY)
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> > @@ -43,6 +51,9 @@ static const struct attribute_group *riscv_pmu_attr_g=
roups[] =3D {
> >       NULL,
> >  };
> >
> > +/* Allow legacy access by default */
> > +static int sysctl_perf_user_access __read_mostly =3D SYSCTL_LEGACY;
> > +
>
> I'm still not in favor of this. Hopefully the distro discussions result i=
n
> it being changed.
>

I did not see any feedback from distro guys. I talked to David (fedora
maintainer) and he is even okay with
SYSCTL_NO_USER_ACCESS :). I would love to hear back from others (cc'd
a few distro folks to this thread).

> >  /*
> >   * RISC-V doesn't have heterogeneous harts yet. This need to be part o=
f
> >   * per_cpu in case of harts with different pmu counters
> > @@ -301,6 +312,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 =
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
> > @@ -329,18 +345,34 @@ static int pmu_sbi_ctr_get_idx(struct perf_event =
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
> > +     /*
> > +      * In legacy mode, we have to force the fixed counters for those =
events
> > +      * but not in the user access mode as we want to use the other co=
unters
> > +      * that support sampling/filtering.
> > +      */
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
> > @@ -474,6 +506,14 @@ static u64 pmu_sbi_ctr_read(struct perf_event *eve=
nt)
> >       return val;
> >  }
> >
> > +static void pmu_sbi_set_scounteren(void *arg)
> > +{
> > +     struct perf_event *event =3D (struct perf_event *)arg;
> > +
> > +     csr_write(CSR_SCOUNTEREN,
> > +               csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(even=
t)));
> > +}
> > +
> >  static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
> >  {
> >       struct sbiret ret;
> > @@ -490,6 +530,18 @@ static void pmu_sbi_ctr_start(struct perf_event *e=
vent, u64 ival)
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STARTED))
> >               pr_err("Starting counter idx %d failed with error %d\n",
> >                       hwc->idx, sbi_err_map_linux_errno(ret.error));
> > +
> > +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> > +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
> > +             pmu_sbi_set_scounteren((void *)event);
> > +}
> > +
> > +static void pmu_sbi_reset_scounteren(void *arg)
> > +{
> > +     struct perf_event *event =3D (struct perf_event *)arg;
> > +
> > +     csr_write(CSR_SCOUNTEREN,
> > +               csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(eve=
nt)));
> >  }
> >
> >  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long f=
lag)
> > @@ -497,6 +549,10 @@ static void pmu_sbi_ctr_stop(struct perf_event *ev=
ent, unsigned long flag)
> >       struct sbiret ret;
> >       struct hw_perf_event *hwc =3D &event->hw;
> >
> > +     if (hwc->flags & PERF_EVENT_FLAG_USER_ACCESS &&
> > +         hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT)
> > +             pmu_sbi_reset_scounteren((void *)event);
> > +
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> >               flag !=3D SBI_PMU_STOP_FLAG_RESET)
> > @@ -704,10 +760,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu,=
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
> >        */
> > -     csr_write(CSR_SCOUNTEREN, 0x7);
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_LEGACY)
> > +             csr_write(CSR_SCOUNTEREN, 0x7);
> > +     else
> > +             csr_write(CSR_SCOUNTEREN, 0x2);
> >
> >       /* Stop all the counters so that they can be enabled from perf */
> >       pmu_sbi_stop_all(pmu);
> > @@ -851,6 +910,123 @@ static void riscv_pmu_destroy(struct riscv_pmu *p=
mu)
> >       cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->n=
ode);
> >  }
> >
> > +static void pmu_sbi_event_init(struct perf_event *event)
> > +{
> > +     /*
> > +      * The permissions are set at event_init so that we do not depend
> > +      * on the sysctl value that can change.
> > +      */
> > +     if (sysctl_perf_user_access =3D=3D SYSCTL_NO_USER_ACCESS)
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_NO_USER_ACCESS;
> > +     else if (sysctl_perf_user_access =3D=3D SYSCTL_USER_ACCESS)
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_USER_ACCESS;
> > +     else
> > +             event->hw.flags |=3D PERF_EVENT_FLAG_LEGACY;
> > +}
> > +
> > +static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_s=
truct *mm)
> > +{
> > +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> > +             return;
> > +
> > +     /* In legacy mode, the first 3 CSRs are available. */
>
> first and third
>
> > +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> > +                 event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS) {
> > +                     return;
> > +             }
> > +     }
> > +
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
> > +
> > +     event->hw.flags |=3D PERF_EVENT_FLAG_USER_READ_CNT;
> > +
> > +     /*
> > +      * We must enable userspace access *before* advertising in the us=
er page
> > +      * that it is possible to do so to avoid any race.
> > +      * And we must notify all cpus here because threads that currentl=
y run
> > +      * on other cpus will try to directly access the counter too with=
out
> > +      * calling pmu_sbi_ctr_start.
> > +      */
> > +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> > +             on_each_cpu_mask(mm_cpumask(mm),
> > +                              pmu_sbi_set_scounteren, (void *)event, 1=
);
> > +}
> > +
> > +static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm=
_struct *mm)
> > +{
> > +     if (event->hw.flags & PERF_EVENT_FLAG_NO_USER_ACCESS)
> > +             return;
> > +
> > +     /* In legacy mode, the first 3 CSRs are available. */
>
> first and third
>
> > +     if (event->hw.flags & PERF_EVENT_FLAG_LEGACY) {
> > +             if (event->attr.config !=3D PERF_COUNT_HW_CPU_CYCLES &&
> > +                 event->attr.config !=3D PERF_COUNT_HW_INSTRUCTIONS) {
> > +                     return;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Here we can directly remove user access since the user does no=
t have
> > +      * access to the user page anymore so we avoid the racy window wh=
ere the
> > +      * user could have read cap_user_rdpmc to true right before we di=
sable
> > +      * it.
> > +      */
> > +     event->hw.flags &=3D ~PERF_EVENT_FLAG_USER_READ_CNT;
> > +
> > +     if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
> > +             on_each_cpu_mask(mm_cpumask(mm),
> > +                              pmu_sbi_reset_scounteren, (void *)event,=
 1);
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
>
> Instead of passing prev shouldn't we pass NULL, as it's not used?
>
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
> > @@ -888,6 +1064,10 @@ static int pmu_sbi_device_probe(struct platform_d=
evice *pdev)
> >       pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> >       pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> >       pmu->ctr_read =3D pmu_sbi_ctr_read;
> > +     pmu->event_init =3D pmu_sbi_event_init;
> > +     pmu->event_mapped =3D pmu_sbi_event_mapped;
> > +     pmu->event_unmapped =3D pmu_sbi_event_unmapped;
> > +     pmu->csr_index =3D pmu_sbi_csr_index;
> >
> >       ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> >       if (ret)
> > @@ -901,6 +1081,8 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
> >       if (ret)
> >               goto out_unregister;
> >
> > +     register_sysctl("kernel", sbi_pmu_sysctl_table);
> > +
> >       return 0;
> >
> >  out_unregister:
> > --
> > 2.37.2
> >
>
> Thanks,
> drew



--=20
Regards,
Atish
