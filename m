Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1C7276DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjFHFpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjFHFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:45:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115C26BF;
        Wed,  7 Jun 2023 22:45:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39c84863e34so78622b6e.2;
        Wed, 07 Jun 2023 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686203135; x=1688795135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kr5oRcYFTtHOq9g2agMGwQw/oZjqZmrvl2oTroMyEE=;
        b=Qk7YYfikceaQvVZ9RlXCBxqJxpyaoUgSavBej0y4tb0PS+435aqVoGmhCyipvcMAQI
         emqHmgDwnJfj42YgIeJmN9zFcDhhdY+Zjziz7ZYegWdjxRtQLWlIT930/V4v2JgtZOaD
         jn5QF0yKvDjTBjggFoYii5Jk0R3YddnByizqegiZip4gijnbV/hutFUtt+kKP/ddb8gY
         DKQi7QvGUG5njSqmAsRMeGTyfs/QLtA1SqVCqYkf401F6+o2wOgXEZB4LSwf9LazmbBa
         6i/+GD9UPZs9gCK7BkiDfYoPgS1NJr4dcJqLOVSBaYznMcp8lTQYmNleBtRxhy0+rAoe
         sw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686203135; x=1688795135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kr5oRcYFTtHOq9g2agMGwQw/oZjqZmrvl2oTroMyEE=;
        b=fwgFJFK4WCDghN4AzD8ReCbNSbNvNICmPWzI68xELafkP4erXYxgFRQd9mrG+Z9Hf5
         TBFZueqDWkvPURjotE4WCWGgzfEcGz50xGqO5jp4dIHSu0B3FlzOoGx4SyKk92GzDkFH
         +fNadY+bztsJBdjedfwxy9ZkFl5ceyhMPB9csJkZmOoM+ptbi4SmN8ZNi6oMinxAtAz7
         1y9dN19OXZIeZFNyL2lz7RwHBXTn+vFHb8n7XpK+eFqjrSD0E6D0hsNyVQQBarxHr5Zq
         ob/sldv/l/By5Dp0/ZWVmMYbWIKnVFav/zJKlB+gi8czqCnxLHqGAWyIlrcv+/TUsLi1
         WGZw==
X-Gm-Message-State: AC+VfDxHLRATEVN9PR4zys31yqV5MOIRjQPzTf1Z1+rvkv/CrKzSgMEh
        IWl06pqDi5uUn6ZVamF1Uy2b3BAOxRy4KQ==
X-Google-Smtp-Source: ACHHUZ4FiASFuH4hCL/c2dZjH1Xp+5R8AhjMPLQVATNXFI7PYE86VRW5dOCz4E+kDm9O5j58wqYpww==
X-Received: by 2002:aca:1717:0:b0:398:2f92:65ca with SMTP id j23-20020aca1717000000b003982f9265camr6436831oii.7.1686203135289;
        Wed, 07 Jun 2023 22:45:35 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-10.three.co.id. [180.214.233.10])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001b077301b15sm477961plb.156.2023.06.07.22.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:45:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C83E21069EA; Thu,  8 Jun 2023 12:45:31 +0700 (WIB)
Date:   Thu, 8 Jun 2023 12:45:31 +0700
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
        Dan Carpenter <dan.carpenter@linaro.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 3/8] crypto: drbg: Convert dual BSD 3-Clause/GPL-1.0
 license boilerplate to SPDX identifier
Message-ID: <ZIFq--S08zbg5gwf@debian.me>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-13-bagasdotme@gmail.com>
 <CAC1cPGzZGWxS1qdKZkMuHrCenegje-M0QE0tFG5UotHAjN5vmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7Mo51Ey7jJxGFqqz"
Content-Disposition: inline
In-Reply-To: <CAC1cPGzZGWxS1qdKZkMuHrCenegje-M0QE0tFG5UotHAjN5vmQ@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Mo51Ey7jJxGFqqz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 09:56:03AM -0400, Richard Fontana wrote:
> On Wed, Jun 7, 2023 at 1:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > Replace the boilerplate with corresponding SPDX tag. Since there is no
> > explicit GPL version, assume GPL 1.0+.
> >
> > Cc: Stephan Mueller <smueller@chronox.de>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  crypto/drbg.c | 33 +--------------------------------
> >  1 file changed, 1 insertion(+), 32 deletions(-)
> >
> > diff --git a/crypto/drbg.c b/crypto/drbg.c
> > index ff4ebbc68efab1..f797deaf3952ef 100644
> > --- a/crypto/drbg.c
> > +++ b/crypto/drbg.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-1.0+
> >  /*
> >   * DRBG: Deterministic Random Bits Generator
> >   *       Based on NIST Recommended DRBG from NIST SP800-90A with the f=
ollowing
> > @@ -9,38 +10,6 @@
> >   *
> >   * Copyright Stephan Mueller <smueller@chronox.de>, 2014
> >   *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, and the entire permission notice in its entirety,
> > - *    including the disclaimer of warranties.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in =
the
> > - *    documentation and/or other materials provided with the distribut=
ion.
> > - * 3. The name of the author may not be used to endorse or promote
> > - *    products derived from this software without specific prior
> > - *    written permission.
> > - *
> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the=
 GPL are
> > - * required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > - * DAMAGE.
>=20
> The non-GPL portion of this notice does not match BSD-3-Clause as
> currently defined by SPDX (see:
> https://github.com/spdx/license-list-XML/blob/main/src/BSD-3-Clause.xml).
> This is at least the third time in your recent patches that you have
> assumed that a non-GPL license matches a particular SPDX identifier
> without (apparently) checking.

I missed the point of first clause of this BSD boilerplate, for which
I had to not delete the boilerplate. I can keep the SPDX tag if Stephan
(original author) or at least Greg agree with this BSD wording variant.

>=20
> That's assuming it's appropriate to represent this as a dual license
> and omit the 'ALTERNATIVELY' parenthetical. I'm not sure how I feel
> about that.

Do you mean the SPDX tag should have been with AND instead?

Thanks for reviewing.

--=20
An old man doll... just what I always wanted! - Clara

--7Mo51Ey7jJxGFqqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIFq+wAKCRD2uYlJVVFO
owQnAQD7djjDG/HLJy5ZH4Onmzv3cI/Vo4h49aXIKDGYk1+h2AEAuZ0AtAyJmxWC
VJxnVJ8OLN4BK/WQ776KeD/aflduuwg=
=k5Kv
-----END PGP SIGNATURE-----

--7Mo51Ey7jJxGFqqz--
