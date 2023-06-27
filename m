Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9E73FFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjF0PgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjF0Pf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:35:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7EE2D73;
        Tue, 27 Jun 2023 08:35:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bd77424c886so4987467276.0;
        Tue, 27 Jun 2023 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687880156; x=1690472156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t34dMh1LA/z2OKAJ4jAEU30sT39Ov42eZVuKu2QRsXc=;
        b=S+67Q0u8wsg3If6D4hJuslAKZBSdftW/X7Z9Lhs5DwloQrx3Y3V/Ot2iGYMNWxrTli
         CgA9fAu+7JuY74dZkw0uSny8SRyv1lycWzajbFsJxsZy3dkgGM0yqaMsHeTUSXd46ZLa
         jdsKzIffZrEsyFltQW7l3d5Rpel9lNxhJxgs0WttAlAD5o+IDA2POcsMhzuI7aKPr3Xl
         gpw/WBfoTDzq648VM5WmvamopgUpNEgK+FmLqAddQgR5TUFGRw9FgUSypwSq3R0o2p7V
         QmSM6jHUKUemiU1DmkkIXpfYsubczgXudLAW97TqhdMNUBqJJMFCH5JOPxdkP4nTniUq
         WsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687880156; x=1690472156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t34dMh1LA/z2OKAJ4jAEU30sT39Ov42eZVuKu2QRsXc=;
        b=JxmRjYdyyxL4Iuv+XoJ3CjYEd2TtR2nYTvxMccN4/OjbcA0WKoL/hsbsHD9Hk4T7+z
         DXFvcNRWRBtIOJaRbgpS6iQCVxjmZCz3ERDlOzQSAhWuNa0U8F/3rIlxZwrjQDM3Gp0k
         gPR+uN/Y9xC7wXHl4z+GWgFPncBKv1j6/cNrYcoY0I88zfaPlHc+d1xmwJt9jindHSoj
         36fvLUCHYL1MHdFi6+aYu5i4ASpqQb6fd+08/2EKlMVZv6tlxs+Nywdg84utMhXl90Lz
         0R24vbsMddwInZx/NdUMp/3yRiRhvsvE8E2loinOpxU/TsB4qtLEieGeCGTeEmrdg0th
         Yn8g==
X-Gm-Message-State: AC+VfDyNQGSRcJTEf0y7fc7wBm03hZMnFVCU53mGEBbvXFnkUCc5Sm4I
        O+1Elwz9Ka03yRnAgj7QOjMcq8mWHvueTTLwH5Q=
X-Google-Smtp-Source: ACHHUZ6SEN56fCOhEJtNpJlypow/HFGRuO5Q0veZ7YY+Ggdc+XjZp36+8hCy7Te++rx9lAuzJUgUrKeDS/Kau4IehjY=
X-Received: by 2002:a25:492:0:b0:c11:8be2:ff4 with SMTP id 140-20020a250492000000b00c118be20ff4mr10793243ybe.4.1687880156456;
 Tue, 27 Jun 2023 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230627092633.2135105-1-tmricht@linux.ibm.com>
In-Reply-To: <20230627092633.2135105-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 27 Jun 2023 08:35:44 -0700
Message-ID: <CAM9d7cjmmx2GQ7QQj3wBe1KkqgVNzoYbMuLeasVUWuZeLWUE9A@mail.gmail.com>
Subject: Re: [PATCH] perf/test: perf test case Daemon operations dumps core
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, hca@linux.ibm.com,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 27, 2023 at 2:39=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The perf test case Daemon operations dumps core all the time.
> I narrowed it down to this invocation:

Jiri sent the same fix already.  I'll add your Reported-by, ok?

https://lore.kernel.org/all/20230626201606.2514679-1-jolsa@kernel.org/

Thanks,
Namhyung


>
> Segmentation fault (core dumped)
> ....
> (gdb) where
>     at builtin-daemon.c:1527
>     argv=3D0x3ffe66f9630) at perf.c:323
>     at perf.c:377
>     at perf.c:421
> (gdb)
>
> Normally this goes unnoticed, the core dumps are only shown in
> verbose mode and when core dump generation is enabled on fedora 38:
>
>  # ./perf test daemon
>  80: daemon operations                   : Ok
>  # ll core*
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4586
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4688
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4812
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4857
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4893
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4933
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4947
> -rw------- 1 root root 3551232 Jun 27 10:08 core.4949
>  # ./perf test -v daemon
>  80: daemon operations                  :
> --- start ---
> test child forked, pid 4974
> test daemon list
> ./tests/shell/daemon.sh: line 133:  4980 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> test daemon reconfig
> ./tests/shell/daemon.sh: line 133:  5082 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> test daemon stop
> ./tests/shell/daemon.sh: line 133:  5206 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> test daemon signal
> ./tests/shell/daemon.sh: line 133:  5250 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> signal 12 sent to session 'test [5252]'
> signal 12 sent to session 'test [5252]'
> test daemon ping
> ./tests/shell/daemon.sh: line 133:  5286 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> test daemon lock
> ./tests/shell/daemon.sh: line 133:  5326 Segmentation fault \
>                 (core dumped) perf daemon start --config ${config}
> test child finished with 0
> ---- end ----
> daemon operations: Ok
>  # ll core*|wc -l
> 16
>  #
>
> The root cause is in function cmd_daemon():
>
>     argc =3D parse_options(argc, argv, daemon_options, daemon_usage,
>                          PARSE_OPT_STOP_AT_NON_OPTION);
>
>     if (argc) {
>         if (!strcmp(argv[0], "start"))
>                 ret =3D __cmd_start(&__daemon, daemon_options, argc,
>                                   argv);
>         if (!strcmp(argv[0], "signal"))
>                     ^^^^^^^
> Parameter argv[0] is set to NULL in function __cmd_start() and the
> next strcmp() accesses a NULL pointer.
>
> Output after:
>
>  # ./perf daemon start --config /tmp/perf-daemon-config
>  #
>  # ./perf test -v daemon
>  80: daemon operations                                               :
> --- start ---
> test child forked, pid 6517
> test daemon list
> test daemon reconfig
> test daemon stop
> test daemon signal
> signal 12 sent to session 'test [6780]'
> signal 12 sent to session 'test [6780]'
> test daemon ping
> test daemon lock
> test child finished with 0
> ---- end ----
> daemon operations: Ok
>  #
>
> Fixes: 92294b906e6c ("perf daemon: Dynamically allocate path to perf")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
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
>                         ret =3D __cmd_start(&__daemon, daemon_options, ar=
gc, argv);
> -               if (!strcmp(argv[0], "signal"))
> +               else if (!strcmp(argv[0], "signal"))
>                         ret =3D __cmd_signal(&__daemon, daemon_options, a=
rgc, argv);
>                 else if (!strcmp(argv[0], "stop"))
>                         ret =3D __cmd_stop(&__daemon, daemon_options, arg=
c, argv);
> --
> 2.41.0
>
