Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31A36AE755
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCGQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCGQw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:52:58 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A272984FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:49:02 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id f23so12826435vsa.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678207740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAM6KLGzntkSWdjqY00tOO6Re1CtThRvd/af47qdcys=;
        b=sMlSZ99iY1HXbVfOwHWFFNCePy6z5mMJc7oroohOrUO5Kd6B/PA4UN67MKzkTIxBlr
         0XDLyNp2UMVwMgLjhSbmqBS5pHRXTpRHGdPbbOH5EL64VbBmd/hA/94DVXvxqt+8CNEQ
         f25B+F75LFjlhslV28C/rEhR0lE6N+uOI6de+I7EMlLSqZj7sdUqm5gDDkTVoYk7KfjJ
         mUFwn2S2OQ0F6yfEr5zB38OS+OuvtzjMjqBIaoB6iq+T/OSB2JbIjrK7bMxBUr02pIBG
         x6EZDyyt7243EaX3u/ayDVZJkJwbXwbOPUBv+RVL9FCdEFDyhEz/fb+Qtpow3oyYsAaP
         iPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAM6KLGzntkSWdjqY00tOO6Re1CtThRvd/af47qdcys=;
        b=b67Flo8P0jOBJU0dEvQVjcq6BKyrZP7sAgMiFsHyYQANKYCbFvWvYT3c0FHa8Rd2lm
         znQ3Ekmb25rAU8nV2dgzCTdZ/TcxIJ5a3VPzfrIXA3RAJSUiFpHuy8sy1J3w3B5Kpznr
         Twj7oGo+ipvC5LdWnD+z2KFQTsJOqdvdrPQwIoSNnvxpFJu21BRbkZTILH+6FBDT+lLK
         p+tDzKQehhZc3X3D535Vs4LohHCJ1paRHk43+fghyE1JlLyWA0sccb/xl4P758nhDWYt
         EFzXGNVjKEcnZUxALRRoB3QRBZGBVK/U2JMtOAVvZkv22xwyLGF0/Sq382IM4+w+KQiJ
         vu8A==
X-Gm-Message-State: AO0yUKVilwa5fJ1/ws74oXAVEjtZu13bO+7eNQ0lUejMftiSH3abKWAR
        5XVfjqghCjS28fZdTUUwNbj5AamWF+uST5rBh/kDNA==
X-Google-Smtp-Source: AK7set/aGZTSkM0B9sWQYZhfE6LKKIa7JSaHfa8fNaeVAqzf3UgTfODCbnSXRvhpl/MM03uqaOH4EQYIMkUsDvh2F0s=
X-Received: by 2002:a67:ead9:0:b0:411:ffe1:9c6 with SMTP id
 s25-20020a67ead9000000b00411ffe109c6mr10136669vso.0.1678207739881; Tue, 07
 Mar 2023 08:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-2-keguang.zhang@gmail.com> <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
 <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com>
In-Reply-To: <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 7 Mar 2023 17:48:49 +0100
Message-ID: <CAMRc=Me3Lnf0W=Y0oMkUGJ59rVCRb+qGq2Eb3vqRZm5gQUwOxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: loongson1: Convert to SPDX identifier
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 3:25=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail.c=
om> wrote:
>
> On Mon, Mar 6, 2023 at 5:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> > >
> > > Use SPDX-License-Identifier instead of the license text and
> > > update the author information.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > V1 -> V2: Keep GPLv2, just convert to SPDX identifier
> > > ---
> > >  drivers/gpio/gpio-loongson1.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongs=
on1.c
> > > index 5d90b3bc5a25..8862c9ea0d41 100644
> > > --- a/drivers/gpio/gpio-loongson1.c
> > > +++ b/drivers/gpio/gpio-loongson1.c
> > > @@ -1,11 +1,8 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > >   * GPIO Driver for Loongson 1 SoC
> > >   *
> > > - * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> > > - *
> > > - * This file is licensed under the terms of the GNU General Public
> > > - * License version 2. This program is licensed "as is" without any
> > > - * warranty of any kind, whether express or implied.
> > > + * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > >   */
> > >
> > >  #include <linux/module.h>
> > > @@ -90,6 +87,6 @@ static struct platform_driver ls1x_gpio_driver =3D =
{
> > >
> > >  module_platform_driver(ls1x_gpio_driver);
> > >
> > > -MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> >
> > Why are you removing credits of the old author?
> Kelvin Cheung and Keguang Zhang are the same person.
> This change is to keep pace with the related entry of MAINTAINERS.
>

Even so - how could I have possibly known this? Please put it into the
commit message, it's crucial information for this change.

Bart
