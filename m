Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3656B61567A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKBAQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:16:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FF10B9;
        Tue,  1 Nov 2022 17:16:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so339376wms.0;
        Tue, 01 Nov 2022 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6EgJHcNc9I4Hg68B4v54gsqbN5dL6gMdd+mtOwKKfWQ=;
        b=eXIDVLm2x52AdgKdH1WyIVfjTCZX4+dnaPvNdX8OkfPZnW0AquTc3oqES44BmI7f3o
         83RHeP9/PUEJbtHkpgCmAPAfD3s9ncp3Jos6q+nQmoAYuuVXxtLF0wEZwEdI+5blRciT
         sYx3Mc1P1Cu/scsLYGwrx33fCwfLjYDeosPm2NRES57lKCVvQPT2vGyqsQvGthQDA9qY
         OwzsU88NpdaeYkoOkZ7FRdMbDBHuSheVb5Fcf3aZy6bnTvmZrz6eJYQXMvm1J+ZFuXsR
         UK0ifiZJWiBfyrxkWHHmwLPUGSPfJVguNq22BxuTQkLpWAlbyzWWde5RGtOtx1dHvZDI
         YGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EgJHcNc9I4Hg68B4v54gsqbN5dL6gMdd+mtOwKKfWQ=;
        b=xjqGqlJRYr8g2yAPQ8LVuIGWrjBrWcH5+7K1+ydhpGQcj6ded0UxDX3hWV29Qvzuwm
         VTqnE36HTBbPPsgUodNyd2KD1HVWwFWdzvou/P56GRLbyF+lzTeTILWXHwxYzV5MlEF5
         tE9gAdO9opGL1dgnFNsO0GX2ocHnI+kDf+IrNF5YMQXKHnNbI8Dgds3A1pC+3SUf2p1k
         Z522lCoC431UUcMGyWLx8HVfCc7RhqLA92CCIC0Ttt6hP7Ed9LsI5be4CbydeFRFwhBl
         ARrclZyCGJjey1ejvgWymI2D6dK/eYE/xiFOwP1c6DaH9G62Ov6frK91FkpXDL3Lg78W
         FizA==
X-Gm-Message-State: ACrzQf0e4MPuFE1tRg5Dux08jbuLVBhVInXxhL55D/TIo1zV4uZtBQmR
        T2TQe85hjDd3gMD76SJj/2Gj7dah+iM=
X-Google-Smtp-Source: AMsMyM4bqf2Q2DAJavIvv67fkz1F+mis5E51X6JVvDcGHELGOnt56JeXjFBEQ0/iqEwRHWznhtTZ2A==
X-Received: by 2002:a05:600c:6885:b0:3c2:9da1:5034 with SMTP id fn5-20020a05600c688500b003c29da15034mr13720974wmb.38.1667348206213;
        Tue, 01 Nov 2022 17:16:46 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002365cd93d05sm10965055wrs.102.2022.11.01.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:16:45 -0700 (PDT)
Message-ID: <ae43aa9c3a9f29d0ecef69756a539ebf00a84ab1.camel@gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: pressure: bmp280: convert to i2c's
 .probe_new()
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Nov 2022 01:16:44 +0100
In-Reply-To: <20221101215236.ihoqkx2xckilom67@pengutronix.de>
References: <cover.1667151588.git.ang.iglesiasg@gmail.com>
         <af8ed10a85d48531c50823163e6c55b2a72371ef.1667151588.git.ang.iglesiasg@gmail.com>
         <20221101215236.ihoqkx2xckilom67@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-01 at 22:52 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Oct 30, 2022 at 06:53:11PM +0100, Angel Iglesias wrote:
> > Use i2c_client_get_device_id() to get the i2c_device_id* parameter in t=
he
> > .new_probe() callback.
> >=20
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > ---
> > =C2=A0drivers/iio/pressure/bmp280-i2c.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > b/drivers/iio/pressure/bmp280-i2c.c
> > index 0c27211f3ea0..20073b09b3e3 100644
> > --- a/drivers/iio/pressure/bmp280-i2c.c
> > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > @@ -5,11 +5,11 @@
> > =C2=A0
> > =C2=A0#include "bmp280.h"
> > =C2=A0
> > -static int bmp280_i2c_probe(struct i2c_client *client,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct i2c_device_id *id)
> > +static int bmp280_i2c_probe(struct i2c_client *client)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct i2c_device_id *=
id =3D i2c_client_get_device_id(client);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct regmap_con=
fig *regmap_config;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct regmap *regmap;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (id->driver_data=
) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case BMP180_CHIP_ID:
>=20
> What is the motivation for moving regmap? I thought reverse christmas
> tree is only a thing in network code? I would have left the regmap
> declaration where it is.

Long story short, I worked previously on a small refactor of this driver to=
 add
support for a new family of sensors. During the different iterations of the
patchset, one thing that was agreed was unifying the driver coding style to
reverse xmas tree. For some extra context, here's the thread:
https://lore.kernel.org/all/20220814145249.701f1261@jic23-huawei/

> > @@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D bmp280_of_i2c_match,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.pm =3D pm_ptr(&bmp280_dev_pm_ops),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_probe,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe_new=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_probe,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.id_table=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D bmp280_i2c_id,
> > =C2=A0};
> > =C2=A0module_i2c_driver(bmp280_i2c_driver);
>=20
> Best regards
> Uwe
>=20
Kind regards
Angel
