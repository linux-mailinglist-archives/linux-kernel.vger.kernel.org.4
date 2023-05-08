Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D014C6FA78F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjEHKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjEHKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:31:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30127861;
        Mon,  8 May 2023 03:31:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac80da3443so49514131fa.0;
        Mon, 08 May 2023 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683541882; x=1686133882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amwYBq+jb1CsqDhbhENxkL/a7slnR1MMQpRg55XlQh4=;
        b=HeA+9NAYlSeApxZpRbTMMykVsHCMgoDqynnUSgttGrR0la3k9DcqoooUJaUM9XsWWi
         oVeZr7DAFGbN8S//A06AJPqyfIrBx6o5zAjKaG9+LN/cFyDcmSQTHvvFQjlAISRjgjpr
         j4515fjXCk9DlhO+HKa3YJIC4CNSnyHHYUjjJbrfQ7ZHDsi5og8ICrBEyyizZEXNWMOu
         22cufaE4McRHzpSnS0+fPfftCO1X+VwxfStVKNaY8vsRl3eRFsQV+R+vVq8zm4qN0r+j
         FjgU5426jNsZ8C9FT+wE7iiSpNEJNeTWUmlI7PlZCnFkmE3hzRcv8mFFROvMgKyFnSVE
         GAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541882; x=1686133882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amwYBq+jb1CsqDhbhENxkL/a7slnR1MMQpRg55XlQh4=;
        b=hV7ma2RwNz6qSD4qmXM2G5zftu/NDgiigDmi1O0oS9cotVbmLbW7a7m0McrcI35043
         K4t/sThMwmHcC4e6PfIOODVANvmyRyRTqd0TXdfaRI3mckIBHzOvBO+VUKM9Hcwg/vE0
         xT03og2bB6Kq6TQmSCvMD2kZ5CuVEodVnSngaZ+sgLpQqZaWaeMy7dTZmPbXyYgFR814
         PRQ0S8VDPHrnFR52hCTk//ivHG3Jj9tqrb07c0/KbelOWPSJEX9qMZ6lvdYXF89L8/x5
         yg7r5L98qLYcZ77u/vU7tvwwKOmCktjzjb0iaLT4JHrJC4sSMA+rldqJwN9upmN8300z
         r71A==
X-Gm-Message-State: AC+VfDwCTcBWh9HlAkLI9bHaQIdXCDPgFVGGdeTz4g7Bbx76fVIM+Os5
        dlaM58Anabb1hbAivaMUt0c=
X-Google-Smtp-Source: ACHHUZ4rWnAunezD5kIXGWV98XZ31Vkfv7SVY9JpCoZ2eekU8RPutkVcScoSI+jYrJ7p3UYilFI0Nw==
X-Received: by 2002:a2e:2e0b:0:b0:2ac:7850:5a6c with SMTP id u11-20020a2e2e0b000000b002ac78505a6cmr2759390lju.24.1683541882108;
        Mon, 08 May 2023 03:31:22 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v24-20020a2e9918000000b002aa39dd9ad3sm1139600lji.125.2023.05.08.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:31:21 -0700 (PDT)
Date:   Mon, 8 May 2023 13:31:17 +0300
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
Subject: [PATCH v5 2/5] iio: trigger: Add simple trigger_validation helper
Message-ID: <51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com>
References: <cover.1683541225.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oc98IvEB8exS0Lgy"
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


--oc98IvEB8exS0Lgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some triggers can only be attached to the IIO device that corresponds to
the same physical device. Implement generic helper which can be used as
a validate_trigger callback for such devices.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history
v4: =3D> v5:
 - fix kernel-doc case
v2: =3D> v3:
 - Fix title (space after iio:)
v2: New patch
---
 drivers/iio/industrialio-trigger.c | 22 +++++++++++++++++++++-
 include/linux/iio/trigger.h        |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-=
trigger.c
index 784dc1e00310..f207e36b12cc 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -322,7 +322,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *tr=
ig,
 	 * this is the case if the IIO device and the trigger device share the
 	 * same parent device.
 	 */
-	if (pf->indio_dev->dev.parent =3D=3D trig->dev.parent)
+	if (iio_validate_own_trigger(pf->indio_dev, trig))
 		trig->attached_own_device =3D true;
=20
 	return ret;
@@ -728,6 +728,26 @@ bool iio_trigger_using_own(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_trigger_using_own);
=20
+/**
+ * iio_validate_own_trigger - Check if a trigger and IIO device belong to
+ *  the same device
+ * @idev: the IIO device to check
+ * @trig: the IIO trigger to check
+ *
+ * This function can be used as the validate_trigger callback for triggers=
 that
+ * can only be attached to their own device.
+ *
+ * Return: 0 if both the trigger and the IIO device belong to the same
+ * device, -EINVAL otherwise.
+ */
+int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *tri=
g)
+{
+	if (idev->dev.parent !=3D trig->dev.parent)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_validate_own_trigger);
+
 /**
  * iio_trigger_validate_own_device - Check if a trigger and IIO device bel=
ong to
  *  the same device
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 51f52c5c6092..bce3b1788199 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -171,6 +171,7 @@ void iio_trigger_free(struct iio_trigger *trig);
  */
 bool iio_trigger_using_own(struct iio_dev *indio_dev);
=20
+int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *tri=
g);
 int iio_trigger_validate_own_device(struct iio_trigger *trig,
 				     struct iio_dev *indio_dev);
=20
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

--oc98IvEB8exS0Lgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRYz3UACgkQeFA3/03a
ocWPcAf/UixYrfSpC1SEdpflWi9hBk9x2y8cCbGEyqX2ItYFRlGYl5G8fFA8jr2M
Mtyg2BWZtMywiQ+ZPYtRDcjhwZY7HXGet3D0xfvjBznnwSfqUYXCzXDdfMRYDJr+
Z6dxbOWomlM9BY+7yuchE0iUAXZhS8435qQIc96LNkJrLSnih7apDrL7zmKBNQ4k
0LSUHiiWTGtFyDipYbNG+92P9uyiPGWzVXn7DLc3MZ3BqhlnGNageEROJoZqiV1/
2nttFDPYiDHt/c/jpVQXU7v9tPuvsJsunNxszs1rIZwP+rRA6X0IAwZ2nXtisvMl
ikTQcDFw1Z3lV+VsLJCcMRKbblcZAQ==
=fvzq
-----END PGP SIGNATURE-----

--oc98IvEB8exS0Lgy--
