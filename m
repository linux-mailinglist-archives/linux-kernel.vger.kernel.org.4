Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AA56F5558
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjECJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:51:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4AB4C13;
        Wed,  3 May 2023 02:50:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso291108e87.3;
        Wed, 03 May 2023 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107434; x=1685699434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=giiNwB/ofLJq9Zmc8RdE3SafvU/LyX7CoNowFxpAxEY=;
        b=Gh1VBV9IXf791iwp+kVCh7qyn4R5Y3nCmJ1Qz7pMO/cE/bqq1xWFVP0QU1dBf2q2X0
         SjafL7wxMcVIckevgWFkgOopOZBawflfB8ldsyKJWPKoF2kPUFoodBzz8AqKvs22y2tI
         mTIcJqGTx7DSmPq0bh6bc3iXI/C6Oe0fUkWn7edYnMmhA8N09r4v/3vbvh20fVhcalfY
         FyrTwDMzoIYVWefwe3vB6dqQatlKDGcNjo/Ln9SgoqlWkuNed21FhG7elKtnnW64+39C
         j36wHhHdxgZUyGt2RdkXBOHWApjYrmIZwy0yzmN4Y1JpY8TeOjq1BNvmCJRgofwCd9L9
         kWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107434; x=1685699434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giiNwB/ofLJq9Zmc8RdE3SafvU/LyX7CoNowFxpAxEY=;
        b=K5yUdQr18gMoQH6EgCsC8n88CLusVnpAiMi8J6IsIFzXg+htPYYzE/KD+MC0dmjS2s
         ym/FeasBPvSxSLeeUYH6a4aFM7o8x9tXR4ITqSz2gdbscKl4tLauwVvxB9QFH5ZgWyem
         mT3hQDzVWuVKlNc/d7NIzZ5QLR5ZWh6M0PJ0jJEFr1y9dOA55YW9FjONCTNzvBp1Dov0
         O9mpdVX+u42PyaUZUeCj1Ts9zXnHA6UaO4CG8JtOxTv9vwAn5WhEsiQJSrjMoxxJ71vd
         3CHOJ7Ll4iSWjHX9NMvERAqACnjH8fd5B7ONW5AD0aEvukenUybB/hHwr/yM3m0p8R11
         RldA==
X-Gm-Message-State: AC+VfDy1c1XCNMfNVvjoNazwqHRlfk1ENeX/F7D89Yscc22hkJu2iKEA
        evM77KG22jJwImsKBTHVrBc=
X-Google-Smtp-Source: ACHHUZ4nK3cEvg58H2Kq5P3sIHMsiEzWtHGPmej11jB01kfLHuLIvkXu0MpBeoe/PLq2qTgbYLmaoQ==
X-Received: by 2002:a05:6512:502:b0:4ef:f64b:65b5 with SMTP id o2-20020a056512050200b004eff64b65b5mr770258lfb.62.1683107434279;
        Wed, 03 May 2023 02:50:34 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512014600b004efd3c2b746sm5475508lfo.162.2023.05.03.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:50:33 -0700 (PDT)
Date:   Wed, 3 May 2023 12:50:30 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: Add ROHM BU27008
Message-ID: <1c1b035d9c93faa59fabc60e7376e67c9ed93747.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MZBAOBq6rUGqWZP+"
Content-Disposition: inline
In-Reply-To: <cover.1683105758.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZBAOBq6rUGqWZP+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for ROHM BU27008 color sensor driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
No changes since v1
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32772c383ab7..c02e3d2ec348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18198,10 +18198,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
 F:	drivers/iio/light/bh1750.c
=20
-ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
+ROHM BU270xx LIGHT SENSOR DRIVERs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
+F:	drivers/iio/light/rohm-bu27008.c
 F:	drivers/iio/light/rohm-bu27034.c
=20
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
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

--MZBAOBq6rUGqWZP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSLmYACgkQeFA3/03a
ocWYVQf/TavC0x0EopKULDo1d2NIOS4xV02Ca059/9CtwibgG+floEcaSAZUEsFL
hhjEqYBnDdaMHXw6Q45th7detgiPH7HVKW09PYlKJWdpIiRywJCfTXGmdelB0itT
SEEGrQL2DAAsEHAg162h/LYHVjufXJByezioLYDTBj9ZsmLYOA3058s1hpVgH4Rl
Y0Ch9tjn0HemXwku6wtZhLl/Vi7TO0J39sN3UOqWXFsmXzt3w2exPWxNz4Wq4Qtw
GztHLlHzIhBkIlDfLQkU9JoSUXNwUdgK+uPXzuksXQfcivWXfxTpoStygK1BIVAv
csK5qTX6YQy9XSJ8yHMnCFv2QLtVRw==
=oZhD
-----END PGP SIGNATURE-----

--MZBAOBq6rUGqWZP+--
