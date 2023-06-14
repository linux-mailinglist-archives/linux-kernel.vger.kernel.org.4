Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E28730161
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjFNOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:12:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2988610CB;
        Wed, 14 Jun 2023 07:12:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30fc90f359fso2101859f8f.3;
        Wed, 14 Jun 2023 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686751945; x=1689343945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZDLewBF8krwjKdzGPgy6i6KLvD9d5BWuqInYm38DtU=;
        b=qOvO8407S5cG7o9xqLViYBblnALmkt8fd7TkCgM+0urVKiWsfTshA8i0bEzaqUDkfg
         qOof2uWEX8/4m9eUNhxxaQRgh3CH6qbHl1FgylHIHfL+VRmCkAmU0rdxDUE87GM6ta9I
         hk3OIUkxRimPdaNW/pqt3wADaV+YhWbYalf12FiAPyiSDhvrKzUBc9Kf1XYCENOVh2EM
         JASNKqzcFII4/SvKmOpnX4uwoVtGN4AAPf2UIG6MaVAY8sVIw++755c4osCCS1f5YDkR
         JqRapUsGrHY/flfj7/uVXGbDayT6WshjpKILYJxn4w5l54taI7p7RZqVy34+lrR8spvt
         hBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751945; x=1689343945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZDLewBF8krwjKdzGPgy6i6KLvD9d5BWuqInYm38DtU=;
        b=aRkwFz3nPk/qfR6Iveoja0E3vnY5otZhk/vDFL1Z7pQ+YbT3qVUHghqm1T5Y5BSn0H
         mabPPe//c8oXxDK+TzGjieyYi8X4xdd1w5PA3JSyGgLTaG+qHVUnJq8y7StVyt7MKNLc
         gwY98a/pq44pbgz680EvV8DRTIBKLYcxeqomX8ZadNrwNab3u1PMb45CILE25ILwVj44
         YxTiUlTpc00cKJ5e4x4Lhae7tOVtKkkols12/2neWzNGX84zJEUJFS47BRCb6eK8zb3I
         2pgUP/+s4k1hW5zcLeqCj+OmLxp1GGt8lMILJg8vtMCiaWeROPb0j/POcQd/Zn295zOy
         OWFA==
X-Gm-Message-State: AC+VfDxEH06eV2qv9/re/astp6D6UeFlfXwA+smzunqP2D8mNDJ7ZZqa
        wrr7AGNEAhCKosKh3p3myQtFkz8iiWm8YyxBGjk=
X-Google-Smtp-Source: ACHHUZ61hx7YoAY7ltQMo8T0HIryzg1K8HLWMEcRxmY5i+zfIV3yMhGTopjMnT6XjLYyp/tEgEQpnjHS9b04OSJHuQQ=
X-Received: by 2002:adf:fb4a:0:b0:311:af5:ad64 with SMTP id
 c10-20020adffb4a000000b003110af5ad64mr1041315wrs.16.1686751945324; Wed, 14
 Jun 2023 07:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230613004341.3540325-1-azeemshaikh38@gmail.com> <202306131229.B5F2D9F@keescook>
In-Reply-To: <202306131229.B5F2D9F@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 10:12:14 -0400
Message-ID: <CADmuW3VEiseKt2UM9o9jzzR8nEawh1jxANyxdZcxk89U65pXEQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 3:30=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jun 13, 2023 at 12:43:41AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -E2BIG
> > is used to check for truncation instead of sizeof(dest).
>
> Perhaps say "PAGE_SIZE" here instead of sizeof(dest)?
>

Ack.

> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> >  drivers/usb/gadget/function/f_printer.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadg=
et/function/f_printer.c
> > index 28db3e336e7d..10dc7c55c25f 100644
> > --- a/drivers/usb/gadget/function/f_printer.c
> > +++ b/drivers/usb/gadget/function/f_printer.c
> > @@ -1211,8 +1211,8 @@ static ssize_t f_printer_opts_pnp_string_show(str=
uct config_item *item,
> >       if (!opts->pnp_string)
> >               goto unlock;
> >
> > -     result =3D strlcpy(page, opts->pnp_string, PAGE_SIZE);
> > -     if (result >=3D PAGE_SIZE) {
> > +     result =3D strscpy(page, opts->pnp_string, PAGE_SIZE);
> > +     if (result =3D=3D -E2BIG) {
>
> I think "< 1" might be a better test here.
>

Curious, why "< 1" instead of "< 0"?

> >               result =3D PAGE_SIZE;
> >       } else if (page[result - 1] !=3D '\n' && result + 1 < PAGE_SIZE) =
{
> >               page[result++] =3D '\n';
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
> >
>
> -Kees
>
> --
> Kees Cook
