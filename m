Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294D72E90B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjFMRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:08:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39F187;
        Tue, 13 Jun 2023 10:08:49 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA62F6602121;
        Tue, 13 Jun 2023 18:08:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686676128;
        bh=iQ4ftuaDBWznEH5kDX5P/Q5kN2Byy7CoqD5P8dbx2Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMSzrc9xFt40RcZnTRnRdu5SpYhhgLOXDegVKwBQhYZVVwzU94lSbbkDIFRoLF5fR
         N2bKCjUUwKuOb09ysuRw3IqWyQZVjyuJlSh6YvPT20jn94HrqRvNNJBhS1NCbbb8BC
         OzcaWz/YP/QcSsYlKe3cZ9WVv8e7hjMTiR8xUZd0sFdKSj9PdH2DIWxWDxGxbv9NW4
         K8V1pI0eWvzABG6Z59Chs04UOPga8mcn/kAxSkM9MO/CmHSWxa722i32rn8rhFkiyt
         emmCZGyVMJWLwlNsgByytgQhV33ez/ZEVnm7XiNwp/eWINFvjRvlilNx7Tr7hHdax3
         04faZNC2KZmhg==
Received: by mercury (Postfix, from userid 1000)
        id 8AC541066FC6; Tue, 13 Jun 2023 19:08:45 +0200 (CEST)
Date:   Tue, 13 Jun 2023 19:08:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 13/25] PM / devfreq: rockchip-dfi: Pass private data
 struct to internal functions
Message-ID: <20230613170845.j5fcj746u6n6tmsq@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-14-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fprcqslfdwew5bja"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-14-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fprcqslfdwew5bja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:41AM +0200, Sascha Hauer wrote:
> The internal functions do not need the struct devfreq_event_dev *,
> so pass them the struct rockchip_dfi *. This is a preparation for
> adding perf support later which doesn't have a struct devfreq_event_dev *.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 0a568c5551699..d39db5de7f19c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -72,9 +72,8 @@ struct rockchip_dfi {
>  	unsigned int channel_mask;
>  };
> =20
> -static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev=
 *edev)
> +static void rockchip_dfi_start_hardware_counter(struct rockchip_dfi *dfi)
>  {
> -	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs =3D dfi->regs;
> =20
>  	/* clear DDRMON_CTRL setting */
> @@ -102,18 +101,16 @@ static void rockchip_dfi_start_hardware_counter(str=
uct devfreq_event_dev *edev)
>  		       dfi_regs + DDRMON_CTRL);
>  }
> =20
> -static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev =
*edev)
> +static void rockchip_dfi_stop_hardware_counter(struct rockchip_dfi *dfi)
>  {
> -	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	void __iomem *dfi_regs =3D dfi->regs;
> =20
>  	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
>  		       dfi_regs + DDRMON_CTRL);
>  }
> =20
> -static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, s=
truct dmc_count *count)
> +static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct =
dmc_count *count)
>  {
> -	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
>  	u32 i;
>  	void __iomem *dfi_regs =3D dfi->regs;
> =20
> @@ -131,7 +128,7 @@ static int rockchip_dfi_disable(struct devfreq_event_=
dev *edev)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> =20
> -	rockchip_dfi_stop_hardware_counter(edev);
> +	rockchip_dfi_stop_hardware_counter(dfi);
>  	clk_disable_unprepare(dfi->clk);
> =20
>  	return 0;
> @@ -148,7 +145,7 @@ static int rockchip_dfi_enable(struct devfreq_event_d=
ev *edev)
>  		return ret;
>  	}
> =20
> -	rockchip_dfi_start_hardware_counter(edev);
> +	rockchip_dfi_start_hardware_counter(dfi);
>  	return 0;
>  }
> =20
> @@ -166,7 +163,7 @@ static int rockchip_dfi_get_event(struct devfreq_even=
t_dev *edev,
>  	u32 access =3D 0, total =3D 0;
>  	int i;
> =20
> -	rockchip_dfi_read_counters(edev, &count);
> +	rockchip_dfi_read_counters(dfi, &count);
> =20
>  	/* We can only report one channel, so find the busiest one */
>  	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
> --=20
> 2.39.2
>=20

--fprcqslfdwew5bja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSIopgACgkQ2O7X88g7
+prsew/+LN7A+w+Fxan4kvHnEiZpj4xZA3Avqs/Lsz2Rem4DqsupltVNzgsPMwlH
8TJksf8RvETr2hPUT/2R/VgGApIR+QygSUj8Y/s/sPj0ngXuk/nrMvniByPEqN+g
V1yNWPMNOYGpZX9SCvpAA1Nwlvsvg9oHRHI553vxF7F5JDine/YYhqjqATdJf7Bl
WPo7YtJ+kCmjPuk+GK3Foll/+WJo8Sa1GJUNqw9ovdqtThn7lVvwuSqYGUCoVoii
hkht0bKwaDuLDdwHVzvsZC81eeoLefsvAty+HDDveLZ1bgq6xdmdbKnAjOW9tbgg
vrDV6qWDlsFdhemvfHPMAWsTLAz+azDDQAFJBU7PE9y8h0MVd/3nbRh42qgT1Yaf
bnEShymXUwvk31rrrlJmZ0MPI9lLtZ/Zrs+UzhalDzDKiqWAFHnTqUIa2PxCpGkU
TgbhRxy3zIefePLjkZeEwSMaCXmrRGCHaijM3DmVB1OvGGmYpr+2ydeEw5CT99Je
sB9RcK1n/ROKIJG+jPVEt68SWuqDSC5uWRDrks9RYb97vVYTdtBLM2nqAkl0bXJJ
GH9L5qjwWyJG4SQFQ1H+/87Zo/VrzHFaDY8jmf2iLEoH8zGd0GAG1PUp3TsFjbKS
Cm+ng9GjXUu2/T9yTL5Q+G+YI5jghuX4R/i8Oi6wdOgsANTyz4A=
=Lfwq
-----END PGP SIGNATURE-----

--fprcqslfdwew5bja--
