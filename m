Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB87329C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbjFPI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbjFPI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:28:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB42D79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:28:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b445512846so4848651fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686904101; x=1689496101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZCqAGjRKDvEoatemozoXx1FoWJTpUzjMGwy/qF8g/8=;
        b=JwldKiQ0TB5xwMKUZIM3Sewt0gaaQKVVgk21JApvEvBQYPpsTN2Zqr4JqgFbWYFNmL
         tzhVTu0yvEsEb4QsfVkIiDOD3KW80NFwC3yVhgsF9V3kZX6VLlQqjCMB0zlZtZK93yr3
         alc0LbjCSWLj3u/pIpWKtOfZ2jAoqnO4GxYl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904101; x=1689496101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZCqAGjRKDvEoatemozoXx1FoWJTpUzjMGwy/qF8g/8=;
        b=UcR6SdW32nG+5nyBXgvMwFXH0oI4itX7XEKgzMmJ0ocw+iKBFJDUaTRnwyTjOWGh7d
         UlwjUPT8Ky9NYxENeXTRZIFZ+QK6ELTZZw/Yzl0rGtN/oml1hqQdVcc4OHY/gl6cSFMW
         KitGpdQ3L5IZOieK8QzpDEKfi1Vl8AZIvEzBsI04vECASlrxCbPnuasGWgvSyHkHmwIv
         JNY90KxqMTccnNE0mXhk/pkQm3f4DfWEW1fbH0BWCT1c2Qvovg9YPO+pcRqauLsxHcmo
         Bshu7tchtosdllgN7XmKvDYb4Zqz0EVmaldiaPaUGVO6tQeOviUP9QIZRYcQUiQigsye
         NPiA==
X-Gm-Message-State: AC+VfDzeIlnmdKkvLVHPRqLucTxEexNZ7PD2+YK/0GW60yHA4BAGQziu
        CUzNWOtjsyc2+pC89dounkxZ1R9JvwNYz/6LapEb
X-Google-Smtp-Source: ACHHUZ56TziHoZxjzqlSenTHxGQzrOu7m8nSQ8jAwhCsCTSWZVoNUnVvDh+QFfMtHzF5cXvsWIqhYxl5XU8WgpNfj9Y=
X-Received: by 2002:a2e:330f:0:b0:2a8:bd1f:a377 with SMTP id
 d15-20020a2e330f000000b002a8bd1fa377mr1210632ljc.20.1686904101308; Fri, 16
 Jun 2023 01:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com> <20230512085321.13259-6-alexghiti@rivosinc.com>
In-Reply-To: <20230512085321.13259-6-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 16 Jun 2023 01:28:09 -0700
Message-ID: <CAOnJCUL8t-BMfLX0uvjbFK9TFVyqEdCnkYN9aE0hB4NXEtRHZw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] riscv: Prepare for user-space perf event mmap support
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
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
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 1:58=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Provide all the necessary bits in the generic riscv pmu driver to be
> able to mmap perf events in userspace: the heavy lifting lies in the
> driver backend, namely the legacy and sbi implementations.
>
> Note that arch_perf_update_userpage is almost a copy of arm64 code.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile     |  2 +-
>  arch/riscv/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++
>  drivers/perf/riscv_pmu.c       | 41 ++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |  4 +++
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4cf303a779ab..0d215fd9860d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -70,7 +70,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  +=3D mcount-dyn.o
>
>  obj-$(CONFIG_TRACE_IRQFLAGS)   +=3D trace_irq.o
>
> -obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o
> +obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o perf_event.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   +=3D perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                +=3D sbi.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_even=
t.c
> new file mode 100644
> index 000000000000..94174a0fc251
> --- /dev/null
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/sched_clock.h>
> +
> +void arch_perf_update_userpage(struct perf_event *event,
> +                              struct perf_event_mmap_page *userpg, u64 n=
ow)
> +{
> +       struct clock_read_data *rd;
> +       unsigned int seq;
> +       u64 ns;
> +
> +       userpg->cap_user_time =3D 0;
> +       userpg->cap_user_time_zero =3D 0;
> +       userpg->cap_user_time_short =3D 0;
> +       userpg->cap_user_rdpmc =3D
> +               !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +
> +       userpg->pmc_width =3D 64;
> +

The counter width is 64 for cycle & instret. Other hpmcounter can have
different width.
This information should retrieved from counter info.

> +       do {
> +               rd =3D sched_clock_read_begin(&seq);
> +
> +               userpg->time_mult =3D rd->mult;
> +               userpg->time_shift =3D rd->shift;
> +               userpg->time_zero =3D rd->epoch_ns;
> +               userpg->time_cycles =3D rd->epoch_cyc;
> +               userpg->time_mask =3D rd->sched_clock_mask;
> +
> +               /*
> +                * Subtract the cycle base, such that software that
> +                * doesn't know about cap_user_time_short still 'works'
> +                * assuming no wraps.
> +                */
> +               ns =3D mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift=
);
> +               userpg->time_zero -=3D ns;
> +
> +       } while (sched_clock_read_retry(seq));
> +
> +       userpg->time_offset =3D userpg->time_zero - now;
> +
> +       /*
> +        * time_shift is not expected to be greater than 31 due to
> +        * the original published conversion algorithm shifting a
> +        * 32-bit value (now specifies a 64-bit value) - refer
> +        * perf_event_mmap_page documentation in perf_event.h.
> +        */
> +       if (userpg->time_shift =3D=3D 32) {
> +               userpg->time_shift =3D 31;
> +               userpg->time_mult >>=3D 1;
> +       }
> +
> +       /*
> +        * Internal timekeeping for enabled/running/stopped times
> +        * is always computed with the sched_clock.
> +        */
> +       userpg->cap_user_time =3D 1;
> +       userpg->cap_user_time_zero =3D 1;
> +       userpg->cap_user_time_short =3D 1;
> +}
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index ebca5eab9c9b..af69da268246 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -171,6 +171,8 @@ int riscv_pmu_event_set_period(struct perf_event *eve=
nt)
>
>         local64_set(&hwc->prev_count, (u64)-left);
>
> +       perf_event_update_userpage(event);
> +
>         return overflow;
>  }
>
> @@ -267,6 +269,9 @@ static int riscv_pmu_event_init(struct perf_event *ev=
ent)
>         hwc->idx =3D -1;
>         hwc->event_base =3D mapped_event;
>
> +       if (rvpmu->event_init)
> +               rvpmu->event_init(event);
> +
>         if (!is_sampling_event(event)) {
>                 /*
>                  * For non-sampling runs, limit the sample_period to half
> @@ -283,6 +288,39 @@ static int riscv_pmu_event_init(struct perf_event *e=
vent)
>         return 0;
>  }
>
> +static int riscv_pmu_event_idx(struct perf_event *event)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +               return 0;
> +
> +       if (rvpmu->csr_index)
> +               return rvpmu->csr_index(event) + 1;
> +
> +       return 0;
> +}
> +
> +static void riscv_pmu_event_mapped(struct perf_event *event, struct mm_s=
truct *mm)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (rvpmu->event_mapped) {
> +               rvpmu->event_mapped(event, mm);
> +               perf_event_update_userpage(event);
> +       }
> +}
> +
> +static void riscv_pmu_event_unmapped(struct perf_event *event, struct mm=
_struct *mm)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +
> +       if (rvpmu->event_unmapped) {
> +               rvpmu->event_unmapped(event, mm);
> +               perf_event_update_userpage(event);
> +       }
> +}
> +
>  struct riscv_pmu *riscv_pmu_alloc(void)
>  {
>         struct riscv_pmu *pmu;
> @@ -307,6 +345,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>         }
>         pmu->pmu =3D (struct pmu) {
>                 .event_init     =3D riscv_pmu_event_init,
> +               .event_mapped   =3D riscv_pmu_event_mapped,
> +               .event_unmapped =3D riscv_pmu_event_unmapped,
> +               .event_idx      =3D riscv_pmu_event_idx,
>                 .add            =3D riscv_pmu_add,
>                 .del            =3D riscv_pmu_del,
>                 .start          =3D riscv_pmu_start,
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 9f70d94942e0..1452c8af3b67 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -55,6 +55,10 @@ struct riscv_pmu {
>         void            (*ctr_start)(struct perf_event *event, u64 init_v=
al);
>         void            (*ctr_stop)(struct perf_event *event, unsigned lo=
ng flag);
>         int             (*event_map)(struct perf_event *event, u64 *confi=
g);
> +       void            (*event_init)(struct perf_event *event);
> +       void            (*event_mapped)(struct perf_event *event, struct =
mm_struct *mm);
> +       void            (*event_unmapped)(struct perf_event *event, struc=
t mm_struct *mm);
> +       uint8_t         (*csr_index)(struct perf_event *event);
>
>         struct cpu_hw_events    __percpu *hw_events;
>         struct hlist_node       node;
> --
> 2.37.2
>


--=20
Regards,
Atish
