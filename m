Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE246F6665
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEDH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjEDH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:58:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1489D;
        Thu,  4 May 2023 00:58:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so175615e87.3;
        Thu, 04 May 2023 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683187093; x=1685779093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vDKtd+6SUBHcVfjrnZzqsHHwPGA/V8JOv73WPDoiE4=;
        b=nA4WQdOOsCPmalSFyKz+KFUzbknl9LGS6Eh4MVg/QET5MVLdgvLYiE34BQo1CcK19P
         OcK6Wfh1f/nmblaxU4LPSuoFk9RUw23nzy+1ILpO5+LKHrlP2okBc0xICCIh1CEoEYFA
         FcAat/zU8DWZ9WAoLy/YKGthRyKKRVP4dH5+nQPrP04UqlF7AJ8320dDdWjkkDpqxpcZ
         oFRBrqkSx2getWbylqCy88Ql5nWeq3kO2ULE3tNZ5uhrDcRMmJoQrw5G0QAQ+VSDZMKJ
         ltF31ZOUe4HSXKi46ii8BppG8cxs+LVXTQ7aYA+8Fv0xmQim1p5mVcuoOf7bGnJBFsxR
         5sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187093; x=1685779093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vDKtd+6SUBHcVfjrnZzqsHHwPGA/V8JOv73WPDoiE4=;
        b=UZZgrOBNt86mgbZmLxWNOPa1C9woaZCICXosV1L9SUf+4x3yzwhu3nbyRuGtjWHQVL
         hxR9Kl90Pj+Y4/LYU8LYpOO3i1X8xX1D9eH93rYznRvsOuBEKYxubOgnSuXwJ9+tWvtS
         bJoIevnd04q/NrLF9KfoNd4t13NrKSt0OJRapqBnrgb/3wfL1Hng5bs6bxGcNHyEStAc
         13wsmgv8e1hPO0CSMgDE0SSUSmiSfZXFEEYqtPGamrP9quqspA+Grt6BT8Tt1oeYuVAz
         mVH/sTLXgQk5gnyrUsDWpA6fRtFbac6lAk+pMmdIOGjxVzp1lkbIw9xhYKl01+7IVaed
         za6g==
X-Gm-Message-State: AC+VfDwTVPada46oCQC6jfsYEFSAMY3S5KQzwri4SrezVmdpIRVANRYo
        ohYrYdBhh2UZmP5t+fE99yw=
X-Google-Smtp-Source: ACHHUZ7gY/3ZiDJPcW+3n3j3tEcpRuOGxE+LoMhfUZ3u5a3xOaUJurgTz5pqCYWQNDsQQZTxvgFW7A==
X-Received: by 2002:a05:6512:3906:b0:4eb:2d47:602 with SMTP id a6-20020a056512390600b004eb2d470602mr1383002lfu.59.1683187093308;
        Thu, 04 May 2023 00:58:13 -0700 (PDT)
Received: from fedora (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id s5-20020ac25fa5000000b004e83f386878sm6392874lfe.153.2023.05.04.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:58:12 -0700 (PDT)
Date:   Thu, 4 May 2023 10:58:04 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] iio: bu27008: Probe asynchronously
Message-ID: <7cbc13bb62a0f6919366317991c5f451a0f8aa4e.1683185765.git.mazziesaccount@gmail.com>
References: <cover.1683185765.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrwMi0N3ruh9uJZf"
Content-Disposition: inline
In-Reply-To: <cover.1683185765.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrwMi0N3ruh9uJZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devices which may take a while to initialize during probe and which have
no strong reason to probe synchronously can request asynchronous probing
as default probe strategy. This can speed-up start times on some
platforms.

The BU27008 gets probe delayed for at least two reasons. It enables the
supply regulator, (which is likely to have ramp-up delay if it was
disabled) and additionally it delays while the sensor itself is
initializing.

Changing to asynchronous probing may cause problems. Some of which are
discussed in:
https://lore.kernel.org/all/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org=
=2Euk/

Enabling async probing for the ROHM BU27008 should be fairly safe to try
though as there is no in-tree users for it yet. If the async probing
appears to be an issue we can switch easily back to synchronous (or
better yet, fix the actual problem).

Enable asynchronous probing for BU27008.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I am unsure if this change is 100% safe - but I don't immediately see
the harm. Please let me know if some of you have more experience on
problems when using asynchronous probing with IIO devices.
---
 drivers/iio/light/rohm-bu27008.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
index c04d845062ba..628d17036bb4 100644
--- a/drivers/iio/light/rohm-bu27008.c
+++ b/drivers/iio/light/rohm-bu27008.c
@@ -982,6 +982,7 @@ static struct i2c_driver bu27008_i2c_driver =3D {
 	.driver =3D {
 		.name =3D "bu27008",
 		.of_match_table =3D bu27008_of_match,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new =3D bu27008_probe,
 };
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

--hrwMi0N3ruh9uJZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmRTZYwACgkQeFA3/03a
ocV01Qf+MNP2ygbXo7I6Vngpe67zSBo3sOt3eOoXjBlae8VvOSGk2y52KNbh64s7
mGrGB0q33y6MQ196jb10ODHBAFKkdtYPtC5gR/OTJtqHyNRfrffcjwndkJk8Ugl3
D5HrkAs/Z9OPvqMwbUT9Ffrazxi56B+dtsHiks9d1gbxmGpRHOKLSJ1m5u8PmBku
62LacMozxQTryj9QTvLeofFQslR+3KBIoXq4TlwY5UX8GunL5eg8FIWAHqIOBZyA
1BTBOQpN6puSYr1cyQsPJ3adPCaBvBVnzxK2TxSdX0HAO5spGbNVBpG1qq4U5uNr
J6pkID5yQ3nqKL5ldyrGkHATdJIMhA==
=8YZz
-----END PGP SIGNATURE-----

--hrwMi0N3ruh9uJZf--
