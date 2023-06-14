Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB4730152
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjFNOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjFNOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:11:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77631172E;
        Wed, 14 Jun 2023 07:11:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so7101575e9.0;
        Wed, 14 Jun 2023 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686751871; x=1689343871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz9ocE9wSFsUBVqfWl7R+s5U+bYM0cPq3yRFLbSu/Zc=;
        b=FR3twmarfk2EPI8yiFDBM5rCl2OANzVSHuogAmnugHRKcvEjbrfutvGloyZZHjq2NY
         HpZWdhnPa+A0JzexiWsi45cRwlO37IYCVfPVwaFMbfEKyrqRUxAszj1eUHPjP0WCcC7W
         /CCQZ1Sg5QfqWDcVlwTt7wNgT6f+xyUuoewt4KGN4IhlqHXmLgs61XdVRF+u2o9JRlZI
         EvNTDeEkepihweFVjVZR6iECJyMtNSSJX2T2/8SGpBXm49p/6LhWyvarLBWPjM2Hua0G
         HRCmBFyl0KsHzV2yaflrMXT8/LfNT2ptjZ3BG+psx54CDl7mLlESMLRuPCyXqgNNCfTC
         BNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751871; x=1689343871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz9ocE9wSFsUBVqfWl7R+s5U+bYM0cPq3yRFLbSu/Zc=;
        b=HBbcBmApcv2LP6LfgMCVdUvLoDdsJklmTfrGGLHg854fxk0YQunn5a+PswvcAceSgA
         3PgcENPhp07HZCQEWDlqTOzHKyvv0Q/8fYrxHWWIkEVG/hpSs/y/4uXfaySVm6DBOxpc
         1Vg/ZBc8c0c7HOSr1ElKV7urT1qLhDC2GW2JZy5IhWI153+3KUswMKV4WL5qETxdDcRd
         +uct6UCu4BOxPuSpsalOpeGFfdaCu6HkBx0FPZ1qXOwlfOjnXPXZYCPa4HHZ+YpR0Ec+
         3hFISxbB6yz2gqGfrXToon66HPnaPjEdBMrf0eCua9EfFA7HpbhXNqi+7nmCy9mJt02H
         yxNw==
X-Gm-Message-State: AC+VfDyj5bItU+8kGGU4asuGfUTUutKQ41pfacbNcgiRAVp/ELjebPGe
        R4StE1ycDv0PrXJLE1BbaTVlexYI1/yhz3R4W5Fxtu7fXRRggA==
X-Google-Smtp-Source: ACHHUZ7WhhI/3XFQTE8Bk+RYTYauu4NKeDEPTNei+gC1zcXHGUqwkBuFSV13MXRMZZVq0/Kmfxep5lL4KkDAkj9035U=
X-Received: by 2002:adf:f8c7:0:b0:30f:c9ee:d5b4 with SMTP id
 f7-20020adff8c7000000b0030fc9eed5b4mr4234511wrq.71.1686751870735; Wed, 14 Jun
 2023 07:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230613004402.3540432-1-azeemshaikh38@gmail.com> <202306131231.88243CB@keescook>
In-Reply-To: <202306131231.88243CB@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 10:10:59 -0400
Message-ID: <CADmuW3V-Km8Xa+GpTOKLu_RS_Dvsf3AgHFnOAcHxOQ2CQ2j+cQ@mail.gmail.com>
Subject: Re: [PATCH] usbip: usbip_host: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 13, 2023 at 3:31=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jun 13, 2023 at 12:44:02AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -E2BIG
> > is used to check for truncation instead of sizeof(dest).
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> >  drivers/usb/usbip/stub_main.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_mai=
n.c
> > index e8c3131a8543..a92a284f5abb 100644
> > --- a/drivers/usb/usbip/stub_main.c
> > +++ b/drivers/usb/usbip/stub_main.c
> > @@ -174,8 +174,8 @@ static ssize_t match_busid_store(struct device_driv=
er *dev, const char *buf,
> >               return -EINVAL;
> >
> >       /* busid needs to include \0 termination */
> > -     len =3D strlcpy(busid, buf + 4, BUSID_SIZE);
> > -     if (sizeof(busid) <=3D len)
> > +     len =3D strscpy(busid, buf + 4, BUSID_SIZE);
> > +     if (len =3D=3D -E2BIG)
> >               return -EINVAL;
>
> "len" is never used again, so maybe:
>
>         if (strscpy(...) < 0)
>                 return -EINVAL;
>
> -Kees
>

Thanks. Sent v2.

> >
> >       if (!strncmp(buf, "add ", 4)) {
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
> >
>
> --
> Kees Cook
