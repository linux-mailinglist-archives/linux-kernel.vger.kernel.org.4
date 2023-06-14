Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB873061E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjFNRhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:37:00 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB6ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:36:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9a81da5d7so16511cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686764219; x=1689356219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EljyySPJN/DBQ8Xy5B6EfkCPm3Xjn/z4XXSJw0Skw10=;
        b=B+iGVkxNGASP+ybziEfosMBaGFc9ZUFAwWx20Q2Kxgjz3gVBkuddF9lJnNQDDQu5/Z
         ClTzTWiftydz2soapXU2EiIrtsvzmxpbUqsvJrSn2Ya/g/4Nmjaj6BzVIgy1hpzyYW9m
         5JRGYyJq3PZ0cj7188D5pK4w01Dsw5xZUqDYMDG4O3Zl3ZttBbUyP8jCUq0eRfO7iZ0R
         bK0U2HTi4WYXh11cc2hX5VX5p1AnFMb6Ycx1vINPTmJOOrjPcEimuj1Yzb+GCB/+INjg
         5DeVjSJUw2sEnEFUQT83vtXDVn7LOWckuw/CjRE1ParpFE29dWYLKpex58C3eYsBBiu4
         z4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764219; x=1689356219;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EljyySPJN/DBQ8Xy5B6EfkCPm3Xjn/z4XXSJw0Skw10=;
        b=c0bnidxKuQDckKJRKjHjQIq3Zs6KRqe6RDD2bNWoKClL45f42r0F9869tHkoE3oabB
         h+/KRmu7mF8hYM21N+vG2a8mfVYYJxNpyKSL2XBD5dIHZMNDHTPlIyA/0Sa4pccCHfOn
         p+ZNi+BtQQ9gIQoUp+KhtPXySlecXHy3bzf/dX60pmWRLmZaqW7u/KFOPgiR6eekD48K
         gKgBKIoILChbH0SS/zZR0ajvfhMyhMkg3S7bPexulTi3AQ2bkyy55luTKL8Zk2IUQxGB
         Ak2akMyzS9HKUigDWK4+QUpjXeHxSfl9VMgMP1C6wkl3pXNO7bCh4Wh5ZFyJ/h03Tdp2
         6y1A==
X-Gm-Message-State: AC+VfDxoJnQbOJBF0wtYROw2V8QsiNd3pBroCkvASM18g814urBQC/9i
        xj9V+nAQqcd5gkm81x31RldUqKpDSkj/NYl6HKKt6Q==
X-Google-Smtp-Source: ACHHUZ7wE2k19SrUhc7gV+jBBssbQRnmtml/5ZhqHEk87Z3CiBYgVCDQvZ0Mu3CifQp0jQZvSGP9xlq91FFqzRtbKmU=
X-Received: by 2002:ac8:5b01:0:b0:3ef:2f55:2204 with SMTP id
 m1-20020ac85b01000000b003ef2f552204mr8923qtw.6.1686764218769; Wed, 14 Jun
 2023 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230608061812.3715566-1-irogers@google.com>
In-Reply-To: <20230608061812.3715566-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 10:36:47 -0700
Message-ID: <CAP-5=fX1X=A7gkExsV917EntTdfgytNA8LBvHwTCsXfq1zHixw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools api: Add simple timeout to io read
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
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

On Wed, Jun 7, 2023 at 11:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> In situations like reading from a pipe it can be useful to have a
> timeout so that the caller doesn't block indefinitely. Implement a
> simple one based on poll.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

There is overlap in what these patches aim to fix with the 2 submitted
patches making addr2line more robust:
https://lore.kernel.org/all/20230613034817.1356114-2-irogers@google.com/

I think it could be pragmatic to take both of them. Be robust but
timeout if addr2line doesn't respond for 1s. What do you think?

Thanks,
Ian

> ---
>  tools/lib/api/io.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index d5e8cf0dada0..9fc429d2852d 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -8,6 +8,7 @@
>  #define __API_IO__
>
>  #include <errno.h>
> +#include <poll.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> @@ -23,6 +24,8 @@ struct io {
>         char *end;
>         /* Currently accessed data pointer. */
>         char *data;
> +       /* Read timeout, 0 implies no timeout. */
> +       int timeout_ms;
>         /* Set true on when the end of file on read error. */
>         bool eof;
>  };
> @@ -35,6 +38,7 @@ static inline void io__init(struct io *io, int fd,
>         io->buf =3D buf;
>         io->end =3D buf;
>         io->data =3D buf;
> +       io->timeout_ms =3D 0;
>         io->eof =3D false;
>  }
>
> @@ -47,7 +51,29 @@ static inline int io__get_char(struct io *io)
>                 return -1;
>
>         if (ptr =3D=3D io->end) {
> -               ssize_t n =3D read(io->fd, io->buf, io->buf_len);
> +               ssize_t n;
> +
> +               if (io->timeout_ms !=3D 0) {
> +                       struct pollfd pfds[] =3D {
> +                               {
> +                                       .fd =3D io->fd,
> +                                       .events =3D POLLIN,
> +                               },
> +                       };
> +
> +                       n =3D poll(pfds, 1, io->timeout_ms);
> +                       if (n =3D=3D 0)
> +                               errno =3D ETIMEDOUT;
> +                       if (n > 0 && !(pfds[0].revents & POLLIN)) {
> +                               errno =3D EIO;
> +                               n =3D -1;
> +                       }
> +                       if (n <=3D 0) {
> +                               io->eof =3D true;
> +                               return -1;
> +                       }
> +               }
> +               n =3D read(io->fd, io->buf, io->buf_len);
>
>                 if (n <=3D 0) {
>                         io->eof =3D true;
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
