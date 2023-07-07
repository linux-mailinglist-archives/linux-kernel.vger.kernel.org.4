Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974A74AF95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGGLWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGGLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:22:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F771FF6;
        Fri,  7 Jul 2023 04:22:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so2824504e87.2;
        Fri, 07 Jul 2023 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728947; x=1691320947;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZjA1a1Afzs6q7vAiqjeopUm2/pQmTWPahmXLjFLNwg=;
        b=iK3P6nulx5kICrJoyqmShehCXYzWbkXx4LA+/LJ2S+o2qpnKBYZtPf+QdioNsOdxHF
         xWB3rJvjxkn59k8hP0uNdizkT62OqXj5oxEht5560RA+6c+HM4jMAhsX5RcHtiu/IVz6
         7rCMN6ArDyxSP3MTbYsHupPYCTekx3g6AO5kRuNaga2MeFQoXiJmt4Jg0WRmDMnEUymP
         VkxMf52Ljk4owmZLuU8ECd9NietR0ngAAxJdK3zEnykHaPOiS8+eZZAqNHuBVQ0LWxEk
         LduG2eDae+PsliDNCQh8LQ75lYBkyjf9G+0VZeZ+6FgKU8K1PUVzvG050Xy8AY1l4D6l
         sH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728947; x=1691320947;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZjA1a1Afzs6q7vAiqjeopUm2/pQmTWPahmXLjFLNwg=;
        b=kK4Fd3YiCTjAKUa93+A77E/JiPXCOGf2iewX6Md1+vpCTdxlZG3wDLk+bL4MmKLl9k
         VJidw9d+2iXdMeLOwI7DSMcWhWeCaDZz5h5ivRiQs2dvum6trPFwB2Pn6QRT7zjUtdHc
         F5PomsB4+nQDJK6Tcbt1BR01nccl1dwZoD+lhdS1TFrQxdHWQHYpmJlj5VcCIrIMaZx+
         j1mnc047+MCorFCIz2NsgG7DyCb5Lt3sbAbmcnDQUk964TaqZhBlpzoz0YaruRBExVnv
         LRw1NH0byYCVP+igF9XAhQaUmCg5h5xGlxbYgF+plwmnUfY3B69aZnIUrWZRB7rt/LOj
         hnvg==
X-Gm-Message-State: ABy/qLa3sw3qIV2th0aJA9Hc1A7b6DvY76Mysd2v4HEZYumsF81g+MKc
        531czpwsg+y/SiTETMvQHhg=
X-Google-Smtp-Source: APBJJlF32/MRRb13L0lUA8epvt/PGbReQ1s56ZPqykxUMHTfrQtof+i9wnbh4gtzTlfPgnj7FQUA1Q==
X-Received: by 2002:a05:6512:464:b0:4fb:97e8:bc25 with SMTP id x4-20020a056512046400b004fb97e8bc25mr3501477lfd.34.1688728947060;
        Fri, 07 Jul 2023 04:22:27 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b004fb7bb42de4sm644646lfn.58.2023.07.07.04.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:22:26 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:22:14 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Support ROHM BU27010 RGBC sensor
Message-ID: <cover.1688723839.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0lBHn7wM0n6T2zx"
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


--f0lBHn7wM0n6T2zx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27010 RGBC + flickering sensor.

Following description copied from commit log:

> The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> There are some notable things though:
>  - gain setting is once again new and exotic. Now, there is 6bit gain
>    setting where 4 of the bits are common to all channels and 2 bits
>    can be configured separately for each channel. The BU27010 has
>    similar "1X on other channels vs 2X on IR when selector is 0x0"
>    gain design as BU27008 had. So, we use same gain setting policy for
>    BU27010 as we did for BU27008 - driver sets same gain selector for
>    all channels but shows the gains separately for all channels so users
>    can (at least in theory) detect this 1X vs 2X madness...
>  - BU27010 has suffled all the control register bitfields to new
>    addresses and bit positions while still keeping the register naming
>    same.
>  - Some more power/reset control is added.
>  - FIFO for "flickering detection" is added.
>
> The control register suffling made this slightly nasty. Still, it is
> easier for maintenance perspective to add the BU27010 support in BU27008
> driver because - even though the bit positions/addresses were changed -
> most of the driver structure can be re-used. Writing own driver for
> BU27010 would mean plenty of duplicate code albeit a tad more clarity.

This series is done on top of the iio-for-6.5a + this fix-up series:
https://lore.kernel.org/all/cover.1686648422.git.mazziesaccount@gmail.com/

I didn't spot these fixups from iio git although I think I saw mail
stating they were applied.

Revision history:

v1 =3D> v2:
 - make vdd-supply required binding.
 - Some re-ordering for struct member init.
 - Some re-ordering for code to get rid of function declarations.
 - Tidy up the mess from patch 2/3.
   - Refactor parts from 3/3 to 2/3.
   - Clean-up commented out code and tidy things in general.

Please note: I'll be mostly away from the computer during July. Please,
take your time reviewing and forgive me if sending follow-up revisions
is delayed.

---

Matti Vaittinen (3):
  dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
  iio: light: bu27008: add chip info
  iio: light: bd27008: Support BD27010 RGB

 .../bindings/iio/light/rohm,bu27010.yaml      |  49 ++
 drivers/iio/light/rohm-bu27008.c              | 622 ++++++++++++++----
 2 files changed, 556 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

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

--f0lBHn7wM0n6T2zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmSn9WAACgkQeFA3/03a
ocXpIQf/efHlfr0i8yGrGK4TBrulAlyuIYElovzNrx1WfT2XtHVskVqsOc2gue8M
2MqdWbM+xG121YOg8KlzSjWSkB9M/Y/bUfdpe5g3jggcDxGilXjoOtHBFpgAhUEk
eMIzNhKTU1GgBMxtTdW+jhNW2O3pS1H4qHvopCeVvz6WGj4DCidiMusXU/FX4sYT
W+oOKBIwId6PKbAooxwtQ+5hJZRU4yiEizP0KmN7DstZGlvUMHDj39ZoOG6y+zbJ
EGWDeUHUo4GEp3+K4dUzHuNZ0z/B5WARWao9YJRBTfBZ9Z4hO9LiuSIFGDG6QOsl
BRdoLosMYAm9w6+72LliqP39mTaJwQ==
=pJVJ
-----END PGP SIGNATURE-----

--f0lBHn7wM0n6T2zx--
