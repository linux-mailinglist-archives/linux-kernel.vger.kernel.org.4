Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D195F3B05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 03:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJDBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 21:34:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA824F3D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 18:34:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so6843039wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ba7+VCWbkSLdpJi3cP/QjqQGiLdpPdQDJwXzgD1/onY=;
        b=LDHsaymAavJtj3LDueXJl2RdUB3co7vxf5coiblnwptFT1MJTUAJ/7NiGmIi0N62BQ
         YXM/NoPBl/tGd/0nj1jh5V4Yr7ZqYFEYOcZacScdEz+MDbhaA4VLxe5Ppfq398+YRMQ7
         ot4EjIMKcTsLYr8W/YrZ9LS3Z3FsnNb8JkadHtD6kDLMrD+141aE+a7iv+RYaM54cQmW
         cdNgshd/R2VGEMmq6affMREJOr4+0dssk6YslPUpKf1wzymfBgKEUB8UB1RUkMUkQml7
         8tIQM7MSnS3aNDAgBG9EJtmI+sONjqYMEvvO0237gIzIMi9/8WkfauuQC6PAnECixlIu
         dYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ba7+VCWbkSLdpJi3cP/QjqQGiLdpPdQDJwXzgD1/onY=;
        b=TP1UdNULvP/7Wcl+YxHXLtaSyR0Vgid/N8kjd+v3ERb2TU5YtwyKSPnXmhyVpFvdrR
         EtMMnEhBHN2AxnqP3byAaqqw0W/C2c3amZ//r3/lbhmbp2D+Dd3Z/k+BAlMC4ug3P9MB
         nYYIwYKPbm9W+FqpBA12H0nEso+Zsa2ztxXyJhxd4z490dK3E5hmmzejK6B2JgU4zicn
         zfrq4P/jUl4tahnDTQbqNroFGRmooeCFmpFaSFEU9j4w6f5hUWUenst8JF/4EVfvNUTc
         ZEGTZL0wfk3KHaVYPgv+/thX8CeVpnle5kI6ReaNAik5WBfVrNx2OJbOskHa9WNBjqLE
         /DlA==
X-Gm-Message-State: ACrzQf2uDuGQ7eo9O9YBOiejVqto6fp8AaFk9WeM1W4GFJ7l6nVrmX4G
        sMrxAfBnx2p17scqfPc3ldw0uVUAsPEJGusNtmPa7g==
X-Google-Smtp-Source: AMsMyM6krLGiwys9XeWRnQqFdw/0YjkEcWg5F182whJ0d8Wtva7lQmEXb9BgNObGQCN0qtEVegHxoyk1iR6ApX6Sc6M=
X-Received: by 2002:a5d:68d0:0:b0:22c:dfba:3bd6 with SMTP id
 p16-20020a5d68d0000000b0022cdfba3bd6mr11297684wrw.300.1664847266592; Mon, 03
 Oct 2022 18:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220928072204.1613330-1-irogers@google.com> <20220928072204.1613330-4-irogers@google.com>
 <e685d636-52cd-b34a-2d10-90c16b2e57cf@linux.intel.com>
In-Reply-To: <e685d636-52cd-b34a-2d10-90c16b2e57cf@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Oct 2022 18:34:14 -0700
Message-ID: <CAP-5=fXnzHBuNORVCznEi6yhoJXXD6bVaevw6qygsGf8BgmiWA@mail.gmail.com>
Subject: Re: [PATCH v1 03/22] perf metrics: Don't scale counts going into metrics
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Thu, Sep 29, 2022 at 1:49 AM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> On 9/28/2022 3:21 PM, Ian Rogers wrote:
> > Counts are scaled prior to going into saved_value, reverse the scaling
> > so that metrics don't double scale values.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/stat-shadow.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 9e1eddeff21b..b5cedd37588f 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -865,11 +865,16 @@ static int prepare_metric(struct evsel **metric_events,
> >                       if (!v)
> >                               break;
> >                       stats = &v->stats;
> > -                     scale = 1.0;
> > +                     /*
> > +                      * If an event was scaled during stat gathering, reverse
> > +                      * the scale before computing the metric.
> > +                      */
> > +                     scale = 1.0 / metric_events[i]->scale;
> > +
> This look likes not work for kernel side events like
> /sys/devices/uncore_imc_*/events/cas_count_read(write).

I've not been able to reproduce this. I've tried:

  {
    "MetricName": "IanTest",
    "MetricExpr": "uncore_imc@cas_count_read@ * 6.103515625e-5 +
uncore_imc@cas_count_write@ * 6.103515625e-5"
  }

where it scales the two counters and sums them. I see:

$ perf stat -M IanTest -a sleep 1

Performance counter stats for 'system wide':

           298.70 MiB  uncore_imc/cas_count_write/      #   721.00
IanTest
           429.64 MiB  uncore_imc/cas_count_read/

      1.004877710 seconds time elapsed

So the metric's value nearly matches the sum. If the scaled values had
been used the sum would have been something like 0.044454345703124995.

From the code, this is the only place a metric's "ID" (event/counter)
is associated with a value, so I would be confused if there were a
code path where reversing the scaling wasn't happening.

Thanks,
Ian

> >                       source_count = evsel__source_count(metric_events[i]);
> >
> >                       if (v->metric_other)
> > -                             metric_total = v->metric_total;
> > +                             metric_total = v->metric_total * scale;
> >               }
> >               n = strdup(evsel__metric_id(metric_events[i]));
> >               if (!n)
>
> --
> Zhengjun Xing
