Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA3622042
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKHXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKHXXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08B62AC6E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:22:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j15so23310582wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcavttwH0q3M9PraafemTP01iTUHxHGotv46eg3YbBs=;
        b=rxPbT0U5+f/HhF5uwizaUfRbdFygOsBf7nhQiLgvAV6cOj1b7nnFFZAUyfXKfDuenf
         heZI60ZEINlWgvsmECMf1D6Ov6qqVXt5xaQS9AY9d76xf4lpLfo31nC97tsKkup6+PA3
         ZSZFinu/h2+DeVvpmJBlrAy1hmIvct9YLFk0GCtOtnqZF2sPMLpf6C6pxvosgIE+PC68
         Leznntw061i/+IHhbBMOMXUTtOgG+Olv1WLxAhR+hgO7+Z+vLMt1dT0xa+42ptEJaaoi
         TObTFSsPwxXSrXT+wMmfRucP5CdWNqSYLKK0tRUl55K0p8hIhH2wWRxeoPlHpzHimyeC
         uaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcavttwH0q3M9PraafemTP01iTUHxHGotv46eg3YbBs=;
        b=pFa/Z/4sbpAOOvxirWA8pCHuMWJJVNJ8izCXkox7mkUMccXyZwwvhCDzE0UcwIocYL
         0+GGrcgxJ1H9c9AasYThPXJVTSK6XqmzufhTIVf4c6q53JlB88kRFYDvNK6KlKylXGbc
         PmF+mz7rReTYbIhIDGUH2hGBG9x2F+eSP+QbTLFZsrqfThFav/3hfJCe3AOxGvL1wqym
         FZEP8V0nz7Yla+x9Du0Q2zn2B1UlRZb/bEsXBE2/x63KRrSdnmiOOLEXYyqjCpG9m+q/
         XOQlFDZpOJdu8Izyxu+BGyfNBxk3amXLEKtlFbI6imyKtRIdidA8gzHX2EiruOMXVj8x
         Tt8Q==
X-Gm-Message-State: ACrzQf1XsTz0Dh4h77c+h4IEK0yzQzb3YHpWf3VrW1enhn5o90VZL/EZ
        MHY/fu4a3dyM5uv0nwL//fnwUa/hMxT4IrDuEZEd1Q==
X-Google-Smtp-Source: AMsMyM5y2i4ewEOMisgv/IT0ccWDvptArlraGJCg4PGzsgAfhXW+PMTycbgC0Fd9TLCJhykdEfACkB8+AdLs9SKnO1Q=
X-Received: by 2002:adf:db92:0:b0:236:9d4a:476f with SMTP id
 u18-20020adfdb92000000b002369d4a476fmr37191905wri.654.1667949772244; Tue, 08
 Nov 2022 15:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-8-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-8-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:22:32 -0800
Message-ID: <CAP-5=fVyRrU_oFU_r3jsoY2MK=zMKLKvgLvhG+v8SjtSQmmoeg@mail.gmail.com>
Subject: Re: [PATCH 7/9] perf stat: Add header for interval in JSON output
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It missed to print a matching header line for intervals.
>
> Before:
>   # perf stat -a -e cycles,instructions --metric-only -j -I 500
>   {"unit" : "insn per cycle"}
>   {"interval" : 0.500544283}{"metric-value" : "1.96"}
>   ^C
>
> After:
>   # perf stat -a -e cycles,instructions --metric-only -j -I 500
>   {"unit" : "sec"}{"unit" : "insn per cycle"}
>   {"interval" : 0.500515681}{"metric-value" : "2.31"}
>   ^C
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 25f67fb37f6d..aab2576bd40f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -860,6 +860,10 @@ static void print_metric_headers(struct perf_stat_config *config,
>                 if (!config->iostat_run)
>                         fputs(aggr_header_csv[config->aggr_mode], config->output);
>         }
> +       if (config->json_output) {
> +               if (config->interval)
> +                       fputs("{\"unit\" : \"sec\"}", config->output);
> +       }
>         if (config->iostat_run)
>                 iostat_print_header_prefix(config);
>
> --
> 2.38.1.431.g37b22c650d-goog
>
