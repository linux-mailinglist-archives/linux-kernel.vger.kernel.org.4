Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA75F2C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJCIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiJCIiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:38:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7471A4E847;
        Mon,  3 Oct 2022 01:11:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 25so5184809lft.9;
        Mon, 03 Oct 2022 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=n8GMBnHxJxPaGcOLs5PFtLhf/pfq+CS8nFHzOIUU5Qc=;
        b=jIkamS1RHFlH2SL/8e3NYvEsKWvfGXLkJz78rFGNdC8hRYUVKhxx8dD8+4xPeaXrQF
         XI8itBO/7GZfhjIEyxV31JX7JnSgykL5xJJepQrw0rzwacAPDBsdPRgiumAf51k2ljpP
         ce3rP+vUa9U4dxeifNcUMfgkXfisnAaT3M1pnOo33nbv97pYezhCZ35CmEl+enBRrZpD
         6V/g+eWIEwpreV1PtkzZ0w9xj3TVOgN9K3fEakbdkvP+LDWXstcFPM44Mb2ZNplHgti1
         YB5yq2x92cWT1BHBfS9td/idQnJs3v3vwG2VsCD1W0Epu8SxQMOHir7A+BopGq7dnH2C
         hAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=n8GMBnHxJxPaGcOLs5PFtLhf/pfq+CS8nFHzOIUU5Qc=;
        b=s5Ac37yK0VzPeipmHLFPdwZVFJ60AuB/kACTjTERipXTt3SW2mPGldxPOCWqhn0Sb4
         X09Y3TTqsQc26f+jeT/XOJ1jRv02+2SmQmzCmIoa68D6b+SwtL2kLgIcTgSF9BoPUkUv
         2wIy5jbTUKmLarcZE0QxB7EnL6JpZe6mqoNJOprUVL+W9FbLEvCp8hSpYGpjCdjxaYf6
         hoaeR/imMfOk7rjhJCzF9mmdRXZHcnVbWY3KGJlp1bVsKrPT3CFfCt2Lx4IJxEmuXtuB
         QXuk/i78/43hOFJa1QwuhzBLUpYBMGgJztQd7LGKBL9SlLSQ938gJHQFoyrTq3I+b+ne
         kCVQ==
X-Gm-Message-State: ACrzQf2effwMS7JXxhxKbtWxaSg7S3USSVYmIq2kvYe5/eOidjWhRkg4
        OFOqfgULRCK8YM9ueXgm3P2olMP2yKE=
X-Google-Smtp-Source: AMsMyM5QgYlSP3Kogs4t3JONKnm6ALa2mDNjMs+sbXfnGYB/A9raY9ov5c0lh2CH1pUt6O2Bmke8Gg==
X-Received: by 2002:a05:6512:1392:b0:4a1:e5b8:f9b with SMTP id p18-20020a056512139200b004a1e5b80f9bmr7250781lfa.474.1664784703798;
        Mon, 03 Oct 2022 01:11:43 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512304f00b00492b494c4e8sm1351128lfb.298.2022.10.03.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:11:42 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:11:33 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] iio: at91-sama5d2_adc: Fix unsafe buffer attributes
Message-ID: <be69775aa302159f088b8b91894e6ec449bca65b.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCYLTgg4To/0KZJq"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCYLTgg4To/0KZJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The iio_triggered_buffer_setup_ext() was changed by
commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")
to silently expect that all attributes given in buffer_attrs array are
device-attributes. This expectation was not forced by the API - and some
drivers did register attributes created by IIO_CONST_ATTR().

The added attribute "wrapping" does not copy the pointer to stored
string constant and when the sysfs file is read the kernel will access
to invalid location.

Change the IIO_CONST_ATTRs from the driver to IIO_DEVICE_ATTR in order
to prevent the invalid memory access.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_=
attr")

---

v2 =3D> v3:
Split change to own patch for simpler fix backporting.
---
 drivers/iio/adc/at91-sama5d2_adc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index 279430c1d88c..6e3f9fa93cee 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1841,13 +1841,26 @@ static ssize_t at91_adc_get_watermark(struct device=
 *dev,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
 }
=20
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", "2");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", AT91_HWFIFO_MAX_SIZE_STR);
+}
+
 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
 		       at91_adc_get_fifo_state, NULL, 0);
 static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
 		       at91_adc_get_watermark, NULL, 0);
-
-static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
-static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
=20
 static IIO_CONST_ATTR(oversampling_ratio_available,
 		      __stringify(AT91_OSR_1SAMPLES) " "
@@ -1864,8 +1877,8 @@ static const struct attribute_group at91_adc_attribut=
e_group =3D {
 };
=20
 static const struct attribute *at91_adc_fifo_attributes[] =3D {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
 	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
 	NULL,
--=20
2.37.3


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

--bCYLTgg4To/0KZJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mTUACgkQeFA3/03a
ocV55Qf/cPENFqybBAKcTd4RDKH/h/Oe427StBd+bRAVNhKC5hGigSl4DXZPJpb4
7asjsDj4TgWKd0u9j3tlkhEVy5UZwWP/FKpAVdZwqdfnbB85xBfjMue8pue6zuRW
gwDrup7GMFrAlQYnFKt+znz8JvJeeSx+2rOlYpajr/PwspyglJs40A6/daB9ljB2
ASchwOJ8h6bDtk/H5nqV63oSMPT0uoTJGQNnKos3LFqpyxZDMIlXVcBh9BiQ1gE2
Loj5wJDM1hxAMtx4GX3EJYHWDtMmZ5+aT84QhRXn/Lt1GKuoxECWV4hytSMOaldH
7Kd7h0tfgpFGYs6tzNDNL/WI4TESjg==
=rETr
-----END PGP SIGNATURE-----

--bCYLTgg4To/0KZJq--
