Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7B722277
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFEJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFEJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:46:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB026DB;
        Mon,  5 Jun 2023 02:46:01 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6261cb1208eso31922786d6.0;
        Mon, 05 Jun 2023 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685958361; x=1688550361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJsWxNn+ehAzikAnLEGHSuhlWphRfQgau36mI159SV8=;
        b=mXTdR4CcVVVjT/Qc4hbfsPVKcGa4qvFMqokLP3mWACF+hehi0eYEZCAAh8Mly5xqZ7
         OdQwB9RvK466dKJPm3Xf14I/MnPDyaCEMucCpze46I6jU9fvPWEb2aq14aedRxI+v71L
         TatFHLdGo2Rg1oJUNQjsOVwuVVSXFfr1tYysFr1hPhQ8oRe1Onf2jM19DMhv6J33siK3
         MA4w8+18ByiU8GJrrUTFvaO66wdv/esL455cAs/VlnjO2Ru0vdNnpq+ioNINk5v+s/oX
         ncCrSSB+ynRvBjn9sofTSltEuX0eoaDFtr/j37ETRRGdEjxUSuGc4aCgLaXRDtGYzKJ2
         3oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685958361; x=1688550361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJsWxNn+ehAzikAnLEGHSuhlWphRfQgau36mI159SV8=;
        b=XTPNwgEl3i1i2UqECEKU5OffcN0Z3DAYA6ZVSVqXLi5nKDuhty+u9Ci5US4Ib7wR0C
         9SfIlmNAXs0YM+p2E43ohGSSluVlTmxx9/KV6M+DOh8AQvqTAvWeC7Vjd4PhtAgc9vHp
         +5Cz+fzYLI78RlAXjdP7v67asDE5a6VJWnkO3MvsGi36wyRz5Y3+poHAQV6mrYdH+oCK
         bkmOH5XZ8sNbpgSQhq8tl1EYPTK/C5SkAumem0yjfKDMenq3kjPLruCBVuT8lw4PHRXd
         OAWnm+ye4IL8GhlxCGkuYW+LjUYPRkV3mcu7cUTbCmnrY629DQwumsUYidqKFFLvMVyZ
         2pZw==
X-Gm-Message-State: AC+VfDxmuOIuBcPtGC89ktRjDTx3e+18lv5jP+SKfthi3JTmGu+s79w9
        yjNpXs19AxUXETW+6vVaFfwQFvt2faiV80uOfkOzYHFTIeI=
X-Google-Smtp-Source: ACHHUZ7rEj10g7ikWyZ3KsOkINRJ5HpW1dgRXnpiCle+k7JUOkhRh3Ttxy58uWLS7jcOMUJiInZ1F65FYFqKngGaa+w=
X-Received: by 2002:a05:620a:46a2:b0:75b:23a1:d847 with SMTP id
 bq34-20020a05620a46a200b0075b23a1d847mr15874844qkb.9.1685958360822; Mon, 05
 Jun 2023 02:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-6-herve.codina@bootlin.com> <ZHtIdTZbULl6t4RT@surfacebook>
 <20230605094637.7615b689@bootlin.com>
In-Reply-To: <20230605094637.7615b689@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jun 2023 12:45:24 +0300
Message-ID: <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Mon, Jun 5, 2023 at 10:46=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
> On Sat, 3 Jun 2023 17:04:37 +0300
> andy.shevchenko@gmail.com wrote:
> > Tue, May 23, 2023 at 05:12:19PM +0200, Herve Codina kirjoitti:

...

> > > +           case IIO_VAL_INT:
> > > +                   *val =3D vals[--length];
> >
> > > +                   while (length) {
> >
> >                       while (length--) {
> >
> > will do the job and at the same time...
> >
> > > +                           if (vals[--length] < *val)
> > > +                                   *val =3D vals[length];
> >
> > ...this construction becomes less confusing (easier to parse).
>
> Indeed, I will change in the next iteration.

And looking into above line, this whole construction I would prefer to
have a macro in minmax.h like

#define min_array(array, len) \
{( \
  typeof(len) __len =3D (len); \
  typeof(*(array)) __element =3D (array)[--__len]; \
  while (__len--) \
    __element =3D min(__element, (array)[__len]); \
  __element; \
)}

(it might need more work, but you got the idea)

> > > +                   }
> > > +                   break;

...

> > > +           default:
> > > +                   /* FIXME: learn about min for other iio values */
> >
> > I believe in a final version this comment won't be here.
>
> We have the same FIXME comment in the iio_channel_read_max() function I
> copied to create this iio_channel_read_min() and, to be honest, I
> don't really know how to handle these other cases.
>
> In this series, I would prefer to keep this FIXME.

I see, Jonathan needs to be involved here then.

> > > +                   return -EINVAL;

--=20
With Best Regards,
Andy Shevchenko
