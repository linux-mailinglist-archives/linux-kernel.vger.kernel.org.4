Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCE56C8FE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjCYRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjCYRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:37:24 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3410265;
        Sat, 25 Mar 2023 10:37:14 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CE6E41C0AB2; Sat, 25 Mar 2023 18:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679765800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0qpAaGx+s3uQlRuZYn6EDwuH8UAOh4JZE3aZA+H03Q=;
        b=esiDhnO6Gw+H5J9u0yH+/GJpl/lXBCD3kXfO7BR9mKReuJiFSNM+PBXYfUG4+a5UMLU8rH
        qmB41s59ziGAbe0tlqgiZ4wrzVKiSAFInXBLXLqn5j7KzFa7cXmVEFxfYPcLl9IsD7Tkpn
        T70zBqgr473WEvHjtEQ6CSgd6EYrrJU=
Date:   Sat, 25 Mar 2023 18:36:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Message-ID: <ZB8xKGgvlb5oC/pt@duo.ucw.cz>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tDKVZO8CUzZz+aY/"
Content-Disposition: inline
In-Reply-To: <20230303095023.538917-2-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tDKVZO8CUzZz+aY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2023-03-03 17:50:22, Fenglin Wu wrote:
> Add initial driver to support flash LED module found in Qualcomm
> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
> and each channel can be controlled indepedently and support full scale
> current up to 1.5 A. It also supports connecting two channels together
> to supply one LED component with full scale current up to 2 A. In that
> case, the current will be split on each channel symmetrically and the
> channels will be enabled and disabled at the same time.
>=20
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sm7225-fairphone-fp4 +=
 pm6150l

> +	flash->led_cdev.brightness_set_blocking =3D qcom_flash_led_brightness_s=
et;
> +
> +	init_data.fwnode =3D node;
> +	init_data.devicename =3D NULL;
> +	init_data.default_label =3D NULL;
> +	init_data.devname_mandatory =3D false;
> +
> +	rc =3D devm_led_classdev_flash_register_ext(dev, flash, &init_data);
> +	if (rc < 0) {
> +		dev_err(dev, "Register flash LED classdev failed, rc=3D%d\n", rc);
> +		return rc;
> +	}

I'd expect setting max_brightness somewhere around here.

What does cat /sys/class/leds/*/max_brightness say (and what directory
name are you using)?

BR,								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--tDKVZO8CUzZz+aY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZB8xKAAKCRAw5/Bqldv6
8qX7AJwPlw7HryoubF1RG7ezrmWwvAgThgCfZ8gHW9qCeUerl+HA7trpQCq4RZI=
=lEcr
-----END PGP SIGNATURE-----

--tDKVZO8CUzZz+aY/--
