Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662895F8C5B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJIQfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiJIQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:35:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E111E248EA;
        Sun,  9 Oct 2022 09:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7445BB80D75;
        Sun,  9 Oct 2022 16:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBE4C433C1;
        Sun,  9 Oct 2022 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665333344;
        bh=c+Le9ocXWIoHOMEoqO5QlnIiTWoWlBDgr3VKXdt1bVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lSeOz0Bcj3GDbcVaTrnxJKUad4yDiVGJe2FCGY5/kHJBkCjbRWDnIH4Kd/9L2Y1KL
         aecIkc13GQjYtrUaHwepVEhMUbSMPNVBJtdAh6KW5wVRl/e//med9TVEUITcVmet7V
         Xc72BQcnLZ3u3Auqr3VARmcfBXJL68ClsYTSpcKA+NXXBxCoRdNUQmAkxlC3m90hCy
         EY7P20tIMlJX+v8c+0tzRxmYGaLG1zUlmimzH/B1Ncv2ITwJ5M+x3DdLEkmaW0IiHg
         9RBEufwh0jmta5iiMEcwIaKv0O4LnDfMXEquxdNNKPCKacSzaZ7tbx3LgFz4IhsG2u
         jUl1CW3gWQaCg==
Date:   Sun, 9 Oct 2022 17:36:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20221009173606.5b8e5661@jic23-huawei>
In-Reply-To: <CAKv63ut4DJCLQP8ckOsC+K4DGy+v2Y5ghfoTjQoyg4CvditW6Q@mail.gmail.com>
References: <cover.1663834141.git.cmo@melexis.com>
        <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
        <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
        <CAKv63ut4DJCLQP8ckOsC+K4DGy+v2Y5ghfoTjQoyg4CvditW6Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 10:20:18 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Sun, 2 Oct 2022 at 18:09, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 22/09/2022 =C3=A0 10:13, cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org=
 a =C3=A9crit : =20
> > > From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
> > > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > > rate (2 seconds). =20
> >
> > Hi,
> >
> > should there be a v7, a few nitpick below.
> > =20
> It was already applied, but I can spin a new patch for the suggested
> changes (the s32 is mostly there because before this patch it was
> returning value for further bit manipulation).

Follow on patch welcome!

Thanks,

Jonathan

>=20
> > >
> > > +     ret =3D regmap_read_poll_timeout(data->regmap, MLX90632_REG_STA=
TUS,
> > > +                                    reg_status,
> > > +                                    (reg_status & MLX90632_STAT_BUSY=
) =3D=3D 0,
> > > +                                    10000, 100 * 10000);
> > > +     if (ret < 0) {
> > > +             dev_err(&data->client->dev, "data not ready");
> > > +             return -ETIMEDOUT; =20
> >
> > Why not "return ret;"?
> > =20
> If you came to this point there were already several i2c reads, so I
> think it is more important to convert those to timeout.
>=20
> > >       mutex_lock(&data->lock);
> > > -     measurement =3D mlx90632_perform_measurement(data);
> > > -     if (measurement < 0) {
> > > -             ret =3D measurement;
> > > +     ret =3D mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> > > +     if (ret < 0)
> > > +             goto read_unlock;
> > > +
> > > +     switch (data->powerstatus) {
> > > +     case MLX90632_PWR_STATUS_CONTINUOUS:
> > > +             measurement =3D mlx90632_perform_measurement(data); =20
> >
> >    ret =3D mlx90632_perform_measurement(data);
> > and
> >    measurement =3D ret;
> > on success would be less verbose (no need for {}, and save 1 LoC) and
> > more in line with mlx90632_calculate_dataset_ready_time() above.
> > =20
> I wanted to change as few lines as possible to avoid clogging the
> patch with unrelated changes. Also in most cases, we will be
> in-success here, so limiting the number of variable copies in the
> success path should be the priority.

