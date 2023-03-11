Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B16B5E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCKQzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCKQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:55:12 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6455520
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:55:10 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id ks17so5652823qvb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1678553709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIomLG7UnQJj876RAoaqIkfKcALzjeNdqoIdaS6cOuA=;
        b=IKHmjVOAfqKWlUeGJMI5dRwxBG4FGobmdNwrOOi1L7o6tWYb0OVzglFy7+hcQ6+4im
         jsacJ3xMs8PtPQ7lXyI4ZqO35YauGKQ7cv+i2XxdK7gV5eVrPVbKDyscrbjIAP9jUaWW
         NVuBeO0sdUGldxoRdALANZ9ATWRebkAUZxQNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678553709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIomLG7UnQJj876RAoaqIkfKcALzjeNdqoIdaS6cOuA=;
        b=Am7vNMhdxe0dSEuLu8e9OeW4NeOkbJ5RQSz9oYz4i632k0AUMFPhufIiFeL4Ua78FI
         b067QS13s9uEFMZFMtqev9zB/oPjztSvdZ/NedHYHX7AHOw/8JAlzTLFnbQV2imOPXGk
         5cSCQzh3S3cw1xogX7yHgi/JU4IMTmuN2Nk3TTuBTc8jES3ovDQ40Kwb2ViJAzQtSzOp
         FaRAlQ21BQRkQph57o7+fKZx00ZWeaIiH9iAeHRQexNLhBMBS4xkFvkToePKjIXtNOHM
         1avj004ouitS25snPvzdVMQzKJQVh4IdMRPoMY0+xO0cjEKJRGyndz+cuz5wux7z6DvY
         uqpg==
X-Gm-Message-State: AO0yUKUV4sXaR61biCp42Wh6gnEf0q2GZipTpDzodnAXzrFbAIqI1BmU
        R+Enb1+wiPDa6yy2LjDhC7kvXQ==
X-Google-Smtp-Source: AK7set+jc34nG16Iv3yaR0QZYNu/Re47mZ/FVzqaCs0fWfCvaN09bMctjtbX7adZwq53L84o9rBuPw==
X-Received: by 2002:a05:6214:258f:b0:5a3:fffa:f600 with SMTP id fq15-20020a056214258f00b005a3fffaf600mr377474qvb.26.1678553709699;
        Sat, 11 Mar 2023 08:55:09 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-036b.res6.spectrum.com. [2603:6081:7b00:6400::36b])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a248400b0074357fa9e15sm2110419qkn.42.2023.03.11.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 08:55:09 -0800 (PST)
Date:   Sat, 11 Mar 2023 11:55:07 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Simon Glass <sjg@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        U-Boot Custodians <u-boot-custodians@lists.denx.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        barebox@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [RESEND PATCH] kconfig: Proposed language extension for multiple
 builds
Message-ID: <20230311165507.GN3041508@bill-the-cat>
References: <20230310183717.RESEND.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <bae2702e-3570-f461-b86f-e56ce82a636e@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nKkts6aBvDQ9fwd+"
Content-Disposition: inline
In-Reply-To: <bae2702e-3570-f461-b86f-e56ce82a636e@infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nKkts6aBvDQ9fwd+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 09:39:15PM -0800, Randy Dunlap wrote:
> Hi--
>=20
> On 3/10/23 18:37, Simon Glass wrote:
> > (I am sending this again to get more feedback)
> >=20
> > In the case of Linux, only one build is produced so there is only a
> > single configuration. For other projects, such as U-Boot and Zephyr, the
> > same code is used to produce multiple builds, each with related (but
> > different) options enabled.
> >=20
> > This can be handled with the existing kconfig language, but it is quite
> > verbose, somewhat tedious and very error-prone, since there is a lot of
> > duplication. The result is hard to maintain.
> >=20
> > Describe an extension to the Kconfig language to support easier handling
> > of this use case.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> IMO Masahiro has already answered this multiple times and I agree with hi=
s answers.
>=20
> For others, the full previous thread is at
>   https://lore.kernel.org/all/20230219145453.1.Idaaf79c3e768b85750d5a7eb7=
32052576c5e07e5@changeid/

Well, I think what was unclear, or maybe we just wanted to confirm the
answer was "none at all", was this. As good community neighbors, we see
a generic issue in the Kconfig language, a tool used frequently outside
of just the Linux kernel, and would like to contribute back. Ideally
without having first gone off, designed and implemented something, and
then been told it's all wrong and to rewrite it first. So what level of
interest is there in this?

As I pointed out in that thread, I believe barebox has examples where
some keyword like we're proposing here would help them (and yes, there's
only a dozen or so symbols so it's also manageable without anything
special), and Simon believes Zephyr will be in a similar situation soon
enough (which doesn't use the kernel's implementation of the language).
Frankly, I keep going back to "tristate" is just the original example of
what we're talking about here (CONFIG_FOO=3Dn, CONFIG_FOO_MODULE=3Dy), not
that I'm suggesting we would remove the tristate word.
So we would really like to make sure as many people and projects are
aware, as possible.

And as Simon asked in the thread, what about code refactoring that makes
further maintenance easier? Clearly, such patches would need to be
against the current appropriate tree.

--=20
Tom

--nKkts6aBvDQ9fwd+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmQMsmcACgkQFHw5/5Y0
tyx+wwv/dmFZaZi7VhdtJ2VaNC4i1XByc8cyBYW3rT8yVRK75dzQ9I/p0FGL8LCx
73GpQdSlx+n8S+qPu3d71WUpv5dZBBdqSjD6s4olHY3p+xuriV9Qd1UM9qiEyYXf
sQH+bVlvK+82C3xADqUiKdgTzKqMKxW2zhUj88qTIHxKpdbzF/7Y7TnuMLH3sAhP
Ho8dpmM+PKxL0J4i9aMX664hpwU7I4yDBnc0oXa2ROgRdogu0yKt+6TGecs9qsL2
IUnl9Cp8x6EtFVQd2otm/UUAQrbyGBW+WZDVWcuS99Bs0bGi1Bl7B+IBsP8JOmD0
jlMcn/IJlo1b7cAKri8mlPGBEXtIcthBJ/TYPmx/MwmG9Oj0WjQPLsfYVuppb/bu
7i2nHzVRl3+UBWMppuyrsUROhBBdlBEqPJRZJhCHEfHa6kKGucClIoqM7RqmOxtC
dOSQrs/XyC9gCJ4TUDep5eSiNizYzpl14QcJpxv+iQu86W96tWE5fc4Q4zZSEl5m
YzXxsFiQ
=OI2Z
-----END PGP SIGNATURE-----

--nKkts6aBvDQ9fwd+--
