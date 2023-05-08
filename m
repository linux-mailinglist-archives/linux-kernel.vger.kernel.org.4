Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A966FA799
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjEHKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjEHKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:32:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAD2676F;
        Mon,  8 May 2023 03:31:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso4989490e87.2;
        Mon, 08 May 2023 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683541901; x=1686133901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVOcW5KSfysHy4pPWrUvfd7L7A9hkxm02fk2t4xmkTs=;
        b=midirEziNdd9rEplMPFT2tyoTB62QKPhg8cQcgG/bJ8utNrMkwuS+sZJB/Qb0luBdy
         rHUpyyrhfQ6FJL8t3rJsbnSmKjJelHAT3C6zod/h+Jl1XC18MN+Q/wbFl9jf0OD0Mi0M
         LwMfBCubSZgcmNDt94m/6orh2BJv1t6k2zccZhEk2pe+VXxwWQtHnEvl0jUUfiQgIClz
         ox0IoRVzI3y3WJO4N9TTUhUpBLeCLA+ZJZJVfOux0WrqLtX5gARt4+tsIaljysHAy1ww
         BH6ViLOreP+HpPmNN7u5uj8lSTlL2mSQYSb+lc9BShqcd3NcDUuxQS44yV7mLU40g1v9
         QX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541901; x=1686133901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVOcW5KSfysHy4pPWrUvfd7L7A9hkxm02fk2t4xmkTs=;
        b=HcdPnQiWt2C7Yaqk1tQ9mpXSllhZPUQqW7jkMPi8JJSd4t5b0tAI5UxV4L/OxiROe8
         NqOiwaexKNweAzdFxNaQm6uaByCCBioKNCjSNUiC1RsrAhCScYPKtWp1vKddg3j5/4xQ
         qvUyvK3aKEidsUIYT9veqoMu2TlVb8Dzqu/xUz4HZf+nCM4+1mSWTsZ0LatwhiRpdcA4
         g9LZxuKEvzJiawZW6AtXm/zKBQXITx6qf7RKxlS11AuAL+kyAUx23pk633UNTj8a/G37
         bBauPj4Fn1Ef4bBUNTPK6TZE/kFA/UwmbMufuIUKVD0sSQD4GP68QcUxpVVYPOyDhdww
         qB8w==
X-Gm-Message-State: AC+VfDxOOwAKD9b8e/pHGd24jdQYL/KY0yzEHNnvShZArQM8fTGmVd+e
        17herwUnaVRg21Iy1sto5wo=
X-Google-Smtp-Source: ACHHUZ5Y1Dv01gKb4AgUcpnypAjvvhRaAfmwQuAmjFIf03cSrRcGKdy9Zn0ZVAG5L1WBQLvp5ES84Q==
X-Received: by 2002:ac2:52b6:0:b0:4f2:5393:b71 with SMTP id r22-20020ac252b6000000b004f253930b71mr18514lfm.17.1683541900903;
        Mon, 08 May 2023 03:31:40 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004eff32d6a21sm1243928lfe.121.2023.05.08.03.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:31:40 -0700 (PDT)
Date:   Mon, 8 May 2023 13:31:35 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] iio: kx022a: Use new iio_validate_own_trigger()
Message-ID: <cbd585e4787f62dc1a343a51b629ce73dd7d5426.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cRliBzZvdnyxsxOz"
Content-Disposition: inline
In-Reply-To: <cover.1683541225.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cRliBzZvdnyxsxOz
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
2.40.1


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

--cRliBzZvdnyxsxOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRYz4cACgkQeFA3/03a
ocWVcQf/eA4a8cLJ+0z3LlVxw4mYck1x5vPOsbvAp75RiJ+XF+CCKB7em0lYxYdS
3v1VhMhIvb3koLpcyYu92YrzuwQiLTxir2RWr3a4RmgTbdFP61C+gjacQHnBu+WN
B55Qz05gTKh6AS5zPFRUZno4/X5gd6RxEgvvHOvOxSdhyzDfQFVYnjhU0l4l3twr
/1srDImrafVaSMG6vZF3AwBQ7KDV8fMcXwIoZhu6ahZt5VPj+7q8WWaJDj6+OSKq
BAvGdFiX1+qI+eBhUQ3PgEXSeG4CQrmM++ZqjVsi7zRVZsDnYYc21GomGwj7OEme
h4UdopbnCNWT7AQ2f2IQ98N22UQGMQ==
=8JC5
-----END PGP SIGNATURE-----

--cRliBzZvdnyxsxOz--
