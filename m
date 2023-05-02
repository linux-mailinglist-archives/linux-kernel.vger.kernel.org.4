Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6BA6F3F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjEBIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjEBIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:20:04 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FCF526F;
        Tue,  2 May 2023 01:19:44 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9AB0A1C0AAC; Tue,  2 May 2023 10:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1683015548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amEFe/AE8jRh6/Xwc3QzQAWClDEiUJE0RbFRN3x/zrA=;
        b=ohp4qkGeHKc9LrlWEsJdYNeZsW7Ilzal+Wd6cQH8k0HFQEOpeltRuLwimI4wIq2QV5oR72
        lxSFJhGeJQRsLZVme5A6pkHN5DqlPIx5nFcg5ls1osn76DcKzoGRTafKt5RuE04gWD4Uo9
        uVlpVcBDKxHxA2H6/Y89MJmMy+zdrSc=
Date:   Tue, 2 May 2023 10:19:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH 5.15 v3 5/5] counter: 104-quad-8: Fix race
 condition between FLAG and CNTR reads
Message-ID: <ZFDHe0a7kcJXQoNM@duo.ucw.cz>
References: <20230411155220.9754-1-william.gray@linaro.org>
 <20230411155220.9754-5-william.gray@linaro.org>
 <ZD1MZO3KpRmuzy42@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YuWiOo1iHaN3h6UL"
Content-Disposition: inline
In-Reply-To: <ZD1MZO3KpRmuzy42@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YuWiOo1iHaN3h6UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, Apr 11, 2023 at 11:52:20AM -0400, William Breathitt Gray wrote:
> > commit 4aa3b75c74603c3374877d5fd18ad9cc3a9a62ed upstream.
> >=20
> > The Counter (CNTR) register is 24 bits wide, but we can have an
> > effective 25-bit count value by setting bit 24 to the XOR of the Borrow
> > flag and Carry flag. The flags can be read from the FLAG register, but a
> > race condition exists: the Borrow flag and Carry flag are instantaneous
> > and could change by the time the count value is read from the CNTR
> > register.

> > Since the race condition could result in an incorrect 25-bit count
> > value, remove support for 25-bit count values from this driver.

I believe usual solution is to read the carry, read the counter, and
read the carry again. If old_carry =3D new_carry, we are pretty sure we
did not hit the race, and can use 25 bit value.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--YuWiOo1iHaN3h6UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZFDHewAKCRAw5/Bqldv6
8vlpAKCFBg45QB+KFONqyP6+X7EHhS4IYgCeJ8GNZyQWfm63Nnq+NBigLvYUKPY=
=GwcR
-----END PGP SIGNATURE-----

--YuWiOo1iHaN3h6UL--
