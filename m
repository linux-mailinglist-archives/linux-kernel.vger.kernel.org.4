Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D162B7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKPKV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiKPKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:21:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E016252A3;
        Wed, 16 Nov 2022 02:21:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z18so25829326edb.9;
        Wed, 16 Nov 2022 02:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epA11DHIv/C0ex3IjVI5I2qB7Y3CHDmgusYp3VOP3lQ=;
        b=QSCiqiGAQszDAYrGQI3FpAYln+FUiRobmaBNDu9SL9LmhMzJPzQ2H0nOkCGiWkkWR7
         kdF3ExgRV259NdzIa1R5Hk+IlchAemgyICf/887g76ZXIi0fhjH2P6zegRO2fFGJ8qtp
         clUgo46XLGYff18FzxddsKdJi3+Pn++GLCcOZe6nykZyeCLvQr3UI14iQ294MWe3qc/p
         FiViSkmXNu+8CEL7jT8vI+GOfl5KEGK0WQULkLy7zjX1XWpwAfFkYETg8+mrSWyQP9Ki
         /Peau9/Oh4Ym7CXYcr9Z1awyJkjOBamHHHumkGHVWLyZiKwffCrR7aH15sGgDhYsR8tv
         TVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epA11DHIv/C0ex3IjVI5I2qB7Y3CHDmgusYp3VOP3lQ=;
        b=mzTSR+Dt+wjCbjbV88o2iyuu59D6iMzpmiErOXy4squr/fAO0A9uDmTIYrcQOhZ2Cx
         N9Mqdci3KAL8l0n3YdMUOxnrtMwuSy22cAI5B93A7q8LFxR0xP+ev8M14Ka4Xc+4RlCE
         Mzgs/d4p4RQSWqEX2IVDpuiE/nAIBEugiOB77v96ka9///atBC68PN2yMLXiPPTzOBo7
         9lurDNOOFL29L1OF0P79QLBFlZZEKPcxWOr0qA6YE1MT2/aVKG62eWfJbre/fUdHzE8L
         cdc0gG1yONgOk92CO766u7sb1BIgGXpXMHYwRSsRVhMHDbt1/qJsa7qB6J3xq2U/qD/u
         qoyA==
X-Gm-Message-State: ANoB5pmItkCLNqfm2y2Jqn0yCF2DL6P8OmiQZwam5JTvD3aIMn7Wcubc
        1D4fLVGJbhav1IMIrS96X7U=
X-Google-Smtp-Source: AA0mqf6nmt7GuOY4FnnIbrBUDNfvaoNsGLdS3Y+3L1PrhCwtFz9gm68wG4NACTcYvhhOLH2DnAeaMg==
X-Received: by 2002:aa7:d484:0:b0:461:a4eb:6753 with SMTP id b4-20020aa7d484000000b00461a4eb6753mr18921563edr.309.1668594099877;
        Wed, 16 Nov 2022 02:21:39 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906140900b007a9a56e2a07sm6605922ejc.49.2022.11.16.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:21:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:21:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
Message-ID: <Y3S5sZIVi2DPua0p@orome>
References: <20221114202943.2389489-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZP8t6sia5cyeZVao"
Content-Disposition: inline
In-Reply-To: <20221114202943.2389489-1-bmasney@redhat.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZP8t6sia5cyeZVao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 03:29:43PM -0500, Brian Masney wrote:
> Note that this is a RFC patch and not meant to be merged. I looked into
> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> board (sc8280xp) where the UFS host controller would fail to probe due
> to repeated probe deferrals when trying to get reset-gpios via
> devm_gpiod_get_optional().
>=20
> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> pinctrl driver doesn't define one, so of_gpiochip_add() should
> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> happen since the fwnode member on the struct gpiochip is set to null
> when of_gpiochip_add() is called. Let's work around this by ensuring
> that it's set if available.
>=20
> Note that this broke sometime within the last few weeks within
> linux-next and I haven't bisected this. I'm posting this in the hopes
> that someone may know offhand which patch(es) may have broken this.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..8bec66008869 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, =
void *data,
>  	 * Assign fwnode depending on the result of the previous calls,
>  	 * if none of them succeed, assign it to the parent's one.
>  	 */
> -	gdev->dev.fwnode =3D dev_fwnode(&gdev->dev) ?: fwnode;
> +	gc->fwnode =3D gdev->dev.fwnode =3D dev_fwnode(&gdev->dev) ?: fwnode;

This doesn't look right to me. Looking at the documentation of
gc->fwnode and how it is used, the purpose of this is to allow
explicitly overriding the fwnode that the GPIO chip will use.

So really this should not be used beyond the initial registration
in gpiochip_add_data_with_key(). If the above patch fixes anything,
then I suspect somebody is using gc->fwnode outside of this
registration.

Looking at gpiolib, the only remaining place that seems to do this is
the gpio-reserved-ranges handling code, in which case, the below on top
of my initial patch might fix that. That might explain why MSM is still
seeing issues.

--- >8 ---
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 11fb7ec883e9..d692ad5c5a27 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -447,10 +447,11 @@ static unsigned long *gpiochip_allocate_mask(struct g=
pio_chip *gc)
=20
 static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
 {
+	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
 	int size;
=20
 	/* Format is "start, count, ..." */
-	size =3D fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
+	size =3D fwnode_property_count_u32(fwnode, "gpio-reserved-ranges");
 	if (size > 0 && size % 2 =3D=3D 0)
 		return size;
=20
@@ -471,6 +472,7 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *=
gc)
=20
 static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
 {
+	struct fwnode_handle *fwnode =3D dev_fwnode(&gc->gpiodev->dev);
 	unsigned int size;
 	u32 *ranges;
 	int ret;
@@ -483,7 +485,7 @@ static int gpiochip_apply_reserved_ranges(struct gpio_c=
hip *gc)
 	if (!ranges)
 		return -ENOMEM;
=20
-	ret =3D fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges"=
, ranges, size);
+	ret =3D fwnode_property_read_u32_array(fwnode, "gpio-reserved-ranges", ra=
nges, size);
 	if (ret) {
 		kfree(ranges);
 		return ret;
--- >8 ---

I don't have a good idea about the Lenovo X13 issue, though, but I
haven't looked at ACPI at all since I don't have any hardware to test
on.

Thierry

--ZP8t6sia5cyeZVao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN0ua0ACgkQ3SOs138+
s6FnUBAAr//n8UR0DGk3K82H0+Nh9thuccu3XyZs38DMwvwOUaV4Xh9PJuR43qU6
Pe5b43sJ7K33z5ltCpWp2mvh0sdnAhTqEjk6f322bNbsVbfRf12ajC3LKBgOQTuG
CuZgC6a9eBcshti6t5C5jdcG98puHT2AG/8Ps9EpaSFV+KHMUgHJ6cMiMfwDmBhe
Jqn9pVSFCEm3yRUwtFrWhwZXCW+RSxdB9nJhCU1KcBo7nxDuWT8wq3hCPb1L17bL
KYXynrT4bZ/WOU7L+GQ5A1RsHMS94G1HrG3I26lJQD8IQLoZcOaG7I3iKN/8kmUc
hIH5ErY1DPAhkC5vEe0xmfrkWYvbzna9EEAGTxqU+BEXHZHHP1qXA5DyAUsfUw3T
TKIUbALCitP1dWZIRG5QfptnYay7401Lb1HBmQnAP6xQIvDKo6YRSYvxIg6KW93n
NPkM97S9qiNpafer7vLAFyxuifg1OfeKEm0gOAmiX7kzKEW80kgkZP4WkAyELBvU
+5l4Agpl7DIBcpwtCACdXpWS445JjCqIxOme7Bhv+G7f8qmbfy8YrVi5kLvUSvRO
wNBAkRyET8BVZYAI8FLF7/Ar5x+vmgL404vrOYGwvivcc05j63ZfRUFLxWSfwcps
wdBMFnAMaP3but4kEssXp9tIjBu2FrwYySjooPUV/R1sUaW8RJ0=
=pljc
-----END PGP SIGNATURE-----

--ZP8t6sia5cyeZVao--
