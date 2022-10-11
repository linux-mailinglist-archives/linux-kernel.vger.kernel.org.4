Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC385FB9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJKRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJKRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:48:35 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54BC4BD38;
        Tue, 11 Oct 2022 10:48:34 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso16786273fac.6;
        Tue, 11 Oct 2022 10:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFEDgKRLNBXIcQQzG3utcKdq1fAEvCe7vcubsOS0pX8=;
        b=YeRbJuyKX79RudwGWkXmF9v5+N5e6njLqeM6LPkjH8f1GAZTQ+sVieYvFgaIKZWfQX
         otTQBmV4YoIfIZBrVXVWmR45kI4yhZlLglyi+LbGdH8uns77RocP+D1SJ3PnJWHKPvZr
         6ksx+8ZJ+a/IT0Aundc029cPjjJQdmzF/SB1mJTxzV6YQqqD/0vzwJkbVgw0KyTZybZk
         UV40jbdxkW+myg8YS8VAgwQily4tUmL9+3XJi+p0rBl9rTjAfOHCCr7UpI88f8U5KJFP
         ia2hZW3dqXvet83z9gC6oj6M7PxgXmJRVM0ZjuaFAnbQvpMI9yEoVErzAkhQBfMW1RVZ
         7adA==
X-Gm-Message-State: ACrzQf1E8zYXRTwkzXYqoKcdU4LGyaFKKt6/7wP71bfL961oPwYpQF7K
        XKv47prgad3ua1D6vgSUlk+tbJzArRFpMKUCoRE=
X-Google-Smtp-Source: AMsMyM66bgb9X76VWSKpfpzMqYCIBKG1unh2EwtVeopVQm7t7fTpcpWmVH3/lff8MkTOECp7z/au55vCQzqoKcWTBsQ=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr203116oae.218.1665510513845; Tue, 11
 Oct 2022 10:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220926144948.223641-1-james.clark@arm.com> <20220926144948.223641-2-james.clark@arm.com>
 <d18181a2-ce9c-5d7f-17ca-43154fc6470f@arm.com>
In-Reply-To: <d18181a2-ce9c-5d7f-17ca-43154fc6470f@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 10:48:22 -0700
Message-ID: <CAM9d7ci3+gq6avXuhBsPH_v8PQDFJY=4JFOG9_BQ7xvEFazZTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf test: Fix attr tests for PERF_FORMAT_LOST
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Oct 11, 2022 at 6:00 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 26/09/2022 15:49, James Clark wrote:
> > Since PERF_FORMAT_LOST was added, the default read format has that bit
> > set, so add it to the tests. When running on an older kernel the tests
> > will still fail because Perf will not set that bit.
> >
> > This fixes the following failure:
> >
> >   expected read_format=0|4, got 20
> >   FAILED './tests/attr/test-record-C0' - match failure
> >
> > Fixes: 85b425f31c88 ("perf record: Set PERF_FORMAT_LOST by default")
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/tests/attr/base-record                | 2 +-
> >  tools/perf/tests/attr/system-wide-dummy          | 2 +-
> >  tools/perf/tests/attr/test-record-group          | 4 ++--
> >  tools/perf/tests/attr/test-record-group-sampling | 6 +++---
> >  tools/perf/tests/attr/test-record-group1         | 4 ++--
> >  tools/perf/tests/attr/test-record-group2         | 4 ++--
> >  6 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> > index 8c10955eff93..9758e22daf9c 100644
> > --- a/tools/perf/tests/attr/base-record
> > +++ b/tools/perf/tests/attr/base-record
> > @@ -9,7 +9,7 @@ size=128
> >  config=0
> >  sample_period=*
> >  sample_type=263
> > -read_format=0|4
> > +read_format=0|20
>
> Hi Namhyung,
>
> Did you manage to take a look at this review? Are you ok with it being
> 0|20 or should I change it to 0|4|20?

I'm sorry I missed this.  It'd be nice if it can succeed on old kernels too.
Please go with 0|4|20 and the like.

Thanks,
Namhyung


>
> >  disabled=1
> >  inherit=1
> >  pinned=0
> > diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> > index 86a15dd359d9..0df8a997fe51 100644
> > --- a/tools/perf/tests/attr/system-wide-dummy
> > +++ b/tools/perf/tests/attr/system-wide-dummy
> > @@ -11,7 +11,7 @@ size=128
> >  config=9
> >  sample_period=4000
> >  sample_type=455
> > -read_format=4
> > +read_format=20
> >  # Event will be enabled right away.
> >  disabled=0
> >  inherit=1
> > diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
> > index 14ee60fd3f41..09aa40af841c 100644
> > --- a/tools/perf/tests/attr/test-record-group
> > +++ b/tools/perf/tests/attr/test-record-group
> > @@ -7,14 +7,14 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=327
> > -read_format=4
> > +read_format=20
> >
> >  [event-2:base-record]
> >  fd=2
> >  group_fd=1
> >  config=1
> >  sample_type=327
> > -read_format=4
> > +read_format=20
> >  mmap=0
> >  comm=0
> >  task=0
> > diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
> > index 300b9f7e6d69..3ad68c3405c8 100644
> > --- a/tools/perf/tests/attr/test-record-group-sampling
> > +++ b/tools/perf/tests/attr/test-record-group-sampling
> > @@ -7,7 +7,7 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=343
> > -read_format=12
> > +read_format=28
> >  inherit=0
> >
> >  [event-2:base-record]
> > @@ -21,8 +21,8 @@ config=3
> >  # default | PERF_SAMPLE_READ
> >  sample_type=343
> >
> > -# PERF_FORMAT_ID | PERF_FORMAT_GROUP
> > -read_format=12
> > +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
> > +read_format=28
> >  task=0
> >  mmap=0
> >  comm=0
> > diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
> > index 3ffe246e0228..53e1ba38febc 100644
> > --- a/tools/perf/tests/attr/test-record-group1
> > +++ b/tools/perf/tests/attr/test-record-group1
> > @@ -7,7 +7,7 @@ ret     = 1
> >  fd=1
> >  group_fd=-1
> >  sample_type=327
> > -read_format=4
> > +read_format=20
> >
> >  [event-2:base-record]
> >  fd=2
> > @@ -15,7 +15,7 @@ group_fd=1
> >  type=0
> >  config=1
> >  sample_type=327
> > -read_format=4
> > +read_format=20
> >  mmap=0
> >  comm=0
> >  task=0
> > diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
> > index 6b9f8d182ce1..ca21b5ce71aa 100644
> > --- a/tools/perf/tests/attr/test-record-group2
> > +++ b/tools/perf/tests/attr/test-record-group2
> > @@ -9,7 +9,7 @@ group_fd=-1
> >  config=0|1
> >  sample_period=1234000
> >  sample_type=87
> > -read_format=12
> > +read_format=28
> >  inherit=0
> >  freq=0
> >
> > @@ -19,7 +19,7 @@ group_fd=1
> >  config=0|1
> >  sample_period=6789000
> >  sample_type=87
> > -read_format=12
> > +read_format=28
> >  disabled=0
> >  inherit=0
> >  mmap=0
