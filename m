Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329C56F551D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjECJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjECJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:45:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC52D69;
        Wed,  3 May 2023 02:44:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2aa39ce5d26so50335311fa.1;
        Wed, 03 May 2023 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107086; x=1685699086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojEP9jyPYV0kD4k17U7z2zy6rqymh0kERFtXzzcztIU=;
        b=Zv0OMcx+3tE1eL/oKZ1vLmKsrOS70sB8Y3JKt5oTugKAIGzBCrXdxXrfRw2nETQDRj
         yn0u9pEABmPNFKhaIU9Vi/YG66R5ef71eDrHqFYTV2ojm+5qBD010v0zi+tAoHCi/hc6
         +Lumqk1EW1BrS45MK4kLp3aH71ffjST5qHZ4KbxSKIV0UoZUSlAfsBeEFaq+NCN9wx9W
         YsIfcyupolcFlkQHyyHO7Iwm8MuJUHranqQrhWldjODlf9DBi1FY9Ip2KHU63zro9Xbb
         WSvIXUGqibhT+TzH38zCfWekFe0ve4GINNJYO24dH7YS86neAINd2cQbP0ffExyQudQO
         UBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107086; x=1685699086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojEP9jyPYV0kD4k17U7z2zy6rqymh0kERFtXzzcztIU=;
        b=ZO+xDYc+bmJLTTudcI7eCv9/oI1a1zjxPaeG/WiTfbYgE+Z0jh5dO+dRScJXTCnora
         WX0WmCwkjFR1QhKYzk6+/mk5SNnnp2EeN5+Ec+mjTVOaXk1ehkuTVlJLevGW0PQK7/ZK
         4kLTNEDELwcQQ+yTAWHkV6tXuq29p84aiTlMZZKs1+eYU92OZu77AejaGBxBgQ+NdaGS
         LqurSROq9/FtTGRG5PxqaoqO8FnOZ51lI46SIU3TUmnp7mhnK0jQX9PNSrXW4305vzw+
         Piz/PIKr9Cq9mTXLz0y5wClKJ/DB9bGW2XYDIjQMNa7B58FT/IoZkX0eCSUgGiw/NVWO
         VQXQ==
X-Gm-Message-State: AC+VfDwAJ/jXi663xn+2LxWg5POkeudAomgx1kpoH4EogXmfvTZ3Annx
        5UEj12OqtTdIHeLn7mG7AGQ=
X-Google-Smtp-Source: ACHHUZ7pgzWt3EBF0ftVh/qjbv7O9HsTVOsdlQkINcPMbcunzFiEfvfGCfeZQmH98HcoLckbOlS1MA==
X-Received: by 2002:a2e:870a:0:b0:2a8:b579:225b with SMTP id m10-20020a2e870a000000b002a8b579225bmr5715324lji.40.1683107085468;
        Wed, 03 May 2023 02:44:45 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8857000000b002a8c271de33sm5778594ljj.67.2023.05.03.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:44:44 -0700 (PDT)
Date:   Wed, 3 May 2023 12:44:29 +0300
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
Subject: [PATCH v4 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <cover.1683105758.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P6C63pZ7fe5zi9Lk"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P6C63pZ7fe5zi9Lk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for ROHM BU27008 RGB sensor.

The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
and IR) with four configurable channels. Red and green being always
available and two out of the rest three (blue, clear, IR) can be
selected to be simultaneously measured. Typical application is adjusting
LCD backlight of TVs, mobile phones and tablet PCs.

This series supports reading the RGBC and IR channels using IIO
framework. However, only two of the BC+IR can be enabled at the same
time. Series adds also support for scale and integration time
configuration, where scale consists of impact of both the integration
time and hardware gain. The gain and time support is backed by the newly
introduced IIO GTS helper. This series depends on GTS helper patches
added in BU27034 support series which is already merged in iio/togreg
which this series is based on.

The hardware allows configuring gain setting by writing a 5-bit gain
selector value to a register. Part of the gain setting is common for all
channels (RGBC + IR) but part of the selector value can be set
separately for RGBC and IR:

MODE_CONTROL2 REG:
bit 7	    6	    5	    4	    3	    2	    1	    0
-----------------------------------------------------------------
|	RGB	selector		|
+---------------------------------------+
-----------------------------------------------------------------
| high bits IR	|			| low bits IR selector	|
+---------------+			+-----------------------+

In theory it would be possible to set certain separate gain values for
RGBC and IR channels, but this gets pretty confusing because there are a
few 'unsupported' selector values. If only RGBC or IR was set, some
extra handling should be done to prevent the other channel from getting
unsupported value due to change in high-bits. Furthermore, allowing the
channels to be set different gain values (in some cases when gains are
such the HW supports it) would make the cases where also integration
time is changed to achieve correct scale ... interesting. It might also
be confusing for user to try predicting when setting different scales
succeeds and when it does not. Furthermore, if for example the scale
setting for RGBC caused IR selector to be invalid - it could also cause
the IR scale to "jump" very far from previous value.

To make the code simpler and more predictable for users, the current
logic is as follows:

1. Prevent setting IR scale. (My assumption is IR is less used than
RGBC)
2. When RGBC scale is set, set also the IR-selector to the same value.
This prevents unsupported selector values and makes the IR scale changes
predictable.

The 2) could mean we effectively have the same scale for all channels.
Unfortunately, the HW design is slightly peculiar and selector 0 means
gain 1X on RGBC but gain 2X on IR. Rest of the selectors equal same gain
values on RGBC and IR. The result is that while changin selector from 0
=3D> 1 causes RGBC gain to go from 1X =3D> 4X, it causes IR gain to go from
2X =3D> 4X.

So, the driver provides separate scale entries for all channels (also
RGB and C will have separate gain entries because these channels are of
same type as IR channel). This makes it possible for user applications
to go read the scales for all channels after setting scale for one (in
order to detect the IR scale difference).

Having the separate IR scale entry which applications can read to detect
"arbitrary scale changes" makes it possible for applications to be
written so they can cope if we need to implement the 'allow setting some
different gains for IR and RGBC' - later.

Finally, the scales_available is also provided for all other channels
except the IR channel, which does not allow the scale to be changed.

The sensor provides a data-ready IRQ and the driver implements a
triggered buffer mode using this IRQ as a trigger.

Finally, the series introduces generic iio_validate_own_trigger() helper
which can be used as a validate_trigger callback for drivers which
require the trigger and iio-device to be parented by same device. The
KX022A driver is converted to use this new callback instead of rolling
it's own function. The new helper and KX022A can be merged in as
independent changes if need be.


Revision history
v3 =3D> v4:
  bu27008 driver fixes
    - Drop thread from device IRQ handler
    - Styling and some minor improvements
    - Use kernel-doc for enums
    - Correctly order entries in Makefile
v2 =3D> v3:
  dt-bindings:
    - No changes
  iio_validate_own_trigger:
    - subject fix
  bu27008:
    - Mostly styling based on comments from Andy and Andi

  More accurate changelog in individual patches

v1 =3D> v2:
  dt-bindings:
    - Fix issues pointed by Krzysztof.
  bu27008 driver:
    - Fix issues pointed by Jonathan
  Add new helper for validating own trigger

  More accurate changelog in individual patches

---


Matti Vaittinen (5):
  dt-bindings: iio: light: ROHM BU27008
  iio: trigger: Add simple trigger_validation helper
  iio: kx022a: Use new iio_validate_own_trigger()
  iio: light: ROHM BU27008 color sensor
  MAINTAINERS: Add ROHM BU27008

 .../bindings/iio/light/rohm,bu27008.yaml      |  49 +
 MAINTAINERS                                   |   3 +-
 drivers/iio/accel/kionix-kx022a.c             |  13 +-
 drivers/iio/industrialio-trigger.c            |  22 +-
 drivers/iio/light/Kconfig                     |  14 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/rohm-bu27008.c              | 993 ++++++++++++++++++
 include/linux/iio/trigger.h                   |   1 +
 8 files changed, 1082 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 create mode 100644 drivers/iio/light/rohm-bu27008.c


base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420
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

--P6C63pZ7fe5zi9Lk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRSLP0ACgkQeFA3/03a
ocUDrQf+OxNKGB/FUi7i21Z8bsvmAsD8L+98eC7ffGG18ejsVA6OJ9vQksoOd3R3
No+G8FNR/dM15gpbIH1VnCvEA8YGIzs66+YhzD73iMRyFS03BkcfLnZqmNVNL9uS
XaFJPF+UmoamLn4rfIlBOjVDezGlzmdbIURLOg3w1vHMarXF7Xjr5MxaeHibc/bU
wHOl9Q2b+9K7p3/5nNIOxbcFoiFulSffYvad3y6DMMckgP/PP0Ur4dQ0WbK1sN78
7lGp8O46noD6LWRFxFa93u4TV/4Or6A7xlWQMnRBhsi2mBmz2QTmxyEwkTaNxYn/
CvsRIpUuKSi+XTgLZO7mDgFY4m1VdQ==
=7Cpw
-----END PGP SIGNATURE-----

--P6C63pZ7fe5zi9Lk--
