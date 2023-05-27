Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC3713726
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjE0XTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 19:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0XTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 19:19:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F9D3;
        Sat, 27 May 2023 16:19:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6261a1a7454so3501186d6.3;
        Sat, 27 May 2023 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685229588; x=1687821588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmP1Wdih2jmgBNgRuCig0lHf98Ze9PVsZQRiONBAQjA=;
        b=cCTy9nvcJ9criXQ2j7Lz+pQJSyBaMFLoiyppyEHcrcL+DY7QzoLAlrXhyU2EPtNWcI
         O79vXDay9SIYQFNzO/t/qMhucaSz2FQYz2AhjbOgbxfxkmaosfVZcZV7OSS6fkl7cykW
         vJ9En8xx29w1kTpgAoF4azHYTarhmxf9BNszzGmHSwogXBlYLLYR2wY1nG0i58NXrwlS
         r8SY35fqHW3T6x/Mdm8WW62lW/fAos/JcBfLy0EmL5+GOYUbbMw9BgT+dse3YIHh7naz
         3O0GGlRSCr0MVVRdlmeAu3FvgFpWdO/92/a+5bBL1hSNcRQXxxEX1h+FAlAJd/sRzpAh
         k5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685229588; x=1687821588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmP1Wdih2jmgBNgRuCig0lHf98Ze9PVsZQRiONBAQjA=;
        b=EiH0pSQZ03eI4KwSZVrJ4rgGd1EReblzfZWIny4f2SopCnbQfc4pa98H4+inJo9U8k
         GK3iLNAMfcQJ1f/jguO1OYl2VeQK6Wi45h0w7tUkcz/dBd7UC62PzgN+whAOGHCf4u9H
         bkZq252DncyIXFLHQWescWNOzFkuFodycDZvCW/FgcOY4l9MfOMeKC7XtCA3q5YAPj+h
         m+dK96v9AmDdZhg3l+U9l5v1Gm7VVhW/PuJW1O1CAgLdVFN/fEjzWsM7z5/iSiHChQyQ
         /lHqtnVVDhoVZH+b/X2YeW2dH3Fd/NbJuuuORT1ZZojEUCZOk6iDOp/9NkZIfLho6Iay
         V5CA==
X-Gm-Message-State: AC+VfDxjTQhuz7RXd68R2ndRArtz7M+syIkPaqP5kZux6yEXu2vndhCB
        jr34lQd4vxTXczqxKwDj+pGIB8ayte1/BSbX7jY=
X-Google-Smtp-Source: ACHHUZ4MCtxUZFmkT+8bmXt4CiwAFqv/7/SCQ8/6kvUZrRdEdOFHgryDuAvZCnH8gitKstn1hxlben+HE603wHzNJ44=
X-Received: by 2002:a05:6214:29e9:b0:625:aa49:c341 with SMTP id
 jv9-20020a05621429e900b00625aa49c341mr5556910qvb.53.1685229587968; Sat, 27
 May 2023 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230527132747.83196-1-frank@oltmanns.dev> <20230527132747.83196-3-frank@oltmanns.dev>
In-Reply-To: <20230527132747.83196-3-frank@oltmanns.dev>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 28 May 2023 09:19:36 +1000
Message-ID: <CAGRGNgWP6McbfORNQrrdvktEOVMgS-KCXuhC5GRYz-+SgsFx1w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] clk: sunxi-ng: Implement precalculated NKM rate selection
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
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

Hi Frank,

On Sat, May 27, 2023 at 11:37=E2=80=AFPM Frank Oltmanns <frank@oltmanns.dev=
> wrote:
>
> Add a new precalculation method for NKM clock rate selection in the
> sunxi-ng clock driver. Introduce ccu_nkm_find_best_precalc which uses a
> precalculated table of valid NKM combinations (struct clk_nkm_table and
> struct clk_nkm_combo) to find the best rate. This approach provides
> faster rate selection by searching a table of valid combinations rather
> than calculating for all possible combinations.
>
> The table of NKM combinations needs to be initialized with meaningful
> combinations only, i.e. removing redundant combinations that result in
> the same rate.
>
> Keep the existing ccu_nkm_find_best function in place and use it as a
> fallback if no precalculated table is provided.
>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 84 +++++++++++++++++++++++++++-------
>  drivers/clk/sunxi-ng/ccu_nkm.h | 26 +++++++++++
>  2 files changed, 94 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index 94d2a83992b2..9652f6df17bd 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -54,6 +54,49 @@ static unsigned long ccu_nkm_find_best(unsigned long p=
arent, unsigned long rate,
>         return best_rate;
>  }
>
> +static unsigned long ccu_nkm_find_best_precalc(unsigned long parent,
> +                                              unsigned long rate,
> +                                              struct _ccu_nkm *nkm,
> +                                              struct clk_nkm_table *tabl=
e)
> +{
> +       unsigned long best_rate =3D 0, best_diff =3D ULONG_MAX;
> +       unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> +       int start =3D 0, end =3D table->num - 1, mid;
> +
> +       while (start <=3D end) {
> +               unsigned long tmp_rate;
> +               unsigned long tmp_diff;
> +
> +               mid =3D (start + end) / 2;
> +
> +               tmp_rate =3D parent * table->combos[mid].n * table->combo=
s[mid].k /
> +                          table->combos[mid].m;
> +
> +               tmp_diff =3D abs(rate - tmp_rate);
> +
> +               if (tmp_diff < best_diff) {
> +                       best_rate =3D tmp_rate;
> +                       best_diff =3D tmp_diff;
> +                       best_n =3D table->combos[mid].n;
> +                       best_k =3D table->combos[mid].k;
> +                       best_m =3D table->combos[mid].m;
> +                       if (best_diff =3D=3D 0)
> +                               goto out;
> +               }

If the table was sorted by n * k / m, this could just be a process of
searching through until we either:
- find that the first rate in the table is too high
- find an exact rate
- go above the requested rate, then there's only two to compare: our
current rate and the previous one

This should massively simplify this function and would still work with
a binary search.

> +               if (rate < tmp_rate)
> +                       end =3D mid - 1;
> +               else
> +                       start =3D mid + 1;
> +       }
> +
> +out:
> +       nkm->n =3D best_n;
> +       nkm->k =3D best_k;
> +       nkm->m =3D best_m;
> +
> +       return best_rate;
> +}
> +
>  static void ccu_nkm_disable(struct clk_hw *hw)
>  {
>         struct ccu_nkm *nkm =3D hw_to_ccu_nkm(hw);
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nk=
m.h
> index 6601defb3f38..fa5551724921 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -12,6 +12,30 @@
>  #include "ccu_div.h"
>  #include "ccu_mult.h"
>
> +struct clk_nkm_combo {
> +       u8      n;
> +       u8      k;
> +       u8      m;
> +};
> +
> +/**
> + * struct clk_nkm_table - Table of all meaningful combinations for n, k,=
 and m
> + *
> + * @num: Number of entries in the table
> + * @combos: Array of combos (of size num) that are supported by this clo=
ck.
> + *
> + * This table shall contain all meaningful combinations of n, k, and m. =
That
> + * means that combinations that result in the same clock rate shall only=
 be
> + * listed once. For example, if both
> + * { .n =3D 1, .k =3D 2, .m =3D 2} and  { .n =3D 2, .k =3D 2, .m =3D 4}
> + * are valid values for n, k, and m, only one of them would be allowed b=
ecause
> + * both result in a factor of 1.0.
> + */
> +struct clk_nkm_table {
> +       size_t                  num;
> +       struct clk_nkm_combo    *combos;

Should this be a "flex" array, i.e.

struct clk_nkm_combo combos[]

> +};
> +
>  /*
>   * struct ccu_nkm - Definition of an N-K-M clock
>   *

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
