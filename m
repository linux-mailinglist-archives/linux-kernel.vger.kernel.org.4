Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26AF737787
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFTWfj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFTWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:35:37 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05607DC;
        Tue, 20 Jun 2023 15:35:37 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so196127939f.2;
        Tue, 20 Jun 2023 15:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300536; x=1689892536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrWpIyeCLEscJMgZ3prpYzuEG/O9cCUuFZ9aiShbUK4=;
        b=XHouAlSmYuriu1ZDNsGln14zZLb1L7bV6FaHZBJHSZUMkKpYARFGc4yKMJ/uAGMqx4
         vG9JYpNLiVLl5ui4Sish0L0K1TfOTtKe6l6pJwcegz9xiAgOYJw8yKG8qWTXVV24/tT+
         V9w5VsL5ONY2Ffjep97A2dCk2aAzJCW6stTv6EAHpSv0FN/dq30uq/X1TlXv9b146kim
         d2cPpBJw4iGDXzE/q1YlzQ4Q6OL8oLnlXAZXy3uNEgsWOw+IeQ0ysOvKkuGCxbU8aoFQ
         UllfKo8Gtz7lyb5MP83Q3PhEpagJFvJdhlGhAI/sy3M0zaB5/XuHsNBDe8SSLjuGns+t
         sfEg==
X-Gm-Message-State: AC+VfDwUZ42I9zA4hchGOdSTrxMxYGbQ1I8m6bngIM60bk5ZcrsHfYkH
        6XvxZFWgKCPrwX2qsz7z0Adh8xSBNZIyvCXQvtwys9cA
X-Google-Smtp-Source: ACHHUZ5fqB6N3TX8dcYKwAW+b+agZlXAW1mft/IQzqkhbDimUcUCSALSlqN+p1WuHp45qxyR0TyX9+9HZvh0UKVIa9I=
X-Received: by 2002:a6b:7b46:0:b0:77a:17d1:3b2b with SMTP id
 m6-20020a6b7b46000000b0077a17d13b2bmr10118877iop.18.1687300536235; Tue, 20
 Jun 2023 15:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230613033946.103515-1-yangjihong1@huawei.com> <20230613033946.103515-2-yangjihong1@huawei.com>
In-Reply-To: <20230613033946.103515-2-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 15:35:25 -0700
Message-ID: <CAM9d7cjyVgJiVT4Lf+qGd+d2es6NcoN3H42onpN_t4Ed0JHgig@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/4] perf trace-event-info: Add
 tracepoint_id_to_name() helper
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        anshuman.khandual@arm.com, jesussanp@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 12, 2023 at 8:41 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Add tracepoint_id_to_name() helper to search for the trace events directory
> by given event id and return the corresponding tracepoint.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/trace-event-info.c | 11 +++++++++++
>  tools/perf/util/trace-event.h      |  6 ++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
> index c24b3a15e319..a7901f4a6654 100644
> --- a/tools/perf/util/trace-event-info.c
> +++ b/tools/perf/util/trace-event-info.c
> @@ -466,6 +466,17 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
>         return NULL;
>  }
>
> +char *tracepoint_id_to_name(u64 config)
> +{
> +       struct tracepoint_path *path = tracepoint_id_to_path(config);
> +       char *buf = NULL;
> +
> +       if (path && asprintf(&buf, "%s:%s", path->system, path->name) > 0)
> +               return buf;

I think we need to call put_tracepoints_path() before return.

Thanks,
Namhyung


> +
> +       return NULL;
> +}
> +
>  static struct tracepoint_path *tracepoint_name_to_path(const char *name)
>  {
>         struct tracepoint_path *path = zalloc(sizeof(*path));
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index a0cff184b1cd..a69ee29419f3 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -62,6 +62,12 @@ unsigned long long eval_flag(const char *flag);
>
>  int read_tracing_data(int fd, struct list_head *pattrs);
>
> +/*
> + * Return the tracepoint name in the format "subsystem:event_name",
> + * callers should free the returned string.
> + */
> +char *tracepoint_id_to_name(u64 config);
> +
>  struct tracing_data {
>         /* size is only valid if temp is 'true' */
>         ssize_t size;
> --
> 2.30.GIT
>
