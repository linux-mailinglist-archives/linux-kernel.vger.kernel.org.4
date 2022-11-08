Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1262203A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKHXU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHXU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:20:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA78220E7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:20:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so23309114wru.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUnYOUwlAhTiIxun+3EmlrJD7Z1kFHI5Kib+dD6aRMQ=;
        b=B5kllI0DUR7e0rjuPoqVmMaizNRfiRBDmVsTyupE1yfyV8XkUnrR5WZaeBhmIZbApv
         CUnIqkT1PswOUdS50DXst9OnZKyaTmOVoovd+3u4mGQPLWnTJaHUwk8VLc/bcOqmtMZD
         GNP5n/N512fciJyCL4mNhE169fKS7eYiKKU3D9nJOJAx8B1yztbs5kFn3EsKZn+cUhL2
         F133q5qkj9wiQEQuaHDrGqzk8pPqfaM1jIbbF761FPp+eAbWmr7xh+GKL87AVtXqJazy
         E9Qkn+XRmGSU/wchy1wU9EFXn23qVVv8mUsc416TiSAyPzWSs4g6ShCzA1Ugl3Bq2L3i
         k6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUnYOUwlAhTiIxun+3EmlrJD7Z1kFHI5Kib+dD6aRMQ=;
        b=hytL5pdUKsTVVs+RjSEVFwc/eQVDTjiedo75Zv86u1N2SP8jk9zLcRdJ1xkRYDW3d0
         EtN4TLQu1t1B6ECRn0BdKPzPrNmp8N69zbM3BxC1ue+hWzzlZipYt3qIuzfbo2W7hvsn
         q3cpIkblrKtfI5hcjbTji+7dmvHws0UpOT9jKnXzeuhhqzyEwzRK81/Tri4iV/otZXa2
         j1crkcTE/UeqdmjXHukXt6GFbm8MaT/cAvGAMZv3ebLeXYwVe+TblDctkr+uYT6uIUnS
         mBfwWv2ZIBbgrvW/cBCDa6rBF54KjC4kut5VsApNXEjLh3mU1ooxhh+sKPeoNM07G4PP
         Qo2w==
X-Gm-Message-State: ACrzQf3ZMHpXu9PhIk+FOvq+WbpBDdVcsfC3OGgXkmfRm0hiM/Vh2lgT
        hZWhZ7M9bAZqROxsKlKqdJMXUjU82Qj8UdxI9b64Fg==
X-Google-Smtp-Source: AMsMyM4lQGiaprqHiWECzyXIIKuncPhQ5UXFOjXQo9uzf3X6QkA3C4OiBmyEowYEdcOAVRt1A0bJC5qQtDAlQwpy4wI=
X-Received: by 2002:adf:e711:0:b0:236:2f7f:4f08 with SMTP id
 c17-20020adfe711000000b002362f7f4f08mr37589267wrm.375.1667949653475; Tue, 08
 Nov 2022 15:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-7-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:20:41 -0800
Message-ID: <CAP-5=fXSROZwwgGGHGjYwC3QkzX9_CBXrV7Ye5y8+2mK16jJmQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf stat: Do not indent headers for JSON
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Currently --metric-only with --json indents header lines.  This is not
> needed for JSON.
>
>   $ perf stat -aA --metric-only -j true
>         {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"cpu" : "0", {"metric-value" : "0.101"}{"metric-value" : "0.86"}{"metric-value" : "1.91"}
>   {"cpu" : "1", {"metric-value" : "0.102"}{"metric-value" : "0.87"}{"metric-value" : "2.02"}
>   {"cpu" : "2", {"metric-value" : "0.085"}{"metric-value" : "1.02"}{"metric-value" : "1.69"}
>   ...
>
> Note that the other lines are broken JSON, but it will be handled later.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 515fb6db3d67..25f67fb37f6d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -851,7 +851,7 @@ static void print_metric_headers(struct perf_stat_config *config,
>         if (prefix && !config->json_output)
>                 fprintf(config->output, "%s", prefix);
>
> -       if (!config->csv_output && !no_indent)
> +       if (!config->csv_output && !config->json_output && !no_indent)
>                 fprintf(config->output, "%*s",
>                         aggr_header_lens[config->aggr_mode], "");
>         if (config->csv_output) {
> --
> 2.38.1.431.g37b22c650d-goog
>
