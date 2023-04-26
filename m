Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71876EF3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbjDZMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbjDZMDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:03:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0B4C12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:02:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a6762fd23cso59045715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1682510570; x=1685102570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/ZJvITr8KkQOHptvc/4Q9ya9xSDX/U43gmvan7hhKU=;
        b=LHGu3pjDBJLpaFUJbFE46f0Nt3CTbOiwgFAmrHLLD4f5otkROHDMFrXZe3Nu6+J1A1
         It6sCGAMNkfTS0Nw/+8/rAsLatPzQzyKq7wWKwFyKq6nXwFpM/cpxxGSEqVWjt9pZYWT
         5hl8rkHajZIaLtlGecDCaCk323FjJ4k85T502pkYCMjq8PYQwaARmQVdTqZwWu1PS+aJ
         waIgDO1Sjfe/GZx2GQ23WOnFrcN0yuXq7YHfY9DCmw5nlGhzRYsr64OdsWBEzlt6F/tc
         eWTCOEYhBTlKDz34zb2d7TXo9J8EcBexkXkjT/lubMJz/5cfvQK9jZ4UpAoBDP3C7ypW
         YKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682510570; x=1685102570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/ZJvITr8KkQOHptvc/4Q9ya9xSDX/U43gmvan7hhKU=;
        b=btj5r0BgKl1+r6eng/COLhGQh3zOhvmy7YoUdVGYsVENxxDrgAA+wsmoMxYqxo73f5
         6WM70mbz72HbSjp+O15R6dC+sOMTKOoZdQBj40UMlw46YMVIDhOiE2RQosIq4BIIZb26
         YDICong0JYCpvix/RetoJCVOY94BZLBA466sQXUJDEcFVXLk8tl+DF8OMr0d2+EJTnGA
         9vv+SfNta29IDuZ5IQaWa3vLCcEryeW7t6gbDTsRezoGJeN0DyDoyfKP2XpeLwMlXbxt
         rxI/D513KcllnzucM33QhOtfE2Vxkqkw40+Z3HjlJQKjcsJCTsvLonhfS2KEv/d6HIGJ
         9X6w==
X-Gm-Message-State: AAQBX9dX+3n+rtymtUEYMED0zvriaKliU/HggshnxqU9jBEksi0Rtdbg
        /2ciMM5N96+FJkmtjmT93qcszWgjcZhPROLc7P+woiiZ93uvNkBxNYs=
X-Google-Smtp-Source: AKy350bHLjfCqNJNNZNVfoIuedLydbz+xrRy8UIckV8r+z3xeD7GYSUoBubCEVMm+SMbra972i0vf4I61xxbcQ6onBU=
X-Received: by 2002:a17:903:2441:b0:1a0:50bd:31a8 with SMTP id
 l1-20020a170903244100b001a050bd31a8mr27072916pls.26.1682510570638; Wed, 26
 Apr 2023 05:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230420102316.757-1-honda@mechatrax.com> <20230423121528.259d3cd4@jic23-huawei>
In-Reply-To: <20230423121528.259d3cd4@jic23-huawei>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Wed, 26 Apr 2023 21:02:13 +0900
Message-ID: <CA+Tz-SEAyXcJ++YDzDC=ySd1gOC-j-DDp8sMHBUCSy9Q3wQ4HA@mail.gmail.com>
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Apr 23, 2023 at 7:59=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 20 Apr 2023 19:23:16 +0900
> Masahiro Honda <honda@mechatrax.com> wrote:
>
> > The Sigma-Delta ADCs supported by this driver can use SDO as an interru=
pt
> > line to indicate the completion of a conversion. However, some devices
> > cannot properly detect the completion of a conversion by an interrupt.
> > This is for the reason mentioned in the following commit.
> >
> > commit e9849777d0e2 ("genirq: Add flag to force mask in
> >                       disable_irq[_nosync]()")
> >
> > A read operation is performed by an extra interrupt before the completi=
on
> > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLA=
ZY
> > flag.
> >
> > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > ---
> > v3:
> >  - Remove the Kconfig option.
> > v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechat=
rax.com/
> >  - Rework commit message.
> >  - Add a new entry in the Kconfig.
> >  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing th=
e IRQ.
> > v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechat=
rax.com/
> >
> >  drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index d8570f620..215ecbedb 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *indio_d=
ev, struct iio_trigger *trig)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
> >
> > +static void ad_sd_free_irq(void *sd)
> > +{
> > +     struct ad_sigma_delta *sigma_delta =3D sd;
> > +
> > +     irq_clear_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY)=
;
> > +     free_irq(sigma_delta->spi->irq, sigma_delta);
> > +}
>
> Don't fuse the two operations unwinding like this.  Just register a callb=
ack that only
> does the irq_clear_status_flags immediately after setting them.  Then lea=
ve
> the orginally devm_request_irq call alone.  If it fails, the devm cleanup=
 will
> deal with the irq_clear_status_flag for you.
>
> It almost never makes sense for a single devm call to unwind more than on=
e function call in
> a driver.
>
> Otherwise this looks fine to me,
>
> Thanks,
>
> Jonathan
>

I understand. I'll fix it.

Thanks,
