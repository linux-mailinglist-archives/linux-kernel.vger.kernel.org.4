Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1646F4E05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjECAND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECANB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 20:13:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B832680
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 17:13:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso6272214276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683072779; x=1685664779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mszgk8kcqy9NacUC4irOM12AZRObXiNESQ4V20e6ClI=;
        b=qkgJTaRvQKsXbiUwxdR3cT+heU6eWtN2ZDfoZliUoVM3UUesOjfboFzSIbw96Vvx2w
         MxIkoM1/YWtStBrFDCUhLYNrimJUQjgXNyu8++TCdUp5zbSvGP7ir48Fa6G5YkEcnHG8
         76j9FSe0Aed0Qj+mmm03ukANqEXDzhNh0pemxCieZSLeU5vL+MRRmn8mxVYiHkxNGxTK
         naQD23AexjHkDnbBPT9szvXCrdZyM3Quk8A0Yw+V2NFhQr9FzqkGuAwu1Az48PGG9aGE
         dfLWBQvEw8ifReBVNDhaxCg7amUoPQeGnUfZ02ghdhQ9zXmlfO3WtouD1+l+UZ21+rNx
         iuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683072779; x=1685664779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mszgk8kcqy9NacUC4irOM12AZRObXiNESQ4V20e6ClI=;
        b=Rosa5rOzkB+c4eo7WSEuTP8cVGuYWgQezDCemuvW8D62ebwuq8n1LLwTYUYMOeaVh7
         E6EJgWb5KBxsK6mXmFPsvj35WwLJRJeWyqogxiaerZvH1D3wWSLvY2H5InGoidBvdHYL
         VX+t/kdCf75D2isJM0PdBkELjqX2rWQ6vR/S6Z6bP/OmxX7FTfg4Q8Hy9psha6C5PJG3
         PK2M3iCyfZHP7OYSJUDBvbxjbbFuZTO5BkRtueT0ozbO40K/KJz+P6IDMBMGNwPM/j8N
         6cSBWPqIcNjA/n/K7rnKJizhab2Kb9GmgCDQd4EPeruvQT81x7g7TFwhFDeJQmlRA/HC
         T92A==
X-Gm-Message-State: AC+VfDyMLumojt5yGILdFDE1YidoiAuopR2iCXHs3PpZPasb5aQLq4tZ
        MvIVlKBFGxmNy2lGCej8orA0Wrv2l5ja0BtwFl0=
X-Google-Smtp-Source: ACHHUZ6+77di1oBaEHkzxiJH5sZPfohzbAFdZ/RMHcUZtaO3531dWEiuxivGrRiaQP+a6IrJMVm3jg==
X-Received: by 2002:a25:760a:0:b0:b9d:8a4e:e79f with SMTP id r10-20020a25760a000000b00b9d8a4ee79fmr15053557ybc.40.1683072779462;
        Tue, 02 May 2023 17:12:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c82-20020a251c55000000b00b9a7f23c2b8sm2658208ybc.24.2023.05.02.17.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 17:12:58 -0700 (PDT)
Date:   Tue, 2 May 2023 20:12:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH 5.15 v3 5/5] counter: 104-quad-8: Fix race
 condition between FLAG and CNTR reads
Message-ID: <ZFGnCJipt1Dwlxvo@fedora>
References: <20230411155220.9754-1-william.gray@linaro.org>
 <20230411155220.9754-5-william.gray@linaro.org>
 <ZD1MZO3KpRmuzy42@fedora>
 <ZFDHe0a7kcJXQoNM@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4aIilrXIIJYE6/fg"
Content-Disposition: inline
In-Reply-To: <ZFDHe0a7kcJXQoNM@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4aIilrXIIJYE6/fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 10:19:07AM +0200, Pavel Machek wrote:
> Hi!
>=20
> > On Tue, Apr 11, 2023 at 11:52:20AM -0400, William Breathitt Gray wrote:
> > > commit 4aa3b75c74603c3374877d5fd18ad9cc3a9a62ed upstream.
> > >=20
> > > The Counter (CNTR) register is 24 bits wide, but we can have an
> > > effective 25-bit count value by setting bit 24 to the XOR of the Borr=
ow
> > > flag and Carry flag. The flags can be read from the FLAG register, bu=
t a
> > > race condition exists: the Borrow flag and Carry flag are instantaneo=
us
> > > and could change by the time the count value is read from the CNTR
> > > register.
>=20
> > > Since the race condition could result in an incorrect 25-bit count
> > > value, remove support for 25-bit count values from this driver.
>=20
> I believe usual solution is to read the carry, read the counter, and
> read the carry again. If old_carry =3D new_carry, we are pretty sure we
> did not hit the race, and can use 25 bit value.
>=20
> Best regards,
> 									Pavel
> --=20
> People of Russia, stop Putin before his war on Ukraine escalates.

That solution might work if the counter only increases, but if the
counter is straddling the zero threshold then the Carry bit will toggle
as the count overflows, underflows, and overflows again. For example:

    * START
        * Carry=3D0,Count=3DMAX
    * > Counting up...
        * Carry=3D1,Count=3D0
    * DRIVER READS Carry=3D1
    * > Counting down...
        * Carry=3D1,Count=3DMAX
    * > Counting up...
        * Carry=3D0,Count=3D0
    * > Counting up...
        * Carry=3D0,Count=3D42
    * DRIVER READS Count=3D42
    * > Counting down...
        * Carry=3D1,Count=3DMAX
    * DRIVER READS Carry=3D1
        * old_carry =3D new_carry
    * FINAL COUNT: Carry=3D1,Count=3D42
        * This was never a state the counter actually reported

Ultimately, the issue is that we have no way to get both Carry and Count
atomically from the device. As long as there's a race condition there,
we can't prevent possibly misinterpreting the Carry and Count values, so
we unfortunately cannot ensure that our 25-bit Count value is an actual
state the counter reported.

William Breathitt Gray

--4aIilrXIIJYE6/fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZFGnCAAKCRC1SFbKvhIj
KwBgAQDGGMzTRsI9z7a069Eb50Vdm0UUKd5QReSBVCHZCJ0l3gEAq4lqY0R935IJ
rMzdfqgEfGs/j+7TB1AMIqXxcWcLQgA=
=m5Zn
-----END PGP SIGNATURE-----

--4aIilrXIIJYE6/fg--
