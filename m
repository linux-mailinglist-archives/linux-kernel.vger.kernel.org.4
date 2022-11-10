Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC647624897
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiKJRtN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Nov 2022 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiKJRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:49:09 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC13C6F9;
        Thu, 10 Nov 2022 09:49:06 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso2949558fac.4;
        Thu, 10 Nov 2022 09:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BPitkaKxysoCSgbSYwvcxMKhFyQVdjW3IRaxfxad28=;
        b=j4XZSOf3MAt3ZpOtHR7MQMbvd1F3pmmgWzdeVprt5BGDnhHQWoeFu/q7xf1Eww17G5
         6AcYjpOYF6Y6FKKbaepnlnjctcdQQLDvzSCH7y2jmOLCo7OgewUZ1vTqoATwiv35Estw
         dln4bgJgRF+1t/L0oq9i2MrpXgYg7QnS7amu9i5zLfHX4WsNBJW/Bhp4Wv2+sZfG2rU1
         3JdmhwBxarBNnOfNvTnmivxF+6+VZYbH7CHbxG3riOp7CX1W1NrwS+e1xAA/9ioSKIrC
         IGrlGuO85F2JNRIFqiRoiEFR7YQBJleoo7Me8vK/qCE7ou1+qWyHW/t5GLnITcXmqH1c
         GuMg==
X-Gm-Message-State: ACrzQf1kp12roxdbEAMe+N0KxV/C25rE9YW1J54RuC1OQR5vNZTGHGpI
        u8Beu+F7ssAxWSq61x3v5SSJEbIwxeWccmgMr2o=
X-Google-Smtp-Source: AMsMyM78WJTlTCqB+Gx2FgBb15rnupyBB8OaCnp82aHgbPAoJ3JLzzXrEu9dqXb/+jGTQAlp70yjRBXs7tVKaDqnZtc=
X-Received: by 2002:a05:6870:b6a8:b0:13c:8991:2ac7 with SMTP id
 cy40-20020a056870b6a800b0013c89912ac7mr1746572oab.209.1668102546029; Thu, 10
 Nov 2022 09:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20221109174635.859406-1-namhyung@kernel.org> <20221109174635.859406-8-namhyung@kernel.org>
 <3be361f6-dd50-8998-872e-27bbf9f02017@arm.com>
In-Reply-To: <3be361f6-dd50-8998-872e-27bbf9f02017@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Nov 2022 09:48:54 -0800
Message-ID: <CAM9d7chY3v+KjaSXh34enE=sdAtAqPBQtW=EqYLU6RHQMMXPSg@mail.gmail.com>
Subject: Re: [PATCH 07/12] perf test: Add 'sqrtloop' test workload
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 10, 2022 at 6:49 AM German Gomez <german.gomez@arm.com> wrote:
>
> On 09/11/2022 17:46, Namhyung Kim wrote:
> > The sqrtloop creates a child process to run an infinite loop calling
> > sqrt() with rand().  This is needed for ARM SPE fork test.
> >
> >   $ perf test -w sqrtloop
> >
> > It can take an optional argument to specify how long it will run in
> > seconds (default: 1).
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/builtin-test.c       |  1 +
> >  tools/perf/tests/tests.h              |  1 +
> >  tools/perf/tests/workloads/Build      |  1 +
> >  tools/perf/tests/workloads/sqrtloop.c | 44 +++++++++++++++++++++++++++
> >  4 files changed, 47 insertions(+)
> >  create mode 100644 tools/perf/tests/workloads/sqrtloop.c
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 0ed5ac452f6e..9acb7a93eeb9 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -122,6 +122,7 @@ static struct test_workload *workloads[] = {
> >       &workload__noploop,
> >       &workload__thloop,
> >       &workload__leafloop,
> > +     &workload__sqrtloop,
> >  };
> >
> >  static int num_subtests(const struct test_suite *t)
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 86804dd6452b..18c40319e67c 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -203,5 +203,6 @@ struct test_workload workload__##work = { \
> >  DECLARE_WORKLOAD(noploop);
> >  DECLARE_WORKLOAD(thloop);
> >  DECLARE_WORKLOAD(leafloop);
> > +DECLARE_WORKLOAD(sqrtloop);
> >
> >  #endif /* TESTS_H */
> > diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> > index 631596bdb2b3..1ca95cb0fdb5 100644
> > --- a/tools/perf/tests/workloads/Build
> > +++ b/tools/perf/tests/workloads/Build
> > @@ -3,5 +3,6 @@
> >  perf-y += noploop.o
> >  perf-y += thloop.o
> >  perf-y += leafloop.o
> > +perf-y += sqrtloop.o
> >
> >  CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer
> > diff --git a/tools/perf/tests/workloads/sqrtloop.c b/tools/perf/tests/workloads/sqrtloop.c
> > new file mode 100644
> > index 000000000000..f7d1f8d4867b
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/sqrtloop.c
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <math.h>
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <linux/compiler.h>
> > +#include <sys/wait.h>
> > +#include "../tests.h"
> > +
> > +static volatile int done;
> > +
> > +static void sighandler(int sig __maybe_unused)
> > +{
> > +     done = 1;
> > +}
> > +
> > +static int __sqrtloop(int sec)
> > +{
> > +     signal(SIGALRM, sighandler);
> > +     alarm(sec);
> > +
> > +     while (!done)
> > +             sqrt(rand());
> > +     return 0;
> > +}
>
> I get some implicit declaration errors on x86 build
>
> (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0)
>
> .  CC      tests/workloads/sqrtloop.o
> .tests/workloads/sqrtloop.c: In function ‘__sqrtloop’:
> .tests/workloads/sqrtloop.c:19:2: error: implicit declaration of function ‘alarm’ [-Werror=implicit-function-declaration]
> .   19 |  alarm(sec);
> .      |  ^~~~~
> .tests/workloads/sqrtloop.c: In function ‘sqrtloop’:
> .tests/workloads/sqrtloop.c:33:10: error: implicit declaration of function ‘fork’ [-Werror=implicit-function-declaration]
> .   33 |  switch (fork()) {
> .      |          ^~~~

Oh, thanks for letting me know.  I think it needs <unitstd.h>.
Will fix in v2.

Thanks,
Namhyung

>
> > +
> > +static int sqrtloop(int argc, const char **argv)
> > +{
> > +     int sec = 1;
> > +
> > +     if (argc > 0)
> > +             sec = atoi(argv[0]);
> > +
> > +     switch (fork()) {
> > +     case 0:
> > +             return __sqrtloop(sec);
> > +     case -1:
> > +             return -1;
> > +     default:
> > +             wait(NULL);
> > +     }
> > +     return 0;
> > +}
> > +
> > +DEFINE_WORKLOAD(sqrtloop);
