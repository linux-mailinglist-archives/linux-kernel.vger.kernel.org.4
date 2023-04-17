Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536176E4388
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDQJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDQJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:20:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8971421C;
        Mon, 17 Apr 2023 02:20:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso11775461fa.2;
        Mon, 17 Apr 2023 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723204; x=1684315204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgrbmJtSLO84P/9uImcl/ILG4CYzql2cJa7HytOmSio=;
        b=EOlZMB3Qua8VqDYh8UvRT26spK208uMi3/t4NKBjbTh+tGhzY0xCMaEgBBGAOek8wM
         UCs7XiVcnOkwTY8MhYnjdV7sT6VQlTMnk1BbDzWtTECYhe6fALnLvCX+jrTEMWc3bPl+
         zwdX7oO8/swY+9HjJR8Q7f47VkKh5SUGaEOEUffLnXtQllB+u850iuAmfFgPmxNmXEdZ
         0t3Z0k8QxnV5cu5EbsC0FonmoTb6C8NV/WZX8uDZ2LXL7x84BMxa1AuERDxikpXx8K+9
         8aPys25Ho2rj7mnUD3tvl2vj5p9ZBpXtFRal0Atbfo1YX3JLGOfXniOE3B/emUWDndks
         1A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723204; x=1684315204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgrbmJtSLO84P/9uImcl/ILG4CYzql2cJa7HytOmSio=;
        b=dlrcE85R5C83mbI+8oSr2jPpjTnZhV7Z7c1aTAnGDR6NFpnTqhPqk5d7uAAvha8sd0
         oJCKyf1nfev1zN7Zo+/VU/+MToLPmPEPU2m8SjD0eAzGvuM/mv1q8anJs82mGx7qgq0Z
         EyHm9T2iuD36L3yTeXsfh83ZLRuFeLtOC5G1W464vesw/FmJ5rdg5Lqj20HC3+JpNVii
         PXesTBH7pCc48lBJO79V+mxJDCRjm/Nl/8oM2+kb+XLI64eNkCXL+rm4PqQVpnzwnAYH
         1YN00FblRsrknt9AwQVgWu13JqHNa3anvJifX5Pdp9CxDnfd9TfwjZ9SMH+fPllDkKgW
         8RRA==
X-Gm-Message-State: AAQBX9eC/vPBF9lgSXYWeOX5h70kFqZBcj0pavTPufoRIgv/COMHY2W1
        ROXgmMon+dZBpybsVGKtrZ4=
X-Google-Smtp-Source: AKy350akDTp90kvAlE1J5IpQpL0xybQXZiyBGwk9M6x2mkuH4dP9XQVBPQIJtXYbV3hBDI7Vqp5+zw==
X-Received: by 2002:a19:f702:0:b0:4a4:68b8:f4f1 with SMTP id z2-20020a19f702000000b004a468b8f4f1mr1792676lfe.55.1681723203760;
        Mon, 17 Apr 2023 02:20:03 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id l9-20020ac25549000000b004eb00c0d417sm1983556lfk.130.2023.04.17.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:20:03 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:19:57 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: bu27034: Fix integration time
Message-ID: <a05647669af22ba919c7c87dccb43975e3235a87.1681722914.git.mazziesaccount@gmail.com>
References: <cover.1681722914.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K2MOcnigrCNm05N+"
Content-Disposition: inline
In-Reply-To: <cover.1681722914.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K2MOcnigrCNm05N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The bu27034 uses micro seconds for integration time configuration. This
is incorrect as the ABI mandates use of seconds.

Change BU27034 driver to use seconds for integration time.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/rohm-bu27034.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index e486dcf35eba..25c9b79574a5 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1167,11 +1167,12 @@ static int bu27034_read_raw(struct iio_dev *idev,
=20
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*val =3D bu27034_get_int_time(data);
-		if (*val < 0)
-			return *val;
+		*val =3D 0;
+		*val2 =3D bu27034_get_int_time(data);
+		if (*val2 < 0)
+			return *val2;
=20
-		return IIO_VAL_INT;
+		return IIO_VAL_INT_PLUS_MICRO;
=20
 	case IIO_CHAN_INFO_SCALE:
 		return bu27034_get_scale(data, chan->channel, val, val2);
@@ -1229,7 +1230,10 @@ static int bu27034_write_raw(struct iio_dev *idev,
 		ret =3D bu27034_set_scale(data, chan->channel, val, val2);
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret =3D bu27034_try_set_int_time(data, val);
+		if (!val)
+			ret =3D bu27034_try_set_int_time(data, val2);
+		else
+			ret =3D -EINVAL;
 		break;
 	default:
 		ret =3D -EINVAL;
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

--K2MOcnigrCNm05N+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ9Dz0ACgkQeFA3/03a
ocVxGwgAyjdJtfrLVu5HaZ1xGwqIJwcvqR9JJd3st/nH2bmuu846tw5Uf/9HcgKI
IW8DflyVJE7o58uj/UR6KLCJSTxOJmiSgo/a+EEnO5fBigKubMQbareHc6Z6f9x7
8xhmOboIjE7U9DCX3iPcInbA8eaygh4q6G34mASp26cOvfokv0CsIaXr7KvMgat3
yVSf+ejiE6fEN+xthkjvQM5NfZ7TRn9RSNnSZi9+Yb0Cx+EGXf70YNKpYQi0Vp4l
qoRArbadmy18v2M/3zQ/VNG/Kf8Q9B5b5tOizUklzCeyQImkdC3UfiC39WAHoynM
vSrpV3dc6w4PviM2ml1U7vCF4Kc+Kw==
=FSyV
-----END PGP SIGNATURE-----

--K2MOcnigrCNm05N+--
