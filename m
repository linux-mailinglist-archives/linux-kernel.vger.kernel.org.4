Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E15FC979
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:50:51 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDC1E0729;
        Wed, 12 Oct 2022 09:50:51 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id u15so13785853oie.2;
        Wed, 12 Oct 2022 09:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX/yDHI2t8BZ8sa9ntdOr+opFKUj/EAzNNBtl+0IS8I=;
        b=JVV+tQguH+IkRIEWjF21cRDIXLlaWgIrBy+J/7V0sLxmQJWbQI8hrDPDrwm2VUk8/d
         9eCuLBtJa6APmx2jXRWBjt1OAkC5ui9i/KPa3IY7PtV5MMPzyK+Ds1YJaDM+yCjOD4K8
         kmB4KtiKPXcYrFr0ga7RhekmhnP1QZ86AZGRtBAt91ySOK9ZFHbYCrbp48gXkCmKvD/+
         xg2JqtN7jJ04nhtPyMOY4Sj1SZR24nNfGNO9ff2bZk7U+Y3cac/K9oZ8dsqQtKOcIT5T
         qovBJaZLzb/1vecPK8GNOkCDCaQw/CMtST/PPgySzidtNUVD0IFrLFC855Z2PwmoG64j
         55GA==
X-Gm-Message-State: ACrzQf1Vie2SqgFd8uIaxqHJq6XcYJ5OUSXG2Wml/fDTrgfnRSOvv8A6
        ICA1VKXR+/aryOX2bL4moikhdgitPMz6IrSE/f4=
X-Google-Smtp-Source: AMsMyM4Ed55O7R+zVeMDuX9LBhttUQpOUu/8L1WD22llWi91ywjl60DudUQihwDxHN5dJ8yPHTcC9Bd62c3LV6d/q1o=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr2464453oib.209.1665593450439; Wed, 12
 Oct 2022 09:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221012111025.30609-1-james.clark@arm.com> <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
In-Reply-To: <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:50:39 -0700
Message-ID: <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 12/10/2022 12:10, James Clark wrote:
> > Especially when CONFIG_LOCKDEP and other debug configs are enabled,
> > Perf can print the following warning when running the "Track with
> > sched_switch" test:
>
> Oops got the wrong test name here and in the title. Should be "kernel
> lock contention analysis test"

Could you please resend?

>
> >
> >   Warning:
> >   Processed 1378918 events and lost 4 chunks!
> >
> >   Check IO/CPU overload!
> >
> >   Warning:
> >   Processed 4593325 samples and lost 70.00%!
> >
> > The test already supplies -q to run in quiet mode, so extend quiet mode
> > to perf_stdio__warning() and also ui__warning() for consistency.

I'm not sure if suppressing the warnings with -q is a good thing.
Maybe we need to separate warning/debug messages from the output.

Thanks,
Namhyung


> >
> > This fixes the following failure due to the extra lines counted:
> >
> >   perf test "lock cont" -vvv
> >
> >   82: kernel lock contention analysis test                            :
> >   --- start ---
> >   test child forked, pid 3125
> >   Testing perf lock record and perf lock contention
> >   [Fail] Recorded result count is not 1: 9
> >   test child finished with -1
> >   ---- end ----
> >   kernel lock contention analysis test: FAILED!
> >
> > Fixes: ec685de25b67 ("perf test: Add kernel lock contention test")
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/ui/util.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
> > index 689b27c34246..1d38ddf01b60 100644
> > --- a/tools/perf/ui/util.c
> > +++ b/tools/perf/ui/util.c
> > @@ -15,6 +15,9 @@ static int perf_stdio__error(const char *format, va_list args)
> >
> >  static int perf_stdio__warning(const char *format, va_list args)
> >  {
> > +     if (quiet)
> > +             return 0;
> > +
> >       fprintf(stderr, "Warning:\n");
> >       vfprintf(stderr, format, args);
> >       return 0;
> > @@ -45,6 +48,8 @@ int ui__warning(const char *format, ...)
> >  {
> >       int ret;
> >       va_list args;
> > +     if (quiet)
> > +             return 0;
> >
> >       va_start(args, format);
> >       ret = perf_eops->warning(format, args);
