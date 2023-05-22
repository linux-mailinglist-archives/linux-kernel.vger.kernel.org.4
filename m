Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CAA70B9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjEVKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEVKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:15:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B8BE;
        Mon, 22 May 2023 03:15:40 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75b14216386so34019885a.0;
        Mon, 22 May 2023 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684750540; x=1687342540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQFJJglwb8UC3vbX+bVe8wmmxX+DWMka1YOsU9Z1BbU=;
        b=Ry04oRkBDzCflbHhH3PaVCKdTzhRC/ZtFQlHljIK07hNVZRK7c9Pq1ggd6BOYtuhgf
         I17i3yqg6N4+CWjKTN6hK8FWs22PgySZCdt/F+JjZG0CNXp1jHOBZIf0XfPt9vD1E6Qv
         rqZ7HKaesDzDVqux7QuZ9I9Kz1Ti9p3OCbPvZeU05g1kghXPToaSS/dvgiTRLZaJ10KD
         TcCPYIHTgY44uMKiBCbMpAmnOB+DAT3uamgChYvtycPTFpewSshva5EyIBnJChVv7n4I
         g6JS5NCmoRsyFeIunLkJwsKuACL2rM/Y7zm76ks6sPMOk3j32dFAzdH0uUSmK0enPwgS
         2GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684750540; x=1687342540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQFJJglwb8UC3vbX+bVe8wmmxX+DWMka1YOsU9Z1BbU=;
        b=QNGrxZaiPvywiTDx1Fmc93H34u9WpXGOsFaWPBbX7dSVxe7Ykvu56Br0cy0incW2W+
         vIadcP9Tfjygd9cA8aOBmYn/iGV47zFGTPAqqN9eu34C7TNa8FEHhrYCe85v0tp2mJaq
         K4lWCtlvpKsj6cZlT71QsJ26Y0j6RUR+v5m0Y4sC0qmc4MNaFrA8azbI5h7MTU3GZQWg
         wI0HKaxTW6y56EgNGTYRe56XwijLcarj5FRHNRdVABhJgFkTZU/p0ye/mP7zJZqDe6+y
         0XmwRsoAuAlI4rsalPNBKhYWaQW5m299ztQullh60ZFbbb4xLJvd3QvowpHkOstdZIcp
         b7SQ==
X-Gm-Message-State: AC+VfDxqwgV5K7ZOMgbk9SQ5NCFM2uOAco2zkY7FySXApDLCazWFB9Ds
        kUxuiRu2sgVX33s7ym6d02PU+LWuq9JcV1eFnMU=
X-Google-Smtp-Source: ACHHUZ5mQ99YKkCOLeyzMJoiM4YNvaRBRDSU0Ni+XchUkgtp30ZEOR7KZIOFrp+NW59vkXmtJXPew3qZZ0DPAd9xLMc=
X-Received: by 2002:a05:620a:22b8:b0:75b:23a0:e7d2 with SMTP id
 p24-20020a05620a22b800b0075b23a0e7d2mr21864qkh.51.1684750539901; Mon, 22 May
 2023 03:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu> <20230521225901.388455-2-contact@artur-rojek.eu>
In-Reply-To: <20230521225901.388455-2-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 13:15:03 +0300
Message-ID: <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
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

On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek <contact@artur-rojek.eu=
> wrote:
>
> Consumers expect the buffer to only contain enabled channels. While
> preparing the buffer, the driver makes two mistakes:
> 1) It inserts empty data for disabled channels.
> 2) Each ADC readout contains samples for two 16-bit channels. If either
>    of them is active, the whole 32-bit sample is pushed into the buffer
>    as-is.
>
> Both of those issues cause the active channels to appear at the wrong
> offsets in the buffer. Fix the above by demuxing samples for active
> channels only.
>
> This has remained unnoticed, as all the consumers so far were only using
> channels 0 and 1, leaving them unaffected by changes introduced in this
> commit.

...

> +       u16 tdat[6];
> +       u32 val;
> +
> +       memset(tdat, 0, ARRAY_SIZE(tdat));

Yeah, as LKP tells us this should be sizeof() instead of ARRAY_SIZE().

> +       for (i =3D 0; mask && i < ARRAY_SIZE(tdat); mask >>=3D 2) {
> +               if (mask & 0x3) {

(for the consistency it has to be GENMASK(), but see below)

First of all, strictly speaking we should use the full mask without
limiting it to the 0 element in the array (I'm talking about
active_scan_mask).

That said, we may actually use bit operations here in a better way, i.e.

  unsigned long mask =3D active_scan_mask[0] & (active_scan_mask[0] - 1);

  j =3D 0;
  for_each_set_bit(i, active_scan_mask, ...) {
    val =3D readl(...);
    /* Two channels per sample. Demux active. */
    tdat[j++] =3D val >> (16 * (i % 2));
  }

> +                       val =3D readl(adc->base + JZ_ADC_REG_ADTCH);
> +                       /* Two channels per sample. Demux active. */
> +                       if (mask & BIT(0))
> +                               tdat[i++] =3D val & 0xffff;
> +                       if (mask & BIT(1))
> +                               tdat[i++] =3D val >> 16;
> +               }
>         }

--=20
With Best Regards,
Andy Shevchenko
