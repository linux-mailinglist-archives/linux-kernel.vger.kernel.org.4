Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB16DF526
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDLM0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDLM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:26:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01526B8;
        Wed, 12 Apr 2023 05:26:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o1so14492521lfc.2;
        Wed, 12 Apr 2023 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302388;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Y8SzNN5mNDbUKXbv/hNMw3cqHQa6RWiGGetlO0vZAE=;
        b=pY14FIRGL13fp0Yzw9a0vHJbqBq/ju2gGL7K57ycDWmv7h1jnFb5pOwCSD3cB4BzsR
         apNA5e72eDHkXwlFAjt7C8K1kiHY005ticcR1I0hk9xLg/BuCvNYxgr1j8CdtYvMUeEy
         kczSw0q6C3DfObBhjIxlUXatdxhQVRqzaSWus8/FapfzCmcvkqfuKq3SMusZfApH9IS4
         NnPFnuHgewo8D94Q4hCWRBe8f5gKB2fIMPO5nuWbFnPwuAkSCWJIN5v1vDEIm2itq1+n
         /blvFkQ5AlHFMq2phtwcJDYu4Z24v9lf1l2sIjXJxvwU+Oguerq5Yt8ImWIofj0cbLmc
         2ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302388;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y8SzNN5mNDbUKXbv/hNMw3cqHQa6RWiGGetlO0vZAE=;
        b=M3mc5G48hhINb4YQGXZ8ecwjoez98YdaaRMAl7xQvywOdxvoWepVUNP+ziupaVc0RR
         omBDjl80KMaXCUlYm37a+N+XhSX95Q7+4qt9C+YvSFqE/PR44JwusgebeEFX811Tr2TO
         VPdrpDvcAwT2dMUeEScijkFULuZZksUzF48K87XwSef08atnu2tQ/0kRHVa5TfioLoGa
         q9BsJxdNFfJtLHWFhLN5UTv+ePjC3JAs1P0eIC95PdBhOK5rDYtBPOEih+zTLtbjga/d
         znIu2xtUpZS3QwtF8Q1hIx8LEFdpacFh79Y+p4P3H1fG845laIvIPQ7oV3VrRgsgXgfU
         AYlw==
X-Gm-Message-State: AAQBX9fIqrOJiAg7OVt7WFgzKEAAyRRF4P+p2efAOdostv8uFU+YDvKV
        n1lbdVxp6ZEfwldLjIKlDJnmHN7b2IA=
X-Google-Smtp-Source: AKy350ZTc0CEBb8ibbY1LpjpBJIAw5pqqxdbi5V14jj1NpSmg6wAjZ54W8pJ2MMnFlZ6aWFYHUiiyA==
X-Received: by 2002:a05:6512:3905:b0:4dc:807a:d144 with SMTP id a5-20020a056512390500b004dc807ad144mr3735161lfu.39.1681302388010;
        Wed, 12 Apr 2023 05:26:28 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p22-20020a19f016000000b004ec834cc59fsm1945032lfc.267.2023.04.12.05.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:26:27 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:26:15 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: Fix integration time units for iio-gts
Message-ID: <cover.1681301472.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VB6YwPETZFQ4go9u"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VB6YwPETZFQ4go9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The newly added iio-gts-helper (gain time scale helper) errorneously
reports available integration times as micro seconds. The same mistake
is in newly added BU27034 light sensor driver. Fix these by adding new
IIO_VAL type, IIO_VAL_INT_MICRO - which can be used for micro <unit>
values where the integer part is zero.

NOTE:
I did not have the time to test the gts-helpers with integration times
which are greater than 1 second. Currently there is no other in-tree users
besides the bu27034, which does always use integration times smaller
than 1 second. When greater than 1 second times are needed, this needs
to be revised. (Or, when the devm_* interface kunit test support gets
added). Right now this should be a quick fix to integration time
handling before the bug manifests itself in the user-space).

I am planning to test (and re-work if needed) the gts-helpers available
integration time list for > 1Sec times - but I most probably don't have
the time for that during this or next week. (Don't know about the
weekend though - but probably not.)

--

Matti Vaittinen (3):
  iio: core: add IIO_VAL_INT_MICRO
  iio: gts: fix units of available integration times
  iio: bu27034: Fix integration time units

 drivers/iio/industrialio-core.c       | 4 ++++
 drivers/iio/industrialio-gts-helper.c | 2 +-
 drivers/iio/light/rohm-bu27034.c      | 7 +++++--
 include/linux/iio/types.h             | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)


base-commit: c86b0e73f0bebbb0245ef2bac4cf269d61ff828c
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

--VB6YwPETZFQ4go9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQ2oy4ACgkQeFA3/03a
ocU0OQf/VGWbJ030HpBqIOqIku7QspaMH1CCuQrqcMR5ax4aqCCRJQIx1sQC0oAd
UKjq9JxdSRx5z51k6lx90llOPb8F43jN7RPnegO0tr9A3vCb32VPOq5g5Mi4Prr+
IgKXfkpggoGDiDdYpeXbFGxT9S3kU+BezBxGT8dMQbJZVRneyPeF37rX266aIE0p
ABXga939QRTRjvIkWI7VdFpCbrmP1yVIWdD53y03xMov+BgDgdb8Q8yIrzhUD3Aa
sVqLagZIf/3ssoZwW7i6N1DV2sH9A8SDUBiiL7d/Cv2xcBQuuppZTnwzSE+UvEbj
JbdV+OZiiRU+aUEARIqVbxs6X2+lCg==
=sSAi
-----END PGP SIGNATURE-----

--VB6YwPETZFQ4go9u--
