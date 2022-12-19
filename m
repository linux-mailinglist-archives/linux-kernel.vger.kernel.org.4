Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8249E6511B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiLSSWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiLSSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:22:08 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3048F614D;
        Mon, 19 Dec 2022 10:22:07 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id o13so5148604ilc.7;
        Mon, 19 Dec 2022 10:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCTcW0l43/XJ8Y/T8YvwdqIIDyvz92ZMBFfEAbp5qlc=;
        b=VRRrjYoWc5u3Y6LMf0SOyl0oqaa0B80y302NTu/u7Lb6zenYaAnXzsztzM4hDrU1p6
         cE+n68waRU435tRdvKrOXq5bm6iUec2wPffYat7BuRgQnzhYXyn1V2Bxev4qi+3q49Mu
         vNMzMJMN8Gc15ThDMRlW7g34xh0EHiCsXHakO6fyit5lBJ6xOX3kUl0j91rsI3jwbegb
         rVBuu7755k1zr1pCU5mK3bgdgUHdutWXmqsfy3Ir0B/a8yxRA5yGoS9YGcK2kROfhUMz
         nnUib3ICPIbT7HpaEJmGo4XxuQyyc2KASX8dVwGml4FGKu3rBmjdCqARKDdTKE+sMF+d
         U6Ww==
X-Gm-Message-State: ANoB5plaNAbnjmC46FNlZN3ya4ppzePhD1Un2l79PId9z75z9fl48G+L
        x9Shy/eSo3z3y6frRGtlZakdoTSGWFD6f7Ajhco=
X-Google-Smtp-Source: AA0mqf5xzBrdJ+G2LZmoxl5mvXcBzdl4khxGIZaNkJCbQWUtuPzEJtz8wFjaUzNg+y1IDUNVm7l9G+2lRRo5GWnk6BQ=
X-Received: by 2002:a92:d6d1:0:b0:303:288d:9f6a with SMTP id
 z17-20020a92d6d1000000b00303288d9f6amr21276976ilp.119.1671474126382; Mon, 19
 Dec 2022 10:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20221219161259.3097213-1-james.clark@arm.com> <20221219161259.3097213-2-james.clark@arm.com>
In-Reply-To: <20221219161259.3097213-2-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Dec 2022 10:21:56 -0800
Message-ID: <CAM9d7chFXKTcD80dLkFLwQVT9M+k0oRSB5C7gXUXUS2OZ0UusQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf event: Add simd_flags field to perf_sample
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, robh@kernel.org,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Dec 19, 2022 at 8:13 AM James Clark <james.clark@arm.com> wrote:
>
> From: German Gomez <german.gomez@arm.com>
>
> Add new field to the struct perf_sample to store flags related to SIMD
> ops.
>
> It will be used to store SIMD information from SVE and NEON when
> profiling using ARM SPE.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/sample.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 60ec79d4eea4..bdf52faf165f 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -66,6 +66,18 @@ struct aux_sample {
>         void *data;
>  };
>
> +struct simd_flags {
> +       u64     arch:1, /* architecture (isa) */
> +               pred:2; /* predication */

Can we reserve more bits for possible future extension or
other arch support?  It seems to be too tight for each field.
Do you plan to add more info to the struct in the future?

Thanks,
Namhyung


> +};
> +
> +/* simd architecture flags */
> +#define SIMD_OP_FLAGS_ARCH_SVE         0x01    /* ARM SVE */
> +
> +/* simd predicate flags */
> +#define SIMD_OP_FLAGS_PRED_PARTIAL     0x01    /* partial predicate */
> +#define SIMD_OP_FLAGS_PRED_EMPTY       0x02    /* empty predicate */
> +
>  struct perf_sample {
>         u64 ip;
>         u32 pid, tid;
> @@ -103,6 +115,7 @@ struct perf_sample {
>         struct stack_dump user_stack;
>         struct sample_read read;
>         struct aux_sample aux_sample;
> +       struct simd_flags simd_flags;
>  };
>
>  /*
> --
> 2.25.1
>
