Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA46C1E70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCTRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCTRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:46:15 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66111126D1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3e0965f70ecso199901cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679334119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAnnZhxSECmWEFCJFYllR9DzNyhZdUZqxvsrbpN2GZc=;
        b=GiigGtcchnYyBKN2vYxUun/lh701XjtV4OXlxBstCcrehMWqaU20jmN+kX9kN47D9Z
         9tQPHd2vOhYHdZKg70bsLAcC75HlSr/5nQPBWfntrujNs01hV236BjEyD8ssa/hlf8up
         U0wWDwv3SpJQVBX31tmrMTdrUER9YaiLHe8VzOFIrpbBbMpNnn4b7elx8CKWKo3yLlnY
         egm6lsAVvVAHFk3MRbewJVwTwgXRcyj4L5SYtUR7PiVnbDLgvxsNWETPxFwX4SJFrdNl
         8LteocM0l6K6itDMICan39LnEsn/C/eqN5W41xoAvS8PYhVZYCYdkDp2ZLKejTu64OBP
         EAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAnnZhxSECmWEFCJFYllR9DzNyhZdUZqxvsrbpN2GZc=;
        b=dyE2mh2mtpmnJs15rpp1J2fLXdFkKhn0A5Fbhp6Cvr0f0TIiuhbvmkBQ/DQJDLksR8
         GqILSOjHXZot11ohzmEWVfCCI659moXRMNoidOBt3p5CuztYPWLxSCxaZiwAlESgPv4F
         bj0rmSn05flYY6LHng428A5HR98EMdq3TKLl5YuAb5xxoUQFMB2yvb+/WwjuRLb7sX3C
         s6IvlAAXaF6RT+C4WgwGo/bmNxorH3NNDJv5I+f0m/6SNfxx6YsPThD5uEF5Edkg2d85
         cgWuxsE3P7NgQDNoBXkyFs/fmB7p9aw9Z+2fQlAhZBVJ5u4EC/2w24R8ub6gu9JPG1Wc
         UBUA==
X-Gm-Message-State: AO0yUKWhogKVstK4SObZfaid5Pb9XxaXkGY0zwQha7q6m7I49l98xQyj
        cVlBUzUA5IZ5lMrkAyaagyz7PUZf/i/8wxaFDRTpIA==
X-Google-Smtp-Source: AK7set9QajIYfX8V++DQO6FlLbHYXZw4R/NtQBgW0vr9oaXNj4NJ3wdIzdY4WMuCrBr0dX2M4Xf738AbUZqx7Va+jp4=
X-Received: by 2002:ac8:7d8c:0:b0:3b9:f660:bdfe with SMTP id
 c12-20020ac87d8c000000b003b9f660bdfemr648718qtd.11.1679334118825; Mon, 20 Mar
 2023 10:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230320114601.524958-1-james.clark@arm.com>
In-Reply-To: <20230320114601.524958-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:41:46 -0700
Message-ID: <CAP-5=fXw+JfWQahgCp3N2dx5WYSUURHMyD8JqRzrYoX8_i=hUA@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Add N1 metrics
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 4:46=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Generated from the telemetry solution repo[1] with this command:
>
>   ./generate.py <linux-repo>/tools/perf/ --telemetry-files \
>     ../../data/pmu/cpu/neoverse/neoverse-n1.json
>
> Since this data source now includes the SPE events for N1, it has
> diverged from A76 which means the folder has to be split.
>
> The new data also uses more fine grained grouping, but this will be
> consistent for all future products. Long PublicDescriptions are now
> included even for common events because this can include product
> specific details. For non verbose mode the common BriefDescriptions
> remain the same.
>
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../{cortex-a76-n1 =3D> cortex-a76}/branch.json |   0
>  .../{cortex-a76-n1 =3D> cortex-a76}/bus.json    |   0
>  .../{cortex-a76-n1 =3D> cortex-a76}/cache.json  |   0
>  .../exception.json                            |   0
>  .../instruction.json                          |   0
>  .../{cortex-a76-n1 =3D> cortex-a76}/memory.json |   0
>  .../pipeline.json                             |   0
>  .../arch/arm64/arm/neoverse-n1/bus.json       |  18 ++
>  .../arch/arm64/arm/neoverse-n1/exception.json |  62 +++++
>  .../arch/arm64/arm/neoverse-n1/general.json   |   6 +
>  .../arch/arm64/arm/neoverse-n1/l1d_cache.json |  50 ++++
>  .../arch/arm64/arm/neoverse-n1/l1i_cache.json |  10 +
>  .../arch/arm64/arm/neoverse-n1/l2_cache.json  |  46 ++++
>  .../arch/arm64/arm/neoverse-n1/l3_cache.json  |  18 ++
>  .../arch/arm64/arm/neoverse-n1/ll_cache.json  |  10 +
>  .../arch/arm64/arm/neoverse-n1/memory.json    |  22 ++
>  .../arch/arm64/arm/neoverse-n1/metrics.json   | 219 ++++++++++++++++++
>  .../arch/arm64/arm/neoverse-n1/retired.json   |  26 +++
>  .../arch/arm64/arm/neoverse-n1/spe.json       |  18 ++
>  .../arm64/arm/neoverse-n1/spec_operation.json | 102 ++++++++
>  .../arch/arm64/arm/neoverse-n1/stall.json     |  10 +
>  .../arch/arm64/arm/neoverse-n1/tlb.json       |  66 ++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   4 +-
>  23 files changed, 685 insertions(+), 2 deletions(-)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/branch.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/bus.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/cache.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/exception.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/instruction.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/memory.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a76-n1 =3D> cortex-a=
76}/pipeline.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exce=
ption.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/gene=
ral.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_=
cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_=
cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_c=
ache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memo=
ry.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metr=
ics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/reti=
red.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec=
_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stal=
l.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.=
json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/branch.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.jso=
n
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/branch.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json =
b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/bus.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/bus.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/cache.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/cache.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception=
.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/exception.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.=
json
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/exception.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instructi=
on.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/instruction.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instructio=
n.json
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/instruction.jso=
n
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/memory.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.jso=
n
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/memory.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.=
json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76/pipeline.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.j=
son
> rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a76/pipeline.json
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json b/=
tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
> new file mode 100644
> index 000000000000..2e11a8c4a484
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/bus.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "BUS_ACCESS",
> +        "PublicDescription": "Counts memory transactions issued by the C=
PU to the external bus, including snoop requests and snoop responses. Each =
beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_CYCLES",
> +        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles r=
epresent a clock cycle in which a transaction could be sent or received on =
the interface from the CPU to the external bus. Since that interface is dri=
ven at the same clock speed as the CPU, this event is a duplicate of CPU_CY=
CLES."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "PublicDescription": "Counts memory read transactions seen on th=
e external bus. Each beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "PublicDescription": "Counts memory write transactions seen on t=
he external bus. Each beat of data is counted individually."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.j=
son b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
> new file mode 100644
> index 000000000000..4404b8e91690
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/exception.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "ArchStdEvent": "EXC_TAKEN",
> +        "PublicDescription": "Counts any taken architecturally visible e=
xceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Excep=
tions are counted whether or not they are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_RETURN",
> +        "PublicDescription": "Counts any architecturally executed except=
ion return instructions. Eg: AArch64: ERET"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF",
> +        "PublicDescription": "Counts the number of synchronous exception=
s which are taken locally that are due to attempting to execute an instruct=
ion that is UNDEFINED. Attempting to execute instruction bit patterns that =
have not been allocated. Attempting to execute instructions when they are d=
isabled. Attempting to execute instructions at an inappropriate Exception l=
evel. Attempting to execute an instruction when the value of PSTATE.IL is 1=
."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC",
> +        "PublicDescription": "Counts SVC exceptions taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT",
> +        "PublicDescription": "Counts synchronous exceptions that are tak=
en locally and caused by Instruction Aborts."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT",
> +        "PublicDescription": "Counts exceptions that are taken locally a=
nd are caused by data aborts or SErrors. Conditions that could cause those =
exceptions are attempting to read or write memory where the MMU generates a=
 fault, attempting to read or write memory with a misaligned address, inter=
rupts from the nSEI inputs and internally generated SErrors."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ",
> +        "PublicDescription": "Counts IRQ exceptions including the virtua=
l IRQs that are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ",
> +        "PublicDescription": "Counts FIQ exceptions including the virtua=
l FIQs that are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SMC",
> +        "PublicDescription": "Counts SMC exceptions take to EL3."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC",
> +        "PublicDescription": "Counts HVC exceptions taken to EL2."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_PABORT",
> +        "PublicDescription": "Counts exceptions which are traps not take=
n locally and are caused by Instruction Aborts. For example, attempting to =
execute an instruction with a misaligned PC."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_DABORT",
> +        "PublicDescription": "Counts exceptions which are traps not take=
n locally and are caused by Data Aborts or SError interrupts. Conditions th=
at could cause those exceptions are:\n\n1. Attempting to read or write memo=
ry where the MMU generates a fault,\n2. Attempting to read or write memory =
with a misaligned address,\n3. Interrupts from the SEI input.\n4. internall=
y generated SErrors."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_OTHER",
> +        "PublicDescription": "Counts the number of synchronous trap exce=
ptions which are not taken locally and are not SVC, SMC, HVC, data aborts, =
Instruction Aborts, or interrupts."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_IRQ",
> +        "PublicDescription": "Counts IRQ exceptions including the virtua=
l IRQs that are not taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_FIQ",
> +        "PublicDescription": "Counts FIQs which are not taken locally bu=
t taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior =
for FIQs when not executing\n in EL3)."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
> new file mode 100644
> index 000000000000..20fada95ef97
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/general.json
> @@ -0,0 +1,6 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES",
> +        "PublicDescription": "Counts CPU clock cycles (not timer cycles)=
. The clock measured by this event is defined as the physical clock driving=
 the CPU logic."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.j=
son b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
> new file mode 100644
> index 000000000000..6cd0b3ba5010
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json
> @@ -0,0 +1,50 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load or store operations that missed in the level =
1 data cache. This event only counts one event per cache line. This event d=
oes not count cache line allocations from preload instructions or from hard=
ware cache prefetching."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations. Atomic operations that resolve in the CPUs caches =
(near atomic operations) counts as both a write access and read access. Eac=
h access to a cache line is counted including the multiple accesses caused =
by single instructions such as LDM or STM. Each access to other level 1 dat=
a or unified memory structures, for example refill buffers, write buffers, =
and write-back buffers, are also counted."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of dirty data from the =
L1 data cache to the L2 cache. This occurs when either a dirty cache line i=
s evicted from L1 data cache and allocated in the L2 cache or dirty data is=
 written to the L2 and possibly to the next level of cache. This event coun=
ts both victim cache line evictions and cache write-backs from snoops or ca=
che maintenance operations. The following cache operations are not counted:=
\n\n1. Invalidations which do not result in data being transferred out of t=
he L1 (such as evictions of clean data),\n2. Full line writes which write t=
o L2 without writing L1, such as write streaming mode."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load operation. Atomic load operations that resolve in the CPUs caches co=
unts as both a write access and read access."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR",
> +        "PublicDescription": "Counts level 1 data cache accesses generat=
ed by store operations. This event also counts accesses caused by a DC ZVA =
(data cache zero, specified by virtual address) instruction. Near atomic op=
erations that resolve in the CPUs caches count as a write access and read a=
ccess."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load instructions where the memory read operation =
misses in the level 1 data cache. This event only counts one event per cach=
e line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed store instructions where the memory write operatio=
n misses in the level 1 data cache. This event only counts one event per ca=
che line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> +        "PublicDescription": "Counts level 1 data cache refills where th=
e cache line data came from caches inside the immediate cluster of the core=
."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +        "PublicDescription": "Counts level 1 data cache refills for whic=
h the cache line data came from outside the immediate cluster of the core, =
like an SLC in the system interconnect or DRAM."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +        "PublicDescription": "Counts dirty cache line evictions from the=
 level 1 data cache caused by a new cache line allocation. This event does =
not count evictions caused by cache maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +        "PublicDescription": "Counts write-backs from the level 1 data c=
ache that are a result of a coherency operation made by another CPU. Event =
count includes cache maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "PublicDescription": "Counts each explicit invalidation of a cac=
he line in the level 1 data cache caused by:\n\n- Cache Maintenance Operati=
ons (CMO) that operate by a virtual address.\n- Broadcast cache coherency o=
perations from another CPU in the system.\n\nThis event does not count for =
the following conditions:\n\n1. A cache refill invalidates a cache line.\n2=
. A CMO which is executed on that CPU and invalidates a cache line specifie=
d by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast=
 from one CPU to another."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.j=
son b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
> new file mode 100644
> index 000000000000..e719b6e7fa77
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills in the level 1 i=
nstruction cache caused by a missed instruction fetch. Instruction fetches =
may include accessing multiple instructions, but the single cache line allo=
cation is counted once."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE",
> +        "PublicDescription": "Counts instruction fetches which access th=
e level 1 instruction cache. Instruction cache accesses caused by cache mai=
ntenance operations are not counted."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
> new file mode 100644
> index 000000000000..2f6099889de1
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json
> @@ -0,0 +1,46 @@
> +[
> +    {
> +        "ArchStdEvent": "L2D_CACHE",
> +        "PublicDescription": "Counts level 2 cache accesses. level 2 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the first level caches or translation resolutions due to accesses.=
 This event also counts write back of dirty data from level 1 data cache to=
 the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills into the level 2=
 cache. level 2 cache is a unified cache for data and instruction accesses.=
 Accesses are for misses in the level 1 caches or translation resolutions d=
ue to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of data from the L2 cac=
he to outside the CPU. This includes snoops to the L2 (from other CPUs) whi=
ch return data even if the snoops cause an invalidation. L2 cache line inva=
lidations which do not write data outside the CPU and snoops which return d=
ata from an L1 cache are not counted. Data would not be written outside the=
 cache when invalidating a clean cache line."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
> +        "PublicDescription": "TBD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD",
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y read operations. level 2 cache is a unified cache for data and instructio=
n accesses, accesses are for misses in the level 1 caches or translation re=
solutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR",
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y write operations. level 2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the level 1 caches or translation r=
esolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified c=
ache for data and instruction accesses, accesses are for misses in the leve=
l 1 caches or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified =
cache for data and instruction accesses, accesses are for misses in the lev=
el 1 caches or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +        "PublicDescription": "Counts evictions from the level 2 cache be=
cause of a line being allocated into the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +        "PublicDescription": "Counts write-backs from the level 2 cache =
that are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoo=
p responses or,\n\n3. Direct cache transfers to another CPU due to a forwar=
ding snoop request."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_INVAL",
> +        "PublicDescription": "Counts each explicit invalidation of a cac=
he line in the level 2 cache by cache maintenance operations that operate b=
y a virtual address, or by external coherency operations. This event does n=
ot count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A=
 Cache Maintenance Operation (CMO), which invalidates a cache line specifie=
d by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cann=
ot be broadcast from one CPU to another."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
> new file mode 100644
> index 000000000000..f93e0c9f309a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
> +        "PublicDescription": "Counts level 3 cache line allocates that d=
o not fetch data from outside the level 3 data or unified cache. For exampl=
e, allocates due to streaming stores."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_REFILL",
> +        "PublicDescription": "Counts level 3 accesses that receive data =
from outside the L3 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE",
> +        "PublicDescription": "Counts level 3 cache accesses. level 3 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the lower level caches or translation resolutions due to accesses.=
"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_RD",
> +        "PublicDescription": "TBD"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.js=
on b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
> new file mode 100644
> index 000000000000..bb712d57d58a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "LL_CACHE_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster. This event counts when the system register=
 CPUECTLR.EXTLLC bit is set. This event counts read transactions returned f=
rom outside the core if those transactions are either hit in the system lev=
el cache or missed in the SLC and are returned from any other external sour=
ces."
> +    },
> +    {
> +        "ArchStdEvent": "LL_CACHE_MISS_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster but missed in the system level cache. This =
event counts when the system register CPUECTLR.EXTLLC bit is set. This even=
t counts read transactions returned from outside the core if those transact=
ions are missed in the System level Cache. The data source of the transacti=
on is indicated by a field in the CHI transaction returning to the CPU. Thi=
s event does not count reads caused by cache maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json=
 b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
> new file mode 100644
> index 000000000000..9041f6e0befb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/memory.json
> @@ -0,0 +1,22 @@
> +[
> +    {
> +        "ArchStdEvent": "MEM_ACCESS",
> +        "PublicDescription": "Counts memory accesses issued by the CPU l=
oad store unit, where those accesses are issued due to load or store operat=
ions. This event counts memory accesses no matter whether the data is recei=
ved from any level of cache hierarchy or external memory. If memory accesse=
s are broken up into smaller transactions than what were specified in the l=
oad or store instructions, then the event counts those smaller memory trans=
actions."
> +    },
> +    {
> +        "ArchStdEvent": "MEMORY_ERROR",
> +        "PublicDescription": "Counts any detected correctable or uncorre=
ctable physical memory errors (ECC or parity) in protected CPUs RAMs. On th=
e core, this event counts errors in the caches (including data and tag rams=
). Any detected memory error (from either a speculative and abandoned acces=
s, or an architecturally executed access) is counted. Note that errors are =
only detected when the actual protected memory is accessed by an operation.=
"
> +    },
> +    {
> +        "ArchStdEvent": "REMOTE_ACCESS",
> +        "PublicDescription": "Counts accesses to another chip, which is =
implemented as a different CMN mesh in the system. If the CHI bus response =
back to the core indicates that the data source is from another chip (mesh)=
, then the counter is updated. If no data is returned, even if the system s=
noops another chip/mesh, then the counter is not updated."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to load operations. The event counts any memory load access, no matter w=
hether the data is received from any level of cache hierarchy or external m=
emory. The event also counts atomic load operations. If memory accesses are=
 broken up by the load/store unit into smaller transactions that are issued=
 by the bus interface, then the event counts those smaller transactions."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to store operations. The event counts any memory store access, no matter=
 whether the data is located in any level of cache or external memory. The =
event also counts atomic load and store operations. If memory accesses are =
broken up by the load/store unit into smaller transactions that are issued =
by the bus interface, then the event counts those smaller transactions."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
> new file mode 100644
> index 000000000000..dc0f8638f8f5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/metrics.json
> @@ -0,0 +1,219 @@
> +[
> +    {
> +        "MetricName": "backend_stalled_cycles",
> +        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the backend unit of the proce=
ssor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "branch_misprediction_ratio",
> +        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
> +        "BriefDescription": "This metric measures the ratio of branches =
mispredicted to the total number of branches architecturally executed. This=
 gives an indication of the effectiveness of the branch prediction unit.",
> +        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },
> +    {
> +        "MetricName": "branch_mpki",
> +        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of branch m=
ispredictions per thousand instructions executed.",
> +        "MetricGroup": "MPKI;Branch_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "branch_percentage",
> +        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC)=
 * 100)",
> +        "BriefDescription": "This metric measures branch operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "crypto_percentage",
> +        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures crypto operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "dtlb_mpki",
> +        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of data TLB=
 Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "dtlb_walk_ratio",
> +        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of data TLB accesses. This gives an indica=
tion of the effectiveness of the data TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "frontend_stalled_cycles",
> +        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the frontend unit of the proc=
essor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "integer_dp_percentage",
> +        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar integer operati=
ons as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "ipc",
> +        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
> +        "BriefDescription": "This metric measures the number of instruct=
ions retired per cycle.",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "1per cycle"
> +    },
> +    {
> +        "MetricName": "itlb_mpki",
> +        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of instruct=
ion TLB Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "itlb_walk_ratio",
> +        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
> +        "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of instruction TLB accesses. This gives an=
 indication of the effectiveness of the instruction TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1d_cache_miss_ratio",
> +        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata cache accesses missed to the total number of level 1 data cache accesse=
s. This gives an indication of the effectiveness of the level 1 data cache.=
",
> +        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l1d_cache_mpki",
> +        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
data cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_miss_ratio",
> +        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata TLB accesses missed to the total number of level 1 data TLB accesses. T=
his gives an indication of the effectiveness of the level 1 data TLB.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_mpki",
> +        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_cache_miss_ratio",
> +        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction cache accesses missed to the total number of level 1 instruction=
 cache accesses. This gives an indication of the effectiveness of the level=
 1 instruction cache.",
> +        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l1i_cache_mpki",
> +        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_miss_ratio",
> +        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction TLB accesses missed to the total number of level 1 instruction T=
LB accesses. This gives an indication of the effectiveness of the level 1 i=
nstruction TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_mpki",
> +        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_cache_miss_ratio",
> +        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 2 c=
ache accesses missed to the total number of level 2 cache accesses. This gi=
ves an indication of the effectiveness of the level 2 cache, which is a uni=
fied cache that stores both data and instruction. Note that cache accesses =
in this cache are either data memory access or instruction fetch as this is=
 a unified cache.",
> +        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l2_cache_mpki",
> +        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified cache accesses missed per thousand instructions executed. Note that=
 cache accesses in this cache are either data memory access or instruction =
fetch as this is a unified cache.",
> +        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_tlb_miss_ratio",
> +        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 2 u=
nified TLB accesses missed to the total number of level 2 unified TLB acces=
ses. This gives an indication of the effectiveness of the level 2 TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness=
",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l2_tlb_mpki",
> +        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_hit_ratio",
> +        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)"=
,
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses hit in the cache to the total number of last level ca=
che accesses. This gives an indication of the effectiveness of the last lev=
el cache for read traffic. Note that cache accesses in this cache are eithe=
r data memory access or instruction fetch as this is a system level cache."=
,
> +        "MetricGroup": "LL_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_miss_ratio",
> +        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses missed to the total number of last level cache access=
es. This gives an indication of the effectiveness of the last level cache f=
or read traffic. Note that cache accesses in this cache are either data mem=
ory access or instruction fetch as this is a system level cache.",
> +        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_mpki",
> +        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of last lev=
el cache read accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "load_percentage",
> +        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures load operations as a p=
ercentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "scalar_fp_percentage",
> +        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar floating point =
operations as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "simd_percentage",
> +        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures advanced SIMD operatio=
ns as a percentage of total operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "store_percentage",
> +        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures store operations as a =
percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.jso=
n b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
> new file mode 100644
> index 000000000000..0c7692ad5108
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/retired.json
> @@ -0,0 +1,26 @@
> +[
> +    {
> +        "ArchStdEvent": "SW_INCR",
> +        "PublicDescription": "Counts software writes to the PMSWINC_EL0 =
(software PMU increment) register. The PMSWINC_EL0 register is a manually u=
pdated counter for use by application software.\n\nThis event could be used=
 to measure any user program event, such as accesses to a particular data s=
tructure (by writing to the PMSWINC_EL0 register each time the data structu=
re is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers m=
ust insert instructions that write to the PMSWINC_EL0 register into the sou=
rce code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 regi=
ster, there is no need to do a read/increment/write sequence to the PMSWINC=
_EL0 register."
> +    },
> +    {
> +        "ArchStdEvent": "INST_RETIRED",
> +        "PublicDescription": "Counts instructions that have been archite=
cturally executed."
> +    },
> +    {
> +        "ArchStdEvent": "CID_WRITE_RETIRED",
> +        "PublicDescription": "Counts architecturally executed writes to =
the CONTEXTIDR register, which usually contain the kernel PID and can be ou=
tput with hardware trace."
> +    },
> +    {
> +        "ArchStdEvent": "TTBR_WRITE_RETIRED",
> +        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1=
. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H=
 bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2=
, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically u=
pdated when the kernel is swapping user-space threads or applications."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETIRED",
> +        "PublicDescription": "Counts architecturally executed branches, =
whether the branch is taken or not. Instructions that explicitly write to t=
he PC are also counted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts branches counted by BR_RETIRED whic=
h were mispredicted and caused a pipeline flush."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json b/=
tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
> new file mode 100644
> index 000000000000..5de8b0f3a440
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spe.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "SAMPLE_POP",
> +        "PublicDescription": "Counts statistical profiling sample popula=
tion, the count of all operations that could be sampled but may or may not =
be chosen for sampling."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_FEED",
> +        "PublicDescription": "Counts statistical profiling samples taken=
 for sampling."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_FILTRATE",
> +        "PublicDescription": "Counts statistical profiling samples taken=
 which are not removed by filtering."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_COLLISION",
> +        "PublicDescription": "Counts statistical profiling samples that =
have collided with a previous sample and so therefore not taken."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operat=
ion.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.=
json
> new file mode 100644
> index 000000000000..be8c0667f1d9
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.jso=
n
> @@ -0,0 +1,102 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED",
> +        "PublicDescription": "Counts branches which are speculatively ex=
ecuted and mispredicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED",
> +        "PublicDescription": "Counts branches speculatively executed and=
 were predicted right."
> +    },
> +    {
> +        "ArchStdEvent": "INST_SPEC",
> +        "PublicDescription": "Counts operations that have been speculati=
vely executed."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +        "PublicDescription": "Counts unaligned memory read operations is=
sued by the CPU. This event counts unaligned accesses (as defined by the ac=
tual instruction), even if they are subsequently issued as multiple aligned=
 accesses. The event does not count preload operations (PLD, PLI)."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +        "PublicDescription": "Counts unaligned memory write operations i=
ssued by the CPU. This event counts unaligned accesses (as defined by the a=
ctual instruction), even if they are subsequently issued as multiple aligne=
d accesses."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +        "PublicDescription": "Counts unaligned memory operations issued =
by the CPU. This event counts unaligned accesses (as defined by the actual =
instruction), even if they are subsequently issued as multiple aligned acce=
sses."
> +    },
> +    {
> +        "ArchStdEvent": "LDREX_SPEC",
> +        "PublicDescription": "Counts Load-Exclusive operations that have=
 been speculatively executed. Eg: LDREX, LDX"
> +    },
> +    {
> +        "ArchStdEvent": "STREX_PASS_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed and have successfully completed the store ope=
ration."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_FAIL_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed and have not successfully completed the store=
 operation."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC",
> +        "PublicDescription": "Counts speculatively executed load operati=
ons including Single Instruction Multiple Data (SIMD) load operations."
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC",
> +        "PublicDescription": "Counts speculatively executed store operat=
ions including Single Instruction Multiple Data (SIMD) store operations."
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC",
> +        "PublicDescription": "Counts speculatively executed logical or a=
rithmetic instructions such as MOV/MVN operations."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D operations excluding load, store and move micro-operations that move data=
 to or from SIMD (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC",
> +        "PublicDescription": "Counts speculatively executed floating poi=
nt operations. This event does not count operations that move data to or fr=
om floating point (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC",
> +        "PublicDescription": "Counts speculatively executed operations w=
hich cause software changes of the PC. Those operations include all taken b=
ranch operations."
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC",
> +        "PublicDescription": "Counts speculatively executed cryptographi=
c operations except for PMULL and VMULL operations."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC",
> +        "PublicDescription": "Counts immediate branch operations which a=
re speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC",
> +        "PublicDescription": "Counts procedure return operations (RET) w=
hich are speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +        "PublicDescription": "Counts indirect branch operations includin=
g procedure returns, which are speculatively executed. This includes operat=
ions that force a software change of the PC, other than exception-generatin=
g operations.  Eg: BR Xn, RET"
> +    },
> +    {
> +        "ArchStdEvent": "ISB_SPEC",
> +        "PublicDescription": "Counts ISB operations that are executed."
> +    },
> +    {
> +        "ArchStdEvent": "DSB_SPEC",
> +        "PublicDescription": "Counts DSB operations that are speculative=
ly issued to Load/Store unit in the CPU."
> +    },
> +    {
> +        "ArchStdEvent": "DMB_SPEC",
> +        "PublicDescription": "Counts DMB operations that are speculative=
ly issued to the Load/Store unit in the CPU. This event does not count impl=
ied barriers from load acquire/store release operations."
> +    },
> +    {
> +        "ArchStdEvent": "RC_LD_SPEC",
> +        "PublicDescription": "Counts any load acquire operations that ar=
e speculatively executed. Eg: LDAR, LDARH, LDARB"
> +    },
> +    {
> +        "ArchStdEvent": "RC_ST_SPEC",
> +        "PublicDescription": "Counts any store release operations that a=
re speculatively executed. Eg: STLR, STLRH, STLRB'"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json =
b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
> new file mode 100644
> index 000000000000..688afd8a4061
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/stall.json
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND",
> +        "PublicDescription": "Counts cycles when frontend could not send=
 any micro-operations to the rename stage because of frontend resource stal=
ls caused by fetch memory latency or branch prediction flow stalls. All the=
 frontend slots were empty during the cycle when this event counts."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND",
> +        "PublicDescription": "Counts cycles whenever the rename unit is =
unable to send any micro-operations to the backend of the pipeline because =
of backend resource constraints. Backend resource constraints can include i=
ssue stage fullness, execution stage fullness, or other internal pipeline r=
esource fullness. All the backend slots were empty during the cycle when th=
is event counts."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json b/=
tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
> new file mode 100644
> index 000000000000..b550af1831f5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n1/tlb.json
> @@ -0,0 +1,66 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 instruction TLB refills fro=
m any Instruction fetch. If there are multiple misses in the TLB that are r=
esolved by the refill, then this event only counts once. This event will no=
t count if the translation table walk results in a fault (such as a transla=
tion or access fault), since there is no new translation created for the TL=
B."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 data TLB accesses that resu=
lted in TLB refills. If there are multiple misses in the TLB that are resol=
ved by the refill, then this event only counts once. This event counts for =
refills caused by preload instructions or hardware prefetch accesses. This =
event counts regardless of whether the miss hits in L2 or results in a tran=
slation table walk. This event will not count if the translation table walk=
 results in a fault (such as a translation or access fault), since there is=
 no new translation created for the TLB. This event will not count on an ac=
cess from an AT(address translation) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB",
> +        "PublicDescription": "Counts level 1 data TLB accesses caused by=
 any memory load or store operation. Note that load or store instructions c=
an be broken up into multiple memory operations. This event does not count =
TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB",
> +        "PublicDescription": "Counts level 1 instruction TLB accesses, w=
hether the access hits or misses in the TLB. This event counts both demand =
accesses and prefetch or preload generated accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y operations from both data and instruction fetch, except for those caused =
by TLB maintenance operations and hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB",
> +        "PublicDescription": "Counts level 2 TLB accesses except those c=
aused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK",
> +        "PublicDescription": "Counts data memory translation table walks=
 caused by a miss in the L2 TLB driven by a memory access. Note that partia=
l translations that also cause a table walk are counted. This event does no=
t count table walks caused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK",
> +        "PublicDescription": "Counts instruction memory translation tabl=
e walks caused by a miss in the L2 TLB driven by a memory access. Partial t=
ranslations that also cause a table walk are counted. This event does not c=
ount table walks caused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "PublicDescription": "Counts level 1 data TLB refills caused by =
memory read operations. If there are multiple misses in the TLB that are re=
solved by the refill, then this event only counts once. This event counts f=
or refills caused by preload instructions or hardware prefetch accesses. Th=
is event counts regardless of whether the miss hits in L2 or results in a t=
ranslation table walk. This event will not count if the translation table w=
alk results in a fault (such as a translation or access fault), since there=
 is no new translation created for the TLB. This event will not count on an=
 access from an Address Translation (AT) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "PublicDescription": "Counts level 1 data TLB refills caused by =
data side memory write operations. If there are multiple misses in the TLB =
that are resolved by the refill, then this event only counts once. This eve=
nt counts for refills caused by preload instructions or hardware prefetch a=
ccesses. This event counts regardless of whether the miss hits in L2 or res=
ults in a translation table walk. This event will not count if the table wa=
lk results in a fault (such as a translation or access fault), since there =
is no new translation created for the TLB. This event will not count with a=
n access from an Address Translation (AT) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_RD",
> +        "PublicDescription": "Counts level 1 data TLB accesses caused by=
 memory read operations. This event counts whether the access hits or misse=
s in the TLB. This event does not count TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_WR",
> +        "PublicDescription": "Counts any L1 data side TLB accesses cause=
d by memory write operations. This event counts whether the access hits or =
misses in the TLB. This event does not count TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y read operations from both data and instruction fetch except for those cau=
sed by TLB maintenance operations or hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y write operations from both data and instruction fetch except for those ca=
used by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_RD",
> +        "PublicDescription": "Counts level 2 TLB accesses caused by memo=
ry read operations from both data and instruction fetch except for those ca=
used by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_WR",
> +        "PublicDescription": "Counts level 2 TLB accesses caused by memo=
ry write operations from both data and instruction fetch except for those c=
aused by TLB maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index f134e833c069..9d400785d195 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -23,8 +23,8 @@
>  0x00000000410fd080,v1,arm/cortex-a57-a72,core
>  0x00000000410fd090,v1,arm/cortex-a73,core
>  0x00000000410fd0a0,v1,arm/cortex-a75,core
> -0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
> -0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
> +0x00000000410fd0b0,v1,arm/cortex-a76,core
> +0x00000000410fd0c0,v1,arm/neoverse-n1,core
>  0x00000000410fd0d0,v1,arm/cortex-a77,core
>  0x00000000410fd400,v1,arm/neoverse-v1,core
>  0x00000000410fd410,v1,arm/cortex-a78,core
> --
> 2.34.1
>
