Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83C66EF4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjDZM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbjDZM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:58:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E5E3AA5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:57:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so47161065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682513866; x=1685105866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMrzz290CXTDAc1/Hdn97jk/DDRJ16Ie5vLkukohIek=;
        b=OHOk5Km8hexCdTFqOsexMPch/RzMpK27eYgNq8umnNpIVqmCEarcwdUb4r3bb3izyz
         Zr5phS3EYAD9LNZjZ82WDlrYSQAYtiFenltEI+UI3eZ7OqYoqRbCPPTpi1h/HkjqK+b6
         A+Z/4znZVP+Z0gdgknd6FHZY66x7p9HhzEQpscMow/f9HQOxE5hvnetrX9oNdJB2ebUj
         8kkUwbxOELEZgzAhDXYcN4SOLW6HHjAdXWHN972VMdjv+xyFZ59xB2vt0HMK6oskZ4NA
         rh9u104TTHYbW/Ymzne2lSLGBNQzYOJjIuSgOgN478IycPS4ecqzu3zYgrlDTKN18/IM
         aFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682513866; x=1685105866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMrzz290CXTDAc1/Hdn97jk/DDRJ16Ie5vLkukohIek=;
        b=V8aY/lkQGJQ3Mbbn7BzYTQbVklSD7Kd2QMy2f99CE3CA5fsRX8Av/MDARyCt8nLyqz
         Y24iAdr+O98WBawentZU8GlB/VMa/rO7Yo8MKIW6A1dZuiUFVYYzosR+5946IfstLmM9
         LvDiJL8LNW2VJYBaRYNSLa5RtpdoKudQ4ivXH2gCxwpYsnQ7yYHYiwcA1yA60zWDuPg3
         bk1xjGXe2Qs4PvweeCOuZh0uDOwBgbMSI8gIDbDxokdSyFIHG1KZqNHKEJYeANNV9ZRy
         E6Zr+wOxE/j+fbLShVNcoNOwuzDZS8cmpPnugk0zJTtwBFZ2YV3Bcm+8d7LQIR70eVD5
         60Ug==
X-Gm-Message-State: AAQBX9dGP4NmOCunae0PombyqXusDniqe2RaUp2MKVE60SSWZhWvCRbJ
        Nr8mpEAzFOBjPrwO1tx7j/vRxw==
X-Google-Smtp-Source: AKy350Z0p33MJUnv+TBJKVkWqkOvg1sJ2QBg2nwBCyxM8ZDODhESbIfekP7YVfqDMN4FaAkcRmf6wA==
X-Received: by 2002:a7b:cbd7:0:b0:3f1:9be0:b39f with SMTP id n23-20020a7bcbd7000000b003f19be0b39fmr10234000wmi.8.1682513865594;
        Wed, 26 Apr 2023 05:57:45 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n10-20020a1c720a000000b003edef091b17sm17844488wmc.37.2023.04.26.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 05:57:45 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:57:44 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
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
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through
 perf
Message-ID: <kwvrls2m6swp443brn27jwcsdhovtc4kxrkqustxpqgf7zqltw@xlhsrndkf4om>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413161725.195417-5-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 06:17:25PM +0200, Alexandre Ghiti wrote:
> We used to unconditionnally expose the cycle and instret csrs to
> userspace, which gives rise to security concerns.
> 
> So only allow access to hw counters from userspace through the perf
> framework which will handle context switchs, per-task events...etc. But
> as we cannot break userspace, we give the user the choice to go back to
> the previous behaviour by setting the sysctl perf_user_access.
> 
> We also introduce a means to directly map the hardware counters to
> userspace, thus avoiding the need for syscalls whenever an application
> wants to access counters values.
> 
> Note that arch_perf_update_userpage is a copy of arm64 code.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |  23 +++-
>  arch/riscv/include/asm/perf_event.h         |   3 +
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/riscv/kernel/perf_event.c              |  65 +++++++++++
>  drivers/perf/riscv_pmu.c                    |  42 ++++++++
>  drivers/perf/riscv_pmu_legacy.c             |  17 +++
>  drivers/perf/riscv_pmu_sbi.c                | 113 ++++++++++++++++++--
>  include/linux/perf/riscv_pmu.h              |   3 +
>  tools/lib/perf/mmap.c                       |  65 +++++++++++
>  9 files changed, 322 insertions(+), 11 deletions(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 4b7bfea28cd7..02b2a40a3647 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -941,16 +941,31 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>  The default value is 8.
>  
>  
> -perf_user_access (arm64 only)
> -=================================
> +perf_user_access (arm64 and riscv only)
> +=======================================
> +
> +Controls user space access for reading perf event counters.
>  
> -Controls user space access for reading perf event counters. When set to 1,
> -user space can read performance monitor counter registers directly.
> +arm64
> +=====
>  
>  The default value is 0 (access disabled).
> +When set to 1, user space can read performance monitor counter registers
> +directly.
>  
>  See Documentation/arm64/perf.rst for more information.
>  
> +riscv
> +=====
> +
> +When set to 0, user access is disabled.
> +
> +When set to 1, user space can read performance monitor counter registers
> +directly only through perf, any direct access without perf intervention will
> +trigger an illegal instruction.
> +
> +The default value is 2, it enables the legacy mode, that is user space has
> +direct access to cycle, time and insret CSRs only.

I think this default value should be a Kconfig symbol, allowing kernels to
be built with a secure default.

>  
>  pid_max
>  =======
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index d42c901f9a97..9fdfdd9dc92d 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -9,5 +9,8 @@
>  #define _ASM_RISCV_PERF_EVENT_H
>  
>  #include <linux/perf_event.h>
> +
> +#define PERF_EVENT_FLAG_LEGACY	1
> +
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index aa22f87faeae..9ae951b07847 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -70,7 +70,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>  
>  obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
>  
> -obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
> +obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o perf_event.o
>  obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)		+= sbi.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> new file mode 100644
> index 000000000000..4a75ab628bfb
> --- /dev/null
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/perf/riscv_pmu.h>
> +#include <linux/sched_clock.h>
> +
> +void arch_perf_update_userpage(struct perf_event *event,
> +			       struct perf_event_mmap_page *userpg, u64 now)
> +{
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +	struct clock_read_data *rd;
> +	unsigned int seq;
> +	u64 ns;
> +
> +	userpg->cap_user_time = 0;
> +	userpg->cap_user_time_zero = 0;
> +	userpg->cap_user_time_short = 0;
> +	userpg->cap_user_rdpmc =
> +		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +
> +	/*
> +	 * The counters are 64-bit but the priv spec doesn't mandate all the
> +	 * bits to be implemented: that's why, counter width can vary based on
> +	 * the cpu vendor.
> +	 */
> +	userpg->pmc_width = rvpmu->ctr_get_width(event->hw.idx) + 1;
> +
> +	do {
> +		rd = sched_clock_read_begin(&seq);
> +
> +		userpg->time_mult = rd->mult;
> +		userpg->time_shift = rd->shift;
> +		userpg->time_zero = rd->epoch_ns;
> +		userpg->time_cycles = rd->epoch_cyc;
> +		userpg->time_mask = rd->sched_clock_mask;
> +
> +		/*
> +		 * Subtract the cycle base, such that software that
> +		 * doesn't know about cap_user_time_short still 'works'
> +		 * assuming no wraps.
> +		 */
> +		ns = mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift);
> +		userpg->time_zero -= ns;
> +
> +	} while (sched_clock_read_retry(seq));
> +
> +	userpg->time_offset = userpg->time_zero - now;
> +
> +	/*
> +	 * time_shift is not expected to be greater than 31 due to
> +	 * the original published conversion algorithm shifting a
> +	 * 32-bit value (now specifies a 64-bit value) - refer
> +	 * perf_event_mmap_page documentation in perf_event.h.
> +	 */
> +	if (userpg->time_shift == 32) {
> +		userpg->time_shift = 31;
> +		userpg->time_mult >>= 1;
> +	}
> +
> +	/*
> +	 * Internal timekeeping for enabled/running/stopped times
> +	 * is always computed with the sched_clock.
> +	 */
> +	userpg->cap_user_time = 1;
> +	userpg->cap_user_time_zero = 1;
> +	userpg->cap_user_time_short = 1;
> +}
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index ebca5eab9c9b..12675ee1123c 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -171,6 +171,8 @@ int riscv_pmu_event_set_period(struct perf_event *event)
>  
>  	local64_set(&hwc->prev_count, (u64)-left);
>  
> +	perf_event_update_userpage(event);
> +
>  	return overflow;
>  }
>  
> @@ -283,6 +285,43 @@ static int riscv_pmu_event_init(struct perf_event *event)
>  	return 0;
>  }
>  
> +static int riscv_pmu_event_idx(struct perf_event *event)
> +{
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +
> +	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
> +		return 0;
> +
> +	/*
> +	 * cycle and instret can either be retrieved from their fixed counters
> +	 * or from programmable counters, the latter being the preferred way
> +	 * since cycle and instret counters do not support sampling.
> +	 */
> +
> +	return rvpmu->csr_index(event) + 1;
> +}
> +
> +static void riscv_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	/*
> +	 * The user mmapped the event to directly access it: this is where
> +	 * we determine based on sysctl_perf_user_access if we grant userspace
> +	 * the direct access to this event. That means that within the same
> +	 * task, some events may be directly accessible and some other may not,
> +	 * if the user changes the value of sysctl_perf_user_accesss in the
> +	 * meantime.
> +	 */
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> +
> +	event->hw.flags |= rvpmu->event_flags(event);
> +	perf_event_update_userpage(event);
> +}
> +
> +static void riscv_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> +{
> +	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
>  struct riscv_pmu *riscv_pmu_alloc(void)
>  {
>  	struct riscv_pmu *pmu;
> @@ -307,6 +346,9 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>  	}
>  	pmu->pmu = (struct pmu) {
>  		.event_init	= riscv_pmu_event_init,
> +		.event_mapped	= riscv_pmu_event_mapped,
> +		.event_unmapped	= riscv_pmu_event_unmapped,
> +		.event_idx	= riscv_pmu_event_idx,
>  		.add		= riscv_pmu_add,
>  		.del		= riscv_pmu_del,
>  		.start		= riscv_pmu_start,
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index 0d8c9d8849ee..35c4c9097a0f 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -74,6 +74,21 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
>  	local64_set(&hwc->prev_count, initial_val);
>  }
>  
> +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
> +{
> +	return event->hw.idx;
> +}
> +
> +static int pmu_legacy_event_flags(struct perf_event *event)
> +{
> +	/* In legacy mode, the first 3 CSRs are available. */
> +	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
> +	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
> +		return 0;
> +
> +	return PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
>  /*
>   * This is just a simple implementation to allow legacy implementations
>   * compatible with new RISC-V PMU driver framework.
> @@ -94,6 +109,8 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>  	pmu->ctr_get_width = NULL;
>  	pmu->ctr_clear_idx = NULL;
>  	pmu->ctr_read = pmu_legacy_read_ctr;
> +	pmu->event_flags = pmu_legacy_event_flags;
> +	pmu->csr_index = pmu_legacy_csr_index;
>  
>  	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>  }
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..af7f3128b6b8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -24,6 +24,10 @@
>  #include <asm/sbi.h>
>  #include <asm/hwcap.h>
>  
> +#define SYSCTL_NO_USER_ACCESS	0
> +#define SYSCTL_USER_ACCESS	1
> +#define SYSCTL_LEGACY		2
> +
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
> @@ -43,6 +47,9 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>  	NULL,
>  };
>  
> +/* Allow legacy access by default */
> +static int sysctl_perf_user_access __read_mostly = SYSCTL_LEGACY;
> +
>  /*
>   * RISC-V doesn't have heterogeneous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
> @@ -301,6 +308,11 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
>  }
>  EXPORT_SYMBOL_GPL(riscv_pmu_get_hpm_info);
>  
> +static uint8_t pmu_sbi_csr_index(struct perf_event *event)
> +{
> +	return pmu_ctr_list[event->hw.idx].csr - CSR_CYCLE;
> +}
> +
>  static unsigned long pmu_sbi_get_filter_flags(struct perf_event *event)
>  {
>  	unsigned long cflags = 0;
> @@ -329,18 +341,30 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
>  	struct sbiret ret;
>  	int idx;
> -	uint64_t cbase = 0;
> +	uint64_t cbase = 0, cmask = rvpmu->cmask;
>  	unsigned long cflags = 0;
>  
>  	cflags = pmu_sbi_get_filter_flags(event);
> +
> +	/* In legacy mode, we have to force the fixed counters for those events */
> +	if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
> +		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
> +			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> +			cmask = 1;
> +		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
> +			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
> +			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
> +		}
> +	}
> +
>  	/* retrieve the available counter index */
>  #if defined(CONFIG_32BIT)
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			rvpmu->cmask, cflags, hwc->event_base, hwc->config,
> +			cmask, cflags, hwc->event_base, hwc->config,
>  			hwc->config >> 32);
>  #else
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
> -			rvpmu->cmask, cflags, hwc->event_base, hwc->config, 0);
> +			cmask, cflags, hwc->event_base, hwc->config, 0);
>  #endif
>  	if (ret.error) {
>  		pr_debug("Not able to find a counter for event %lx config %llx\n",
> @@ -490,6 +514,11 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
>  		pr_err("Starting counter idx %d failed with error %d\n",
>  			hwc->idx, sbi_err_map_linux_errno(ret.error));
> +
> +	if (!(event->hw.flags & PERF_EVENT_FLAG_LEGACY) &&
> +	    event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> +		csr_write(CSR_SCOUNTEREN,
> +			  csr_read(CSR_SCOUNTEREN) | (1 << pmu_sbi_csr_index(event)));
>  }
>  
>  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> @@ -497,6 +526,11 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  	struct sbiret ret;
>  	struct hw_perf_event *hwc = &event->hw;
>  
> +	if (!(event->hw.flags & PERF_EVENT_FLAG_LEGACY) &&
> +	    event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> +		csr_write(CSR_SCOUNTEREN,
> +			  csr_read(CSR_SCOUNTEREN) & ~(1 << pmu_sbi_csr_index(event)));
> +
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
>  		flag != SBI_PMU_STOP_FLAG_RESET)
> @@ -704,10 +738,13 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  
>  	/*
> -	 * Enable the access for CYCLE, TIME, and INSTRET CSRs from userspace,
> -	 * as is necessary to maintain uABI compatibility.
> +	 * We keep enabling userspace access to CYCLE, TIME and INSRET via the
> +	 * legacy option but that will be removed in the future.

Will it? The documentation hunk didn't mention that value 2 was depreciated.

>  	 */
> -	csr_write(CSR_SCOUNTEREN, 0x7);
> +	if (sysctl_perf_user_access == SYSCTL_LEGACY)
> +		csr_write(CSR_SCOUNTEREN, 0x7);
> +	else
> +		csr_write(CSR_SCOUNTEREN, 0x2);
>  
>  	/* Stop all the counters so that they can be enabled from perf */
>  	pmu_sbi_stop_all(pmu);
> @@ -851,6 +888,66 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
>  
> +static int pmu_sbi_event_flags(struct perf_event *event)
> +{
> +	if (sysctl_perf_user_access == SYSCTL_NO_USER_ACCESS)
> +		return 0;
> +
> +	/* In legacy mode, the first 3 CSRs are available. */
> +	if (sysctl_perf_user_access == SYSCTL_LEGACY) {
> +		int flags = PERF_EVENT_FLAG_LEGACY;
> +
> +		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES ||
> +		    event->attr.config == PERF_COUNT_HW_INSTRUCTIONS)
> +			flags |= PERF_EVENT_FLAG_USER_READ_CNT;
> +
> +		return flags;
> +	}
> +
> +	return PERF_EVENT_FLAG_USER_READ_CNT;
> +}
> +
> +static void riscv_pmu_update_counter_access(void *info)
> +{
> +	if (sysctl_perf_user_access == SYSCTL_LEGACY)
> +		csr_write(CSR_SCOUNTEREN, 0x7);
> +	else
> +		csr_write(CSR_SCOUNTEREN, 0x2);
> +}
> +
> +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
> +					      int write, void *buffer,
> +					      size_t *lenp, loff_t *ppos)
> +{
> +	int prev = sysctl_perf_user_access;
> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	/*
> +	 * Test against the previous value since we clear SCOUNTEREN when
> +	 * sysctl_perf_user_access is set to SYSCTL_USER_ACCESS, but we should
> +	 * not do that if that was already the case.
> +	 */
> +	if (ret || !write || prev == sysctl_perf_user_access)
> +		return ret;
> +
> +	on_each_cpu(riscv_pmu_update_counter_access, (void *)&prev, 1);
> +
> +	return 0;
> +}
> +
> +static struct ctl_table sbi_pmu_sysctl_table[] = {
> +	{
> +		.procname       = "perf_user_access",
> +		.data		= &sysctl_perf_user_access,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= riscv_pmu_proc_user_access_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_TWO,
> +	},
> +	{ }
> +};
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu = NULL;
> @@ -888,6 +985,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	pmu->ctr_get_width = pmu_sbi_ctr_get_width;
>  	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
>  	pmu->ctr_read = pmu_sbi_ctr_read;
> +	pmu->event_flags = pmu_sbi_event_flags;
> +	pmu->csr_index = pmu_sbi_csr_index;
>  
>  	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  	if (ret)
> @@ -901,6 +1000,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>  
> +	register_sysctl("kernel", sbi_pmu_sysctl_table);
> +
>  	return 0;
>  
>  out_unregister:
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index 9f70d94942e0..ba19634d815c 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -12,6 +12,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/ptrace.h>
>  #include <linux/interrupt.h>
> +#include <asm/perf_event.h>
>  
>  #ifdef CONFIG_RISCV_PMU
>  
> @@ -55,6 +56,8 @@ struct riscv_pmu {
>  	void		(*ctr_start)(struct perf_event *event, u64 init_val);
>  	void		(*ctr_stop)(struct perf_event *event, unsigned long flag);
>  	int		(*event_map)(struct perf_event *event, u64 *config);
> +	int		(*event_flags)(struct perf_event *event);
> +	uint8_t		(*csr_index)(struct perf_event *event);
>  
>  	struct cpu_hw_events	__percpu *hw_events;
>  	struct hlist_node	node;
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 0d1634cedf44..18f2abb1584a 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -392,6 +392,71 @@ static u64 read_perf_counter(unsigned int counter)
>  
>  static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
>  
> +#elif defined(__riscv) && __riscv_xlen == 64

It's enough to just check __riscv_xlen.

> +
> +#define CSR_CYCLE	0xc00
> +#define CSR_TIME	0xc01
> +#define CSR_CYCLEH	0xc80
> +
> +#define csr_read(csr)						\
> +({								\
> +	register unsigned long __v;				\
> +		__asm__ __volatile__ ("csrr %0, " #csr		\
> +		 : "=r" (__v) :					\
> +		 : "memory");					\
> +		 __v;						\
> +})
> +
> +static unsigned long csr_read_num(int csr_num)
> +{
> +#define switchcase_csr_read(__csr_num, __val)           {\
> +	case __csr_num:                                 \
> +		__val = csr_read(__csr_num);            \
> +		break; }
> +#define switchcase_csr_read_2(__csr_num, __val)         {\
> +	switchcase_csr_read(__csr_num + 0, __val)        \
> +	switchcase_csr_read(__csr_num + 1, __val)}
> +#define switchcase_csr_read_4(__csr_num, __val)         {\
> +	switchcase_csr_read_2(__csr_num + 0, __val)      \
> +	switchcase_csr_read_2(__csr_num + 2, __val)}
> +#define switchcase_csr_read_8(__csr_num, __val)         {\
> +	switchcase_csr_read_4(__csr_num + 0, __val)      \
> +	switchcase_csr_read_4(__csr_num + 4, __val)}
> +#define switchcase_csr_read_16(__csr_num, __val)        {\
> +	switchcase_csr_read_8(__csr_num + 0, __val)      \
> +	switchcase_csr_read_8(__csr_num + 8, __val)}
> +#define switchcase_csr_read_32(__csr_num, __val)        {\
> +	switchcase_csr_read_16(__csr_num + 0, __val)     \
> +	switchcase_csr_read_16(__csr_num + 16, __val)}
> +
> +	unsigned long ret = 0;
> +
> +	switch (csr_num) {
> +	switchcase_csr_read_32(CSR_CYCLE, ret)
> +	switchcase_csr_read_32(CSR_CYCLEH, ret)
> +	default :
               ^ extra space

> +		break;
> +	}
> +
> +	return ret;
> +#undef switchcase_csr_read_32
> +#undef switchcase_csr_read_16
> +#undef switchcase_csr_read_8
> +#undef switchcase_csr_read_4
> +#undef switchcase_csr_read_2
> +#undef switchcase_csr_read
> +}
> +
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +	return csr_read_num(CSR_CYCLE + counter);
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +	return csr_read_num(CSR_TIME);
> +}
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
>  static u64 read_timestamp(void) { return 0; }
> -- 
> 2.37.2
>

A lot going on this patch. It'd be easier to review if it was broken up a
bit. E.g. import of arm code, the tools/lib/perf/mmap.c hunk, and whatever
else makes sense.

Thanks,
drew
