Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3696D5A29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjDDIBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDDIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:01:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE06198C;
        Tue,  4 Apr 2023 01:01:42 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bi31so23622068oib.9;
        Tue, 04 Apr 2023 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680595301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj7wacCuHM8tfquKzfx6fQQY+WR52D59OKXynGSyeSE=;
        b=fwzC1GvMOdpOTVy3nAPtU5TXO0MUxhlV6MYLmXwlzGNTg+uvRk1jTRgoZc6KKvo7SQ
         4R4G94ha/s94Q6Xl7amdh+c1qhsd1AL1v/WIRnOsmadp7dvx1bzen6MJ51Q8cSveALRB
         6pmeAkD7J/2LrVh3m43DgsEI/dZyQG4u7XjAodfM3Go78R7GAxuD8J96/eS0jS3HP/MO
         HhZR1olbznPXix5E6ZG7AFS5iF6uReDPssjje7OZpR5VaNLHkw2neCVMF+IMRCDCmq9N
         +j27fgDh658FLe+HCbY+gAwGSF9S1bjcFFfMTdP81n+o8fzQuyXChJhoP22uMMXL+e6L
         EIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680595301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj7wacCuHM8tfquKzfx6fQQY+WR52D59OKXynGSyeSE=;
        b=0epReBEc+BffLL3wZJpt7qzejncsWtQeLI0ac2chxUg884do8gwnTuFkvQbPSu5T3I
         bwlhz4hFUxLK9DRYbRWcqZUuyd8fynfp/5GqUIz0IFqODu5oBhjCZYRfRVBSfdrmoTIQ
         9ZqBP7w5brPMebXBHw61Upj0Wxl3AB8i+tFpYMqzcQC2DBxUbtwILCjXzneTKiJYhl67
         CYlOw7sGJ7+fa++/uX7Qatq2vSKf9vmCyuT5qj8PJHqlQnQuLVCpA+P4uLHvr+wXGT2A
         MadiXr8tvypbxbsV0vIt0p03GBv6j48wLrJov8+ED7GxdHqecUGjH4odTj4GbNY3LIlt
         G55Q==
X-Gm-Message-State: AAQBX9c1Cc/6nF3HJBPHyW80QNOi9tW9KjX1thEFQWLnH/kDdsOEnJm1
        DFWf43BygQrSNasVOUYMBbS+dkJtbN7LXD9L6DwajpTIMkg=
X-Google-Smtp-Source: AKy350aHSEtuLB/5n0G4vfjplMTWsMaC6MXpBG/eIQTT8wP9Hvop1r0Ck9O7/NJYlNM8BKIeyzoUHF8nDhzCEf56er4=
X-Received: by 2002:a05:6808:2807:b0:387:1afd:5924 with SMTP id
 et7-20020a056808280700b003871afd5924mr487816oib.8.1680595301780; Tue, 04 Apr
 2023 01:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230330102100.17590-1-paul@crapouillou.net> <20230401154220.755e52cb@jic23-huawei>
In-Reply-To: <20230401154220.755e52cb@jic23-huawei>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Tue, 4 Apr 2023 10:01:30 +0200
Message-ID: <CAPJMGm6Xok4gM87VOFgdoNa5iBKW_d1+vNM2wXAvWxe16v=CmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Change "shorted" channels to differential
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alisa Roman <alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 4:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu, 30 Mar 2023 12:21:00 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
>
> > The AD7192 provides a specific channel configuration where both negativ=
e
> > and positive inputs are connected to AIN2. This was represented in the
> > ad7192 driver as a IIO channel with .channel =3D 2 and .extended_name s=
et
> > to "shorted".
> >
> > The problem with this approach, is that the driver provided two IIO
> > channels with the identifier .channel =3D 2; one "shorted" and the othe=
r
> > not. This goes against the IIO ABI, as a channel identifier should be
> > unique.
> >
> > Address this issue by changing "shorted" channels to being differential
> > instead, with channel 2 vs. itself, as we're actually measuring AIN2 vs=
.
> > itself.
> >
> > Note that the fix tag is for the commit that moved the driver out of
> > staging. The bug existed before that, but backporting would become very
> > complex further down and unlikely to happen.
> >
> > Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Co-developed-by: Alisa Roman <alisa.roman@analog.com>
> > Signed-off-by: Alisa Roman <alisa.roman@analog.com>
>
> +CC Fabrizio who has a fix series under review for the same driver.
>
> I'm going to let this one sit on the list for a little while.
> It is a breaking ABI change (that hopefully no one will notice - given
> the first fix from Fabrizio shows the driver crashes on probe currently w=
e
> should be safe on that).
>
> Arguably just changing the index would also have been an ABI change, but
> that would have gotten past any code that didn't take much notice of the
> channel index whereas this won't.
>
> Anyhow, will give it a little while for comments then pick this up
> on top of Fabrizio's fixes series.  Give me a poke in 2-3 weeks if I
> seem to have lost it.

The bug report in libiio related to this patch was from the company I work =
for.
I guess this confirms there are few actual users of the driver (at least
of its later revisions).

I see a somewhat limited usage of the "input2 vs input2" configuration,
it was just causing a libiio initialization issue, without impacting
sysfs operation.
The breaking ABI change would impact only users of this channel
relying on sysfs without libiio.

I tested this patch and I confirm it solves the issue with libiio.

Fabrizio

>
> Jonathan
>
>
> > ---
> >  drivers/iio/adc/ad7192.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 55a6ab591016..99bb604b78c8 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -897,10 +897,6 @@ static const struct iio_info ad7195_info =3D {
> >       __AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE,=
 \
> >               BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> >
> > -#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
> > -     __AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOL=
TAGE, \
> > -             BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> > -
> >  #define AD719x_TEMP_CHANNEL(_si, _address) \
> >       __AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
> >
> > @@ -908,7 +904,7 @@ static const struct iio_chan_spec ad7192_channels[]=
 =3D {
> >       AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
> >       AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
> >       AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> > -     AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
> > +     AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
> >       AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
> >       AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
> >       AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
> > @@ -922,7 +918,7 @@ static const struct iio_chan_spec ad7193_channels[]=
 =3D {
> >       AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
> >       AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
> >       AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
> > -     AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
> > +     AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
> >       AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
> >       AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
> >       AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
>
