Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577973EC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZU7D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:59:01 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D8125;
        Mon, 26 Jun 2023 13:59:00 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7835bad99fbso51939839f.1;
        Mon, 26 Jun 2023 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813140; x=1690405140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8/FilnxQYWJtSiiMwZyoDzlxp4aKzL1HmrYGLutaDA=;
        b=I/FC7e6oYfoh5WYlgLsSpwjy5JlnkQYYgSXieDjc5ZmPi0qTwpgieg3Zm7ugLK1P5g
         Jf9po23SZ1ahikTAgW9wNmsr6tXR/8LQzYNNLKx6dchr1RUCzdWoXFdSA1hJSGxzhIgg
         Il9LNynVx4d5zghKdo8hMP13bxQQ1SKocVOKSMXyysUhYa8amhatR5J/JRV8s22A3M8V
         PAKrSzsUbE6qjDSCL77s2IVqBtSE3c7fbu0CQtmranJS9fsZXt3tIRW68NK4DB38myQW
         W60uUF584oz6WzD3Y2mwcjhJ6K4VSK8xq+5uS2yznGHlxDxNUYqF7ROkQ8k7xmsQrixS
         u2Pw==
X-Gm-Message-State: AC+VfDzSSwZH9WP6Ute7h/4ESWHxUTGZU3ZzneiXfgx8HLgGtP7lzrnr
        pfO2fnP3pc+Qkv1ZYO+nFMnsMrqE7pAOILnbFm0=
X-Google-Smtp-Source: ACHHUZ6kMJi3Eve8QpoIfyr1Bt9ZaZLbIFTqpFwimUl7nrLbeOJZFMknBrYDrzpFpMryPyVUsj5dA82W6H8S2oKbqkU=
X-Received: by 2002:a6b:ea03:0:b0:783:5511:7b27 with SMTP id
 m3-20020a6bea03000000b0078355117b27mr3980870ioc.9.1687813139837; Mon, 26 Jun
 2023 13:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201606.2514679-1-jolsa@kernel.org>
In-Reply-To: <20230626201606.2514679-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 13:58:48 -0700
Message-ID: <CAM9d7chMGzEJ3GKyxXD-RwUpjje7u3Cp810TRD+ZGgCT+mFrEQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add missing else to cmd_daemon subcommand condition
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
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

Hi Jiri,

On Mon, Jun 26, 2023 at 1:16 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Namhyung reported segfault in perf daemon start command.
>
> It's caused by extra check on argv[0] which is set to NULL by previous
> __cmd_start call. Adding missing else to skip the extra check.
>
> Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix.  Now it runs ok.

Before:
  $ sudo ./perf test -v daemon
   85: daemon operations                                               :
  --- start ---
  test child forked, pid 82420
  test daemon list
  ./tests/shell/daemon.sh: line 133: 82426 Segmentation fault
perf daemon start --config ${config}
  test daemon reconfig
  ./tests/shell/daemon.sh: line 133: 82520 Segmentation fault
perf daemon start --config ${config}
  test daemon stop
  ./tests/shell/daemon.sh: line 133: 82636 Segmentation fault
perf daemon start --config ${config}
  test daemon signal
  ./tests/shell/daemon.sh: line 133: 82674 Segmentation fault
perf daemon start --config ${config}
  signal 12 sent to session 'test [82676]'
  signal 12 sent to session 'test [82676]'
  test daemon ping
  ./tests/shell/daemon.sh: line 133: 82702 Segmentation fault
perf daemon start --config ${config}
  test daemon lock
  ./tests/shell/daemon.sh: line 133: 82734 Segmentation fault
perf daemon start --config ${config}
  test child finished with 0
  ---- end ----
  daemon operations: Ok

Maybe we need to investigate more why it was ok..
But at least I don't see segfaults anymore


After:
   85: daemon operations                                               :
  --- start ---
  test child forked, pid 80752
  test daemon list
  test daemon reconfig
  test daemon stop
  test daemon signal
  signal 12 sent to session 'test [81022]'
  signal 12 sent to session 'test [81022]'
  test daemon ping
  test daemon lock
  test child finished with 0
  ---- end ----
  daemon operations: Ok


Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung



> ---
>  tools/perf/builtin-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index f5674d824a40..83954af36753 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1524,7 +1524,7 @@ int cmd_daemon(int argc, const char **argv)
>         if (argc) {
>                 if (!strcmp(argv[0], "start"))
>                         ret = __cmd_start(&__daemon, daemon_options, argc, argv);
> -               if (!strcmp(argv[0], "signal"))
> +               else if (!strcmp(argv[0], "signal"))
>                         ret = __cmd_signal(&__daemon, daemon_options, argc, argv);
>                 else if (!strcmp(argv[0], "stop"))
>                         ret = __cmd_stop(&__daemon, daemon_options, argc, argv);
> --
> 2.41.0
>
