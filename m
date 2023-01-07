Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20F660EAF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAGMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:24:11 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4183760CE0;
        Sat,  7 Jan 2023 04:24:09 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so55626657b3.9;
        Sat, 07 Jan 2023 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjlh/y4ujWrlLj4f+D4wuvbyCFuV7BwnHdo20MJ4gnE=;
        b=LbS0b9zD5+ZsN/uxd7ehSsSqvJpNP7iADK/9yo6qGTPrCwoKuy0FqjYDDG9YTHS7yB
         dQA3PAsRow5BQBV6XqIJBIzMQPn9R/n6X2n4bq2gZYezB+KM1ooDPjYgmKET61QynJX7
         /J5b+15XUWLK6kqERVLhLD7y6GNnL3JsZ1Y5flvjzc2EjC9BwG9k/GN2bZ0JFfg0Y1lS
         hZrHOle9KZ8eui734mS/Dmt8mRvhagWmRNQFzLUI2toyOVeze6qJK7TqyOrohRjC31Is
         ZnyLjselJtIvQ4sWAE6PqkUTvjxwvsKCAgPSckoK67bDP7++V4XE4bdZPf+9+TJxPvgc
         4aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjlh/y4ujWrlLj4f+D4wuvbyCFuV7BwnHdo20MJ4gnE=;
        b=RD1jsU1w+cWDigpJf64g/Yow7Wf/bru4wNjQheXLEqQHh+D/22CWqGQP/8m3o0TeK6
         LgDSksUHdsVNL5/cc/MujgSSFeuBZhJrK+8jCxdFamKV99qZQCVRNkin+ez2Qm8QlpXf
         dldmDp6jGzQeJay76TgQ4ZL6DA/t43JiI1IJbeXo4aNmxmdMURhNGFQemK4QBo8/S1vP
         zaSkxFTatHdqB2HiCnA93ktZ52XfsvGpOxovvZ/9eVA5tSeZjO+Pcp8FXd3yoQ2DOCuy
         GvOCP/t3I//QALrkMI1wTF3e6qMo/80IIKDaqFBv/kU+lZnKPpgArxR1X2Yqg8rrSxjk
         ENZQ==
X-Gm-Message-State: AFqh2ko3d+iXxeSmoknrQGKYnxqTXjl9caqxAS3lFxHIJ8ah9IYV4laM
        8LvlS2uQ5vzqR6zY+/tA/vFS26qPvO1Tocz3DfvkxMWA5Rk=
X-Google-Smtp-Source: AMrXdXvj03+QNFlwghM7LrKQ08KhCNVoUEYXpOEhBslBtXf8OmWT+FXOZXf4h4w5+VEgNrvSc+cUiwVnKSlqqtMYIV8=
X-Received: by 2002:a0d:ea47:0:b0:47d:d0f4:3c92 with SMTP id
 t68-20020a0dea47000000b0047dd0f43c92mr4787543ywe.500.1673094248462; Sat, 07
 Jan 2023 04:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20230107034557.1156022-1-quanfafu@gmail.com> <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
In-Reply-To: <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
From:   Quanfa Fu <quanfafu@gmail.com>
Date:   Sat, 7 Jan 2023 20:23:57 +0800
Message-ID: <CAM4UoyqAGUbLaaoDyvFSTKvgpq9Oz7HuxKLMf3ryOsjHofcpVw@mail.gmail.com>
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 4:42 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 07/01/2023 =C3=A0 04:45, Quanfa Fu a =C3=A9crit :
> > Since this memory will be filled soon below, I feel that there is
> > no need for a memory of all zeros here. 'snprintf' does not return
> > negative num according to ISO C99, so I feel that no judgment is
> > needed here.
> >
> > No functional change intended.
> >
> > Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> > ---
> >   kernel/trace/trace_eprobe.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 352b65e2b910..cd1d271a74e7 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace=
_eprobe *ep, int argc, const ch
> >       for (i =3D 0; i < argc; i++)
> >               len +=3D strlen(argv[i]) + 1;
> >
> > -     ep->filter_str =3D kzalloc(len, GFP_KERNEL);
> > +     ep->filter_str =3D kmalloc(len, GFP_KERNEL);
> >       if (!ep->filter_str)
> >               return -ENOMEM;
> >
> >       p =3D ep->filter_str;
> >       for (i =3D 0; i < argc; i++) {
> >               ret =3D snprintf(p, len, "%s ", argv[i]);
> > -             if (ret < 0)
> > -                     goto error;
> >               if (ret > len) {
>
> Hi,
>
> as per [1]:
>   * The return value is the number of characters which would be
>   * generated for the given input, excluding the trailing null,
>   * as per ISO C99.  If the return is greater than *or equal* to
>   * @size, the resulting string is truncated.
>
> So, should this test be:
>      if (ret >=3D len)
>             ~~~~
>
>
> Also, isn't the p[-1] =3D '\0' after the loop eating the last character?
>     argc =3D 1;
>     argv[0] =3D "a";
>
>     Before the loop:
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     len =3D 1 + 1 =3D 2;
>     ep->filter_str =3D 0x00 0x00
>                      ^
>                      |___ p
>
>     After the loop:
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     ep->filter_str =3D 0x61 0x00
>                           ^
>                           |___ p
>     len =3D 1;
>
>     After p[-1]:
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     ep->filter_str =3D 0x00 0x00
>                        ~~ ^
>                           |___ p
>
> Did I miss something obvious?
> I don't know the intent here, or if it is an issue at all, but it looks o=
dd.
>
> CJ
>
>
> [1]: https://elixir.bootlin.com/linux/v6.2-rc1/source/lib/vsprintf.c#L292=
5
> >                       ret =3D -E2BIG;
> >                       goto error;
>

I think that:

for example, argc =3D 2, argv =3D {"a", "b"};

Before the loop
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
len =3D (1 + 1) + (1 + 1) =3D 4;
ep->filter_str =3D 0x00 0x00 0x00 0x00
                       ^
                        |__ p

After the loop:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
i =3D 1, snprintf write: 'a' and ' ', so ret =3D 2
i =3D 2, snprintf write: 'b' and ' ', so ret =3D 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Since the length of the last argv is not enough
to write, the space is replaced by null

ep->filter_str =3D 0x61 0x20 0x62 0x00
                                                          ^
                                                          |__ p
p =3D ep->fiter_str + 2 (ret1) +2 (ret2) =3D ep->filter_str + 4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
so After p[-1] =3D *(ep->filter_str + 3) =3D '\0';
ep->filter_str =3D 0x61 0x20 0x62 0x00

According to ISO C99: " If the output was truncated due to this limit
then the return value is the number of characters (excluding the
terminating null byte) which would have been written to the final
string if enough  space  had been available"

The last snprintf will end with 'NULL', so I think p[-1] =3D '\0' can
also be deleted
