Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9992460C2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJYE7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJYE7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:59:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732CF6C17;
        Mon, 24 Oct 2022 21:59:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bj12so9596738ejb.13;
        Mon, 24 Oct 2022 21:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLEojOTx4aCHHmvecOfOHhfWOkFg1/CUYSoEkScMIjE=;
        b=YFKwJLKrm4K1Eavnaf/cFwJnw+eKNPwrrbduQh9Q1u3d6dh1g4oTxz/nWXCADNtZRs
         dyQZ3JRlmUwrZDVxua4O8u2qgFzUxgXn+RD8SPqYDhFxRF0z9hYcTIOzyPrlm3BLjMx5
         G0qJ7cISAlMjxJ5w0b6KfhopOdscbufzAxSoZ57xX+l5JT/ZnJOQLjCIxhtF6TymeejL
         CO3RPADAXVCxSyP7JNGyvsLbp2+l17wHUKoi4YYSWZibmAQm6sr74RU6aKqZozwpwNA4
         MOwrt6CNwrmDJRYsg0M4XVxP3v/Gx5iCFKe1GFB5KjcNnXssapjx6BnGdz4tegmpD8zW
         HbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLEojOTx4aCHHmvecOfOHhfWOkFg1/CUYSoEkScMIjE=;
        b=jU1oNJ1cwdXCTo8th+rDYkqem3EorHKBVz5jV/K8GUgIPICSQjc0nxlf49/JGeJ/TR
         zdc7nKK3ZncTeo24fVL2fISsx6DI1BuEEzvmfAT5OsOp4ZqwqgrkGK1Qp2VH6uULPFfK
         Zhh7CZvHO2tn5QPmGk20/7amH3OXqOOn5lxzYrWbZN02o90jjGmLuKGLGn2C7S8mqaU/
         XCxX9NMGk1PwaZxRCGhQgEvWS9J73x9yLNf4BpC7aypyitWuIvVG/4CQx2urIsplk9as
         /OJuMNZrRNCkKTCmCmwtwQkamI2Ywd4ECRRlbYTdQARjYp8JjR6OZw66xGaYm0nxgsxQ
         PGUQ==
X-Gm-Message-State: ACrzQf3vCIL8eKN+NcdGA5EyfJP6CzuIVenynX0bZyvW7Ugt32dFlfZ+
        Rl5bfGhR/pCof+3MgbjW9Q7FM459GpjScA==
X-Google-Smtp-Source: AMsMyM5X/LNSIFW6rNz3HjHRFRCKyv5p2VVlxs+ZmoFUh4niWWPOeEJ1e+Amw6kckueNC0XW9LBO8Q==
X-Received: by 2002:a17:906:844f:b0:78d:8bd1:ee8c with SMTP id e15-20020a170906844f00b0078d8bd1ee8cmr32012478ejy.262.1666673943304;
        Mon, 24 Oct 2022 21:59:03 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906960e00b00780ab5a9116sm746067ejx.211.2022.10.24.21.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 21:59:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1] media: cedrus: Propagate error code from cedrus_h265_skip_bits()
Date:   Tue, 25 Oct 2022 06:59:01 +0200
Message-ID: <12078224.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
References: <20220914150105.209484-1-dmitry.osipenko@collabora.com> <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Dne ponedeljek, 24. oktober 2022 ob 13:38:36 CEST je Hans Verkuil napisal(a=
):
> Hi Dmitry,
>=20
> This patch has a conflict with this patch from Jernej:
>=20
> https://patchwork.linuxtv.org/project/linux-media/patch/20221017194413.11=
983
> 01-1-jernej.skrabec@gmail.com/
>=20
> I decided to take Jernej's patch first. Can you make a v2 that sits on top
> of that patch?

I believe you already merged first version of the patch for 6.1. No need fo=
r=20
this version though, first version already solves main issue.

Best regards,
Jernej

>=20
> Thanks!
>=20
> 	Hans
>=20
> On 9/14/22 17:01, Dmitry Osipenko wrote:
> > The cedrus_h265_skip_bits() may get into infinite loop if decoding
> > parameters are incorrect. In this case we detect the loop and print
> > a error message, continuing the decoding that is fated to fail.
> >=20
> > Will be cleaner to abort the decoding early. Propagate the error code
> > to cedrus_device_run() and reset hardware on the cedrus_h265_skip_bits()
> > failure.
> >=20
> > Suggested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >=20
> >  drivers/staging/media/sunxi/cedrus/cedrus_dec.c  |  2 ++
> >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 15 ++++++++++++---
> >  drivers/staging/media/sunxi/cedrus/cedrus_hw.c   |  7 ++++++-
> >  drivers/staging/media/sunxi/cedrus/cedrus_hw.h   |  2 ++
> >  4 files changed, 22 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c index
> > e7f7602a5ab4..ae5df3dc01c0 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> > @@ -112,6 +112,8 @@ void cedrus_device_run(void *priv)
> >=20
> >  		dev->dec_ops[ctx->current_codec]->trigger(ctx);
> >  =09
> >  	} else {
> >=20
> > +		cedrus_hw_reset(dev);
> > +
> >=20
> >  		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
> >  	=09
> >  						 ctx-
>fh.m2m_ctx,
> >  						=20
VB2_BUF_STATE_ERROR);
> >=20
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > 4952fc17f3e6..f409f59452d8 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > @@ -224,9 +224,10 @@ static void cedrus_h265_pred_weight_write(struct
> > cedrus_dev *dev,>=20
> >  	}
> > =20
> >  }
> >=20
> > -static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
> > +static int cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
> >=20
> >  {
> > =20
> >  	int count =3D 0;
> >=20
> > +	int err;
> >=20
> >  	while (count < num) {
> >  =09
> >  		int tmp =3D min(num - count, 32);
> >=20
> > @@ -235,11 +236,16 @@ static void cedrus_h265_skip_bits(struct cedrus_d=
ev
> > *dev, int num)>=20
> >  			     VE_DEC_H265_TRIGGER_FLUSH_BITS |
> >  			     VE_DEC_H265_TRIGGER_TYPE_N_BITS(tmp));
> >=20
> > -		if (cedrus_wait_for(dev, VE_DEC_H265_STATUS,
> > VE_DEC_H265_STATUS_VLD_BUSY)) +		err =3D cedrus_wait_for(dev,
> > VE_DEC_H265_STATUS, VE_DEC_H265_STATUS_VLD_BUSY); +		if=20
(err) {
> >=20
> >  			dev_err_ratelimited(dev->dev, "timed out=20
waiting to skip bits\n");
> >=20
> > +			return err;
> > +		}
> >=20
> >  		count +=3D tmp;
> >  =09
> >  	}
> >=20
> > +
> > +	return 0;
> >=20
> >  }
> > =20
> >  static void cedrus_h265_write_scaling_list(struct cedrus_ctx *ctx,
> >=20
> > @@ -408,6 +414,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx,
> > struct cedrus_run *run)>=20
> >  	u32 pic_order_cnt[2];
> >  	u8 *padding;
> >  	int count;
> >=20
> > +	int err;
> >=20
> >  	u32 reg;
> >  =09
> >  	sps =3D run->h265.sps;
> >=20
> > @@ -534,7 +541,9 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx,
> > struct cedrus_run *run)>=20
> >  	/* Include the one bit. */
> >  	count++;
> >=20
> > -	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 -=20
count);
> > +	err =3D cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8=
=20
=2D
> > count); +	if (err)
> > +		return err;
> >=20
> >  	/* Bitstream parameters. */
> >=20
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c index
> > a6470a89851e..e9ceca332062 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> > @@ -168,11 +168,16 @@ void cedrus_watchdog(struct work_struct *work)
> >=20
> >  					=20
VB2_BUF_STATE_ERROR);
> > =20
> >  }
> >=20
> > +void cedrus_hw_reset(struct cedrus_dev *dev)
> > +{
> > +	reset_control_reset(dev->rstc);
> > +}
> > +
> >=20
> >  int cedrus_hw_suspend(struct device *device)
> >  {
> > =20
> >  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
> >=20
> > -	reset_control_assert(dev->rstc);
> > +	cedrus_hw_reset(dev);
> >=20
> >  	clk_disable_unprepare(dev->ram_clk);
> >  	clk_disable_unprepare(dev->mod_clk);
> >=20
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h index
> > 7c92f00e36da..919c4475f0d7 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
> > @@ -30,4 +30,6 @@ void cedrus_hw_remove(struct cedrus_dev *dev);
> >=20
> >  void cedrus_watchdog(struct work_struct *work);
> >=20
> > +void cedrus_hw_reset(struct cedrus_dev *dev);
> > +
> >=20
> >  #endif




