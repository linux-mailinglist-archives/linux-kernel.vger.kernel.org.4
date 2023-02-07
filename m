Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B468D5B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjBGLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBGLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:39:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666D01284F;
        Tue,  7 Feb 2023 03:38:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa10so11989863ejc.9;
        Tue, 07 Feb 2023 03:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypYaAIHbgwskXP956yUIa5G6SVK0QZ0JGeu03YaQuLg=;
        b=j50wXizpSCgbltXPzxLm6o6EgUCwunOa3gUhOObCfsxS5zVmzaK1bbvvNUqvbd5N59
         s38vLv0Ysjzb1iVZ1HiJGnplkCzTNqrii67ZhGZXcM6Nm93vBAaQpk0h4FApJ7wqBa7u
         z1jm04ciGE4gBk8tYyYecFTbO6F4uEiBi5Tw5VGhyW22YPsF64IrPcOj1SWTrQ1HmnaR
         f1ZNfG5UyLxIsSMw97PSgxOcFcN3yaX6IUcuonLpJGDzhifWcbo3vsJl4sdNKHkP4cqW
         e+BPGiI5s6QzdCrSLCvvb05XtqKa5znj4Ell/XC4ul+ptUNQ8iQMRC0qxgFDioXRQMOq
         8B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypYaAIHbgwskXP956yUIa5G6SVK0QZ0JGeu03YaQuLg=;
        b=3LPUwvciaQMz/y+a1nRAkftJ3XnYtMWTS1LajHuNDY4Ksa/HS8tMVigcna/0VVukcc
         otH72r/RfIY6Z8+TtJaYoudLRNi/c4bIBhly1XsENjw58xElDdk2xl1AmHmJhSRCV007
         wdP2w0hxMAKe/UQ/L1iOCdSbzPVftYV8GYsFIr+tuHzTA3vWl/LZisjDdDnfWH0GUXk7
         daUoeNj6GWB63r2INi+iUR3erthKK5cRl7YLizHFiCwI0vWjT3bnlXJ/fJjaWxsvnUOm
         TcJFKGiU419SlpTGmrChfFAgfGW71j/2qMI8BM1kW+/vS7ZUM0OV770URb0ozn78y4fJ
         7F2A==
X-Gm-Message-State: AO0yUKV9SaAGwjB0rWIsLQKxlfPoFHh+uB30iA0ssFSohHX9Rt9pVr2+
        QGkNSEKKQGc6o6h6Q7bhsDRs6xXBP7A=
X-Google-Smtp-Source: AK7set9xPPTA4AVcwID7+M8jKZFboG1ezV/PnXsBHNVtCAEcRQMGr+q/tXVvH0nFPyJttT+0/8a26A==
X-Received: by 2002:a17:906:2556:b0:8aa:1eb2:a806 with SMTP id j22-20020a170906255600b008aa1eb2a806mr1043783ejb.74.1675769934798;
        Tue, 07 Feb 2023 03:38:54 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m18-20020a056402511200b004a22ed9030csm6293794edd.56.2023.02.07.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:38:54 -0800 (PST)
Date:   Tue, 7 Feb 2023 12:38:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Message-ID: <Y+I4S7Xt4gKDYLkw@orome>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6YmCx3uIqlMso1fF"
Content-Disposition: inline
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6YmCx3uIqlMso1fF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
>=20
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
>=20
> Remove this inclusion in every place where it is possible.
>=20
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
>=20
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
>=20
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
>=20
> No functional changes
>=20
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/amlogic_thermal.c           | 1 -
>  drivers/thermal/armada_thermal.c            | 2 --
>  drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
>  drivers/thermal/hisi_thermal.c              | 3 +--
>  drivers/thermal/imx8mm_thermal.c            | 1 -
>  drivers/thermal/imx_sc_thermal.c            | 1 -
>  drivers/thermal/intel/intel_hfi.c           | 3 ++-
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>  drivers/thermal/qoriq_thermal.c             | 1 -
>  drivers/thermal/rcar_gen3_thermal.c         | 1 -
>  drivers/thermal/samsung/exynos_tmu.c        | 3 +--
>  drivers/thermal/st/stm_thermal.c            | 1 -
>  drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
>  drivers/thermal/uniphier_thermal.c          | 2 --
>  14 files changed, 4 insertions(+), 18 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--6YmCx3uIqlMso1fF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPiOEsACgkQ3SOs138+
s6GcZg//R3MQVqmdDfUAH1wSX/RKBdIAW3IEegenVrucDauuJHfqOD6w9PZ1mhvo
7sffnxqIcqDT4K1UrFfVoSEsDYYKTB/RbwaiHjr2bGR7DJbLe7diXmw2XZWJZ+gT
Oyw8I6tyWR9ixwcfP5d03Vgi5h4QHSNvlAagPwCIMoYXlC8yMeK5stM5DR2pZCRJ
ZtpT71OQa0iUf9/MP61cm1EZco7cUSbPP79b+0gkGCaEM+N9h5VRSK4wZWyDe2ED
lRwO36ATMnOzHN27cZvYLXEsGiWRLvtSwunIfOkBW2GFf3/t0KJfLNTIIzBYyYv5
7YWQWv2PWY7A2dx0DDskAmo3n+34qouc7lGd+pCJeoPASpEXbCRK5kXvVEVMcMW/
fuxqLlsBpZoNLlxmMCL7LaN0xTTK5aAI930kxr1vJXlYfwvHsXN5YUBi9f+nP3lv
k4LY4P/jgZGDJQMcjL6ysfHJ11S9yc+6mAv9D+Zd6X5sn+DitvYUbq7oH1Vid5oU
nvu13INcwRMa/Q++f6+DOv//64fPIeZctFcq1oQr8tevgECDeJ7qy4ZTPplIcLnU
cGEHqcomIPOkFfvAxYETborXcePZSFKpuYOzecg6YEhcZCtkYLcdiFuw9PoM8Kqn
CYbQQDs1EKfpKznrlpqOIiaZ1PknWjl2zK4ey9b+APu0KE5eghc=
=Zn7P
-----END PGP SIGNATURE-----

--6YmCx3uIqlMso1fF--
