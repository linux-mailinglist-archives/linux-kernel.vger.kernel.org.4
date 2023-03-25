Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3706C8FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCYRdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:33:38 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F293E4;
        Sat, 25 Mar 2023 10:33:36 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6CC9D1C0AB2; Sat, 25 Mar 2023 18:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679765615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QD9OJ0fNImshINXdp8Ur2fXaAERCjCy4tzG/Ysy7jZE=;
        b=pF8t0cRIZdDfV5QmCavmeHvw1p3v9Q65YV/51JaXBtwX2cZT+tPCosStD2gYOdSfK84ckD
        AQGQh1d0MLLG6V8l7dmseEKCwkBEZtvhCyPFQBdNIEOuiHENwQteIZz0cHgh0wojoIWI1U
        g7foXEwH3UkENUV3GMjZm3Glaz5zADM=
Date:   Sat, 25 Mar 2023 18:33:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v8 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Message-ID: <ZB8wbv93+Vmx3trt@duo.ucw.cz>
References: <20230303095023.538917-1-quic_fenglinw@quicinc.com>
 <20230303095023.538917-2-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SNocmiwjTKO0+lmp"
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


--SNocmiwjTKO0+lmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add initial driver to support flash LED module found in Qualcomm
> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
> and each channel can be controlled indepedently and support full scale
> current up to 1.5 A. It also supports connecting two channels together
> to supply one LED component with full scale current up to 2 A. In that
> case, the current will be split on each channel symmetrically and the
> channels will be enabled and disabled at the same time.


> +static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, b=
ool state)
> +{
> +	struct qcom_flash_led *led =3D flcdev_to_qcom_fled(fled_cdev);
> +	int rc;
> +
> +	rc =3D set_flash_current(led, led->flash_current_ma, FLASH_MODE);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D set_flash_timeout(led, led->flash_timeout_ms);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D set_flash_module_en(led, state);
> +	if (rc)
> +		return rc;
> +
> +	return set_flash_strobe(led, SW_STROBE, state);
> +}

Should we disable the module before setting the current? It might be
already active due to torch mode...


> +		return -EINVAL;
> +	}
> +
> +	flash_data->v4l2_flash =3D devm_kcalloc(dev, count,
> +			sizeof(*flash_data->v4l2_flash), GFP_KERNEL);
> +	if (!flash_data->v4l2_flash)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {
> +		led =3D devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
> +		if (!led) {
> +			rc =3D -ENOMEM;
> +			goto release;
> +		}
> +
> +		led->flash_data =3D flash_data;
> +		rc =3D qcom_flash_register_led_device(dev, child, led);
> +		if (rc < 0)
> +			goto release;
> +
> +		flash_data->leds_count++;
> +	}

Do you need to do of_node_put in error paths?

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--SNocmiwjTKO0+lmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZB8wbgAKCRAw5/Bqldv6
8tBgAJ9UbKwCsuWIQ0IHnZPvZFTRfnPQ1ACgs8lE0snt0pnVCsxH55R3wMfwOrE=
=umcN
-----END PGP SIGNATURE-----

--SNocmiwjTKO0+lmp--
