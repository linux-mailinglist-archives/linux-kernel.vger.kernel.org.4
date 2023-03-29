Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B9C6CF70B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjC2X07 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 19:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjC2X05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:26:57 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B0F1BCD;
        Wed, 29 Mar 2023 16:26:52 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so10680585wms.1;
        Wed, 29 Mar 2023 16:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132411; x=1682724411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK678Ukzjb3nFvbqNIdWj4JdVI46X8Fv4m3Xr+xukQM=;
        b=j97w50nTAsedMV5VKamHaVsNePVwKN7VwMF8YdSp06ZDOmsd1kT5UNL1hfbZ43kKmb
         Mb0sl+EsjItYpC9GSsY26u76HU/SGa9QkAkU0umgk7UZNXp5FY9wVTVPHnIJ75H2eQjU
         +iaVm/2C9yjhybZBIPWhVJVoYJpeMBb4vz2jNfC4IG2eOQVAMc3jK4BNGKGItTGjpc/o
         0k+zq5ADbR00NsbgnBLImQaWp/TzxOsHyr+abQXWAgrKHdS2ziH1rk8aMjgnGwpg721N
         IidLLY5LgY/IeBmqLH+5zMysB3jPSjWzK18bxQsaXzlpQu7ZBgX8P1nCsB6GSraNQ3Nf
         FEZw==
X-Gm-Message-State: AO0yUKUJF54SAU2Hr7fMYB0jmat8r/sNtd7h0o2WL/f1CQj+B7w8rLfR
        n4SlgQyGiptyecq6c7HNEFgD8jouW7W2b0d38j8=
X-Google-Smtp-Source: AK7set8gUEJPIOwAxcBoJMe1TIjsSIoK2LeJtrsQFxTLmv2CJ7QsCWtO344nFOyoQySbrV/SfZKVkSXb3rxoAg50Fbk=
X-Received: by 2002:a7b:c4c6:0:b0:3ee:1afc:c15 with SMTP id
 g6-20020a7bc4c6000000b003ee1afc0c15mr16000818wmk.33.1680132410988; Wed, 29
 Mar 2023 16:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230328060038.2346935-1-zangchunxin@lixiang.com>
In-Reply-To: <20230328060038.2346935-1-zangchunxin@lixiang.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Mar 2023 16:26:38 -0700
Message-ID: <CAM9d7ciEhoSLcYjWa81E1eXtq8HRSvQLQZzzFWqJvMjbW1_hjQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf sched: Fix sched latency analysis incorrect
To:     Chunxin Zang <zangchunxin@lixiang.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Zhou <zhouchunhua@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 27, 2023 at 11:01 PM Chunxin Zang <zangchunxin@lixiang.com> wrote:
>
> 'perf sched latency' is incorrect to get process schedule latency
> when it used 'sched:sched_wakeup' to analysis perf.data.
>
> Because 'perf record' prefer use 'sched:sched_waking' to
> 'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
> sched_waking event when it exists"). It's very reasonable to
> evaluate process schedule latency.
>
> Similarly, update sched latency/map/replay to use sched_waking events.
>
> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
> Signed-off-by: Jerry Zhou <zhouchunhua@lixiang.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>
>         changelogs in v4:
>         1) disable to process wakeup event if wakingup event is found.
>
>         changelogs in v3:
>         1) fix non-ASCII characters in commit log.
>
>         changelogs in v2:
>         1) fix email address disappearing in 'signed off by'
>
>  tools/perf/builtin-sched.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 86e18575c9be..ec443df8e05c 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1516,6 +1516,14 @@ static int process_sched_wakeup_event(struct perf_tool *tool,
>         return 0;
>  }
>
> +static int process_sched_wakeup_ignore(struct perf_tool *tool __maybe_unused,
> +                                     struct evsel *evsel __maybe_unused,
> +                                     struct perf_sample *sample __maybe_unused,
> +                                     struct machine *machine __maybe_unused)
> +{
> +       return 0;
> +}
> +
>  union map_priv {
>         void    *ptr;
>         bool     color;
> @@ -1816,10 +1824,11 @@ static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
>
>  static int perf_sched__read_events(struct perf_sched *sched)
>  {
> -       const struct evsel_str_handler handlers[] = {
> +       struct evsel_str_handler handlers[] = {
>                 { "sched:sched_switch",       process_sched_switch_event, },
>                 { "sched:sched_stat_runtime", process_sched_runtime_event, },
>                 { "sched:sched_wakeup",       process_sched_wakeup_event, },
> +               { "sched:sched_waking",       process_sched_wakeup_event, },
>                 { "sched:sched_wakeup_new",   process_sched_wakeup_event, },
>                 { "sched:sched_migrate_task", process_sched_migrate_task_event, },
>         };
> @@ -1839,6 +1848,10 @@ static int perf_sched__read_events(struct perf_sched *sched)
>
>         symbol__init(&session->header.env);
>
> +       /* prefer sched_waking if it is captured */
> +       if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
> +               handlers[2].handler = process_sched_wakeup_ignore;
> +
>         if (perf_session__set_tracepoints_handlers(session, handlers))
>                 goto out_delete;
>
> --
> 2.25.1
>
> 声明：这封邮件只允许文件接收者阅读，有很高的机密性要求。禁止其他人使用、打开、复制或转发里面的任何内容。如果本邮件错误地发给了你，请联系邮件发出者并删除这个文件。机密及法律的特权并不因为误发邮件而放弃或丧失。任何提出的观点或意见只属于作者的个人见解，并不一定代表本公司。
