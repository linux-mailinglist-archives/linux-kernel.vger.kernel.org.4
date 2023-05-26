Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E34711E15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjEZClL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:41:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52517E6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:41:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so19755e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685068866; x=1687660866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUzk7xsdgJU7M6GKVkRONbmBW/W1VsolmG1MhtnbW4k=;
        b=dewv9/nOBEAzMMod+HXOrJ8nBG3gmuVk08ABPHupoSdpSx+7jxn5yueVp3w2S3nQR5
         dVwzByUhHIuOJwycmURLANkZpcqXcccLLvNNFiWCeYTktW72fiRXLExhXMq3Tg0gdLqQ
         xqL+o3eBlXJjpy3ija2AJz09T0JXh6eMj+bLhfyWcE7+QhSZo+nxPSmLumbyMBvvyKYI
         h0f28YcmKLp0GCEMCVKWRmn8ioJG8Bh4l5OGA8k3U3obCQdTmz6MFaV56wXuLV0CJU+P
         kO/D0B9dSVRI7EXyi7s0TCWI1DFHS5yo/ge6o3eKNtIugLRDv9KId1tdAjQO3nu7wmoB
         z58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068866; x=1687660866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUzk7xsdgJU7M6GKVkRONbmBW/W1VsolmG1MhtnbW4k=;
        b=CJbrC2+PGIDgIYGbaDq34j3OVILQJ8CAPKsywOkxy/OtTEgQSIhz/rlfHqHM9Xhye2
         9R55EnL9hM747LL0HnrTxAdFCb0zVivP+tgSfb3ufmv890RSBgP2UHh+GXhheX/Fhi7g
         MCafVvNL1Xn8epGo/F899xMrrzBhsKgk5vGkRSsPQrqsRe5eYX37C96ELTdriHtymJRp
         uaLDHhV7gx1XZcXb0aGwuawY5g4Wr51jXMG03ef1p8Cx/ykF/+ef7ieK2l4bqI22Rg2t
         NwbaSEegfbznGYDsAfo1WOnRUGk9yj4nbXv4JJFo5jvODLfoXCbimQRbZUNxqqPIffPM
         y1jQ==
X-Gm-Message-State: AC+VfDwUMsi38rkQfpziiLrsFWmUfz69QWT3kfx7tTgS8erhkbSTuojC
        MULP8xN83JJcoqu/+4/xlRn4/5UCXaAkUIBKhAVtFQ==
X-Google-Smtp-Source: ACHHUZ4QzeNdp7xwQYla9g2PgfBIKJhYYQ7jBl6vEfMdWSyheJWdeijLtuAek583y0Or3Q2gs+Jn36lvshbq/hm7nHU=
X-Received: by 2002:a05:600c:4711:b0:3f5:f63:d490 with SMTP id
 v17-20020a05600c471100b003f50f63d490mr2819wmo.5.1685068865714; Thu, 25 May
 2023 19:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com> <20230525071133.2066610-9-irogers@google.com>
 <CAM9d7ci5XB7-PdcXchWW7bBFO_64B0M76rpY8xgkBYr3-mGW0Q@mail.gmail.com>
In-Reply-To: <CAM9d7ci5XB7-PdcXchWW7bBFO_64B0M76rpY8xgkBYr3-mGW0Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 25 May 2023 19:40:53 -0700
Message-ID: <CAP-5=fX7_sFV=xGoefpLm_kRMSos7Ec5Df0WwL-k8x6Z4ZKjeg@mail.gmail.com>
Subject: Re: [PATCH v1 08/16] perf daemon: Dynamically allocate path to perf
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, May 25, 2023 at 12:12=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Avoid a PATH_MAX array in __daemon (the .data section) by dynamically
> > allocating the memory.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-daemon.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index 34cbe3e959aa..adb5751c3ed0 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -90,7 +90,7 @@ struct daemon {
> >         char                    *base;
> >         struct list_head         sessions;
> >         FILE                    *out;
> > -       char                     perf[PATH_MAX];
> > +       char                    *perf;
> >         int                      signal_fd;
> >         time_t                   start;
> >  };
> > @@ -1490,6 +1490,15 @@ static int __cmd_ping(struct daemon *daemon, str=
uct option parent_options[],
> >         return send_cmd(daemon, &cmd);
> >  }
> >
> > +static char *set_perf_exe(void)
> > +{
> > +       char path[PATH_MAX];
> > +
> > +       perf_exe(path, sizeof(path));
> > +       __daemon.perf =3D strdup(path);
> > +       return __daemon.perf;
>
> Then you need to free it somewhere.

For leak sanitizer, if an allocation is reachable from a global then
it isn't considered a leak. I'll address this in v2.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +}
> > +
> >  int cmd_daemon(int argc, const char **argv)
> >  {
> >         struct option daemon_options[] =3D {
> > @@ -1503,7 +1512,9 @@ int cmd_daemon(int argc, const char **argv)
> >                 OPT_END()
> >         };
> >
> > -       perf_exe(__daemon.perf, sizeof(__daemon.perf));
> > +       if (!set_perf_exe())
> > +               return -ENOMEM;
> > +
> >         __daemon.out =3D stdout;
> >
> >         argc =3D parse_options(argc, argv, daemon_options, daemon_usage=
,
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
