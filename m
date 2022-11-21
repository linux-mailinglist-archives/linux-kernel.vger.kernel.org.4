Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984A632E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKUVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKUVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:17:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A936B0B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:17:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so21740422wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Ekfx+cFv0QTzsPFN7bYPU5/zvfZbDd29UesdozCrg=;
        b=hDb5s7WdM3dF/sHkGqa48Z6FA7c6Ke/hhfhcLIalOYDcMqjV3JM3ZVnOtG6nwoF4aD
         xMrAdZR3SNzn7Xcko87rcpOlOOAckidjqqCBBCt7Fycdyqjd0OfYC4yY+KRhAifrFzUT
         dGL519H+P5dBM58y2UgCKz9O+VTnr5EboQCOQvJ5Fjmq51YJHxxBLOJd7uvDi5wAmEJO
         Ux9l6at7+P96nZxuc22Lsl8rkrlUdnZrhxkVKGdXzXZrJqmxSLxSnvrRjFfwGnr2V6i4
         lqDlFqn8Hf4IWSRZb5+haP7pMyTl5/4nLUq9wu0fZ2vqTKfcOtEHrp55rmZ4aMYt6GSN
         ZksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Ekfx+cFv0QTzsPFN7bYPU5/zvfZbDd29UesdozCrg=;
        b=iBf82/BWnAD1LzhDgPV9JbDV4EDouzgMnrGTOmScvsQLC7cFjjFMdTq1mwobt0Lb0g
         6MYVtW7YrpteUgma4NczAabMWVkW+1niYxRE5ED4bmcxMdoYVo3BkMDKujAy7iQyPGkp
         2Pg8iuXdTM9JGIteBZO8cYy6ieZ9ZXZ7YijT9mnlv5mHfXw1PH9H5spVZ9OssWsDaRUN
         7OJzmFlZGG12PAlzHWg4/mYrzYCJXd9+ctAa+xdZoLDAgoVK4ptfZCJA5oeVD1wk9+M0
         UZm6qWGyzFP3wLXw9o5Z23rgZ7aT17C1/757BCVV7LieU8IxHY430F2zN1SbKd5q9aAI
         LPmA==
X-Gm-Message-State: ANoB5pkwXoU78huVdhJScj5mb7ds1Fshjso2swGktlJmcXmno04W7oqC
        H8xpv4ZVhSTR62E0eDIC1DXtHfE+yysbWq+82WHCbg==
X-Google-Smtp-Source: AA0mqf6b4s9JdloqQbs+84SgSruGvWZvnqVumYjQMF74kcMtEkYrQGjhq8rcfj/siHYcV9kPcsoN1ZGsSHi6gMc2+Ic=
X-Received: by 2002:adf:f944:0:b0:236:8f54:f1f4 with SMTP id
 q4-20020adff944000000b002368f54f1f4mr12387736wrr.654.1669065445068; Mon, 21
 Nov 2022 13:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Nov 2022 13:17:12 -0800
Message-ID: <CAP-5=fUQUe0UvLhaSBnm-dAPHc3_k8vZWNxhZajg8mg6R8og0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf vendor events intel: Add core event list for Alderlake-N
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Mon, Nov 21, 2022 at 12:19 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Alderlake-N only has E-core, it has been moved to non-hybrid code path on
> the kernel side. Add core event list for Alderlake-N, it is based on the
> ADL gracemont v1.16 JSON file.
>
> https://github.com/intel/perfmon/tree/main/ADL/events/
>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Looks good! Could you add the Alderlake-N patch to create_perf_json.py
to github?

Thanks,
Ian

> ---
> Change log:
>   v2:
>     * Regenerate the core event list with the new converter scripts.
>       (https://github.com/intel/perfmon/pull/32 and add the ADL-N fix)
>
>  .../pmu-events/arch/x86/alderlaken/cache.json | 330 +++++++++++
>  .../arch/x86/alderlaken/floating-point.json   |  18 +
>  .../arch/x86/alderlaken/frontend.json         |  26 +
>  .../arch/x86/alderlaken/memory.json           |  81 +++
>  .../pmu-events/arch/x86/alderlaken/other.json |  38 ++
>  .../arch/x86/alderlaken/pipeline.json         | 533 ++++++++++++++++++
>  .../arch/x86/alderlaken/virtual-memory.json   |  47 ++
>  7 files changed, 1073 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/floating-po=
int.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/frontend.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/pipeline.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlaken/virtual-mem=
ory.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools=
/perf/pmu-events/arch/x86/alderlaken/cache.json
> new file mode 100644
> index 000000000000..043445ae14a8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
> @@ -0,0 +1,330 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory reque=
sts that miss in the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PublicDescription": "Counts the number of cacheable memory requ=
ests that miss in the Last Level Cache (LLC). Requests include demand loads=
, reads for ownership (RFO), instruction fetches and L1 HW prefetches. If t=
he platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L=
2 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x41"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory reque=
sts that access the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
> +        "PublicDescription": "Counts the number of cacheable memory requ=
ests that access the Last Level Cache (LLC). Requests include demand loads,=
 reads for ownership (RFO), instruction fetches and L1 HW prefetches. If th=
e platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2=
 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x4f"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM=
 or MMIO (Non-DRAM).",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.IFETCH",
> +        "PublicDescription": "Counts the number of cycles the core is st=
alled due to an instruction cache or translation lookaside buffer (TLB) mis=
s which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x38"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non=
-DRAM).",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
> +        "PublicDescription": "Counts the number of cycles the core is st=
alled due to an instruction cache or translation lookaside buffer (TLB) mis=
s which hit in DRAM or MMIO (non-DRAM).",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to an instruction cache or TLB miss which hit in the L2 cache.",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
> +        "PublicDescription": "Counts the number of cycles the core is st=
alled due to an instruction cache or Translation Lookaside Buffer (TLB) mis=
s which hit in the L2 cache.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to an instruction cache or TLB miss which hit in the LLC or other =
core with HITE/F/M.",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
> +        "PublicDescription": "Counts the number of cycles the core is st=
alled due to an instruction cache or Translation Lookaside Buffer (TLB) mis=
s which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-=
DRAM).",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.LOAD",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x7"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load which hit in the L2 cache.",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load which hit in the LLC or other core with HITE/F/M.=
",
> +        "EventCode": "0x34",
> +        "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
> +        "PublicDescription": "Counts the number of cycles the core is st=
alled due to a demand load which hit in the Last Level Cache (LLC) or other=
 core with HITE/F/M.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in DRAM.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in the L2 cache.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in the L3 cache.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that uops are b=
locked for any of the following reasons:  load buffer, store buffer or RSV =
full.",
> +        "EventCode": "0x04",
> +        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x7"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that uops are b=
locked due to a load buffer full condition.",
> +        "EventCode": "0x04",
> +        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that uops are b=
locked due to an RSV full condition.",
> +        "EventCode": "0x04",
> +        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that uops are b=
locked due to a store buffer full condition.",
> +        "EventCode": "0x04",
> +        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of load uops retir=
ed.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x81"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of store uops retired.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of store uops reti=
red.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x82"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 128 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x80",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 128 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 16 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x10",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 16 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
. If a PEBS record is generated, will populate the PEBS Latency and PEBS Da=
ta Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 256 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x100",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 256 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 32 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x20",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 32 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
. If a PEBS record is generated, will populate the PEBS Latency and PEBS Da=
ta Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 4 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x4",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 4 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 512 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x200",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 512 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 64 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x40",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 64 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
. If a PEBS record is generated, will populate the PEBS Latency and PEBS Da=
ta Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged loads with an i=
nstruction latency that exceeds or equals the threshold of 8 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x8",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 8 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retired split load uop=
s.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x41"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of stores uops retired. C=
ounts with or without PEBS enabled.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts the number of stores uops retired. =
Counts with or without PEBS enabled. If PEBS is enabled and a PEBS record i=
s generated, will populate PEBS Latency and PEBS Data Source fields accordi=
ngly.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, and modified data w=
as forwarded.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, but no data was for=
warded.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, and non-modified da=
ta was forwarded.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were supplied=
 by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, and modified data w=
as forwarded.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to instruction cache misses."=
,
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x20"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
> new file mode 100644
> index 000000000000..30e8ca3c1485
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of floating point operati=
ons retired that required microcode assist.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.FP_ASSIST",
> +        "PublicDescription": "Counts the number of floating point operat=
ions retired that required microcode assist, which is not a reflection of t=
he number of FP operations, instructions or uops.",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of floating point divide =
uops retired (x87 and SSE, including x87 sqrt).",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.FPDIV",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x8"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json b/to=
ols/perf/pmu-events/arch/x86/alderlaken/frontend.json
> new file mode 100644
> index 000000000000..36898bab2bba
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
> @@ -0,0 +1,26 @@
> +[
> +    {
> +        "BriefDescription": "Counts the total number of BACLEARS due to =
all branch types including conditional and unconditional jumps, returns, an=
d indirect branches.",
> +        "EventCode": "0xe6",
> +        "EventName": "BACLEARS.ANY",
> +        "PublicDescription": "Counts the total number of BACLEARS, which=
 occur when the Branch Target Buffer (BTB) prediction or lack thereof, was =
corrected by a later branch predictor in the frontend.  Includes BACLEARS d=
ue to all branch types including conditional and unconditional jumps, retur=
ns, and indirect branches.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of requests to the instru=
ction cache for one or more bytes of a cache line.",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.ACCESSES",
> +        "PublicDescription": "Counts the total number of requests to the=
 instruction cache.  The event only counts new cache line accesses, so that=
 multiple back to back fetches to the exact same cache line or byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x3"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of instruction cache miss=
es.",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.MISSES",
> +        "PublicDescription": "Counts the number of missed requests to th=
e instruction cache.  The event only counts new cache line accesses, so tha=
t multiple back to back fetches to the exact same cache line and byte chunk=
 count as one.  Specifically, the event counts when accesses from sequentia=
l code crosses the cache line boundary, or when a branch target is moved to=
 a new line or to a non-sequential byte chunk of the same line.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/memory.json
> new file mode 100644
> index 000000000000..f84bf8c43495
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
> @@ -0,0 +1,81 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer is stalled due to any number of reasons, in=
cluding an L1 miss, WCB full, pagewalk, store address block or store data b=
lock, on a load that retires.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.ANY_AT_RET",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xff"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer is stalled due to a core bound stall includ=
ing a store address match, a DTLB miss or a page walk that detains the load=
 from retiring.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.L1_BOUND_AT_RET",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xf4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer and retirement are both stalled due to othe=
r block cases.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.OTHER_AT_RET",
> +        "PublicDescription": "Counts the number of cycles that the head =
(oldest load) of the load buffer and retirement are both stalled due to oth=
er block cases such as pipeline conflicts, fences, etc.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xc0"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer and retirement are both stalled due to a pa=
gewalk.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.PGWALK_AT_RET",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xa0"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer and retirement are both stalled due to a st=
ore address match.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.ST_ADDR_AT_RET",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x84"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears due to =
memory ordering caused by a snoop from an external agent. Does not count in=
ternally generated machine clears such as those due to memory disambiguatio=
n.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were not supp=
lied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84400001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were not supp=
lied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84400001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were not supp=
lied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84400002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were not supp=
lied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84400002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools=
/perf/pmu-events/arch/x86/alderlaken/other.json
> new file mode 100644
> index 000000000000..6336de61f628
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
> @@ -0,0 +1,38 @@
> +[
> +    {
> +        "BriefDescription": "Counts modified writebacks from L1 cache an=
d L2 cache that have any type of response.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10008",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that have any type=
 of response.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that have any type=
 of response.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores that have any type =
of response.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10800",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> new file mode 100644
> index 000000000000..fa53ff11a509
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> @@ -0,0 +1,533 @@
> +[
> +    {
> +        "BriefDescription": "Counts the total number of branch instructi=
ons retired for all branch types.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of instructions in=
 which the instruction pointer (IP) of the processor is resteered due to a =
branch instruction and the branch instruction successfully retires.  All br=
anch type instructions are accounted for.",
> +        "SampleAfterValue": "200003"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.NEAR_CALL",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xf9"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retired JCC (Jump on C=
onditional Code) branch instructions retired, includes both taken and not t=
aken branches.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.COND",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x7e"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of taken JCC (Jump on Con=
ditional Code) branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.COND_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of far branch instruction=
s retired, includes far jump, far call and return, and interrupt call and r=
eturn.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xbf"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of near indirect JMP and =
near indirect CALL branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.INDIRECT",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xeb"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of near indirect CALL bra=
nch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfb"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.INDIRECT_CALL",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.IND_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfb"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.COND",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.JCC",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x7e"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of near CALL branch instr=
uctions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xf9"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of near RET branch instru=
ctions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xf7"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.INDIRECT",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xeb"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of near relative CALL bra=
nch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.REL_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfd"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.NEAR_RETURN",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.RETURN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xf7"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_INST_RETIRED.COND_TAKEN",
> +        "Deprecated": "1",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.TAKEN_JCC",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfe"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of mispredicted bra=
nch instructions retired for all branch types.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of mispredicted br=
anch instructions retired.  All branch type instructions are accounted for.=
  Prediction of the branch target address enables the processor to begin ex=
ecuting instructions before the non-speculative execution path is known. Th=
e branch prediction unit (BPU) predicts the target address based on the ins=
truction pointer (IP) of the branch and on the execution path through which=
 execution reached this IP.    A branch misprediction occurs when the predi=
ction is wrong, and results in discarding all instructions executed in the =
speculative path and re-fetching from the correct path.",
> +        "SampleAfterValue": "200003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted JCC (Jump=
 on Conditional Code) branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.COND",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x7e"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted taken JCC=
 (Jump on Conditional Code) branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near indi=
rect JMP and near indirect CALL branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.INDIRECT",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xeb"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near indi=
rect CALL branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfb"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_MISP_RETIRED.INDIRECT_CALL",
> +        "Deprecated": "1",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.IND_CALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfb"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_MISP_RETIRED.COND",
> +        "Deprecated": "1",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.JCC",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x7e"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_MISP_RETIRED.INDIRECT",
> +        "Deprecated": "1",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xeb"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near RET =
branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.RETURN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xf7"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t BR_MISP_RETIRED.COND_TAKEN",
> +        "Deprecated": "1",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xfe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventName": "CPU_CLK_UNHALTED.CORE",
> +        "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state. The core enters the halt state when it is run=
ning the HLT instruction. The core frequency may change from time to time. =
For this reason this event may have a changing ratio with regards to time. =
This event uses fixed counter 1.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles.",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.CORE_P",
> +        "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state. The core enters the halt state when it is run=
ning the HLT instruction. The core frequency may change from time to time. =
For this reason this event may have a changing ratio with regards to time. =
This event uses a programmable general purpose performance counter.",
> +        "SampleAfterValue": "2000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency. (Fixed event)",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses fixed counter 2.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x3"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency.",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
> +        "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses a programmable general purpose perform=
ance counter.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD",
> +        "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. The core frequency may change from time to time.=
 For this reason this event may have a changing ratio with regards to time.=
  This event uses fixed counter 1.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles.",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. The core frequency may change from time to time.=
 For this reason this event may have a changing ratio with regards to time.=
 This event uses a programmable general purpose performance counter.",
> +        "SampleAfterValue": "2000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of instructions ret=
ired. (Fixed event)",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses fixed counter 0.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of instructions ret=
ired.",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses a programmable general purpose performance counter.",
> +        "SampleAfterValue": "2000003"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t LD_BLOCKS.ADDRESS_ALIAS",
> +        "Deprecated": "1",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.4K_ALIAS",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retired loads that are=
 blocked because it initially appears to be store forward blocked, but subs=
equently is shown not to be blocked based on 4K alias check.",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retired loads that are=
 blocked because its address exactly matches an older store whose data is n=
ot ready.",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears due to =
memory ordering in which an internal load passes an older store within the =
same CPU.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machines clears due to=
 memory renaming.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.MRN_NUKE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears due to =
a page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A=
 page fault occurs when either the page is not present, or an access violat=
ion occurs.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears that fl=
ush the pipeline and restart the machine with the use of microcode due to S=
MC, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUA=
L_TRAP.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.SLOW",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x6f"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears due to =
program modifying data (self modifying code) within 1K of a recently fetche=
d code page.",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.SMC",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots not consum=
ed by the backend due to a micro-sequencer (MS) scoreboard, which stalls th=
e front-end from issuing from the UROM until a specified older uop retires.=
",
> +        "EventCode": "0x75",
> +        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
> +        "PublicDescription": "Counts the number of issue slots not consu=
med by the backend due to a micro-sequencer (MS) scoreboard, which stalls t=
he front-end from issuing from the UROM until a specified older uop retires=
. The most commonly executed instruction with an MS scoreboard is PAUSE.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a mi=
spredicted jump or a machine clear.",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> +        "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend because allocation is stalled due to a m=
ispredicted jump or a machine clear. Only issue slots wasted due to fast nu=
kes such as memory ordering nukes are counted. Other nukes are not accounte=
d for. Counts all issue slots blocked during this recovery window including=
 relevant microcode flows and while uops are not yet available in the instr=
uction queue (IQ) even if an FE_bound event occurs during this period. Also=
 includes the issue slots that were consumed by the backend but were thrown=
 away because they were younger than the mispredict or machine clear.",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to fast nukes such as memory or=
dering and memory disambiguation machine clears.",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a ma=
chine clear (nuke) of any kind including memory ordering and memory disambi=
guation.",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x3"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to branch mispredicts.",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to a machine clear (nuke).",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots ever=
y cycle that were not consumed by the backend due to backend stalls.",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALL",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to certain allocation restricti=
ons.",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to memory reservation stalls in=
 which a scheduler is not able to accept uops.",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to IEC or FPC RAT stalls, which=
 can be due to FIQ or IEC reservation stalls in which the integer, floating=
 point or SIMD scheduler is not able to accept uops.",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to the physical register file u=
nable to accept an entry (marble stalls).",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to the reorder buffer being ful=
l (ROB stalls).",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not consumed by the backend due to scoreboards from the instruc=
tion queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots ever=
y cycle that were not consumed by the backend due to frontend stalls.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ALL",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to BACLEARS.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
> +        "PublicDescription": "Counts the number of issue slots every cyc=
le that were not delivered by the frontend due to BACLEARS, which occurs wh=
en the Branch Target Buffer (BTB) prediction or lack thereof, was corrected=
 by a later branch predictor in the frontend. Includes BACLEARS due to all =
branch types including conditional and unconditional jumps, returns, and in=
direct branches.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to BTCLEARS.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
> +        "PublicDescription": "Counts the number of issue slots every cyc=
le that were not delivered by the frontend due to BTCLEARS, which occurs wh=
en the Branch Target Buffer (BTB) predicts a taken branch.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to the microcode sequencer (M=
S).",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.CISC",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to decode stalls.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.DECODE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to frontend bandwidth restric=
tions due to decode, predecode, cisc, and other limitations.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8d"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to a latency related stalls i=
ncluding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x72"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to ITLB misses.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ITLB",
> +        "PublicDescription": "Counts the number of issue slots every cyc=
le that were not delivered by the frontend due to Instruction Table Lookasi=
de Buffer (ITLB) misses.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to other common frontend stal=
ls not categorized.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.OTHER",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycl=
e that were not delivered by the frontend due to wrong predecodes.",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of consumed retirem=
ent slots.",
> +        "EventCode": "0xc2",
> +        "EventName": "TOPDOWN_RETIRING.ALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of uops retired.",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.ALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of integer divide uops re=
tired.",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.IDIV",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops that are from com=
plex flows issued by the micro-sequencer (MS).",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.MS",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the number of uops that are from co=
mplex flows issued by the Microcode Sequencer (MS). This includes uops from=
 flows due to complex instructions, faults, assists, and inserted flows.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of x87 uops retired, incl=
udes those in MS flows.",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.X87",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
> new file mode 100644
> index 000000000000..67fd640f790e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
> @@ -0,0 +1,47 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to load DTLB misses to any page size.",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to loads (including SW prefetches) whose address translations missed in=
 all Translation Lookaside Buffer (TLB) levels and were mapped to any page =
size. Includes page walks that page fault.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to store DTLB misses to any page size.",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to stores whose address translations missed in all Translation Lookasid=
e Buffer (TLB) levels and were mapped to any page size.  Includes page walk=
s that page fault.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks initiated b=
y a instruction fetch that missed the first and second level TLBs.",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks due to an i=
nstruction fetch that miss the PDE (Page Directory Entry) cache.",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to instruction fetch misses to any page size.",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to instruction fetches whose address translations missed in all Transla=
tion Lookaside Buffer (TLB) levels and were mapped to any page size.  Inclu=
des page walks that page fault.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the head (=
oldest load) of the load buffer and retirement are both stalled due to a DT=
LB miss.",
> +        "EventCode": "0x05",
> +        "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x90"
> +    }
> +]
> --
> 2.25.1
>
