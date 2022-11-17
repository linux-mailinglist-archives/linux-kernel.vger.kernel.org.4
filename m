Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53FB62E3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiKQSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiKQSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:11:50 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECA7FF39;
        Thu, 17 Nov 2022 10:11:48 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso1545424otq.11;
        Thu, 17 Nov 2022 10:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TiNyM9B5M+n2XUh8qUxi//SLLvzOC5yxBWOEqJpqDM=;
        b=EFjPOR8TZIkh2AITRBxbIRluckgnZ5qj/qL/QFt+neUPNS5NIclcjE3TJUus16ilRL
         CuQWE0dcF600n6hKK/ex5haCg3i4Ee/SYaSX3FIzs4Gc8Wo3sTn8wFQQQjfERxwhP0wi
         Q4K5yXwC2IY/Z0nIg6krn+IJmcKa29ha5KyHg2gfTUfa9ngZpD6j+PULM+EWt7Krwd3C
         7X2WSMw8omlCEsPqhAMwZv4lazQV6PVDjrw8oUeWtaJn0zY4E3CPoiyiWUsiZKU4TnLA
         iuSXOacJkDBDlv3LbofwpPraN0zXjyBj2F6EMYYqUgKQJO364/7c88MyllEsC/+K5JdR
         kYkg==
X-Gm-Message-State: ANoB5pnPeZjOQpMZPcaISXuo7QQblWUd+HiYkBzfC7tM+7Pf6O+lsDDy
        CmeaC4BW17sWbk9dsxtIbffpi2Ev3oNxhep2UbM=
X-Google-Smtp-Source: AA0mqf4I4wJeFvLDnwGkxkqCOjJzpbLZcED+PxWHhM8DlnN5kTUiEEvJBBG00gzGYPs5X0SbZkjUBqoUyQiGWMACLZc=
X-Received: by 2002:a05:6830:1215:b0:66d:78b8:7b1a with SMTP id
 r21-20020a056830121500b0066d78b87b1amr2135173otp.206.1668708707662; Thu, 17
 Nov 2022 10:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116233854.1596378-1-namhyung@kernel.org> <20221116233854.1596378-6-namhyung@kernel.org>
 <Y3Zb+JChHoq+89yM@kernel.org> <Y3ZeOuNnk0xclY2x@kernel.org>
 <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
 <Y3ZuW2IxVWp9yoaD@kernel.org> <CAP-5=fWYi2ASE=v0UgrqbBDA2+jC0qmNX2_4r0wbFLV3Dw2nYw@mail.gmail.com>
In-Reply-To: <CAP-5=fWYi2ASE=v0UgrqbBDA2+jC0qmNX2_4r0wbFLV3Dw2nYw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Nov 2022 10:11:36 -0800
Message-ID: <CAM9d7cioaqjPgp+-UyUwzg7J3OQRC8DNMP0T1h5ro=yNgr128w@mail.gmail.com>
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
To:     Ian Rogers <irogers@google.com>,
        German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Nov 17, 2022 at 9:24 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Nov 17, 2022 at 09:16:58AM -0800, Ian Rogers escreveu:
> > > On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> > > > > > The leafloop workload is to run an infinite loop in the test_leaf
> > > > > > function.  This is needed for the ARM fp callgraph test to verify if it
> > > > > > gets the correct callchains.
> > > > > >
> > > > > >   $ perf test -w leafloop
> > > > >
> > > > > On fedora:36
> > > > >
> > > > > In file included from /usr/include/bits/libc-header-start.h:33,
> > > > >                  from /usr/include/stdlib.h:26,
> > > > >                  from tests/workloads/leafloop.c:2:
> > > > > /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> > > > >   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> > > > >       |    ^~~~~~~
> > > > > cc1: all warnings being treated as errors
> > > > > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
> > > > > make[5]: *** Waiting for unfinished jobs....
> > > > >
> > > > > I'll try removing the _FORTIFY_SOURCE
> > > >
> > > > Works after I added this to datasym.c, leafloop.c and brstack.c:
> > >
> > > Is there a reason we are compiling without -O ? Perhaps we can filter
> >
> > I assumed so as Namhyung added it, perhaps he is just carrying it from
> > the pre-existing shell tests?

Exactly :)

> >
> > I wonder its to have a predictable binary output that the test expects
> > when doing things like hardware tracing? As it come from the coresight
> > tests, IIRC.

I think it just checks frame-pointer based callstacks on ARM to have the
precise results for leaves and their parents.


>
> Would the following in the Build be better:
>
> ```
> # Undefine _FORTIFY_SOURCE as it doesn't work with -O0
> CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
> -U_FORTIFY_SOURCE
> ```
>
> We could also use make's `filter-out`. If we are disabling inlining
> then there is also `-fno-optimize-sibling-calls` otherwise we can
> still lose stack frames.

I wonder if it's enough to use -O0 as it's enabled from -O2.
Maybe we can get rid of -fno-inline as well.

German, did you have any concerns for those options?

Thanks,
Namhyung
