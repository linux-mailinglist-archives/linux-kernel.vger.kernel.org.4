Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF77443C0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjF3VEC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjF3VDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:03:52 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98424221;
        Fri, 30 Jun 2023 14:03:48 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c40c367949eso1342543276.1;
        Fri, 30 Jun 2023 14:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688159028; x=1690751028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVGM406xAqn4Hn9Deh7kQt4tORL6Fxhh/UBnDJhIX3I=;
        b=CzIjt5xVEqqcAlgyHrLMT85/B5TIYHlVJM8enjx/uChiCCpipGV8yluOy354TqMDcp
         5u+GjZFANjVQVPclj78VJdP3ZffgzhZfUGP+u2Xixn02GMUuB62EieElyznM4aZGTE7r
         4D5Sqz4C0JYrAIjCBovs1mVW+S8SfIKqDfPXhoDh/GnqmY35Z7bJPlfSCChxAS3QZpPW
         zaeIfmJzMRJ7FoWGp5uCwxtP4/y76rtjYSd5svzEFykevFytm4siO+gaRq3snU72PKr/
         f3VA8jyBwYTv85YlVNGikYLGyqqQQqhJgbDZDLop9jRyElGtyWTOGTpOK3jo5eDP5A0Z
         kkHA==
X-Gm-Message-State: ABy/qLZIyh+XxqZw6ktsMQQPNO47fvX83g7c92J72utM0O7iKaibzY3C
        wS6isL/qNyd0TcWxAL3z1YkrB9DqG03fnDVHrcM=
X-Google-Smtp-Source: APBJJlEG8/0u0yaEBl0JZOnHYNF5VOMtgNAxXm0x2vZqAu/ZydtgsSX1mofjdxkhJyBYZn1lwTjMrZzqhSOVvIJsEj8=
X-Received: by 2002:a25:6cd4:0:b0:bac:1522:f870 with SMTP id
 h203-20020a256cd4000000b00bac1522f870mr3675226ybc.52.1688159028012; Fri, 30
 Jun 2023 14:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230623151016.4193660-1-irogers@google.com> <CAM9d7cgX-vnwkrQMMHn2C1sCjm3YO=xaigmMTsrbkg+fHk2H2g@mail.gmail.com>
In-Reply-To: <CAM9d7cgX-vnwkrQMMHn2C1sCjm3YO=xaigmMTsrbkg+fHk2H2g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Jun 2023 14:03:35 -0700
Message-ID: <CAM9d7cjVChbQThcMx7ptp-FRCrrwgV97fVJ0FpasC20M1+yLbQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Add metric has_event, update intel vendor events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

On Thu, Jun 29, 2023 at 2:31 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Fri, Jun 23, 2023 at 8:10 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Add a new has_event function for metrics so that events that can be
> > disabled by the kernel/firmware don't cause metrics to fail. Use this
> > function for Intel transaction metrics fixing "perf all metrics test"
> > on systems with TSX disabled. The update conversion script is posted in:
> > https://github.com/intel/perfmon/pull/90
> >
> > Re-generate Intel vendor events using:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > Adding rocketlake support, uncore and many core events for meteorlake,
> > and smaller updates for cascakelakex, icelake, icelakex,
> > sapphirerapids, skylake, skylakex and tigerlake.
> >
> > v2. Handle failed memory allocated for evlist, John Garry.
> >
> > Ian Rogers (12):
> >   perf expr: Add has_event function
> >   perf jevents: Support for has_event function
> >   perf vendor metrics intel: Make transaction metrics conditional
> >   perf vendor events intel: Add rocketlake events/metrics
> >   perf vendor events intel: Update meteorlake to 1.03
> >   perf vendor events intel: Update cascadelakex to 1.19
> >   perf vendor events intel: Update icelake to 1.19
> >   perf vendor events intel: Update icelakex to 1.21
> >   perf vendor events intel: Update sapphirerapids to 1.14
> >   perf vendor events intel: Update skylake to 57
> >   perf vendor events intel: Update skylakex to 1.31
> >   perf vendor events intel: Update tigerlake to 1.13
>
> My tigerlake laptop now passes the all metrics test with this.
> It used to fail like below:
>
>   event syntax error:
> '{cpu/cycles-t,metric-id=cpu!3cycles!1t!3/,cpu/tx-start,m..'
>                             \___ unknown term 'cycles-t' for pmu 'cpu'
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
