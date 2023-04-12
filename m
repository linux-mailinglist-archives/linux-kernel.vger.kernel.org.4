Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF36DF538
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDLM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDLM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:28:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFC7DA4;
        Wed, 12 Apr 2023 05:28:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z26so14352055lfj.11;
        Wed, 12 Apr 2023 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=al7GXfMDGfT+oOFD5mcLnTwf/FCNkfbn6/XvAyYGbNM=;
        b=F68RVGygYIxaiSFdCw685GZFm1tpH6RU9psgboEvf8dKwKjcoPQ0IO+OMjz9jk7Fkr
         7SBHD3BKv5rEXKvagymp+uIoXhjJrWFmBQOf1uvKRs51ThlSNqYu0bc9DzAjRqLadtrg
         6mjBFNYV2h+j6bDNV0EWPFqcC9vWBc6U2VjFSPXuY5+cm44TIKb+izuPX9aTHBCWkTs/
         JOkQ7KRdlpwwH7yrdyDCzZY22Y33JSjhmwgaVbuRqmt3qNvwQjpks8BzOC047W/Qfq/T
         YSjTF3ITK+IeSlSnV8eeV7PytpxBNzfpZyuzBFVwN6phCxJmre9Q+FWcQ0r0QKzzsoxJ
         IOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al7GXfMDGfT+oOFD5mcLnTwf/FCNkfbn6/XvAyYGbNM=;
        b=3D7cDRVTDe/pahytxFoQ+m+JrGTpvtadrp9ECQwk/KfUHMPeaOkR7Y4RB7IHTNvMRv
         j/V4Ftp64LAmQDBJ+Y06DlpP/aSQdF4JUlsrQIeQxni4XwJ2N/73g96Rv9CFyGqg9tX3
         W9tYPbE/ezGHer6eh+IeMyMPQfPhByyIyE8zo1Im2XAUUPPx9gR9L+lZWtXTYOqXcum2
         N4/G7/7VbzWuf7YXWh8OMq6OKPCTF0PZpimsJc7wbGC9dxB2rwDk7YjPxZC7uw3jlSB5
         FIkBoJpS1fxFAMzoHwoNhmhdO0rjZcOh2eSxAyUvb/USXnXiUHQbj6cWeDSUel2qFeNi
         zgaQ==
X-Gm-Message-State: AAQBX9ettLyiEoatLq8nIv3RI+rgT6vKYnq4BgWtB5QDefN6f7Dywan/
        65DaJJL6B3aL+mu6CPJJYiGgZFGGa80=
X-Google-Smtp-Source: AKy350bbARqUjS6vcur1SvBsBCp0y5P6v7JHPM1dFVoX0IJcLowld7JWyBlk937m8RZ9B3gz7aNQ6g==
X-Received: by 2002:ac2:518f:0:b0:4e9:bdd0:b667 with SMTP id u15-20020ac2518f000000b004e9bdd0b667mr1589508lfi.0.1681302493642;
        Wed, 12 Apr 2023 05:28:13 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t13-20020ac24c0d000000b004e95a1aca1bsm2989037lfq.87.2023.04.12.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:28:12 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:28:03 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: gts: fix units of available integration times
Message-ID: <f168fb25483e8e2b7a0e02695d3b37377737ddb8.1681301472.git.mazziesaccount@gmail.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZWASXVePNWuhGkMh"
Content-Disposition: inline
In-Reply-To: <cover.1681301472.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZWASXVePNWuhGkMh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The available integration times should be in the units of seconds, not
micro seconds.

Use the new IIO_VAL_INT_MICRO to return times in seconds

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 8bb68975b259..e242d0eb8b94 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -683,7 +683,7 @@ int iio_gts_avail_times(struct iio_gts *gts,  const int=
 **vals, int *type,
 		return -EINVAL;
=20
 	*vals =3D gts->avail_time_tables;
-	*type =3D IIO_VAL_INT;
+	*type =3D IIO_VAL_INT_MICRO;
 	*length =3D gts->num_avail_time_tables;
=20
 	return IIO_AVAIL_LIST;
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--ZWASXVePNWuhGkMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ2o9MACgkQeFA3/03a
ocWEoAgAkSUkTLzGWRZcVAhfLjRG1T64OTC0/2/IolGxW+Bh3lV3SHkE3grA5k88
aGW7OXtqFk3KHsM8/JDsHtKNuQfxTUJhQsj7UVyaGJDSdsmm4fzHVj65VJQCfdpG
X3/bLYxrAkA1Q2Y88R6mwOBJ31TrawwTaTd8nMfI2zIBo6vMMJLC7SK1zZN3DvJB
/Uyw/fmA4BG5ArnfPSqN0HR65Y6HdjpuJ7rjQLPwMV5k6dgn3+YPAAHtcphnPbRa
86Du5PMpb4a5OkzMNoxREEB+brtZXHd7SbBsRhMCi0nee9k82aFjRRzJjC2jdtxl
byTMTbatFM6OAwNufk2ewZ1fZdWllg==
=R/zn
-----END PGP SIGNATURE-----

--ZWASXVePNWuhGkMh--
