Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777626FA77C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjEHKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjEHKap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:30:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C924A8D;
        Mon,  8 May 2023 03:30:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac831bb762so41740931fa.3;
        Mon, 08 May 2023 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683541842; x=1686133842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4n+sPW796mS9dhJ6fHd9qvr1mW3PkrYQCtXjQ0ZTZo=;
        b=QJ2rbssUzSgbKCZkXM9w7Jy0q9Ix8lJSjNabHHhe83scfou2njTVA3OeVd6BRwpSAS
         Y2kXOkoQHhszriKKexHeyuv5TkLFALBm0HfQ8P8OcZZDMbXMKdBDppYtwoAh1uv+jt9c
         S1fIL9/nb7bkjAY4tGXwjoRoolDp+C6Oum9P5o1ksQqlrYU8YSrY1Lm6BIbElpSNWhmR
         CiTm/JmGS5ZaLUBN6uVGcpo3AdXaDcSzVzPmCytsq14l3uPhMCdWWN0UxSKLFmvfYIHW
         K4YYUiGoWmu7o3Uklb0nH1xljrlZKEWBLdJnaMrmuzL12a5oh5J6YSuup+RrDFVGgrfP
         nZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541842; x=1686133842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4n+sPW796mS9dhJ6fHd9qvr1mW3PkrYQCtXjQ0ZTZo=;
        b=idry36PbWBvxLmL6t2TRuwP2KC1Rxmfi3IAj2Mm4a2HoeGPXh7cEMxNH4M7LduKo/B
         HZJfEjaAnQ322dW1v2I/wkfqFej0+N5Jc/VSQnHznVfTp8nM415GDlVbpZz2mBINlhMT
         4c4xWNz+CUOG9O+/dfZm5FlooX0S1wRPyrOWLfAppDqpeFTQGe1eR9cVpCYuCipd1MZ9
         WCQfLp1f/VvxvrRwRGu4jfJQx/+R50q3A2LpL5unxuAuQ2AUghONw9wcudDCuniI1gQX
         82QKSfUTMVy3dZVfMLLTvwOVYyL8Bv3+jwhwnwLYZE1oTYdYmAtbmOoRcF6tLGB/lODH
         ascg==
X-Gm-Message-State: AC+VfDw+hybmBte7tWtAnHdQNtSXLtJj60lO+UR6+o+iEfEIaFb3h0Q3
        9n3DJLi3lsu8wmMTj/gwMWA=
X-Google-Smtp-Source: ACHHUZ4YOM1piwm7Fu+MPvieFGLO26hzkwFNae5/vCt1pwGMpJ94UX0EIzV3mxdVa3/6NfG6InqJEQ==
X-Received: by 2002:a2e:9e45:0:b0:2ac:7764:aa4 with SMTP id g5-20020a2e9e45000000b002ac77640aa4mr2886398ljk.10.1683541841688;
        Mon, 08 May 2023 03:30:41 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9bc8000000b002a8b205bb50sm1104959ljj.61.2023.05.08.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:30:40 -0700 (PDT)
Date:   Mon, 8 May 2023 13:30:28 +0300
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
Subject: [PATCH v5 0/5] Support ROHM BU27008 RGB sensor
Message-ID: <cover.1683541225.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tywmqNVigfIf5Z/k"
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


--tywmqNVigfIf5Z/k
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
  iio_validate_own_trigger:
    - kernel-doc fix
  bu27008 driver fixes:
    - re-enable IRQ in trigger renable-callback
    - do trigger setup on own function
    - drop regmap lock
    - configure channels in appropriate callback
v3 =3D> v4:
  bu27008 driver fixes:
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

 .../bindings/iio/light/rohm,bu27008.yaml      |   49 +
 MAINTAINERS                                   |    3 +-
 drivers/iio/accel/kionix-kx022a.c             |   13 +-
 drivers/iio/industrialio-trigger.c            |   22 +-
 drivers/iio/light/Kconfig                     |   14 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/rohm-bu27008.c              | 1026 +++++++++++++++++
 include/linux/iio/trigger.h                   |    1 +
 8 files changed, 1115 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 create mode 100644 drivers/iio/light/rohm-bu27008.c

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

--tywmqNVigfIf5Z/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRYzzcACgkQeFA3/03a
ocVJyAf/VKRrGdriwVFe902yrspxGTs9cHVLsvCSBdREg2ByVVDXwdczq8M7UJy0
/VWxHBR66SGXskuovDp2pnBh/8JJHU9p4UmnnGfdTndOCL14y+gFp5BElKyb8u0o
p3/tuz2kwAILqpSfcJpSQp7az5Qeu6Hzl6Fo8fyLQThsDZgAgHEKZKFGrZrk+V7O
FnCXpSg6CL648VB70oZNSXbBF+MeGe6REzvImxFztCC2pLkCqviQ+eBcwD+NPzVx
zAdKsOwBfz1UXOHO95pHjzD1qZhQAm6JVAJvV49aJZTohhnN4ffZzN5yx1rVkjtc
t8+VdFiwVE/Hr4K6w2fge/sefB0drw==
=GBvF
-----END PGP SIGNATURE-----

--tywmqNVigfIf5Z/k--
