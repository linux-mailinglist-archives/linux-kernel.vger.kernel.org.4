Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54493723ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjFFKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFFKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:02:06 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6286E4F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:02:04 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43b27330e51so1353645137.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686045724; x=1688637724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzJNkn8MMIl6p+NtwjcktnBBMjRCL8LQ2CZu0WCe8WU=;
        b=b85sowyfu9GgoGWXPnrK/lcStHgLLagfrqalY0vUzKMtrYo9gyfPBM1UjxVni55T2y
         B+RsC04DSvoJbuwSLigKct5ootPwjTwK7C1WC/tE+1Bq/vjWTCdvlfEY0DKfuttps9MS
         y1FZ0csfV4itg9QKmRfRt1WY/mjDL7+mw/5jQ780Jo2bOGr7v76Hf6lDCQmVRqC7ghbK
         knW5L1r0WozAZnjg3sVFNEdvlhFCh3ieIyjXX7P7CgxVmgYc0HhX1F28/iIp51qH/cPi
         OHqPwPaZbWmQtfSi0eZXHUL8ZMh/Ys8JjzJDw2WhZvGq7deGYKBGbJj/RYPXZZe0qCDT
         tILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045724; x=1688637724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJNkn8MMIl6p+NtwjcktnBBMjRCL8LQ2CZu0WCe8WU=;
        b=a1/L0/WO9GMNPBFhVU5okXnKnE2q2V8UN4LVIi8+XQY5n1EwFewmIidtme8SeVC7l9
         iNWYePwX2pSgHIWILAuLnme8XftMdn/og1m5G58oI6DU1SAj3WVOOJqRfYWI2GHo1lfo
         FK9nPtbHhyxi34ZrLN0iP+co/KPxfIH/uLKanhU3kTuBwjPksCudiuFZleBqrb/d8di8
         IM+6PsfnPHVawt29vjJRvpAqsXMlhbAizMI9Hg4gMjm5Yl4MnK2298U07KHs96XpQlHP
         gXg8eP/Tf7H2gbWXHE7NHLqRocyvfLMbS62YV/D0nYOf8Ffi7ytoom7AbV7V4tL0Gowi
         Kyrw==
X-Gm-Message-State: AC+VfDzhnd6ux9bxltTSQX40iiRJEhYvcuFiNCIQJxTy4eO6Neu2aWaU
        KuvzD8lmqjJaxChXqoO/NwKyqQM21CN/h7fy2X3clQ==
X-Google-Smtp-Source: ACHHUZ59ux3Tv3PzL783aI5oC4KCKnUVsXc7kqBQ+9xVId0Qy7fLzd7keSb9xbnNWaejDUqqYnZWjUtZMZ+LzIfWAso=
X-Received: by 2002:a05:6102:3a67:b0:43c:5432:1fae with SMTP id
 bf7-20020a0561023a6700b0043c54321faemr359451vsb.27.1686045724034; Tue, 06 Jun
 2023 03:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230606051323.17698-1-warthog618@gmail.com>
In-Reply-To: <20230606051323.17698-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 6 Jun 2023 12:01:53 +0200
Message-ID: <CAMRc=MfdusMAqfjnQTi_-DdjeLHQzywpk=zpKaQjahy6_gds0Q@mail.gmail.com>
Subject: Re: [PATCH] gpio-sim: fix memory corruption when adding named lines
 and unnamed hogs
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 7:13=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> When constructing the sim, gpio-sim constructs an array of named lines,
> sized based on the largest offset of any named line, and then initializes
> that array with the names of all lines, including unnamed hogs with highe=
r
> offsets.  In doing so it writes NULLs beyond the extent of the array.
>
> Add a check that only named lines are used to initialize the array.
>
> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> After writing the comment above, and looking at the code again, it may be
> clearer to instead check that the offset is within the bounds of the
> array.  Or do both.  Consider that my review.
>

Like:

if (line->offset <=3D max_offset)
    line_names[line->offset] =3D line->name;

? If so, then I agree it makes the purpose of the check clearer.

Bart

> Cheers,
> Kent.
>
>  drivers/gpio/gpio-sim.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index e5dfd636c63c..923e8ff53128 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -721,8 +721,10 @@ static char **gpio_sim_make_line_names(struct gpio_s=
im_bank *bank,
>         if (!line_names)
>                 return ERR_PTR(-ENOMEM);
>
> -       list_for_each_entry(line, &bank->line_list, siblings)
> -               line_names[line->offset] =3D line->name;
> +       list_for_each_entry(line, &bank->line_list, siblings) {
> +               if (line->name)
> +                       line_names[line->offset] =3D line->name;
> +       }
>
>         return line_names;
>  }
> --
> 2.40.1
>
