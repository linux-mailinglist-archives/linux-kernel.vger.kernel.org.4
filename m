Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BF660EAC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAGMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:21:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25060869;
        Sat,  7 Jan 2023 04:21:11 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4b718cab0e4so55571527b3.9;
        Sat, 07 Jan 2023 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmxosPNMV6FSszi/hJsr0RrXBKfpegJ3O+cgcdh/6Kc=;
        b=EZ82pPTlozMJXhQv2PxxKoBXUX2gEBt4fftzwEFyB/tDDU2if1nPRw+E1HATiXQ64u
         bRTaVMZMYaOOhhOCM/f1/mWub8Uy8GgrOUzBK94+/WyFs4AjsCSyfaqKCAurf+stRzX0
         xSSxZjfsQZQPGHJXGdb+tjP211AB8Jx5TT7pHRVuaDQNkqkqmUlfolBqQAY/XTygOAZF
         hjMp/+ay0UGFDcYdil6U1UkNFiYfP2254/sDh4X946iPcgJgEUUQYEnzYSIW/BTn+F/N
         nWc0TOkO/Jl3lvywyx1x3aI+uEUvvXpi2VB8JIFtUulJUKa/Zat0ylKR8JGX5o5TDadu
         QjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmxosPNMV6FSszi/hJsr0RrXBKfpegJ3O+cgcdh/6Kc=;
        b=xIICQbm/q+6hSyQiSknpYUQ2vGy09a4EaQiVrAyrPKALJtfdSRQm5AcSh3gWP1enV3
         sevq317HhS1VKnxhQI9113JcfFVjT5QCmCeFUC9RrmT1fpnfkBigBAWOK/cdos2oPmfQ
         l2upQMNLijdR3xD+8Rie8r7+QiiTNPFNsALf4O+G1bxs6lEbJZDM2ZD0sQK+bgCZlhHM
         eA7EokYr/5Y3MsH9dq0qVAzphIP7bnXvON+jfRcz/bnpnPlaNe4AUjblXFNEq3OuwcGi
         JJzCRO6V5NdW3BoPuDJl22HNKueDkqTJ1OANbBuaul8ufAiQGW6GBN+nyCQ4ZpQ9tbvj
         NX1Q==
X-Gm-Message-State: AFqh2krsQouNT6nm/5RxRGrsz4wGLCoR7mFiw/zWj4ifrjURrL4dNfNm
        uHsyH+gS8lO4mVFsLKd/vdrPlzey7qK8ybkqH4xFEc1j/40=
X-Google-Smtp-Source: AMrXdXuiA6L1UY31D9f2BX0iyG+dmbJ/EQo7SPfc0ZavY8GA0pi5V64vNZjctJ18fYdALZWfWxm8I3MTPMinVypuLdc=
X-Received: by 2002:a81:6c86:0:b0:43f:7e4:81eb with SMTP id
 h128-20020a816c86000000b0043f07e481ebmr600652ywc.44.1673094070240; Sat, 07
 Jan 2023 04:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20230107034557.1156022-1-quanfafu@gmail.com> <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
In-Reply-To: <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
From:   Quanfa Fu <quanfafu@gmail.com>
Date:   Sat, 7 Jan 2023 20:20:59 +0800
Message-ID: <CAM4UoyomEG0=YKQp2ALFXCmpNGriC2n6+4t=pzHyFrkttshEcw@mail.gmail.com>
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
ep->filter_str =3D 0x61 0x20 0x62 0x00    // Since the length of the
last argv is not enough to write, the space is replaced by null
                                                          ^
                                                          |__ p
p =3D ep->fiter_str + 2 (ret1) +2 (ret2) =3D ep->filter_str + 4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
so After p[-1] =3D *(ep->filter_str + 3) =3D '\0';
ep->filter_str =3D 0x61 0x20 0x62 0x00

According to ISO C99: " If the output was truncated due to this limit
hen the return value
is the number of characters (excluding the terminating null byte)
which would have been
written to the final string if enough  space  had been available"

The last snprintf will end with 'NULL', so I think p[-1] =3D '\0' can
also be deleted
