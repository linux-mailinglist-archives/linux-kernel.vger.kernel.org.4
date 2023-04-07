Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6796DAC45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDGLkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:40:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2D59EA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:40:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id cf7so48757228ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680867601; x=1683459601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6lneTVcuijlE7HcvY6uKhaH5lsN0ygO8XwL5giFM3g=;
        b=yHyF1j7oNga6zZnes/RZcW1Je3Y3ozAV0ZejW8OROZktQMhLsbOLzCMrdGUNlYVH8o
         2ONvvRXZd7h1OZSckus4822BOLKupok3l4SvlqA4Glsx5z2nLUu3RrM4JGdChfiFojV3
         dh99QG/6ocBEbCkYAZaK7xvr8dWHh/G3gWBadMOO4OSmIUkb40rnyGQg4gRMoYnu62Mn
         +D55kAZI5dGOEo1Z0V9Uhizh62ruEwfZZcqyadONI9CmdR9UoWQGai84QRgKqnjpWP3g
         YqLtn7xh/RNVupYsw06RO3wQS1ZFvNzqxLdnvFKpdYyXhpcsMLlzswXV+Y4a95mHXvvW
         xERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867601; x=1683459601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6lneTVcuijlE7HcvY6uKhaH5lsN0ygO8XwL5giFM3g=;
        b=QbbHfmp4x7rWPyr/ldThwsAFkl9TdWRdN01vzoTfB6mApJLGMt4LXm2/D28cTmci9I
         NAYhfe/QQPO8m5PgofJ2deDDPrGUjTICTQ3Vj+iWyet7PqFvlgK3nXPfETLPNI91MWGz
         njZrHVDXgxsyAE1lpg3gKXtce+2m3Brwp5trgawbA+VQP/87st6q3ZhvhyeC8bPHUCY1
         bGKfWechK3NzkOWMBHfX5NLggIfzajcaAJU9y3SH2UIFw1cxCqyC/Eb5n2hB+zqbvGnB
         fvN30BDVUv7CD9zHIceF0JkM3pqWEirDS1hNRWjVi5RB5/g1ZQEjFvmzpFngNA5CS65q
         zVUA==
X-Gm-Message-State: AAQBX9c34pd5BvRW3hmFh1h6yfKcyp5FLHSj84w81mx8INeNaXCe9g5q
        dRuqRkEL9PDUr3V7zOCKnxWySA==
X-Google-Smtp-Source: AKy350Zm3HrxO9cgSUxyDUth42AjaSTK5FZVplG0vFmtVYB8Wf2YmmfSWtOkT+wAhLmZVgGGtodjsA==
X-Received: by 2002:a25:378f:0:b0:b40:ceba:f531 with SMTP id e137-20020a25378f000000b00b40cebaf531mr2800270yba.4.1680867601611;
        Fri, 07 Apr 2023 04:40:01 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b14-20020a25ae8e000000b00b7767ca7483sm1050222ybj.32.2023.04.07.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:40:00 -0700 (PDT)
Date:   Fri, 7 Apr 2023 07:39:58 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for
 set_type_config()
Message-ID: <ZDABDvbflOWAqcs+@fedora>
References: <cover.1680708357.git.william.gray@linaro.org>
 <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
 <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk>
 <CAMRc=Mc0HcMnuBqsN7ReNB5JTWR0C4FbMRRM9S7kqhW5otP5WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A9rkc2yXyxiKCahq"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mc0HcMnuBqsN7ReNB5JTWR0C4FbMRRM9S7kqhW5otP5WA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9rkc2yXyxiKCahq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2023 at 12:17:31PM +0200, Bartosz Golaszewski wrote:
> On Thu, Apr 6, 2023 at 7:23=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> >
> > On Wed, Apr 05, 2023 at 11:45:42AM -0400, William Breathitt Gray wrote:
> > > Allow the struct regmap_irq_chip set_type_config() callback to access
> > > irq_drv_data by passing it as a parameter.
> >
> > The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9=
da65:
> >
> >   Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git ta=
gs/regmap-set-type-irq-drv-data
> >
> > for you to fetch changes up to 7697c64b9e4908196f0ae68aa6d423dd40607973:
> >
> >   regmap: Pass irq_drv_data as a parameter for set_type_config() (2023-=
04-05 17:19:24 +0100)
> >
> > ----------------------------------------------------------------
> > regmap: Pass irq_drv_data as a parameter for set_type_config()
> >
> > Allow callbacks to access irq_drv_data.
> >
> > ----------------------------------------------------------------
> > William Breathitt Gray (1):
> >       regmap: Pass irq_drv_data as a parameter for set_type_config()
> >
> >  drivers/base/regmap/regmap-irq.c | 8 +++++---
> >  include/linux/regmap.h           | 6 ++++--
> >  2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> Pulled Mark's tag and applied the two remaining patches, thanks!
>=20
> Bart

Bart, the two remaining patches still depend on the handle_mask_sync
change descripted in the cover patch [0].

Mark, are you able to Ack those patches or alternatively provide an
immutable branch with them? We need the handle_mask_sync change as well
for the idio-16 migration patchset [1].

William Breathitt Gray

[0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.or=
g/
[1] https://lore.kernel.org/all/cover.1680618405.git.william.gray@linaro.or=
g/

--A9rkc2yXyxiKCahq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDABDgAKCRC1SFbKvhIj
Kzf5AQCZMZDcNNV2CB/Zj1XJS4D1ejrk/Lad9vNKFe0CR//TxQD/arFCfkiUZGOy
v5OPZrvybdoGrIg2iQxFz5ETJwh15wA=
=XOZx
-----END PGP SIGNATURE-----

--A9rkc2yXyxiKCahq--
