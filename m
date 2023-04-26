Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC546EEFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjDZIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbjDZIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:08:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F41FE5;
        Wed, 26 Apr 2023 01:08:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so65408281fa.0;
        Wed, 26 Apr 2023 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496484; x=1685088484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWFogPesRkVpMzxNVC02NFFYCke98s78XYIUivPMFsQ=;
        b=OrDhF11kmo13l3Tx4eN2FjmD1eybCrYJ0Pd1hjZsrNss07E3DoTOnNIO4+ZGQvomvA
         hTmR8HNw+7RTcjDPOThbvyUYp5GtQJ46kJ6o6d/6Gj1vsC5ny4whzsA6K/qzt8QgCx5A
         ZbrTrx2X0iPrT3oCncu7OYFN3saasFqoJ/xZUyJhbOxyVGMR2swJUVq5IEmRDX361jVC
         wbw05qPcF25yZC00xkeN/1r/gcOGT839LUdJPUGRJFKUcsAibmYCnma3o2/0s7dieHoL
         QTeKaWimdX73IGD03qNBJ2EGDLfLYm0MlriQESqnyahhD/zOM3TXfLJu3/8rOvkShhBP
         QFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496484; x=1685088484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWFogPesRkVpMzxNVC02NFFYCke98s78XYIUivPMFsQ=;
        b=B3Ci1eoJWsqSqeGaUVbUpXHHD7sEdyfNtkApTjfRSQP6JhDas3IszFFRdQFdYsVERr
         9HgyuD/6ezmtzrlwNZ9/aLzCEogX8EjOjN3R/X5mPrWT7avWPaufZJP+QqCMijU1KwgQ
         Aa8P71jrdSaezY23Czz+noyCs+cvrfM3T8cCrVFTUkJ9P4+Lnp2yKWtTdSZ/eqfhSS8I
         V6LbJLM/e6JSZiMeUOgv1hWUfTnA7HE9gp3/DjRlhU+Ats1+ZfQsyNisLArGtkG4IAEa
         lrW3+KQZp/nXFnWz6oRQBkc3j9/VdN9nzlMHXKKSbzRGv3p2vThjvPezqSah85X0Nayq
         5z/A==
X-Gm-Message-State: AAQBX9eF9WxNw1bAwwPEIaciC5rFoLWJdkeU4Cx9QMQX3bykf5bHx4oN
        NryX1t3Um4b+KUEsw/ei/pw=
X-Google-Smtp-Source: AKy350aGmzbOtkw8gzRpYFQIYuuLon7uAey2DlB3ct09oD1GSuh6fOoqQzXFssTODba71G3SwH4DmA==
X-Received: by 2002:a2e:8602:0:b0:2a8:c7f8:58ef with SMTP id a2-20020a2e8602000000b002a8c7f858efmr4118783lji.22.1682496484476;
        Wed, 26 Apr 2023 01:08:04 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id g6-20020ac25386000000b004edb2cb3500sm2333035lfh.279.2023.04.26.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:08:03 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:08:00 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v3 3/5] iio: kx022a: Use new iio_validate_own_trigger()
Message-ID: <6c1081343f8fa1fe8bb21f340ba031f61d3b6085.1682495921.git.mazziesaccount@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Oa0sD3Rld4rAr3ms"
Content-Disposition: inline
In-Reply-To: <cover.1682495921.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oa0sD3Rld4rAr3ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new generic iio_validate_own_trigger() can be used as
validate_trigger callback for verifying the used trigger belongs to same
device as the iio_dev.

Use the generic function instead of rolling own one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history
v2: New patch
---
 drivers/iio/accel/kionix-kx022a.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index f98393d74666..09814881f513 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -516,17 +516,6 @@ static int kx022a_read_raw(struct iio_dev *idev,
 	return -EINVAL;
 };
=20
-static int kx022a_validate_trigger(struct iio_dev *idev,
-				   struct iio_trigger *trig)
-{
-	struct kx022a_data *data =3D iio_priv(idev);
-
-	if (data->trig !=3D trig)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data =3D iio_priv(idev);
@@ -725,7 +714,7 @@ static const struct iio_info kx022a_info =3D {
 	.write_raw =3D &kx022a_write_raw,
 	.read_avail =3D &kx022a_read_avail,
=20
-	.validate_trigger	=3D kx022a_validate_trigger,
+	.validate_trigger	=3D iio_validate_own_trigger,
 	.hwfifo_set_watermark	=3D kx022a_set_watermark,
 	.hwfifo_flush_to_buffer	=3D kx022a_fifo_flush,
 };
--=20
2.40.0


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

--Oa0sD3Rld4rAr3ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRI298ACgkQeFA3/03a
ocVH8Qf+L8pPoQU2MkB3t762nULTAeClH5Bz7VXO175Y1BSd/sj2jDXA/kxqf8nS
MfvsRRiERlH4XNXOP8HncQ00NxRouOLGJdWNbNjhjNupnKf2Ys/hifbt/tds1989
mpCjb9MBw37uUY+3hPAFXNYG63QKzxzwVCernq6t3dURKIqWonrw+tJjBpQF9Tx3
RfboBhSiEcXVi1hYrQjKOWuv9d8YsXrLqiq+SAW768pmryjkIOufraFLhkHqbBSJ
YF/kdZ1nOAlw4/TLL9/JwQYlMraVt58p7h3N7RntRgdmsIhToAAq7jVtdRF/QvSs
OgznyeuvZ8M8c5zbOyGV9LAA/vHpfg==
=OEkv
-----END PGP SIGNATURE-----

--Oa0sD3Rld4rAr3ms--
