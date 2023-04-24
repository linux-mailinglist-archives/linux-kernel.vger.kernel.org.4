Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7686ECCAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjDXNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjDXNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:09:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3CC468A;
        Mon, 24 Apr 2023 06:08:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec94eb6dcaso4714322e87.3;
        Mon, 24 Apr 2023 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341719; x=1684933719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WccspPnEbBcrRpc7tjCLxW0vQshJEtnsN0ZPyzTWo8s=;
        b=n5FsccVK9Gn0Byub+ajDaMLf5X4ddamnxRfGaS+uTlD1AoOubwB4OqDFyKPp5P9cox
         wAUPqBReZqvZhhKOiQ34hC1U8J/pdNEuwga8biSNFc7GPvizMvSj3Z5G04TwIuWYAHsC
         3QTfd36UJ/Nnq5TBaXwOKLJcsrwaxq+al08L3Z/yU/d65nZ+kp7mGjMhY5zi2vcGbnCk
         xUSGSpx6POzPb9gMGXsi/pVrT+lDPh2DmNMaLaRmT0lx2qhNRu5vy105baH2/6lCmQK1
         spgWYRbUAP3XCK0wg9CfDvnpP0WC/qSWRTeuSonh1Y6izA4JvKSLHcs5NB/qXaX/D4nw
         gZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341719; x=1684933719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WccspPnEbBcrRpc7tjCLxW0vQshJEtnsN0ZPyzTWo8s=;
        b=Y7+d1IeO/8IeiJpDlD1Y4P76cykXlP0Fuvu/BY6j/7XYG+XzWCXOvhwQQqXyzh/C3o
         /HkUxeWZC2Usej2/MswGKTf9H/G8fQwX1bBzFOXTdBMl3Fe+THIMUghZ/VzTm7tI5id1
         X0z/qZDfDSg1dHGU5Z1X5SZ9tf8ZnSAh+xKcvKlOgR+Fg4Qj+I/tPDrinmVRrIqruqua
         5kDk31/bFJ3DU98xtevCZRVF36FHFc8sS0w97X2zI2Znbc44t/NJcU56C4CPfw71x+SE
         D7wX3GZvkSJ8bP7coqayXiyGPWz79zHTCrttjmjcqvBuN95KdfVla/OeJ1avI3UxccGx
         tYAg==
X-Gm-Message-State: AAQBX9flE6WB0syfo7R0cQT7y9la8DcDu5s4C14pfpHsPZ3zIDe5yvXC
        3UTlNXkTtpuZXLoHWDur7Qw=
X-Google-Smtp-Source: AKy350a37VsQnx9sTnnq+ZU7jhDNSrULUErRIXiGr/63SRD0WF9EIh6kIQa1hhDbf7Rq0NjhgnFeXg==
X-Received: by 2002:ac2:4c30:0:b0:4eb:1158:b24c with SMTP id u16-20020ac24c30000000b004eb1158b24cmr2758085lfq.44.1682341719665;
        Mon, 24 Apr 2023 06:08:39 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v25-20020a056512049900b004eff32d6a21sm291447lfq.121.2023.04.24.06.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:08:38 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:08:35 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: kx022a: Use new iio_validate_own_trigger()
Message-ID: <0a8336feba8ccd3a8c71595b85cec36b9ef7b270.1682340947.git.mazziesaccount@gmail.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyzXp1xSVyyIdhkZ"
Content-Disposition: inline
In-Reply-To: <cover.1682340947.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyzXp1xSVyyIdhkZ
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

--kyzXp1xSVyyIdhkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRGf1MACgkQeFA3/03a
ocXlgggAwawpfeouHjta1ek2p5Rhfe2YlpoVIIZlbBYyBvFJN7K51t30DqwgZibz
0xrOmc/x4lrHy+ci9m32DpAkbdQSgTi7XbLPutzULuBfgUmDYZASRBW3UDyLH77b
l59uiZKkDbwEAHmOJXn58nfgaDSpLjFtuSBMZSCqDwCf512VfA+DNSWczTvxl+q+
F1rr5rzTGuf2HxG9BmjGWbmt29PKtaq/QgB/JUOHD7qBd3FnF474CDZskc8nEKIm
24GLyd/hFiYGfSFixkbjFROlBJsoJRTf4iUT72p67lt9mafw6/YaRav/sSrak4he
zFJBuNAlrXYfI+bJt2U9rp9sfDZi0w==
=UOnc
-----END PGP SIGNATURE-----

--kyzXp1xSVyyIdhkZ--
