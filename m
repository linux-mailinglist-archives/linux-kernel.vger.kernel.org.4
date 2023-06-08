Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BF7276BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjFHFcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHFck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:32:40 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530DBE7;
        Wed,  7 Jun 2023 22:32:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62613b2c8b7so2337856d6.1;
        Wed, 07 Jun 2023 22:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686202358; x=1688794358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2OFGIuk/0ZguBRl1X7uFzHckLFOr1kSCfMjfwMf9W8=;
        b=qoMp/yLodDw9nsr5LnE3tGWU+9Ws4ygi8TqVxIQNvl+GqplEj1rOIc5FnXwIxpXe5a
         Xnj0rcPNBL31fnBJMMrevabN48jCejuB3ZvcNSbKSwUj5Rb+0qNm3uA6kyumcmt/nmR/
         FTQXOjY8D+AZMdKSTbNTky6c+WLOwS7p7c2qHCi35VOP08346/q4wNZN759uDU+v/b6k
         AgPwu/1nsYifZ0BoEStSMX/DGeyze0Q4lUri1uQrmeHbRn70/Bugyo3vOoSapzI5k2pW
         pvWyj0E8SGNaVFw73Yq/3MovmTa6g2zhjGwx1mv6A1RUda3C8NhV/OP0vlPOrBaFsp+v
         esfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686202358; x=1688794358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2OFGIuk/0ZguBRl1X7uFzHckLFOr1kSCfMjfwMf9W8=;
        b=Xf1MB6RSUuk7J8W1oevmPq38pGfVEt7/jGesxchPxJLoVOmBwd84go9l7xySfyrWFy
         zIz67G0KG4g407bHXmTRp2HcjyqmflcNdqowZnXX7uUu3ZOOKbgbI/XrhXRA2iaUbTJW
         n1JipwwoHUH9dkmNnmpZHFRFyCUIkXC0hJuYouZvFnIDY9zusIbw4VTx8C1qRtCGjfFj
         n6viYbDdDblQHne2qXbQ6kq4qtQatC2MbJ7mRiFZ9HPhGDmzKbj3RItbcAllIsyRI+sm
         CK/liznCjxfC/lJPNvRZo2ROiK+wWxmvTrjkmhikJdurmICC1aqDxk0OOUIj45xXvYlE
         pkVg==
X-Gm-Message-State: AC+VfDx2OH+3CzJDEnVAamCNcBrzIVfa44BAWyTUoQkNRL5UQlbj7oji
        i1ZgE9wHRlFZ9/PiPvWzC9U=
X-Google-Smtp-Source: ACHHUZ6Yd0uD+lPMu+WRO51kABisCs6xCdPxgBV7w0346Y5pSLhMQVaHAoCNGlfubwmhDgLj+1l3cA==
X-Received: by 2002:a05:6214:230b:b0:62a:d642:df29 with SMTP id gc11-20020a056214230b00b0062ad642df29mr595195qvb.39.1686202358371;
        Wed, 07 Jun 2023 22:32:38 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-10.three.co.id. [180.214.233.10])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b0019c13d032d8sm436511plb.253.2023.06.07.22.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:32:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 946451069EA; Thu,  8 Jun 2023 12:32:34 +0700 (WIB)
Date:   Thu, 8 Jun 2023 12:32:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Richard Fontana <rfontana@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to
 corresponding SPDX license identifier
Message-ID: <ZIFn8mNXVcI0SGTR@debian.me>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-18-bagasdotme@gmail.com>
 <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrhHIH4HO9EIBTVB"
Content-Disposition: inline
In-Reply-To: <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xrhHIH4HO9EIBTVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 09:47:33AM -0400, Richard Fontana wrote:
> On Wed, Jun 7, 2023 at 1:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > License boilerplate in CTS mode implementation (crypto/cts.c) looks like
> > MIT license with advertising clause. Replace it with correspondig
> > SPDX tag.
> >
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  crypto/cts.c | 24 +-----------------------
> >  1 file changed, 1 insertion(+), 23 deletions(-)
> >
> > diff --git a/crypto/cts.c b/crypto/cts.c
> > index 8f604f6554b1c3..9ec7e9787c0f6a 100644
> > --- a/crypto/cts.c
> > +++ b/crypto/cts.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: MIT
> >  /*
> >   * CTS: Cipher Text Stealing mode
> >   *
> > @@ -5,29 +6,6 @@
> >   * The Regents of the University of Michigan
> >   * ALL RIGHTS RESERVED
> >   *
> > - * Permission is granted to use, copy, create derivative works
> > - * and redistribute this software and such derivative works
> > - * for any purpose, so long as the name of The University of
> > - * Michigan is not used in any advertising or publicity
> > - * pertaining to the use of distribution of this software
> > - * without specific, written prior authorization.  If the
> > - * above copyright notice or any other identification of the
> > - * University of Michigan is included in any copy of any
> > - * portion of this software, then the disclaimer below must
> > - * also be included.
> > - *
> > - * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
> > - * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
> > - * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
> > - * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
> > - * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
> > - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
> > - * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
> > - * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
> > - * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
> > - * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
> > - * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
> > - * SUCH DAMAGES.
> >   */
>=20
> This is not the MIT license (as defined by SPDX) - there may not be an
> SPDX identifier covering this license text.
>=20
> This is at least the second time in your recent patches where you have
> assumed that a non-GPL license corresponds to a particular SPDX
> identifier without (apparently) checking.
>=20

I was thought of interpolating license tags (heuristic matching) in
cases like this. In this case, the UoMi license was adapted from
(and roughly resembled) MIT (hence I thought of MIT variant).

Greg, is Richard's comment right? If so, I'll drop this patch.

Thanks!

--=20
An old man doll... just what I always wanted! - Clara

--xrhHIH4HO9EIBTVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIFn7gAKCRD2uYlJVVFO
ozfFAP9sWM4qlwFNu6r3na/bKCKHiwWU8alebLt42wOABFakzAEAjD3+2XFkgSTV
d+qCr/jsqoR+CBbah4h4y+5xdfInHQM=
=6Bvf
-----END PGP SIGNATURE-----

--xrhHIH4HO9EIBTVB--
