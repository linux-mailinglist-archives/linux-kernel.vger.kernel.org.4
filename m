Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10375B9BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIONd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIONdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DB915F2;
        Thu, 15 Sep 2022 06:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0DFB623D1;
        Thu, 15 Sep 2022 13:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD43C433C1;
        Thu, 15 Sep 2022 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663248799;
        bh=kt02/lYM/nXNYS/sA9FY5uDsp9UoiQbwCjmcrQB3SP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GcfK0Cg95szDdUA1f6QcCW77hz7+R9uY/IeuL4tcF0/28pEY06FFpEYxNg4BjOfBG
         yKr1RGAu5xM1MoJFXfFfZouzCU/58QcN1RfYLSTUMJr2ZT7e3/Rl5PO4q+wl13Jykz
         ecNf8TLp9708yO3CSAxzfPAIhVQM2SkwseaQNcsc49RVzQ14Mw9gyZWi6RbVPNLUS4
         V9y9ACQg/ql4YkENREAig73VBZLSAt+rKVVF8+2VJLnF4Lpxdz5b1Se7QMSwYpvqb1
         sSTwuUcd0YAqYhwlVdg4OWJLRJPgGzIKluKGMX9wJTJ92gVKjZ271DPYn2fg+oIl6e
         JWfV5Hgw0nhIg==
Date:   Thu, 15 Sep 2022 14:33:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] iio: pressure: bmp280: Add more tunable config
 parameters for BMP380
Message-ID: <20220915143317.11073134@jic23-huawei>
In-Reply-To: <505a681fe6f18139c8cb0e966a706979f41b7d7e.camel@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
        <680e7218234676ba78fc5eccd5f93e29c06c3983.1659872590.git.ang.iglesiasg@gmail.com>
        <CAHp75VeNctrQjW4RHwbsF-y--9bAzg3XTFTZzXk+6whRFJcFYg@mail.gmail.com>
        <505a681fe6f18139c8cb0e966a706979f41b7d7e.camel@gmail.com>
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

On Mon, 12 Sep 2022 02:53:06 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Mon, 2022-08-08 at 11:13 +0200, Andy Shevchenko wrote:
> > On Sun, Aug 7, 2022 at 2:44 PM Angel Iglesias <ang.iglesiasg@gmail.com>=
 wrote: =20
> > >=20
> > > Allows sampling frequency and IIR filter coefficients configuration
> > > using sysfs ABI.
> > >=20
> > > The IIR filter coefficient is configurable using the sysfs attribute
> > > "filter_low_pass_3db_frequency". =20
> >=20
> > ...
> >  =20
> > > +static const int bmp380_odr_table[][2] =3D { =20
> >=20
> > s32_fract ? =20
>=20
> I modeled this bit and other ODR representations after the adxl355 driver=
. I see
> that s32_fract would be a bit cleaner than having arrays inside arrays, b=
ut I'm
> failing to see which additional advantages would provide.
> Also, technically, these are precomputed frequencies, the first index is =
the
> integer part and the second is the fractional part. The fractions would be
> 200/1, 200/2, 200/4 ... 200/131072
>=20
Agreed. Don't use s32_fract for this.  It would be misleading.

Jonathan

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_200HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D {200, 0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_100HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D {100, 0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_50HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D {50, 0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_25HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D {25, 0},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_12_5HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {12, 500000},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_6_25HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {6, 250000},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_3_125HZ]=C2=A0=C2=
=A0=C2=A0 =3D {3, 125000},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_1_5625HZ]=C2=A0=C2=
=A0 =3D {1, 562500},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_78HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {0, 781250},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_39HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {0, 390625},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_2HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D {0, 195313},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_1HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D {0, 97656},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_05HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {0, 48828},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_02HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {0, 24414},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_01HZ]=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D {0, 12207},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_006HZ]=C2=A0=C2=
=A0=C2=A0 =3D {0, 6104},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_003HZ]=C2=A0=C2=
=A0=C2=A0 =3D {0, 3052},
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [BMP380_ODR_0_0015HZ]=C2=A0=C2=
=A0 =3D {0, 1526},
> > > +}; =20
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D regmap_write_bits(data->regmap,
> > > BMP380_REG_POWER_CONTROL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BMP380_MODE_MASK, =20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 FIELD_PREP(BMP380_MODE_MASK,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BMP380_MODE_SLEEP)); =20
> >=20
> > One line?
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D regmap_write_bits(data->regmap,
> > > BMP380_REG_POWER_CONTROL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BMP380_MODE_MASK, =20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 FIELD_PREP(BMP380_MODE_MASK,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BMP380_MODE_NORMAL)); =20
> >=20
> > Ditto.
> >=20
> > ...
> >  =20
> > > +static const int bmp380_iir_filter_coeffs_avail[] =3D { 0, 1, 3, 7, =
15, 31,
> > > 63, 127 }; =20
> >=20
> > This seems like a power of two - 1, can it be replaced by a formula in =
the
> > code?
> >  =20
>=20

