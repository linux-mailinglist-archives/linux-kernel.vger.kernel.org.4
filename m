Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFA636E46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKWXWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKWXWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:22:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869711E70E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:22:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so31669637wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jdl6xJf2GOmq95nfWh92ojvpXIe3KF+eLKF3UOPapg=;
        b=qOJB4MpqAvn4MQeX4Olb2iCcV3izJiOGVFzb/LgSbt/8ZIRnI30grkK6ejxfBOtfvE
         /SBMZNNVomC0RDOeLbc/MV00k/6DUDBg3CdcDLGrFrrGEGcxd6/gvaOolgYWfgilkbAi
         7iA2CFkamZ3xUJHrx22DnoXOI2dqPuIekmMFDKWO6DpLe4rrPXZv4zqmA7ircGRFNCYu
         MHBv7nbF3CGcvzNK+3pjWsvjJip/8YfPBBtHEotbzzRPsNtabKCZqWeb1nCpGcj+1oPl
         /fsv99iPYSfg/wBfbEAiuj1ImBw3ANHFH4PTRN54fFSg06tGyKR4UyfUhJ5osash7mZp
         ha5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jdl6xJf2GOmq95nfWh92ojvpXIe3KF+eLKF3UOPapg=;
        b=avW41OQ02H+YSA1gWn4C19BvVWbGiFDqpCqbZOvfN2B71QGCSXby/Wlr+mc6vqecLS
         kZeuGVK4UUbu/EzQ884dnpMpI5vudf6ZbVp+UVyuT0lMaYW7bNg97+Xh3cZ0jbCxqGiX
         6e9fsdNg3I7f/zDq8duiBd2XYq4aZmSbdpnT/c2iTiYSRMlpLX3Z0ect8BVp6mSpErhV
         a1Dg14w8ijmMp3WH7Elsjkldrf7zXuJDnnMjDrFdSoVS2vbMZFJn/8++GtbsR8T8uNzo
         yU2r2d99o0EAQeuVmBRerrbHnIVIeGJZ5fDqMDDO4u//IvTRgTJhEub83lzZj9CLL91s
         1Xpw==
X-Gm-Message-State: ANoB5plL94MR2tiye3L+rrdxpAAD3fB6k/nvjFZ0qPtXI/Hf1FYh5RrC
        PL+Avl6h6eK4nfCZR71yl5e8l4/JG1hGmvrhjkx4ug==
X-Google-Smtp-Source: AA0mqf4Md+PgZrtFIP7Z6ENJJ2tkSUqIrPjqpQrsRz7vIeA+KkN2WoOq4c/CeCq2zb9OmeDhHDrxVi+OG5ALSZ+38vk=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr7208230wrp.375.1669245734572; Wed, 23
 Nov 2022 15:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-5-namhyung@kernel.org>
In-Reply-To: <20221123180208.2068936-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:22:01 -0800
Message-ID: <CAP-5=fXzc4-U=g96dr7jzUHNKudcUh2JZW89BT8xs01Zfp7ZDw@mail.gmail.com>
Subject: Re: [PATCH 04/15] perf stat: Use scnprintf() in prepare_interval()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should not use sprintf() anymore.  Let's pass the buffer size and use the
> safer scnprintf() instead.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 15c88b9b5aa3..744b7a40f59a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1073,23 +1073,23 @@ static void print_metric_headers(struct perf_stat_config *config,
>  }
>
>  static void prepare_interval(struct perf_stat_config *config,
> -                            char *prefix, struct timespec *ts)
> +                            char *prefix, size_t len, struct timespec *ts)
>  {
>         if (config->iostat_run)
>                 return;
>
>         if (config->csv_output)
> -               sprintf(prefix, "%lu.%09lu%s", (unsigned long) ts->tv_sec,
> -                                ts->tv_nsec, config->csv_sep);
> +               scnprintf(prefix, len, "%lu.%09lu%s",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
>         else if (!config->json_output)
> -               sprintf(prefix, "%6lu.%09lu ", (unsigned long) ts->tv_sec,
> -                                ts->tv_nsec);
> +               scnprintf(prefix, len, "%6lu.%09lu ",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else if (!config->metric_only)
> -               sprintf(prefix, "{\"interval\" : %lu.%09lu, ", (unsigned long)
> -                                ts->tv_sec, ts->tv_nsec);
> +               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu, ",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>         else
> -               sprintf(prefix, "{\"interval\" : %lu.%09lu}", (unsigned long)
> -                                ts->tv_sec, ts->tv_nsec);
> +               scnprintf(prefix, len, "{\"interval\" : %lu.%09lu}",
> +                         (unsigned long) ts->tv_sec, ts->tv_nsec);
>  }
>
>  static void print_header_interval_std(struct perf_stat_config *config,
> @@ -1390,7 +1390,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>
>         if (interval) {
>                 prefix = buf;
> -               prepare_interval(config, prefix, ts);
> +               prepare_interval(config, buf, sizeof(buf), ts);
>         }
>
>         print_header(config, _target, evlist, argc, argv);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
