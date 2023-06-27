Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546D373F77E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjF0Igb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF0IgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:36:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE5E6F;
        Tue, 27 Jun 2023 01:35:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso18042585e9.1;
        Tue, 27 Jun 2023 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687854939; x=1690446939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j5dQeYHYKYlJGoRN0EElGK6VPybOH+UnW7mCvvK0jmI=;
        b=bMdPxlNve1ptwbBvvg3YZSu7PK70OsE4K3JS3uD/L+E9SjPnZbWxWyEcUupbNIFjbF
         CGMLLfuGZV7S5bP7oRgxd1dUTFUmM2CIlm30RSqDXJ43NOx/VIZN6VDJpi7wM0Br6xas
         Hvk1dAyK98XbcVJ4I816D+gVz5/43og1o8p+BCgH2ZzRqjXBnmz99VHYm9jmHFWoNolJ
         Xy+Eqv+qLDw6Fuz/BIm3S6mQ1LBVeTuZ97N3wRWnQYURYITefb0U4UrQ6uNx6TXzXvlD
         oHxGu3Mz1paoaqJDd7ufeU/bQ0IfqOoWZe3+V/MYlVsNKsvF87QA4TnSWv6EGmjsbzvo
         Lwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854939; x=1690446939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5dQeYHYKYlJGoRN0EElGK6VPybOH+UnW7mCvvK0jmI=;
        b=Fa6YRNlnLur2q21Q5l+Sk1mqcAxQHkikGGITQENF6wrumcZwnX3GJlagPMJMRgUCta
         LkSIOq0W6A3TIfoKhq4srJY0M1uuqT1Q03EEVZ01KomWMsH6Qa4TaRowcXsiL8HRrA/C
         SzxWAOSs0Zx178xJcD/YdnEpuCZwaapZ/w1dwMRqN2V+YixLuK9IDc+txj6DJAorKK56
         GI+naoa1U7XSnA259xVHnJn+E7eD8m3c09aOPEF64Pvfgtfq5hujDjYb7Ap1MBdOMeCm
         YWFGn6L2Te+j1EatpOKhstonfPspzpNHlfXG2vbE7Qsu4uwLsHz2usTIyRSeJWUTM33m
         9vaQ==
X-Gm-Message-State: AC+VfDxFMqbS+VCx6q/WTwBiQzvdjyEMLWnzLuckfpIKapAWrFgrc+2L
        0qGvEsmCU8R9w7y6nWrt4t0=
X-Google-Smtp-Source: ACHHUZ6lMfDIQEfRLBxoYy6NK8cy1ffoV03IuwFDgbqQ1Lmh8SDB7VL77m97d9KgkHl3HSWa0jjOow==
X-Received: by 2002:a05:600c:511f:b0:3fa:9996:8e03 with SMTP id o31-20020a05600c511f00b003fa99968e03mr4416331wms.10.1687854938850;
        Tue, 27 Jun 2023 01:35:38 -0700 (PDT)
Received: from krava (85-160-25-217.reb.o2.cz. [85.160.25.217])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b00313eeca9f4asm6184873wrt.14.2023.06.27.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:35:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 27 Jun 2023 10:35:28 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing else to cmd_daemon subcommand
 condition
Message-ID: <ZJqfUL1gnkTbUx5n@krava>
References: <20230626201606.2514679-1-jolsa@kernel.org>
 <CAM9d7chMGzEJ3GKyxXD-RwUpjje7u3Cp810TRD+ZGgCT+mFrEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chMGzEJ3GKyxXD-RwUpjje7u3Cp810TRD+ZGgCT+mFrEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:58:48PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Mon, Jun 26, 2023 at 1:16 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Namhyung reported segfault in perf daemon start command.
> >
> > It's caused by extra check on argv[0] which is set to NULL by previous
> > __cmd_start call. Adding missing else to skip the extra check.
> >
> > Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")
> > Reported-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks for the fix.  Now it runs ok.
> 
> Before:
>   $ sudo ./perf test -v daemon
>    85: daemon operations                                               :
>   --- start ---
>   test child forked, pid 82420
>   test daemon list
>   ./tests/shell/daemon.sh: line 133: 82426 Segmentation fault
> perf daemon start --config ${config}
>   test daemon reconfig
>   ./tests/shell/daemon.sh: line 133: 82520 Segmentation fault
> perf daemon start --config ${config}
>   test daemon stop
>   ./tests/shell/daemon.sh: line 133: 82636 Segmentation fault
> perf daemon start --config ${config}
>   test daemon signal
>   ./tests/shell/daemon.sh: line 133: 82674 Segmentation fault
> perf daemon start --config ${config}
>   signal 12 sent to session 'test [82676]'
>   signal 12 sent to session 'test [82676]'
>   test daemon ping
>   ./tests/shell/daemon.sh: line 133: 82702 Segmentation fault
> perf daemon start --config ${config}
>   test daemon lock
>   ./tests/shell/daemon.sh: line 133: 82734 Segmentation fault
> perf daemon start --config ${config}
>   test child finished with 0
>   ---- end ----
>   daemon operations: Ok
> 
> Maybe we need to investigate more why it was ok..
> But at least I don't see segfaults anymore

yea, for some reason parse_options would put NULL into argv[0]

I'll try to check what changed, in any case the fix makes the
condition alligned with the other legs and fixes the segfault

jirka

> 
> 
> After:
>    85: daemon operations                                               :
>   --- start ---
>   test child forked, pid 80752
>   test daemon list
>   test daemon reconfig
>   test daemon stop
>   test daemon signal
>   signal 12 sent to session 'test [81022]'
>   signal 12 sent to session 'test [81022]'
>   test daemon ping
>   test daemon lock
>   test child finished with 0
>   ---- end ----
>   daemon operations: Ok
> 
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> 
> 
> > ---
> >  tools/perf/builtin-daemon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index f5674d824a40..83954af36753 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -1524,7 +1524,7 @@ int cmd_daemon(int argc, const char **argv)
> >         if (argc) {
> >                 if (!strcmp(argv[0], "start"))
> >                         ret = __cmd_start(&__daemon, daemon_options, argc, argv);
> > -               if (!strcmp(argv[0], "signal"))
> > +               else if (!strcmp(argv[0], "signal"))
> >                         ret = __cmd_signal(&__daemon, daemon_options, argc, argv);
> >                 else if (!strcmp(argv[0], "stop"))
> >                         ret = __cmd_stop(&__daemon, daemon_options, argc, argv);
> > --
> > 2.41.0
> >
