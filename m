Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E556F8A71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEEUyw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjEEUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:54:46 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A149E3;
        Fri,  5 May 2023 13:54:45 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-b9a6ab9ede3so3007110276.2;
        Fri, 05 May 2023 13:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683320084; x=1685912084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYVGB6plWT1YdfLLw6hoHtv7l2YFMxriyoV+UZStGq4=;
        b=i+2fanKdhVP8IAFYdSPy2tTMfRJ5D8as/v7bblW1rj2svnhNbK2kDv0yIJA1aGkAs+
         FZrDmBZz2kjsCwMl9EW7eRKY7pd3VKIktXKKx4/StL8bW9oAQGgWz0FscqCeXASI0f5P
         HfkIoqykd+Zu5U28gpG4dqGqE4wxnbFrP32667JG2sNixPAbOOCWfjCkpnmBRBTnx++L
         jtxITg4PMDDQZXa7FW+jpXfeZetiMC9vMVwpLKsmZWbGD1q1tcLlG9eAzwm0TassVqx5
         GsbBun3VZ/FfFXq6YhmIOIg19L3EjCJ3CBaPOhqFDWtHKw4MrIy5mthWG8TtXDxjqmMa
         6erQ==
X-Gm-Message-State: AC+VfDx0u1g1/JsLCACCl8xAWQ6AflUlXarZYx1gdXw0h/AaTOTlZEF5
        bCjjcfPJVIz4PW7lUzU5399DAiyhw4TeviLEmtc=
X-Google-Smtp-Source: ACHHUZ7K8c39ZHBIJe/ovC4cnYkkrQsebbP0ZMkYWfv7B2HUDG+87jr0dUz0+X123t+Ee5hn8BDjwnidUGMZKK/LSCA=
X-Received: by 2002:a25:1542:0:b0:b9e:84b0:bfa6 with SMTP id
 63-20020a251542000000b00b9e84b0bfa6mr2836370ybv.25.1683320084061; Fri, 05 May
 2023 13:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230505204119.3443491-1-irogers@google.com>
In-Reply-To: <20230505204119.3443491-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 May 2023 13:54:33 -0700
Message-ID: <CAM9d7cifodHyFJHmfSCBBTocab1GbvzoebLQRbf4vjYJHJWb+g@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Fix segv with --for-each-cgroup
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
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

On Fri, May 5, 2023 at 1:41 PM Ian Rogers <irogers@google.com> wrote:
>
> Ensure the metric threshold is copied correctly or else a use of
> uninitialized memory happens.
>
> Fixes: d0a3052f6fae ("perf metric: Compute and print threshold values")
>
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the fix.  Now it runs ok

  $ sudo ./perf stat -a --bpf-counters \
  > --for-each-cgroup user.slice,system.slice sleep 1

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/metricgroup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4b9a16291b96..c566c6859302 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1730,6 +1730,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>                                 return -ENOMEM;
>
>                         new_expr->metric_expr = old_expr->metric_expr;
> +                       new_expr->metric_threshold = old_expr->metric_threshold;
>                         new_expr->metric_name = strdup(old_expr->metric_name);
>                         if (!new_expr->metric_name)
>                                 return -ENOMEM;
> --
> 2.40.1.521.gf1e218fcd8-goog
>
