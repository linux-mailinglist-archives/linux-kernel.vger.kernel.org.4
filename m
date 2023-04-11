Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128826DDD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDKOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjDKOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:05:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1223C35
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:05:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q5so11060145ybk.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681221928; x=1683813928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0vFaskCpZmNJeRc0/nVEC/5T8uA71WB290yTzRzGdo=;
        b=VgDdIvVTkOiDV708jd0URUaPP2R0GhLmuy84YnDfCC8l4QK5WRMAeEGfxc6SsvIrNn
         5KhIU4DBXIjusjgqkTJBZ+ptq8kOVofQdOOSnefC7QTRODqCF3TEoNCvvRsuVfHAPeiM
         YLTavuwZYARDQ4V8CppMkXuKfIgmc6nIDOK7sYR/+A6QAlZQh9caB2tPMwMMfphCRQmp
         +vpw4zeLIl1aa35veoPcSrBttTYsserRG0rE0Yu9Run6BV65hvWipgi/+CpA51xJxnZo
         5h327lq7WGbhGGgDnK3rnO7XRAJf5+gMbdbl0e4fJ1lhoXGSiHP0YxgQWhEaMRLOZeKg
         EyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221928; x=1683813928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0vFaskCpZmNJeRc0/nVEC/5T8uA71WB290yTzRzGdo=;
        b=TV8et86s3qhqTLo15QIUJntqvthlv1FKlMJUEpIyeAkY2+AfLo4fu0fcVNdfWcci6K
         kwFfmxkgdUJCD25U76qiY7/aYTEze0z65M7f1tRuFWIKNTOlQVuAV03PL0O6eAKcENLE
         8yIM04/xMdRca2nxY3QIev9YYoCRRVYWIBcgghd7afFLBRB8ith/IApRrH4F3zoyCOtD
         QwYFR9ZoEaFQo5wyoHDy5NRWICH4+KJjReE4v2AiEi/sTPcVZqo1sJ3Y2jXc3GorH2eb
         scRQXdbT219KoiJOjZXM6jctzJ/0HjxnD3bmRVB/mlRIfgxL9u5t1FI4ygKOGIus9tE2
         7fbg==
X-Gm-Message-State: AAQBX9efqM307eSq1qG3oZ5Cu+S5HKNCXmLx3DN0ziQ2qGvaVateexM2
        88nBCi2AppUaHUI388rU9Ue6xQ==
X-Google-Smtp-Source: AKy350b5bYtpIsKCWn3lVRtZx+gH/IQvKDmS8WixA4HXanBaMMo4Bcx0pmk8k7zhvETs8fIN4J6k/w==
X-Received: by 2002:a25:dc90:0:b0:b8b:f8c5:27d1 with SMTP id y138-20020a25dc90000000b00b8bf8c527d1mr1798866ybe.24.1681221927887;
        Tue, 11 Apr 2023 07:05:27 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 187-20020a8103c4000000b00545a081847fsm3511942ywd.15.2023.04.11.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:05:27 -0700 (PDT)
Date:   Tue, 11 Apr 2023 10:05:25 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/3] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZDVpJb9DyIU+5eJf@fedora>
References: <cover.1681134558.git.william.gray@linaro.org>
 <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
 <ZDVli05x7u/bg7Zc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OjifHeE5SWJCA/bY"
Content-Disposition: inline
In-Reply-To: <ZDVli05x7u/bg7Zc@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OjifHeE5SWJCA/bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 04:50:03PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 10, 2023 at 10:03:13AM -0400, William Breathitt Gray wrote:
> > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > dedicated functions to improve code clarity.
>=20
> ...
>=20
> >  	*val =3D 0;
>=20
> Is not needed now as always being initialized by below call.

The regmap_noinc_read() call only reads the number of bytes requested.
Since we request 3 bytes, the upper bytes of the u64 val remain
uninitialized, so that is why we need to set *val =3D 0. This isn't
immediately clear in the code, so I can add a comment to make it
explicit.

>=20
> >  	spin_lock_irqsave(&priv->lock, irqflags);
> > =20
> >  	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
> > -
> > -	for (i =3D 0; i < 3; i++)
> > -		*val |=3D (unsigned long)ioread8(&chan->data) << (8 * i);
> > +	ioread8_rep(&chan->data, val, 3);
> > =20
> >  	spin_unlock_irqrestore(&priv->lock, irqflags);
>=20
> ...
>=20
> > +	struct channel_reg __iomem *const chan =3D priv->reg->channel + id;
>=20
> Not sure if array representation will look better here and elsewhere.
>=20
> 	struct channel_reg __iomem *const chan =3D &priv->reg->channel[id];

Perhaps so, but all these struct channel_reg lines will go away in the
next patch [0] migrating to the regmap API, so for the sake of stability
of this patch I hesitate to change these lines.

William Breathitt Gray

[0] https://lore.kernel.org/all/20230410141252.143998-1-william.gray@linaro=
=2Eorg/

--OjifHeE5SWJCA/bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDVpJQAKCRC1SFbKvhIj
K1QNAP9X/VRSYKcIROBO8Z/a3tPqYka7FBDZ4yVZcuyEYLY5NwD9HijhOiOYe4/S
3MLRTNY1lrcDilW1/R1pPt6uDjf9dAM=
=WFt0
-----END PGP SIGNATURE-----

--OjifHeE5SWJCA/bY--
