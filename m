Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360B36EEFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbjDZIH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:07:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819071BD3;
        Wed, 26 Apr 2023 01:07:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8aea0c7dcso63506561fa.2;
        Wed, 26 Apr 2023 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496468; x=1685088468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znvbKQImvhU9C1smHUKd6jzv5MrEvzVI1do0StLztnA=;
        b=sfrjNp7DWHgXQdMEVgFR3eOOp6YGdU6/MEb4X7N1cL69PpYgh2bLrO3GSnA8KeYLp8
         dD4OCCcNe4yIs5XCKUnF0nT0Jmt3tqyEOU4LsPCvVRAhlh1oca+x7Q76GznJ+TvSUecd
         QpiCAen5LAu3ol+HMBskbah3ea7jeOk0P1THGTIUvv31RsrcxZL1Rnx8R8mIc0NwimPs
         K/ei2yIl7X9+3N7CltgRsC3cYNEhxndbvJrDFvum8JkRIjPUrz/FERjUotE2svZo+8sl
         Df9mI/LSaqgTR7vJZc95mwl2clrpwhDJOGdYwZjylH/a3NArL9QoP+fGjuNzY6ayKwLr
         a7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496468; x=1685088468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znvbKQImvhU9C1smHUKd6jzv5MrEvzVI1do0StLztnA=;
        b=RDcvUO/+JRbFRqXRCK5ADEUmQvIqjQm+rYYVPwN6Dd/LK8Nez1933GIritdfMB75Hn
         1IrePxqBi6qL6tgZdBcQKHMYOhUrfafea6YrDZf4QHWtiXBSKW+RDgYdk7nqCgOniLcH
         4ilX0KFsVCt7vqJoHgmf/SOdqQF2MC3sCmhBigXrfF8AXKp7cC9UD0b86eUTmHDkqk2Q
         IO0yX73XJQEiJ8pOFztKjTJnHAqvn+EplRaZFyY85tvcsm4i9GajHePxqHoxii06WosQ
         54E+5I5Jt8LVYg3wytJ6vOXxBq0dMCWdMR75XxlQXOdvPLig2VTYr+zeEZwd/UYFWI3A
         YGQg==
X-Gm-Message-State: AAQBX9dRgTtcgQ/XNzbDCJRpicZ0lbJIFMhQKgget1JKedsRMyuEoxa7
        b0BfXcf7h/yQqf6nqnGhvk8=
X-Google-Smtp-Source: AKy350aLQtIWltZyGL21Xr/ER4wWIT5lNbEkp9XHNXcGQRJCP1IzbTDKlWo+icZ84I+N3segdmZGcQ==
X-Received: by 2002:a2e:978c:0:b0:2a2:ca91:a99e with SMTP id y12-20020a2e978c000000b002a2ca91a99emr4663758lji.39.1682496467670;
        Wed, 26 Apr 2023 01:07:47 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id k19-20020a2e2413000000b002a8c4a26960sm2382331ljk.75.2023.04.26.01.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:07:47 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:07:43 +0300
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
Subject: [PATCH v3 2/5] iio: trigger: Add simple trigger_validation helper
Message-ID: <a9e97b6a84b225f3a57adb6f2113b09b3974cdd7.1682495921.git.mazziesaccount@gmail.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XBLvWoofu7vVefSP"
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


--XBLvWoofu7vVefSP
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
v2: =3D> v3:
 - Fix title (space after iio:)
v2: New patch
---
 drivers/iio/industrialio-trigger.c | 22 +++++++++++++++++++++-
 include/linux/iio/trigger.h        |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-=
trigger.c
index 784dc1e00310..c616297aa754 100644
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
+ * @trig: The IIO trigger to check
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

--XBLvWoofu7vVefSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRI288ACgkQeFA3/03a
ocXGvQgAizU+jMs9XzIvhzAa6r/+POSHKVwh1MaTuzigoMnDEZJRcAtR6UrO2TAC
ickYz010FQHeLwa+6YVpSbhqZu6adhkkKUdc+YlV7+kH3zqt70HWfQvLzR8Iwn/k
B2guHJmmfCnFgf3thFbzkD9IAsaUlDtrkN8lD8Ri171H5IlOXgiAam9ehwz8EgQF
aNEq8cMf8+V7Fpb/+VInO5e7aWPq1YhwCfHQUt0kEYnLTjaKRezm4IRfuiU7Dhj7
oK15QKSr1MFoDnUH2hfCbiejRS2ALx/lhQSAsJGfMNLdV3gVxHVbEQ1Pqy0tT+Pv
hP3vaFSJQyRjX1OfFjkgVvgivlIAWw==
=iihm
-----END PGP SIGNATURE-----

--XBLvWoofu7vVefSP--
