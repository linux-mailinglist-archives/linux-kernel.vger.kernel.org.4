Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49E6C1AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjCTQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjCTQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:04:42 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B4A3BDB6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:54:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o44so4966347qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679327619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7s3A/DGwv7WBw7dO5oMKHGvu+Ybq7w8ym82QotVAyU=;
        b=xRBVBA4AWMnAeXoNfvb8DfBdx9mKeAJx9CeWVlyFYZZa22obu4POITze1ulkKMAjvC
         p06+Mt/yE6xxDNieSxA+DzWIoWIOr+Tl9H7YBRQo/SgfjI70xeITdCZlpU+hrx8jrUpY
         kGlsEhDtRrfM20L6MbEQs7/8i8/vNNdDoE2qvFr0gAieKhmp1ID+t9bxAtLN0eBQGVGO
         mQjUyxMNV5mHObdAAf+TsjU3AcxazJHkaykkwcCS60U6C91jAprsJPKGdzSv8bAWy4wu
         4Tu2cfWrEt42jQuOXyprKaSXKKailMlRICknD5ISrAHjklKLw2ySIZIanKCluv3nLujb
         BMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7s3A/DGwv7WBw7dO5oMKHGvu+Ybq7w8ym82QotVAyU=;
        b=sAgzyMcFjLQy4O/8ABlhvdsk6rKxEXblfnoAWBJnK4RJzHL5Ze+ePpY1vvP/PPhghn
         PmCPnFzUNj4rdecZZBpxNW+b5enPTS+GhUjluo+lw8HhNSDEqUcXgXjd9X6CVZklnPXn
         QjoV2rlvybBOu0l0/LPoi6DbOeln3OEN8htaydU8Znj+jwg5XPU90EeHOdyH3CTRD5xG
         0BS9oBQ+vcS9fsoSgnbPiXOQ5CKTiMt4peuQUOtBfrdBUlntP1v00YKPHKknnvGrwvIB
         vbGETwO4FTFoNc5975aR1k3f/g9O2rB5HSXxyysItmw7FGVW9hho4KGc1uwO9MHN2MAn
         u7ng==
X-Gm-Message-State: AO0yUKVo7OouEwkLtBkBG5Ox/EPxt3xOW92eG0XorGp7I995aPaUjnxO
        o0l8jOZ4l9q9Sy4sG33jNjcvkaznWk8dOwDhIMk=
X-Google-Smtp-Source: AK7set8SsZh5sDU2a1+miGf74SmmwC+TO6/pKMiXl2I+ROIaJLT1U4etn6imHdyNiWJOjQA/k7I0aA==
X-Received: by 2002:a05:6214:2347:b0:56e:9da4:82ff with SMTP id hu7-20020a056214234700b0056e9da482ffmr54125794qvb.50.1679327619121;
        Mon, 20 Mar 2023 08:53:39 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b0074269db4699sm694652qkp.46.2023.03.20.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:53:38 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:53:36 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZBiBgI5mVHAg/59Y@fedora>
References: <cover.1679149542.git.william.gray@linaro.org>
 <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
 <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
 <ZBh8O5oOL0TB9wzT@fedora>
 <ZBh9cUwvV+hi5We8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fyOpXYjtQdJyq73T"
Content-Disposition: inline
In-Reply-To: <ZBh9cUwvV+hi5We8@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fyOpXYjtQdJyq73T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 05:36:17PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 20, 2023 at 11:31:07AM -0400, William Breathitt Gray wrote:
> > On Mon, Mar 20, 2023 at 02:28:31PM +0200, Andy Shevchenko wrote:
> > > On Sat, Mar 18, 2023 at 10:59:51AM -0400, William Breathitt Gray wrot=
e:
> > > > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > > > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > > > dedicated functions to improve code clarity.
>=20
> ...
>=20
> > > > +static void quad8_preset_register_set(struct quad8 *const priv, co=
nst size_t id,
> > > > +				      const unsigned long preset)
> > > > +{
> > > > +	struct channel_reg __iomem *const chan =3D priv->reg->channel + i=
d;
> > > > +	int i;
> > > > +
> > > > +	/* Reset Byte Pointer */
> > > > +	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
> > > > +
> > > > +	/* Set Preset Register */
> > > > +	for (i =3D 0; i < 3; i++)
> > > > +		iowrite8(preset >> (8 * i), &chan->data);
> > > > +}
> > >=20
> > > May we add generic __iowrite8_copy() / __ioread8_copy() instead?
> > >=20
> > > It seems that even current __ioread32_copy() and __iowrite32_copy() h=
as to
> > > be amended to support IO.
>=20
> > Sure, I would use __iowrite8_copy() / __ioread8_copy() for these
> > situations if it were available.
>=20
> If needed, you may always introduce ones.
>=20
> > Is something equivalent available for the regmap API? I'm planning to
> > migrate this driver to the regmap API soon after this patch series is
> > merged, so the *_copy() calls would need to migrated as well.
>=20
> Yes. It's regmap bulk operations.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

After reading through the implementation for these functions I realized
they are actually doing something different than what's happening here.
The 104-QUAD-8 device exposes the 24-bit register by consecutive 8-bit
I/O operations on the same address; however, the iomap_copy and regmap
bulk functions operate on different addresses.

I'm not sure if there really is a way to make the 104-QUAD-8 operation
more generic for other drivers because it configures the current byte
pointer through a separate register from the data register (all of this
feel rather device specific), so I suspect keeping this function local
to 104-quad-8 is best for now.

William Breathitt Gray

--fyOpXYjtQdJyq73T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBiBgAAKCRC1SFbKvhIj
K0wDAP93HV0Gj4xeiDWBbHeWFLfyhiSf9flnQYpPqdmqPGdVbgEAwZeASq9k6oCj
N8Y4mIL7yRicTVlpTwZScTJC72bLnww=
=ZNfg
-----END PGP SIGNATURE-----

--fyOpXYjtQdJyq73T--
