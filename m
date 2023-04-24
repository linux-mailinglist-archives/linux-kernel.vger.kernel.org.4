Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F96EC85D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDXJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:07:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43154E55;
        Mon, 24 Apr 2023 02:07:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f109b1808so752173166b.1;
        Mon, 24 Apr 2023 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682327244; x=1684919244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KP7Rgg0t8v5D0RB4lGbAJgbjIXpGiW0WVmg2B3XGczo=;
        b=ImG3w9bliXi+hb3oh+2FGwHRk8QFdQMBGZw1p6LE3XdUZKfdMQoaCyA/CjsA2svzwy
         8pqjsi9TUfcRj69phcJz9h8GueszJwHLngOYiPDF9pqOE4+0HT9hsyvfHPVfZt7WZkRr
         3juSSt6cpSAmv4jj/6HYSwRgp7MOXza5ajiLLwtN5W1YdfFvLhBbFf7Iu81VZweGRHJo
         wcw1B+tu86+AMgLfL7jtH4LmAouIHX9fZOuA8lwwHNR1s+eVdhmdZN2T4k9xobGamqm6
         bo+QKPAO+qjYFF4iR5/7PrjLyv/pdbdAxXR1I4Sq4IkIlTueUg0/nlT4ZPSZ322IoguV
         EikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327244; x=1684919244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP7Rgg0t8v5D0RB4lGbAJgbjIXpGiW0WVmg2B3XGczo=;
        b=aiC2Yo5o0Qe8IB1idqYiT/NiVUFo/EL1RTNkY2u8ULrgmArpLJ7Z/H3ZgHn7kPkhHx
         3eNlI7ejlPinHvVi/4S2beEjr72wiJKx/eOjHUCFi1E2EQ0UrP2YrxTu3UoO394O8KMQ
         LZ72c0l6pR7VJTm9iXD5+3PM+BJPiZX0TLzJBlWu8XbYw1tbRzk559rDh2pF9BQ4p7MW
         EG9tTFyRws8j8DYorrTy0ILgGyIYylKrB9Di6hRjb+S5YKJGahS0dh8QSj/xgCYSlYgY
         9SSBQgPyQgY0ztQ7pCMa8V973Vqa11VulZxvDYEujgjhLsbBOF2pd5SoVvkibdmlCcqZ
         xinQ==
X-Gm-Message-State: AAQBX9dbcSU6MjqEchlNyBG/77Ffqs5OBMKW+t6HHLvJKgyp3xfPWe1E
        fmXu8723yUQsKuJ+DytrYEk=
X-Google-Smtp-Source: AKy350Ye0LooH8hkdFRnQA9NNr3/w9xIL+7ggtAbMPtnRcicCiLvT+k4C5IMO96T2jlZqoEJXmnJnw==
X-Received: by 2002:a17:906:2095:b0:953:9024:1b50 with SMTP id 21-20020a170906209500b0095390241b50mr7917793ejq.74.1682327243492;
        Mon, 24 Apr 2023 02:07:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id ke15-20020a17090798ef00b0095328ce9c8bsm5326254ejc.67.2023.04.24.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:07:23 -0700 (PDT)
Message-ID: <b6a96cca17832219042c90baec2442b1a5bad7b7.camel@gmail.com>
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Masahiro Honda <honda@mechatrax.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Apr 2023 11:09:34 +0200
In-Reply-To: <20230423121528.259d3cd4@jic23-huawei>
References: <20230420102316.757-1-honda@mechatrax.com>
         <20230423121528.259d3cd4@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, 2023-04-23 at 12:15 +0100, Jonathan Cameron wrote:
> On Thu, 20 Apr 2023 19:23:16 +0900
> Masahiro Honda <honda@mechatrax.com> wrote:
>=20
> > The Sigma-Delta ADCs supported by this driver can use SDO as an interru=
pt
> > line to indicate the completion of a conversion. However, some devices
> > cannot properly detect the completion of a conversion by an interrupt.
> > This is for the reason mentioned in the following commit.
> >=20
> > commit e9849777d0e2 ("genirq: Add flag to force mask in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq[_nosy=
nc]()")
> >=20
> > A read operation is performed by an extra interrupt before the completi=
on
> > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLA=
ZY
> > flag.
> >=20
> > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > ---
> > v3:
> > =C2=A0- Remove the Kconfig option.
> > v2:
> > https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatrax.=
com/
> > =C2=A0- Rework commit message.
> > =C2=A0- Add a new entry in the Kconfig.
> > =C2=A0- Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freei=
ng the
> > IRQ.
> > v1:
> > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.=
com/
> >=20
> > =C2=A0drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
> > =C2=A01 file changed, 20 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > b/drivers/iio/adc/ad_sigma_delta.c
> > index d8570f620..215ecbedb 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *indio_d=
ev,
> > struct iio_trigger *trig)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
> > =C2=A0
> > +static void ad_sd_free_irq(void *sd)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ad_sigma_delta *sigma=
_delta =3D sd;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_clear_status_flags(sigma=
_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_irq(sigma_delta->spi->i=
rq, sigma_delta);
> > +}
>=20
> Don't fuse the two operations unwinding like this.=C2=A0 Just register a =
callback
> that only
> does the irq_clear_status_flags immediately after setting them.=C2=A0 The=
n leave

I was the one to propose fusing them together because I thought that we cou=
ld
have issues by clearing the flag after calling free_irq(). After looking ag=
ain
at the IRQ code, I can see that it is not up to free_irq() to free the allo=
cated
irq_descs (that might only happen when unmapping the virq) which means we s=
hould
be fine doing the normal way.

That said, looking at the only users that care to clear this flag, it looks=
 like
they do it before calling free_irq(). Hence, I'm not sure if there's anythi=
ng
subtle going on. In fact, looking at this line:

https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L1909

I'm not so sure we actually need to clear the flag as for these devices, we
should only have one consumer/action per IRQ. Anyways, probably for correct=
ness
we should still explicitly clear it?

- Nuno S=C3=A1

