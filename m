Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62D6ECCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDXNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjDXNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:08:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C716468A;
        Mon, 24 Apr 2023 06:08:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8b766322bso41796691fa.1;
        Mon, 24 Apr 2023 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682341704; x=1684933704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WL7uFoeDkdqYpddaEcXID1doFO9TkVEZpq0BEErd21g=;
        b=PdGRKMWxs2qOVRcCun4w0093CaT+iYNmy+cQXgFBU33KYpeXLRcuJ07z+trXW9ZnlJ
         fHk0M6vxp/Morfe53VdYTDEzpC9/yjbGKfPaWqTGjChHi8PRbrB2uMJBlOR24AC3htON
         SI4ABy6AWt44Z4BTeZYPkswXWLsJerT2oEZbAm/X5Yc/cORT++AWRANjuPpyFpJWbljZ
         Uoyk0MS7g7lztQrSNZgZA77JrvqeXhkiiurTQH27O9y4Npa20Zh6dD+q5J0gT6AA2OKM
         6AQAU5GtVmwG46Q8d6VgRxxW+QmvZ8clsPtkJ+lmk9LSioL0jSqZn9Zm7q2yf9vSwttE
         PyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341704; x=1684933704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL7uFoeDkdqYpddaEcXID1doFO9TkVEZpq0BEErd21g=;
        b=lUmp+juA0rweR6Ygulfz6irBwaU0yS2JUBxI5f1n3mEo1IAWNImlpwqFvkGUneu9J/
         4GNo6zSrqH+NA3GcIe4JBaeiR/pZmxFKAFk9IoF3w+4GQIXy+5aiZq0Ih6U6DGezvWpH
         VP93ENmT/H7FwE3dbeQrrLvUVjOOBxNVmrWKwk6Ziq7KAhba9NZ1Xd4sFF/lZOuk7IzF
         3L3LH1gu6hTgOp9qW1Ed/XW/unZvn4Gw+zrrPjnZAvJYMxFRjR/gauP+qX+Pa7i8OPjx
         BdZDE+2ortFMaPXDA1+bKwQZ+RTOId4J977rex46kOBEyy0G+9WxtQKKyaCVYIGZLCGX
         XQFw==
X-Gm-Message-State: AAQBX9e0A7QlBhv3Ha48176/yQPYw77lJyfBb9tgZGxMyCq8JCxFYQQV
        p/r0Pc6NC5JS5v8QZP3cCKc=
X-Google-Smtp-Source: AKy350YorN9PeKLJZCCwW0zAr2KcGf1kxH97x+LvbsJG0ZvucMnE1fwrHYzjYVyk31jdjpguKRobIA==
X-Received: by 2002:a2e:7e03:0:b0:2a7:a3b4:7747 with SMTP id z3-20020a2e7e03000000b002a7a3b47747mr2428968ljc.29.1682341703516;
        Mon, 24 Apr 2023 06:08:23 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id h22-20020a2e9ed6000000b002a8ab13b813sm1746248ljk.41.2023.04.24.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:08:22 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:08:19 +0300
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
Subject: [PATCH v2 2/5] iio:trigger: Add simple trigger_validation helper
Message-ID: <91fffd0001e8efef90f43fa03026dc0e5e30b4e4.1682340947.git.mazziesaccount@gmail.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WHhLnMZp04aVLHjv"
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


--WHhLnMZp04aVLHjv
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

--WHhLnMZp04aVLHjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRGf0MACgkQeFA3/03a
ocWeygf/YonbKkRhkJwY0zx7jfJAAydujuf9/TM5E7CVem+lVGsDvZHkBA96qadP
0Ecw9RPfiOTL7enDMseqnqeimI7MotT0QN3fSeW2lLEFmkVe52Gh0pp4tmzUSg/Z
uJXInor+fwlyaizF3ZUDb1sQenGijdldVRv1pDIwsgsk6roSJ8D1rSVcfHu9d0zR
TP95x7lyXGGXD6kiRUG4RB55nyLq+5EE76jh3zOBgymGIzQEpAPKH7qbeHwhi/Q5
/f/Tn9f0lkh0QtVXHskc6Yqle9Tbb/R3Vn6oJUKU0QK+eN90/v+t4ECId30cLkHT
Qz7mo2A2ea/aDzr2Gc0ZckQPZkQ4TQ==
=kuuo
-----END PGP SIGNATURE-----

--WHhLnMZp04aVLHjv--
