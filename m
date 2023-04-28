Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC76F1EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346338AbjD1TjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1TjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:39:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DB49E1;
        Fri, 28 Apr 2023 12:39:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f00d41df22so11992722e87.1;
        Fri, 28 Apr 2023 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682710752; x=1685302752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8w6l7nnz11ryCv+G1IGkewWKYyD3zcBLk2wv/q8Qo8=;
        b=bhMFyGtoDt+xXX5bagCPnYFnH0KRVxSAZWdQVg6CnnaLdh1kdRlp6j7d8EWIqooyab
         l5aOUaN8BzHVIAmAHWK9GqvPk0VHU01rYwOJFDcuupGqP/i67l+SzFLNZC4QGiNkzIgW
         Npv0iZDozvdVYIXlJGx2OGCBUmRLtJvN3i9euhTmcvgdSWtaAzZzCy6LTVdE5XKz2AEh
         2ciuIfuIJHzdIQYNwiOEUxaeRUEZB4sGfaBtjQsxL5EnXayMRXfnLOJadO+I0/5/hq5R
         LMqH9UscKSlxvqILpw+6idRv9CMrA0D6JQgArIQrudx1y2BkgjVk6Yr6DT8CrjbXycwG
         Sqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682710752; x=1685302752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8w6l7nnz11ryCv+G1IGkewWKYyD3zcBLk2wv/q8Qo8=;
        b=NoZKesSQ/Zme3wbjY33jAlFmiXIHmOC5ZXtE48fEj4NETVWJtoUh+Mwgi/39cXa889
         RdtvNxDQlUxP3weToqar6Zf24IZM+RnX0UwtfsGs0sY5T6PS2WN6R78YbWP1HodKS1B0
         T4jp+pMkL6Br6gdqs+Hlwg9fxGONpUhR/0J/jcNbrmAKR8OMp4TwqIcJddbgx72xu2yb
         k6u9wZ8KGv+ORu4xS7pyMhMTJrByS8lN/LPSOBPhQGN/GHPcoBej8sZmAsaeGsEeZRhP
         I6Q8zzP4UnBk1f2kFsAxTapdEA9ExjGqmR02nc1qB/5HboKqkS+eb65Y4uGJpVp19sl0
         +MnQ==
X-Gm-Message-State: AC+VfDwtEvCfwvaDU0BVBSu0a/aRoQ/JzrJKKc1uTq7Ezyao9QLfcFUI
        rg+ZoKoRGW0ik/llLE87uilwgUdozSAFzKB9Vxk=
X-Google-Smtp-Source: ACHHUZ433t3bgfj0+BjReXU7j0D2WPJ17CbsKkkpdLY1WvzyqJOty+9rpO8QDoD0/N399MCsPNNtWooRbo5yFYNhkLA=
X-Received: by 2002:a19:ae06:0:b0:4ed:300c:10b6 with SMTP id
 f6-20020a19ae06000000b004ed300c10b6mr1769269lfc.21.1682710751976; Fri, 28 Apr
 2023 12:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de> <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
 <462b5d12-0430-4fbe-8c26-7b6126556ec8@t-8ch.de> <CAOOmCE8iBfeuodTO7C=0EUOkqv16008h7vsZO2hhBZPuLoLECw@mail.gmail.com>
 <152fb7c0-1075-4718-bca1-c2083c425788@t-8ch.de> <CAOOmCE-KK3AYmjaDO=qV7WzpsgeZ6d7U1Ep9a9=dcu9CEmohLQ@mail.gmail.com>
 <1d89b95e-3a58-4d29-bd40-d92b07412edc@t-8ch.de>
In-Reply-To: <1d89b95e-3a58-4d29-bd40-d92b07412edc@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 14:38:46 -0500
Message-ID: <CAOOmCE-6Mz5YoZs+Xac+p=+yFpL+EctVFsCsMum6SLzKYqTY5g@mail.gmail.com>
Subject: Re: [PATCH v11 08/14] HP BIOSCFG driver - bioscfg-h
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 11:30=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-28 11:19:04-0500, Jorge Lopez wrote:
> > On Fri, Apr 28, 2023 at 11:09=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@=
t-8ch.de> wrote:
> > >
> > > On 2023-04-28 11:03:56-0500, Jorge Lopez wrote:
> > > > On Fri, Apr 28, 2023 at 10:36=E2=80=AFAM Thomas Wei=C3=9Fschuh <tho=
mas@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-28 10:24:40-0500, Jorge Lopez wrote:
> > > > > > On Sun, Apr 23, 2023 at 7:01=E2=80=AFAM Thomas Wei=C3=9Fschuh <=
thomas@t-8ch.de> wrote:
> > > > > > >
> > > > > > > On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > > > > > > > ---
> > > > > > > >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++=
++++++++++++
> > > > > > > >  1 file changed, 613 insertions(+)
> > > > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bios=
cfg.h
> > >
> > > <snip>
> > >
> > > > > > > > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)          =
           \
> > > > > > > > +     static ssize_t curr_val##_store(struct kobject *kobj,=
           \
> > > > > > > > +                                     struct kobj_attribute=
 *attr,    \
> > > > > > > > +                                     const char *buf, size=
_t count)  \
> > > > > > > > +     {                                                    =
           \
> > > > > > > > +             char *p =3D NULL;                            =
             \
> > > > > > > > +             char *attr_value =3D NULL;                   =
             \
> > > > > > > > +             int i;                                       =
           \
> > > > > > > > +             int ret =3D -EIO;                            =
             \
> > > > > > > > +                                                          =
           \
> > > > > > > > +             attr_value =3D kstrdup(buf, GFP_KERNEL);     =
             \
> > > > > > > > +             if (!attr_value)                             =
           \
> > > > > > > > +                     return -ENOMEM;                      =
           \
> > > > > > > > +                                                          =
           \
> > > > > > > > +             p =3D memchr(attr_value, '\n', count);       =
             \
> > > > > > > > +             if (p !=3D NULL)                             =
             \
> > > > > > > > +                     *p =3D '\0';                         =
             \
> > > > > > >
> > > > > > > This can also truncate the string if there is data after the =
newline.
> > > > > >
> > > > > > This is a expected behavior as described by Hans in a later ema=
il
> > > > >
> > > > > I'm fine with stripping a trailing newline.
> > > > >
> > > > > But this truncates the string at the first newline.
> > > > >
> > > > > "foo\nbar" -> "foo"
> > > > > "\nfoo" -> ""
> > > > >
> > > > All inputs expected by this driver and respectively by BIOS are a
> > > > single line.  For this reason, '\n' will cause the string to be
> > > > truncated.
> > > > I propose reporting a warning message indicating that the data ente=
red
> > > > has a '\n' character and will be truncated in addition to failing t=
he
> > > > operation with -EINVAL
> > >
> > > EINVAL sounds good, but a warning is overkill IMO.
> > >
> > > Whoever put in the garbage value will see the error.
> > >
> > > Stripping a trailing newline still seems fine though.
> >
> > So. should the driver return an -EINVAL error or truncate the line,
> > report a warning message, and allow it to proceed.?
> > Please advice
>
> p =3D memchr(attr_value, '\n', count)
> if (p =3D=3D attr_value + count - 1) {
>         *p =3D '\0'; /* strip trailing newline */
>         count--;
> } else if (p) {
>         return -EINVAL; /* enforce single line input */
> }
>
> (untested)
>
> When putting it into a helper you may need to adapt it a bit.
>
> > > This would be a very good candidate for a helper function.

Done!   Helper function created.
