Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0173C6FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFXF4L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXF4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:56:09 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE0C26B3;
        Fri, 23 Jun 2023 22:56:07 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-762092e1fb7so128752085a.1;
        Fri, 23 Jun 2023 22:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586166; x=1690178166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4H08seAO8eFj/VvXuhKcSxDBYOLPlbx5aVZjE1hX6VQ=;
        b=TiNM7ZNcf5/MDtAD7cPRVLb3RWJEUWk0z/0SoEsSupnMx2S1v4jfsV+Li2dOGl+V2A
         SywXOlxtC+mUWR+wpOIG/UnUnkmWo1Yvjrmh72w4qWStzEYvpfq5LwFF9BLOR7nRoUsu
         EfPoSldKn/tST3DEFKsXOLMVNhE46tn0TBc/TPTJW6KrL9DPkYs0VcwlGBVHuQVui8f3
         8JuRNzI4d2MrF68JXsxr5CmX59C+mc5cGF32X0hc06t/GnVbzKmLjYXNEcBsHTotqBz2
         Ee/MpfcuJYjxii/sg0Jw+dmj5vke9ZzlSfm0QuSmgUO610CTGZ7yZrE0vh2d1/JOh5Tp
         Lzsg==
X-Gm-Message-State: AC+VfDyTj6TCxWajfdQiuFokD6VPR1AVOq7DdPy3ua5C2xxQbhwKljAp
        kaCQM4nRNCcUCHoOPRH8AAHtOJjvuIap6ZT7Fs0=
X-Google-Smtp-Source: ACHHUZ6zGCFm282oWne0oEPwkLmNdxGbU5Iqe+gcDVhOJ1rPvB63xsMJeAYe5EN+DtGk297dWDmbX7cS77GUhc0siNA=
X-Received: by 2002:a05:620a:1a87:b0:763:b8f6:33dc with SMTP id
 bl7-20020a05620a1a8700b00763b8f633dcmr15049300qkb.37.1687586166466; Fri, 23
 Jun 2023 22:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230623082031.1402-1-ravi.bangoria@amd.com>
In-Reply-To: <20230623082031.1402-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 22:55:55 -0700
Message-ID: <CAM9d7ciP7hj+u70qxMLE67Hm0uUJfC1rjnW-jDXSLmVYpef_eg@mail.gmail.com>
Subject: Re: [RFC] perf record: Use PERF_RECORD_LOST for synthesizing samples
 from read_format->lost
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        peterz@infradead.org, adrian.hunter@intel.com, kan.liang@intel.com,
        eranian@google.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Fri, Jun 23, 2023 at 1:21 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Currently perf synthesizes PERF_RECORD_LOST_SAMPLES samples for values
> returned by read_format->lost. IIUC, PERF_RECORD_LOST_SAMPLES is used
> only when hw provides corrupted samples and thus kernel has to drop
> those. OTOH, PERF_RECORD_LOST is used when kernel has valid samples but
> it fails to push them to ring-buffer because ring-buffer is already full.
>
> So I feel PERF_RECORD_LOST is more appropriate for synthesizing samples
> from read_format->lost.

The problem of PERF_RECORD_LOST is that it counts non-sample
records too.  It just counts every lost records and put the number
when it can find a space in the ring buffer later.  We don't know
which one is lost and how many of it.

Some users want to get the accurate number of samples even if it's
not recorded in the ring buffer.  Using PERF_RECORD_LOST can be
confusing since the kernel will return inaccurate data in terms of the
number of lost samples.  So I chose PERF_RECORD_LOST_SAMPLES
to return the accurate number for each event.

Thanks,
Namhyung


>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> Notes:
>  - Posting this as RFC to get feedback. I haven't tested it well.
>  - There is one more minor issue: Aggregated Stats shows count of LOST/
>    LOST_SAMPLES records instead of actual number of lost events/samples:
>      ```
>      $ sudo ./perf report -D | tail -20
>      Warning:
>      Processed 78923 events and lost 1153 chunks!
>      Warning:
>      Processed 47427 samples and lost 28.30%!
>      ...
>      Aggregated stats:
>                LOST events:       1153  ( 1.5%)
>        LOST_SAMPLES events:        132  ( 0.2%)
>      ```
>    Not sure if this is intentional.
>
>  tools/perf/builtin-record.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index efa03e4ac2c9..5baed42437b2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1858,7 +1858,7 @@ record__switch_output(struct record *rec, bool at_exit)
>  }
>
>  static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
> -                                       struct perf_record_lost_samples *lost,
> +                                       struct perf_record_lost *lost,
>                                         int cpu_idx, int thread_idx, u64 lost_count,
>                                         u16 misc_flag)
>  {
> @@ -1871,6 +1871,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>                 sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
>                 sample.id = sid->id;
>         }
> +       lost->id = sid->id;
>
>         id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
>                                                        evsel->core.attr.sample_type, &sample);
> @@ -1882,7 +1883,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>  static void record__read_lost_samples(struct record *rec)
>  {
>         struct perf_session *session = rec->session;
> -       struct perf_record_lost_samples *lost;
> +       struct perf_record_lost *lost;
>         struct evsel *evsel;
>
>         /* there was an error during record__open */
> @@ -1895,7 +1896,7 @@ static void record__read_lost_samples(struct record *rec)
>                 return;
>         }
>
> -       lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +       lost->header.type = PERF_RECORD_LOST;
>
>         evlist__for_each_entry(session->evlist, evsel) {
>                 struct xyarray *xy = evsel->core.sample_id;
> --
> 2.41.0
>
